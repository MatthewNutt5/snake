//======================================
// Snake Game FSM - controller.v
//======================================
module controller (clka, clkb, restart, logic_done, prng_done, direction_in, game_state, direction_state, execution_state);

/*
 *  This FSM module consists of three FSMs:
 *  1) The game FSM, showing whether the game is ready/started/ended,
 *  2) The direction FSM, keeping track of which direction
 *     the snake is moving, and
 *  3) The execution FSM, synchronizing the phases of movement,
 *     collision detection, etc., as well as updates to the other FSMs.
 */

//========== Setup ==========

//---------- Input Ports ----------

/*
 *  - clka and clkb are provided by oscillator
 *  - restart could come from a button
 *  - done signals come from external modules, signal when to continue
 *    execution
 */
input wire clka, clkb, restart, logic_done, prng_done;

/*
 *  Represents the buttons being pressed, active high and one-hot
 *  (assume only one is pressed at a time).
 */
input wire [3:0] direction_in;
parameter UP_IN = 4'b0001, DOWN_IN = 4'b0010,
          LEFT_IN = 4'b0100, RIGHT_IN = 4'b1000;



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
output reg [?:0] execution_state;
parameter ?;



//---------- Internal Variables ----------

/*
 *  Used for combinational logic of FSM.
 */
wire [1:0] game_state_temp;
wire [1:0] direction_state_temp;
wire [?:0] execution_state_temp;

/*
 *  Stores output of combinational logic on clka.
 */
wire [1:0] game_state_next;
wire [1:0] direction_state_next;
wire [?:0] execution_state_next;



//========== Code ==========

//---------- Combinational Logic ----------
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
