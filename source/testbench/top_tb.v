//-----------------------------------------------
// Snake Game Testbench - top_tb.v
//-----------------------------------------------
`timescale 1ns/10ps

`define CLOCK \
  begin \
    in_clka = 0; in_clkb = 0; #10; \
    in_clka = 1; in_clkb = 0; #10; \
    in_clka = 0; in_clkb = 0; #10; \
    in_clka = 0; in_clkb = 1; #10; \
  end

module top_tb();

// Inputs to top module
reg        in_clka, in_clkb, in_restart;
reg [3:0]  in_direction_in;

// Outputs from top_module
wire [7:0]  out_row_cathode, out_column_anode;
wire [1:0]  out_control_to_logic, out_logic_to_control, out_game_state,
            out_direction_state, out_execution_state;
wire [63:0] out_led_array_flat;
wire [5:0]  out_random_num;
wire        out_request_rand;

// Create a top system instance
top snake_top (.in_clka (in_clka),
               .in_clkb (in_clkb),
               .in_restart (in_restart),
               .in_direction_in (in_direction_in),
               .out_row_cathode (out_row_cathode),
               .out_column_anode (out_column_anode),
               .out_control_to_logic (out_control_to_logic),
               .out_logic_to_control (out_logic_to_control),
               .out_game_state (out_game_state),
               .out_direction_state (out_direction_state),
               .out_execution_state (out_execution_state),
               .out_led_array_flat (out_led_array_flat),
               .out_random_num (out_random_num),
               .out_request_rand (out_request_rand)
               );

initial
begin



// restart
in_restart = 1;
in_direction_in = 4'b0000; // with the simple Python script, you HAVE to explicitly define each digit
`CLOCK // move to CHECK_STATE

// idle for a few cycles to show that nothing happens until user input detected
in_restart = 0;
`CLOCK // execution_state: CHECK -> DISPLAY, game_state: INIT
`CLOCK 
`CLOCK
`CLOCK

// move to the right
in_direction_in = 4'b1000;
`CLOCK //execution_state: CHECK -> INPUT, game_state: INIT -> RUN
// LOGIC_TICK
`CLOCK //execution_state: INPUT -> WAIT_LOGIC

// now we wait for logic_done, fsm will then do some multiplexing
`CLOCK
`CLOCK
`CLOCK
`CLOCK
`CLOCK
`CLOCK
`CLOCK
`CLOCK

// multiplexing done, let's keep moving
`CLOCK // LOGIC_TICK
`CLOCK // multiplexing
`CLOCK
`CLOCK
`CLOCK
`CLOCK
`CLOCK
`CLOCK
`CLOCK

// should eat an apple on this stage and request a new random number
// new apple is now at (5,6) or 101110
`CLOCK // LOGIC_TICK
`CLOCK // multiplexing 
`CLOCK
`CLOCK
`CLOCK
`CLOCK
`CLOCK
`CLOCK
`CLOCK

// snake is at (3,5), move right one more
`CLOCK // LOGIC_TICK 
`CLOCK // multiplexing
`CLOCK
`CLOCK
`CLOCK
`CLOCK
`CLOCK
`CLOCK
`CLOCK

// move up to eat the next apple
in_direction_in = 4'b0001;
`CLOCK // LOGIC_TICK
`CLOCK
`CLOCK
`CLOCK
`CLOCK
`CLOCK
`CLOCK
`CLOCK
`CLOCK

// continue moving up, eat apple here
// new apple at (6,7)
`CLOCK // LOGIC_TICK
`CLOCK
`CLOCK
`CLOCK
`CLOCK
`CLOCK
`CLOCK
`CLOCK
`CLOCK
`CLOCK
`CLOCK
`CLOCK
`CLOCK
`CLOCK

// move right
in_direction_in = 4'b1000; 
`CLOCK // LOGIC_TICK
`CLOCK
`CLOCK
`CLOCK
`CLOCK
`CLOCK
`CLOCK
`CLOCK
`CLOCK
`CLOCK
`CLOCK
`CLOCK
`CLOCK

// move up
in_direction_in = 4'b0001;
`CLOCK // LOGIC_TICK
`CLOCK
`CLOCK
`CLOCK
`CLOCK
`CLOCK
`CLOCK
`CLOCK
`CLOCK
`CLOCK
`CLOCK
`CLOCK
`CLOCK

// move right, eat apple
// next apple at (3,3)
in_direction_in = 4'b1000; 
`CLOCK // LOGIC_TICK
`CLOCK
`CLOCK
`CLOCK
`CLOCK
`CLOCK
`CLOCK
`CLOCK
`CLOCK
`CLOCK
`CLOCK
`CLOCK
`CLOCK
`CLOCK
`CLOCK
`CLOCK
`CLOCK

// move down 4 spaces
in_direction_in = 4'b0010; 
`CLOCK // LOGIC_TICK
`CLOCK
`CLOCK
`CLOCK
`CLOCK
`CLOCK
`CLOCK
`CLOCK
`CLOCK
`CLOCK // LOGIC_TICK
`CLOCK
`CLOCK
`CLOCK
`CLOCK
`CLOCK
`CLOCK
`CLOCK
`CLOCK
`CLOCK // LOGIC_TICK
`CLOCK
`CLOCK
`CLOCK
`CLOCK
`CLOCK
`CLOCK
`CLOCK
`CLOCK
`CLOCK
`CLOCK
`CLOCK
`CLOCK
`CLOCK
`CLOCK
`CLOCK
`CLOCK
`CLOCK
`CLOCK
`CLOCK
`CLOCK
`CLOCK
`CLOCK
`CLOCK
`CLOCK // LOGIC_TICK
`CLOCK
`CLOCK
`CLOCK
`CLOCK
`CLOCK
`CLOCK
`CLOCK
`CLOCK
`CLOCK // LOGIC_TICK
`CLOCK
`CLOCK
`CLOCK

// move left
in_direction_in = 4'b0100; 
`CLOCK // LOGIC_TICK
`CLOCK
`CLOCK
`CLOCK
`CLOCK
`CLOCK
`CLOCK
`CLOCK
`CLOCK
`CLOCK // LOGIC_TICK
`CLOCK
`CLOCK
`CLOCK
`CLOCK
`CLOCK
`CLOCK
`CLOCK
`CLOCK
`CLOCK
`CLOCK // LOGIC_TICK
`CLOCK
`CLOCK
`CLOCK
`CLOCK
`CLOCK
`CLOCK
`CLOCK
`CLOCK
`CLOCK
`CLOCK
`CLOCK
`CLOCK
`CLOCK
`CLOCK
`CLOCK
`CLOCK
`CLOCK
`CLOCK
`CLOCK
`CLOCK
`CLOCK
`CLOCK
`CLOCK
`CLOCK
`CLOCK
`CLOCK
`CLOCK
`CLOCK
`CLOCK
`CLOCK
`CLOCK
`CLOCK
`CLOCK

// move down to eat apple at (1,5)
in_direction_in = 4'b0010; 
`CLOCK // LOGIC_TICK
`CLOCK
`CLOCK
`CLOCK
`CLOCK
`CLOCK
`CLOCK
`CLOCK
`CLOCK
`CLOCK
`CLOCK
`CLOCK

// move right
in_direction_in = 4'b1000; 
`CLOCK // LOGIC_TICK
`CLOCK
`CLOCK
`CLOCK
`CLOCK
`CLOCK
`CLOCK
`CLOCK
`CLOCK
`CLOCK
`CLOCK
`CLOCK

// move up, contemplate impending doom
in_direction_in = 4'b0001; 
`CLOCK // LOGIC_TICK
`CLOCK
`CLOCK
`CLOCK
`CLOCK
`CLOCK
`CLOCK
`CLOCK
`CLOCK
`CLOCK

// perish, now check if it blinks the head's LED
`CLOCK // LOGIC_TICK, NO_UPDATE
`CLOCK
`CLOCK
`CLOCK
`CLOCK
`CLOCK
`CLOCK
`CLOCK
`CLOCK
`CLOCK
`CLOCK
`CLOCK
`CLOCK
`CLOCK
`CLOCK
`CLOCK
`CLOCK
`CLOCK
`CLOCK
`CLOCK
`CLOCK
`CLOCK
`CLOCK
`CLOCK
`CLOCK
`CLOCK
`CLOCK





$dumpfile ("snake_tb.vcd");
$dumpvars;
$stop;

end

endmodule
