//======================================
// Snake Game FSM - controller.v
//======================================
module controller (clka, clkb, restart, direction_in, from_logic, led_array,
  game_state, direction_state, execution_state, row_cathode, column_anode);

/*
 *  This FSM module consists of three FSMs:
 *  1) The game FSM, showing whether the game is ready/started/ended,
 *  2) The direction FSM, keeping track of which direction
 *     the snake is moving, and
 *  3) The execution FSM, synchronizing the phases of movement,
 *     collision detection, etc., as well as updates to the other FSMs.
 *
 *  This FSM module also handles multiplexing for the 8x8 LED display.
 */

//========== Setup ==========

//---------- Input Ports ----------

/*
 *  Various single-wire inputs.
 *  - clka and clkb are provided by oscillator
 *  - restart could come from a button
 */
input wire clka, clkb, restart;

// TODO: Should these signal arrays instead be signal busses? i.e. collection of
// x-many one-bit wires, instead of x-bit wire?
/*
 *  Represents the buttons being pressed, active high and one-hot
 *  (assume only one is pressed at a time).
 */
input wire [3:0] direction_in;
parameter UP_IN = 4'b0001, DOWN_IN = 4'b0010,
  LEFT_IN = 4'b0100, RIGHT_IN = 4'b1000;

/*
 *  Signal array from logic datapath. Each index represents a different signal.
 *  - The parameters represent indices, not bit masks.
 */
input wire [2:0] from_logic;
parameter LOGIC_DONE = 0, PRNG_DONE = 1, GAME_END = 2;

/*
 *  Nested array from logic datapath denoting which LEDs should be lit or unlit.
 *  - led_array[r] is the r-th row, led_array[r][c] is the c-th column in the
 *    r-th row.
 */
input wire [7:0] led_array [7:0];



//---------- Output Ports ----------

/*
 *  Represents the state of the game.
 */
output reg [1:0] game_state;
parameter INIT = 0, RUN = 1, STOP = 2;

/*
 *  Represents the direction the snake is moving.
 */
output reg [1:0] direction_state;
parameter UP_STATE = 0, DOWN_STATE = 1, LEFT_STATE = 2, RIGHT_STATE = 3;

/*
 *  Synchronizes the flow of execution between the different modules.
 *  - CHECK_STATE: Check the game state - initialized, running, or stopped.
 *    If initialized or running, check input and send signals to logic.
 *    If stopped, don't check for input, just keep going to display state.
 *    The logic datapath should be toggling the head's LED on its own(?).
 *  - INPUT: Check the direction_in input, update direction_state accordingly.
 *    direction_state should be output to the logic datapath so it can update
 *    the head position.
 *  - WAIT_LOGIC: Wait until from_logic[LOGIC_DONE] is true, meaning that the
 *    logic datapath has finished processing and updating from the directional
 *    input.
 *  - UPDATE_STATE: Based on the feedback from the logic datapath, update the
 *    game state.
 *  - WAIT_PRNG: Wait until from_logic[PRNG_DONE] is true, meaning that the
 *    logic datapath has finished processing a new random number (if any).
 *    The logic datapath and PRNG datapath will execute a handshake on their
 *    own; the logic datapath reports back to the controller.
 *  - DISPLAY: For a set number of cycles, iterate over each row in the display
 *    and turn on the LEDs that need to be lit, according to the multiplexing
 *    scheme. Go to CHECK_STATE once the required number of cycles is completed.
 */
parameter SIZE = 3; // Expand as needed
output reg [SIZE-1:0] execution_state;
parameter CHECK_STATE = 0, INPUT = 1, WAIT_LOGIC = 2, UPDATE_STATE = 3,
          WAIT_PRNG = 4, DISPLAY = 5;
parameter NUM_DISPLAY_CYCLES = 4;

/*
 *  Signal array to logic datapath. Each index represents a different signal.
 *  - to_logic[LOGIC_TICK] tells the logic datapath when to intake a new
 *    direction input and update the game board.
 *  - to_logic[NO_UPDATE], when enabled during the tick, will blink the LED that
 *    represents the head position, instead of taking input and updating. Used
 *    after the game has ended.
 */
output reg [1:0] to_logic;
parameter LOGIC_TICK = 0, NO_UPDATE = 1;

/*
 *  Multiplexed 8x8 LED display output.
 *  - row_cathode should be one-cold, "enables" row to display
 *  - column_anode then goes high for each LED that is lit for that row
 */
output reg [7:0] row_cathode;
output reg [7:0] column_anode;



//---------- Internal Variables ----------

/*
 *  Used for combinational logic of FSM.
 */
wire [1:0] game_state_temp;
wire [1:0] direction_state_temp;
wire [SIZE-1:0] execution_state_temp;

/*
 *  Stores output of combinational logic on clka.
 */
reg [1:0] game_state_next;
reg [1:0] direction_state_next;
reg [SIZE-1:0] execution_state_next;

/*
 *  Keeps track of which row to display during multiplexing.
 */
reg [2:0] current_row;



//========== Code ==========

//---------- Combinational Logic ----------

/*
 *  These combinational logic functions define the next state, depending on the
 *  current state and inputs. As wires, they are continuously evaluated.
 *  However, their corresponding registers should only be updated in certain
 *  circumstances, e.g. game_state is updated only during the CHECK_STATE
 *  stage of the execution FSM.
 */



/*
 *  Game state: Start in INIT when restart is asserted, move to RUN when any
 *  directional button is pressed, move to STOP when logic datapath signals
 *  that a body collision has been detected.
 */
assign game_state_temp = game_state_function(restart, direction_in,
  from_logic, game_state);

function [1:0] game_state_function;
  input restart;
  input [3:0] direction_in;
  input [2:0] from_logic;
  input [1:0] game_state;

  if (restart)
    game_state_function = INIT;
  else begin
    case (game_state)

      INIT: begin
        if (direction_in) // If any direction button is pressed
          game_state_function = RUN;
        else
          game_state_function = INIT;
      end

      RUN: begin
        if (from_logic[GAME_END]) // If logic datapath indicates collision
          game_state_function = STOP;
        else
          game_state_function = RUN;
      end

      STOP: begin
        game_state_function = STOP; // Can only be taken out of STOP by restart
      end
      
      default: game_state_function = STOP; // Default to STOP in unknown state

    endcase
  end

endfunction



/*
 *  Direction state: Set current direction to input direction, disallowing
 *  flips (up to down, left to right). Default to right.
 */
assign direction_state_temp = direction_state_function(restart, direction_in);

function [1:0] direction_state_function;
  input restart;
  input [3:0] direction_in;

  if (restart)
    direction_state_function = RIGHT_STATE;
  else begin
    case (direction_state)
      
      UP_STATE: begin
        if (direction_in == LEFT_IN)
          direction_state_function = LEFT_STATE;
        else if (direction_in == RIGHT_IN)
          direction_state_function = RIGHT_STATE;
        else
          direction_state_function = UP_STATE;
      end

      DOWN_STATE: begin
        if (direction_in == LEFT_IN)
          direction_state_function = LEFT_STATE;
        else if (direction_in == RIGHT_IN)
          direction_state_function = RIGHT_STATE;
        else
          direction_state_function = DOWN_STATE;
      end

      LEFT_STATE: begin
        if (direction_in == UP_IN)
          direction_state_function = UP_STATE;
        else if (direction_in == DOWN_IN)
          direction_state_function = DOWN_STATE;
        else
          direction_state_function = LEFT_STATE;
      end

      RIGHT_STATE: begin
        if (direction_in == UP_IN)
          direction_state_function = UP_STATE;
        else if (direction_in == DOWN_IN)
          direction_state_function = DOWN_STATE;
        else
          direction_state_function = RIGHT_STATE;
      end

      default: direction_state_function = RIGHT_STATE;

    endcase
  end
endfunction



// --- Everything below this point is from Homework 3 Question 3; not part of the snake game ---
assign temp_state = fsm_function (state, restart, load_pattern, load_test, enter, same_sig);

function [SIZE-1:0] fsm_function;
  input  [SIZE-1:0] state;
  input  restart, load_pattern, load_test, enter, same_sig;
  
  if (restart)           // Restart --> return to IDLE
    fsm_function = IDLE;
  else begin             // Otherwise, follow normal sequence
    case (state)
    
      IDLE: begin
        if (load_pattern)
          fsm_function = WAIT_PAT;
        else
          fsm_function = IDLE;
      end
    
      WAIT_PAT: begin
        if (enter)
          fsm_function = READY;
        else
          fsm_function = WAIT_PAT;
      end
      
      READY: begin
        if (load_test)
          fsm_function = WAIT_TEST;
        else
          fsm_function = READY;
      end
      
      WAIT_TEST: begin
        if (enter)
          fsm_function = EVAL1;
        else
          fsm_function = WAIT_TEST;
      end
      
      EVAL1: fsm_function = EVAL2;
      
      EVAL2: begin
        if (same_sig)
          fsm_function = MATCH;
        else
          fsm_function = ERROR;
      end
      
      MATCH: begin
        if (load_test)
          fsm_function = WAIT_TEST;
        else
          fsm_function = MATCH;
      end
      
      ERROR: begin
        if (load_test)
          fsm_function = WAIT_TEST;
        else
          fsm_function = ERROR;
      end

      default: fsm_function = IDLE;
      
    endcase
  end
  
endfunction

//----------Seq Logic-----------------------------------------------------------
always @(negedge clka) begin
  next_state <= temp_state;  // Store next state for output logic
end

//----------Output Logic--------------------------------------------------------
always @(negedge clkb) begin

  state <= next_state;

  case(next_state)
    
    IDLE, EVAL2: begin
      {save_pat_sig, save_pat_temp_sig, save_test_sig, save_test_temp_sig, match, error} = 0;
    end
    
    WAIT_PAT: begin
      {save_pat_sig, save_test_sig, save_test_temp_sig, match, error} = 0;
      save_pat_temp_sig = 1;
    end
    
    READY: begin
      {save_pat_temp_sig, save_test_sig, save_test_temp_sig, match, error} = 0;
      save_pat_sig = 1;
    end
    
    WAIT_TEST: begin
      {save_pat_sig, save_pat_temp_sig, save_test_sig, match, error} = 0;
      save_test_temp_sig = 1;
    end
    
    EVAL1: begin
      {save_pat_sig, save_pat_temp_sig, save_test_temp_sig, match, error} = 0;
      save_test_sig = 1;
    end
    
    MATCH: begin
      {save_pat_sig, save_pat_temp_sig, save_test_sig, save_test_temp_sig, error} = 0;
      match = 1;
    end
    
    ERROR: begin
      {save_pat_sig, save_pat_temp_sig, save_test_sig, save_test_temp_sig, match} = 0;
      error = 1;
    end
    
  endcase
  
end



endmodule
