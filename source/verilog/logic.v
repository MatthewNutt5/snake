// Templated from my Homework 3 Problem 3 - change as needed
//-----------------------------------------------
// Combination Lock Datapath - lock_dp.v
//-----------------------------------------------
module lock_dp (clka, clkb, restart, save_pat, save_pat_temp, save_test, save_test_temp, pattern, test, same);

/*
 *  -If the testbench asserts "restart", all registers are cleared to 0
 *  -If the FSM asserts "save_*", the corresponding input registers will update
 *  -If the FSM asserts "save_*_temp", the corresponding temp registers will update, and
 *    with extra output logic, the "same" output is also updated
 *  -The inputs clka/b, restart, pattern, and test are all directly input, not from the FSM
 */

//----------Input Ports--------------------------
input wire        clka, clkb, restart, save_pat, save_pat_temp, save_test, save_test_temp;
input wire [1:0]  pattern, test;

//----------Output Ports-------------------------
output reg        same;

//----------Internal Variables-------------------
reg  [1:0]  pat_out, pat_temp, test_out, test_temp;
wire        same_result;

//----------Code starts here---------------------------------------------------

// Calculate if the test equals the pattern
assign same_result = (pat_out == test_out);



always @(negedge clka) begin
  
  if (restart) begin
  
    {pat_out, pat_temp,
     test_out, test_temp} <= 0;
    
  end else begin
    
    if (save_pat)
      pat_out <= pat_temp;
    if (save_pat_temp)
      pat_temp <= pattern;
      
    if (save_test)
      test_out <= test_temp;
    if (save_test_temp)
      test_temp <= test;
                  
  end
    
end



always @(negedge clkb) begin
  
  same = same_result;

end



endmodule
