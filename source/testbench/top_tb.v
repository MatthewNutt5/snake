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

module snake_tb();

// Inputs to top module
reg        in_clka, in_clkb, in_restart;
reg [3:0]  in_direction_in;

// Outputs from top_module
wire [5:0]  out_random_num;
wire [63:0] out_led_array_flat;
wire        out_request_rand;
wire [1:0]  out_game_state, out_direction_state, out_execution_state, out_to_logic, out_from_logic;
wire [7:0]  out_row_cathode, out_column_cathode;

// Create a top system instance
top snake_top (.in_clka (in_clka),
              .in_clkb (in_clkb),
              .in_restart (in_restart),
              .in_direction_in(in_direction_in),
              .out_led_array_flat(out_led_array_flat), 
              .out_from_logic(out_from_logic),  
              .out_game_state(out_game_state), 
              .out_direction_state(out_direction_state), 
              .out_execution_state(out_execution_state), 
              .out_to_logic(out_to_logic), 
              .out_row_cathode(out_row_cathode), 
              .out_column_cathode(out_column_cathode), 
              .out_random_num(out_random_num), 
              .out_request_rand(out_request_rand)
              );

initial
begin

/*
 *  NOTE: Numerical inputs are delayed by one cycle behind their 
 *        corresponding control input because the FSM delays
 *        control signals to the datapath by one cycle.
 */



// restart
in_restart = 1;
in_direction_in = 0;
`CLOCK // move to CHECK_STATE

// idle for a few cycles to show that nothing happens until user input detected
in_restart = 0;
`CLOCK // execution_state: CHECK -> DISPLAY, game_state: INIT
`CLOCK 
`CLOCK
`CLOCK

// move to the right
in_direction = 3; 
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

// multiplexing done, let's keep moving
`CLOCK // LOGIC_TICK
`CLOCK // multiplexing
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

// snake is at (3,5), move right one more
`CLOCK // LOGIC_TICK 
`CLOCK // multiplexing
`CLOCK
`CLOCK
`CLOCK
`CLOCK
`CLOCK
`CLOCK

// move up to eat the next apple
in_direction = 0;
`CLOCK // LOGIC_TICK
`CLOCK
`CLOCK
`CLOCK
`CLOCK
`CLOCK
`CLOCK
`CLOCK

// continue moving up, eat apple here
// new apple at (3,7)
`CLOCK // LOGIC_TICK
`CLOCK
`CLOCK
`CLOCK
`CLOCK
`CLOCK
`CLOCK
`CLOCK

// move right
in_direction = 3; 
`CLOCK // LOGIC_TICK
`CLOCK
`CLOCK
`CLOCK
`CLOCK
`CLOCK
`CLOCK
`CLOCK

// move down
in_direction = 1; 
`CLOCK // LOGIC_TICK
`CLOCK
`CLOCK
`CLOCK
`CLOCK
`CLOCK
`CLOCK
`CLOCK

// move down, eat apple
// next apple at (3,3)
`CLOCK // LOGIC_TICK
`CLOCK
`CLOCK
`CLOCK
`CLOCK
`CLOCK
`CLOCK
`CLOCK

// move left 3 spaces
in_direction = 2; 
`CLOCK // LOGIC_TICK
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
`CLOCK // LOGIC_TICK
`CLOCK
`CLOCK
`CLOCK
`CLOCK
`CLOCK
`CLOCK
`CLOCK

// move left, eat apple
// next apple at (1,5), need to eat one more before SELF DESTRUCT
`CLOCK // LOGIC_TICK
`CLOCK
`CLOCK
`CLOCK
`CLOCK
`CLOCK
`CLOCK
`CLOCK

// move down 2 spaces
in_direction = 1; 
`CLOCK // LOGIC_TICK
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

// move right 2 spaces, eat apple
in_direction = 3; 
`CLOCK // LOGIC_TICK
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

// move up, contemplate impending doom
in_direction = 0; 
`CLOCK // LOGIC_TICK
`CLOCK
`CLOCK
`CLOCK
`CLOCK
`CLOCK
`CLOCK
`CLOCK

// move left, continue contemplation
in_direction = 2; 
`CLOCK // LOGIC_TICK
`CLOCK
`CLOCK
`CLOCK
`CLOCK
`CLOCK
`CLOCK
`CLOCK

// move down, panic
in_direction = 1; 
`CLOCK // LOGIC_TICK
`CLOCK
`CLOCK
`CLOCK
`CLOCK
`CLOCK
`CLOCK
`CLOCK

// perish
`CLOCK // LOGIC_TICK
`CLOCK
`CLOCK
`CLOCK
`CLOCK
`CLOCK
`CLOCK
`CLOCK

// now check if it blinks the head's LED
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






$dumpfile ("snake_tb.vcd");
$dumpvars;
$stop;

end

endmodule
