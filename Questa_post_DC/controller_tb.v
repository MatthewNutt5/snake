// Templated from my Homework 3 Problem 3 - change as needed
//-----------------------------------------------
// Combination Lock Testbench - lock_tb.v
//-----------------------------------------------
`timescale 1ns/10ps

`define CLOCK \
  begin \
    in_clka = 0; in_clkb = 0; #10; \
    in_clka = 1; in_clkb = 0; #10; \
    in_clka = 0; in_clkb = 0; #10; \
    in_clka = 0; in_clkb = 1; #10; \
  end

module lock_tb();

// Inputs to top module
reg        in_clka, in_clkb, in_restart, in_load_pattern, in_load_test, in_enter;
reg  [1:0] in_pattern, in_test;

// Outputs from top_module
wire       out_match, out_error, out_same_sig;
wire       out_save_pat_sig, out_save_pat_temp_sig, out_save_test_sig, out_save_test_temp_sig;
wire [2:0] out_state;

// Create a top system instance
lock_top top (.in_clka (in_clka),
              .in_clkb (in_clkb),
              .in_restart (in_restart),
              .in_load_pattern (in_load_pattern),
              .in_load_test (in_load_test),
              .in_enter (in_enter),
              .in_pattern (in_pattern),
              .in_test (in_test),
              .out_match (out_match),
              .out_error (out_error),
              .out_state (out_state),
              .out_same_sig (out_same_sig),
              .out_save_pat_sig (out_save_pat_sig),
              .out_save_pat_temp_sig (out_save_pat_temp_sig),
              .out_save_test_sig (out_save_test_sig),
              .out_save_test_temp_sig (out_save_test_temp_sig)
              );

initial
begin

/*
 *  NOTE: Numerical inputs are delayed by one cycle behind their 
 *        corresponding control input because the FSM delays
 *        control signals to the datapath by one cycle.
 */



// cycle 1 - restart
in_restart = 1;
{in_load_pattern, in_load_test, in_enter} = 0;
{in_pattern, in_test} = 0;
`CLOCK

// cycle 2 - load pattern
in_restart = 0;
in_load_pattern = 1;
`CLOCK

// cycle 3 - provide pattern, enter
in_load_pattern = 0;
in_enter = 1;
in_pattern = 2'b11;
`CLOCK

// cycle 4 - load test
in_enter = 0;
in_load_test = 1;
in_pattern = 0;
`CLOCK

// cycle 5 - provide incorrect test, enter
in_load_test = 0;
in_enter = 1;
in_test = 2'b10;
`CLOCK

// cycle 6 - wait for evalution
in_enter = 0;
in_test = 0;
`CLOCK

// cycle 7 - idle to see result
`CLOCK

// cycle 8 - result persists unless we input new test
in_enter = 1;
`CLOCK

// cycle 9 - result persists unless we input new test
in_enter = 0;
in_load_pattern = 1;
`CLOCK

// cycle 10 - result persists unless we input new test
in_load_pattern = 0;
`CLOCK

// cycle 11 - load test
in_load_test = 1;
`CLOCK

// cycle 12 - provide correct test, enter
in_load_test = 0;
in_enter = 1;
in_test = 2'b11;
`CLOCK

// cycle 13 - wait for evalution
in_enter = 0;
in_test = 0;
`CLOCK

// cycle 14 - idle to see result
`CLOCK

// cycle 15 - result persists unless we input new test
in_enter = 1;
`CLOCK

// cycle 16 - result persists unless we input new test
in_enter = 0;
in_load_pattern = 1;
`CLOCK

// cycle 17 - result persists unless we input new test
in_load_pattern = 0;
`CLOCK

// cycle 18 - one more idle for good measure :)
`CLOCK





$dumpfile ("lock_tb.vcd");
$dumpvars;
$stop;

end

endmodule
