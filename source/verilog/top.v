
//-----------------------------------------------
// Snake Game Integration - top.v
//-----------------------------------------------
module snake_top (in_clka, in_clkb, in_restart, in_led_array_flat, in_from_logic, in_direction_in, out_game_state, out_direction_state, 
  out_execution_state, out_to_logic, out_row_cathode, out_column_cathode, in_random_num, out_request_rand);

//----------Input Ports--------------------------
input wire        in_clka, in_clkb, in_restart;
input wire [1:0]  in_from_logic;
input wire [63:0] in_led_array_flat;
input wire [3:0]  in_direction_in;
input wire [5:0]  in_random_num;

//----------Output Ports-------------------------
output wire       out_request_rand;
output wire [1:0] out_game_state, out_direction_state, out_execution_state;, out_to_logic;
output wire [7:0] row_cathode, column_cathode;

//----------Internal Variables-------------------
wire [1:0] direction_state, to_logic, from_logic; // Used to link the FSM controller and datapath
wire [63:0] led_array_flat;
wire [5:0] random_num;
wire request_rand;

assign out_direction_state = direction_state;       // Bring control signals out
assign out_to_logic = to_logic;                     // "
assign in_from_logic = from_logic;                  // "
assign in_led_array_flat = led_array_flat;          // "
assign in_random_num = random_num;                  // "
assign out_request_rand = request_rand;             // "

//----------Code starts here---------------------------------------------------
snake_controller controller (.clka (in_clka),
                             .clkb (in_clkb),
                             .restart (in_restart),
                             .direction_in (in_direction_in),
                             .from_logic (from_logic),
                             .led_array_flat (led_array_flat),
                             .game_state (out_game_state),
                             .direction_state (direction_state),
                             .execution_state (out_execution_state),
                             .to_logic (out_row_cathode),
                             .column_cathode (out_column_cathode)
                            );

snake_logic logic (.clka (in_clka),
                   .clkb (in_clkb),
                   .restart (in_restart),
                   .from_controller (to_logic)),
                   .direction_state (direction_state),
                   .random_num (random_num),
                   .to_controller (from_logic),
                   .led_array_flat (led_array_flat),
                   .request_rand (request_rand)
                  );

snake_prng prng (.clka (in_clka), 
                 .clkb (in_clkb), 
                 .restart (in_restart), 
                 .request_rand (request_rand), 
                 .random_num (random_num)
                );



endmodule
