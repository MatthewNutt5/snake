// Templated from my Homework 3 Problem 3 - change as needed
//-----------------------------------------------
// Combination Lock Integration - lock_top.v
//-----------------------------------------------
module lock_top (in_clka, in_clkb, in_restart, in_load_pattern, in_load_test, in_enter, in_pattern, in_test, out_match, out_error, out_state,
  out_same_sig, out_save_pat_sig, out_save_pat_temp_sig, out_save_test_sig, out_save_test_temp_sig);

//----------Input Ports--------------------------
input wire        in_clka, in_clkb, in_restart, in_load_pattern, in_load_test, in_enter;
input wire [1:0]  in_pattern, in_test;

//----------Output Ports-------------------------
output wire       out_match, out_error, out_same_sig, out_save_pat_sig, out_save_pat_temp_sig, out_save_test_sig, out_save_test_temp_sig;
output wire [2:0] out_state;

//----------Internal Variables-------------------
wire same_sig, save_pat_sig, save_pat_temp_sig, save_test_sig, save_test_temp_sig; // Used to link the FSM controller and datapath
assign out_same_sig = same_sig;                     // Bring control signals out
assign out_save_pat_sig = save_pat_sig;             // "
assign out_save_pat_temp_sig = save_pat_temp_sig;   // "
assign out_save_test_sig = save_test_sig;           // "
assign out_save_test_temp_sig = save_test_temp_sig; // "

//----------Code starts here---------------------------------------------------
lock_fsm fsm (.clka (in_clka),
              .clkb (in_clkb),
              .restart (in_restart),
              .load_pattern (in_load_pattern),
              .load_test (in_load_test),
              .enter (in_enter),
              .same_sig (same_sig),
              .save_pat_sig (save_pat_sig),
              .save_pat_temp_sig (save_pat_temp_sig),
              .save_test_sig (save_test_sig),
              .save_test_temp_sig (save_test_temp_sig),
              .match (out_match),
              .error (out_error),
              .state (out_state)
              );

lock_dp dp (.clka (in_clka),
            .clkb (in_clkb),
            .restart (in_restart),
            .save_pat (save_pat_sig),
            .save_pat_temp (save_pat_temp_sig),
            .save_test (save_test_sig),
            .save_test_temp (save_test_temp_sig),
            .pattern (in_pattern),
            .test (in_test),
            .same (same_sig)
            );



endmodule
