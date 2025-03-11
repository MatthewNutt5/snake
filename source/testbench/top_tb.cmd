| Templated from my Homework 3 Problem 3 - change as needed
|
| lock_tb.cmd
|
| Comments
| Matthew Nutt - mcn5
| ELEC 422 
| Spring 2025
|
| CMOS Combination Lock
|
vector pattern in_pattern\[1\] in_pattern\[0\]
vector test in_test\[1\] in_test\[0\]
vector statebits out_state\[2\] out_state\[1\] out_state\[0\]

ana in_clka in_clkb in_restart in_load_pattern in_load_test in_enter pattern test out_match out_error statebits out_same_sig out_save_pat_sig out_save_pat_temp_sig out_save_test_sig out_save_test_temp_sig
V  in_restart       1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
V  in_load_pattern  0 1 0 0 0 0 0 0 1 0 0 0 0 0 0 1 0 0
V  in_load_test     0 0 0 1 0 0 0 0 0 0 1 0 0 0 0 0 0 0
V  in_enter         0 0 1 0 1 0 0 1 0 0 0 1 0 0 1 0 0 0
V  in_pattern\[1\]  0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
V  in_pattern\[0\]  0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
V  in_test\[1\]     0 0 0 0 1 0 0 0 0 0 0 1 0 0 0 0 0 0
V  in_test\[0\]     0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 0 0 0

clock in_clka 0 1 0 0
clock in_clkb 0 0 0 1
R
