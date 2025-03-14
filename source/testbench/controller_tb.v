//======================================
// Snake Game FSM Testbench - controller_tb.v
//======================================
`timescale 1ns/10ps

`define CLOCK \
  begin \
    in_clka = 0; in_clkb = 0; #10; \
    in_clka = 1; in_clkb = 0; #10; \
    in_clka = 0; in_clkb = 0; #10; \
    in_clka = 0; in_clkb = 1; #10; \
  end

module controller_tb();

// Inputs to module
reg       in_clka, in_clkb, in_restart;
reg [3:0] in_direction_in;
reg [1:0] in_from_logic;
reg [7:0] in_led_array [7:0];

wire [0:63] in_led_array_flat = {in_led_array[0], in_led_array[1],
  in_led_array[2], in_led_array[3], in_led_array[4], in_led_array[5],
  in_led_array[6], in_led_array[7]};

// Outputs from module
wire [1:0] out_game_state, out_direction_state, out_to_logic;
wire [2:0] out_execution_state;
wire [7:0] out_row_cathode, out_column_anode;

// Create an instance of the module
controller control (.clka (in_clka),
                    .clkb (in_clkb),
                    .restart (in_restart),
                    .direction_in (in_direction_in),
                    .from_logic (in_from_logic),
                    .led_array_flat (in_led_array_flat),
                    .game_state (out_game_state),
                    .direction_state (out_direction_state),
                    .execution_state (out_execution_state),
                    .to_logic (out_to_logic),
                    .row_cathode (out_row_cathode),
                    .column_anode (out_column_anode));

initial
begin



// restart
in_restart = 1;
{in_direction_in, in_from_logic} = 0;
in_led_array[0] = 8'b00000000;
in_led_array[1] = 8'b00000000;
in_led_array[2] = 8'b00000000;
in_led_array[3] = 8'b00000000;
in_led_array[4] = 8'b00000000;
in_led_array[5] = 8'b00000000;
in_led_array[6] = 8'b00000000;
in_led_array[7] = 8'b00000000;
`CLOCK // move to UPDATE_STATE

// idle for a few cycles to show that the fsm doesn't send any
// signals, just displays whatever the logic datapath is sending
// (will be set to initial conditions)
in_restart = 0;
in_led_array[0] = 8'b00000000;
in_led_array[1] = 8'b00000000;
in_led_array[2] = 8'b00000000;
in_led_array[3] = 8'b00100100;
in_led_array[4] = 8'b00000000;
in_led_array[5] = 8'b00000000;
in_led_array[6] = 8'b00000000;
in_led_array[7] = 8'b00000000;
`CLOCK // move to CHECK_STATE
`CLOCK // move to DISPLAY
`CLOCK // 16 cycles of DISPLAY multiplexing 
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
`CLOCK // move to UPDATE_STATE
`CLOCK // move to CHECK_STATE
`CLOCK // move to DISPLAY
`CLOCK // 16 cycles of DISPLAY multiplexing 
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





$dumpfile ("controller_tb.vcd");
$dumpvars;
$stop;

end

endmodule
