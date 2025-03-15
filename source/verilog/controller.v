//======================================
// Snake Game FSM - controller.v
//======================================
module controller (clka, clkb, restart, direction_in, from_logic,
  led_array_flat, game_state, direction_state, execution_state, to_logic,
  row_cathode, column_anode);

/*
 *  This FSM module consists of three FSMs:
 *  1) The game FSM, showing whether the game is ready/started/ended,
 *  2) The direction FSM, keeping track of which direction
 *     the snake is moving, and
 *  3) The execution FSM, synchronizing the phases of movement,
 *     collision detection, etc., as well as updates to the other FSMs.
 *  This FSM module also handles multiplexing for the 8x8 LED display.
 */

/*
 *  TODO: It should be possible to make the multiplexed display asynchronous,
 *        i.e. constantly running and getting inputs directly from the logic
 *        datapath. In all game states, the display is running, so there's no
 *        need for it to be part of the controller. Then the DISPLAY state would
 *        just be used to divide the clock for game ticks. Maybe implement an
 *        asynchronous display in a separate module?
 *        This would make sense for the intended use case, i.e. >kHz clock
 *        speeds, but for simulation, it would create "tearing" if the logic
 *        datapath updates the display in the middle of a frame refresh.
 *  TODO: If the multiplexed display is being kept in its current form, is there
 *        a smarter way to control the row cathodes? See the Output Logic block.
 */



//========== Setup ==========

//---------- Input Ports ----------

/*
 *  Various single-wire inputs.
 *  - clka and clkb are provided by oscillator
 *  - restart could come from a button
 */
input wire clka, clkb, restart;

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
input wire [1:0] from_logic;
parameter LOGIC_DONE = 0, GAME_END = 1;

/*
 *  Flattened version of a nested array from logic datapath denoting which LEDs
 *  should be lit or unlit.
 *  - led_array[r] is the r-th row, led_array[r][c] is the c-th column in the
 *    r-th row.
 *  - Indexes off the bottom-left corner of the display matrix.
 *  - Flattened version starts with 0-th row, then 1-st row, etc., unflattened
 *    by internal wire.
 */
input wire [63:0] led_array_flat;



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
 */
output reg [1:0] execution_state;
parameter CHECK_STATE = 0, INPUT = 1, WAIT_LOGIC = 2, DISPLAY = 3;

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
output reg [7:0] row_cathode, column_anode;



//---------- Internal Variables ----------

/*
 *  Used for combinational logic of FSM.
 */
wire [1:0] game_state_temp;
wire [1:0] direction_state_temp;
wire [1:0] execution_state_temp;

/*
 *  Stores output of combinational logic on clka.
 */
reg [1:0] game_state_next;
reg [1:0] direction_state_next;
reg [1:0] execution_state_next;

/*
 *  Keeps track of which row to display during multiplexing, and how many
 *  multiplexing cycles have been completed so far.
 */
reg [2:0] current_row;
reg [1:0] cycle_count;
parameter NUM_DISPLAY_CYCLES = 2;

/*
 *  Unflattens input led_array_flat. Verilog why.
 */
wire [7:0] led_array [7:0];
assign led_array[0] = led_array_flat[7:0];
assign led_array[1] = led_array_flat[15:8];
assign led_array[2] = led_array_flat[23:16];
assign led_array[3] = led_array_flat[31:24];
assign led_array[4] = led_array_flat[39:32];
assign led_array[5] = led_array_flat[47:40];
assign led_array[6] = led_array_flat[55:48];
assign led_array[7] = led_array_flat[63:56];





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
assign direction_state_temp = direction_state_function(restart, direction_in,
  direction_state);

function [1:0] direction_state_function;
  input restart;
  input [3:0] direction_in;
  input [1:0] direction_state;

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

/*
 *  Execution state: Move through execution loop in different paths depending
 *  on game state.
 *  - CHECK_STATE: Check the game state - initialized, running, or stopped.
 *    If initialized or running, check input and send signals to logic.
 *    If stopped, check input, but also send NO_UPDATE to logic.
 *    The logic datapath should be toggling the head's LED on its own(?).
 *  - INPUT: Check the direction_in input, update direction_state accordingly.
 *    direction_state should be output to the logic datapath so it can update
 *    the head position. Send to_logic[LOGIC_TICK], and if the game is ended,
 *    also send to_logic[NO_UPDATE].
 *  - WAIT_LOGIC: Wait until from_logic[LOGIC_DONE] is true, meaning that the
 *    logic datapath has finished processing and updating from the directional
 *    input. This includes if the logic datapath has finished processing a new
 *    random number, if any. The logic datapath and PRNG datapath will execute a
 *    handshake on their own; the logic datapath reports back to the controller.
 *  - DISPLAY: For a set number of cycles, iterate over each row in the display
 *    and turn on the LEDs that need to be lit, according to the multiplexing
 *    scheme. Go to CHECK_STATE once the required number of cycles is completed.
 */
assign execution_state_temp = execution_state_function(restart, from_logic,
  game_state, execution_state, current_row, cycle_count);

function [1:0] execution_state_function;
  input restart;
  input [1:0] from_logic;
  input [1:0] game_state;
  input [1:0] execution_state;
  input [2:0] current_row;
  input [1:0] cycle_count;

  if (restart)
    execution_state_function = CHECK_STATE;
  else
    case (execution_state)

    CHECK_STATE: begin
      if (game_state == INIT)
        execution_state_function = DISPLAY;
      else
        execution_state_function = INPUT;
    end

    INPUT: begin
      execution_state_function = WAIT_LOGIC;
    end

    WAIT_LOGIC: begin
      if (from_logic[LOGIC_DONE])
        execution_state_function = DISPLAY;
      else
        execution_state_function = WAIT_LOGIC;
    end

    DISPLAY: begin
      if ( (current_row == 7) && (cycle_count == NUM_DISPLAY_CYCLES-1) )
        execution_state_function = CHECK_STATE;
      else
        execution_state_function = DISPLAY;
    end

    default: execution_state_function = CHECK_STATE;

    endcase
endfunction



//---------- Sequential Logic ----------

/*
 *  This sequential logic section, consisting of one always block, takes inputs
 *  at the negative edge of clka and updates internal temporary registers based
 *  on those inputs and current states.
 */

always @(negedge clka) begin

  // Update multiplex state if in display state
  if (restart) begin
    current_row <= 0;
    cycle_count <= 0;
  end else if (execution_state == DISPLAY) begin
    if (current_row == 7) begin
      current_row <= 0;
      if (cycle_count == NUM_DISPLAY_CYCLES-1)
        cycle_count <= 0; // Next clkb should be updating state to CHECK_STATE
      else
        cycle_count <= cycle_count + 1;
    end else
      current_row <= current_row + 1;
  end

  game_state_next <= game_state_temp;
  direction_state_next <= direction_state_temp;
  execution_state_next <= execution_state_temp;
  
end



//---------- Output Logic ----------

/*
 *  This output logic section, also consisting of an always block, uses the
 *  state of internal registers at the negative edge of clkb to update various
 *  output signals. Again, final states will only be updated when appropriate.
 */

always @(negedge clkb) begin
  
  game_state <= game_state_next;
  direction_state <= direction_state_next;
  execution_state <= execution_state_next;

  case (execution_state_next)

    CHECK_STATE: begin
      // idle/off
      to_logic <= 0;
      row_cathode <= {8{1'b1}};
      column_anode <= 0;
    end

    INPUT: begin
      to_logic[LOGIC_TICK] <= 1;
      if (game_state == STOP)
        to_logic[NO_UPDATE] <= 1;
      else
        to_logic[NO_UPDATE] <= 0;
      // idle/off
      row_cathode <= {8{1'b1}};
      column_anode <= 0;
    end

    WAIT_LOGIC: begin
      // idle/off
      to_logic <= 0;
      row_cathode <= {8{1'b1}};
      column_anode <= 0;
    end

    DISPLAY: begin
      // Enable the current row, disable all others
      // TODO: Is there a smarter way of doing this?
      row_cathode[0] <= (current_row == 0) ? 0 : 1;
      row_cathode[1] <= (current_row == 1) ? 0 : 1;
      row_cathode[2] <= (current_row == 2) ? 0 : 1;
      row_cathode[3] <= (current_row == 3) ? 0 : 1;
      row_cathode[4] <= (current_row == 4) ? 0 : 1;
      row_cathode[5] <= (current_row == 5) ? 0 : 1;
      row_cathode[6] <= (current_row == 6) ? 0 : 1;
      row_cathode[7] <= (current_row == 7) ? 0 : 1;
      // Columns can just be taken from led_array
      column_anode <= led_array[current_row];
      // idle/off
      to_logic <= 0;
    end

    default: begin
      // idle/off
      to_logic <= 0;
      row_cathode <= {8{1'b1}};
      column_anode <= 0;
    end

  endcase
end



endmodule
