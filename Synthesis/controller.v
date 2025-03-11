// Templated from my Homework 3 Problem 3 - change as needed
//-----------------------------------------------
// Combination Lock FSM - lock_fsm.v
//-----------------------------------------------
module lock_fsm (clka, clkb, restart, load_pattern, load_test, enter, same_sig,
  save_pat_sig, save_pat_temp_sig, save_test_sig, save_test_temp_sig, match, error, state);

//----------Internal Constants-------------------
parameter SIZE = 3;
parameter IDLE = 3'b000;
parameter WAIT_PAT = 3'b001, READY = 3'b010;
parameter WAIT_TEST = 3'b011, EVAL1 = 3'b100, EVAL2 = 3'b101;
parameter MATCH = 3'b110, ERROR = 3'b111;

//----------Input Ports--------------------------
input wire    clka, clkb, restart, load_pattern, load_test, enter, same_sig;

//----------Output Ports-------------------------
output reg            save_pat_sig, save_pat_temp_sig, save_test_sig, save_test_temp_sig, match, error;
output reg [SIZE-1:0] state;

//----------Internal Variables-------------------
wire  [SIZE-1:0]  temp_state;    // Combo part of FSM
reg   [SIZE-1:0]  next_state;    // Internal state reg

//----------Code starts here---------------------------------------------------
assign temp_state = fsm_function (state, restart, load_pattern, load_test, enter, same_sig);
             
//----------Function for Combo Logic-------------------------------------------
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

//----------Seq Logic----------------------------------------------------------
always @(negedge clka) begin
  next_state <= temp_state;  // Store next state for output logic
end

//----------Output Logic-------------------------------------------------------
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
