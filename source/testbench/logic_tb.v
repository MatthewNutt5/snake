//======================================
// Snake Game Logic Datapath Testbench - logic_tb.v
//======================================
`timescale 1ns/10ps

`define CLOCK \
  begin \
    in_clka = 0; in_clkb = 0; #10; \
    in_clka = 1; in_clkb = 0; #10; \
    in_clka = 0; in_clkb = 0; #10; \
    in_clka = 0; in_clkb = 1; #10; \
  end

module logic_tb();

// Inputs to module
reg       in_clka, in_clkb, in_restart;
reg [1:0] in_from_controller, in_direction_state;
reg [5:0] in_random_num;

// Outputs from module
wire [1:0]  out_to_controller;
wire [63:0] out_led_array_flat;
wire        out_request_rand;

// Create an instance of the module
logic logic_instance (.clka (in_clka),
                      .clkb (in_clkb),
                      .restart (in_restart),
                      .from_controller (in_from_controller),
                      .direction_state (in_direction_state),
                      .random_num (in_random_num),
                      .to_controller (out_to_controller),
                      .led_array_flat (out_led_array_flat),
                      .request_rand (out_request_rand)
);

initial
begin



// restart
in_restart = 1;
{in_from_controller, in_direction_state, in_random_num} = 0;
`CLOCK // move to CHECK_STATE

// idle for a few cycles to show that the datapath doesn't do anything until
// the fsm tells it to
in_restart = 0;
in_random_num = 6'b011101;
`CLOCK
`CLOCK
`CLOCK
`CLOCK

// let's move to the right
in_direction_state = 3;
`CLOCK
in_from_controller = 2'b01; // LOGIC_TICK
`CLOCK

// now we wait for logic_done, fsm will then do some multiplexing
in_from_controller = 0;
`CLOCK
`CLOCK
`CLOCK
`CLOCK
`CLOCK
`CLOCK

// multiplexing done, let's keep moving
in_from_controller = 2'b01; // LOGIC_TICK
`CLOCK
in_from_controller = 0;
`CLOCK
`CLOCK
`CLOCK
`CLOCK
`CLOCK
`CLOCK

// should eat an apple on this stage and request a new random number
in_from_controller = 2'b01; // LOGIC_TICK
`CLOCK
in_from_controller = 0;
`CLOCK
in_random_num = 6'b011110; // next apple will be right
`CLOCK
`CLOCK
`CLOCK
`CLOCK
`CLOCK
`CLOCK

// keep moving right to eat the next apple
`CLOCK
in_from_controller = 2'b01; // LOGIC_TICK
`CLOCK
in_from_controller = 0;
`CLOCK
in_random_num = 6'b100110; // next apple will be up
`CLOCK
`CLOCK
`CLOCK
`CLOCK
`CLOCK
`CLOCK
`CLOCK

// move up to eat the next apple
in_direction_state = 0;
`CLOCK
in_from_controller = 2'b01; // LOGIC_TICK
`CLOCK
in_from_controller = 0;
`CLOCK
in_random_num = 6'b100101; // next apple will be left
`CLOCK
`CLOCK
`CLOCK
`CLOCK
`CLOCK
`CLOCK
`CLOCK
`CLOCK

// move left to eat the next apple
in_direction_state = 2;
`CLOCK
in_from_controller = 2'b01; // LOGIC_TICK
`CLOCK
in_from_controller = 0;
`CLOCK
in_random_num = 6'b000000; // next apple will be idc
`CLOCK
`CLOCK
`CLOCK
`CLOCK
`CLOCK
`CLOCK
`CLOCK
`CLOCK
`CLOCK

// move down to kill ourselves
// should see a GAME_END signal
in_direction_state = 1;
`CLOCK
in_from_controller = 2'b01; // LOGIC_TICK
`CLOCK
in_from_controller = 0;
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

// now check if it blinks the head's LED
`CLOCK
in_from_controller = 2'b11; // LOGIC_TICK, NO_UPDATE
`CLOCK
in_from_controller = 0;
`CLOCK
`CLOCK
`CLOCK
`CLOCK
`CLOCK

`CLOCK
in_from_controller = 2'b11; // LOGIC_TICK, NO_UPDATE
`CLOCK
in_from_controller = 0;
`CLOCK
`CLOCK
`CLOCK
`CLOCK
`CLOCK



$dumpfile ("controller_tb.vcd");
$dumpvars;
$stop;

end

endmodule
