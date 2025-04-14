//-----------------------------------------------
// Snake Game Integration - top.v
//-----------------------------------------------
module top (in_clka, in_clkb, in_restart, in_direction_in,
  out_row_cathode, out_column_anode, out_control_to_logic,
  out_logic_to_control, out_game_state, out_direction_state,
  out_execution_state, out_led_array_flat, out_random_num, out_request_rand);

//----------Input Ports--------------------------
input wire        in_clka, in_clkb, in_restart;
input wire [3:0]  in_direction_in;

//----------Output Ports-------------------------
output wire [7:0]  out_row_cathode, out_column_anode;
output wire [1:0]  out_control_to_logic, out_logic_to_control, out_game_state,
  out_direction_state, out_execution_state;
output wire [63:0] out_led_array_flat;
output wire [5:0]  out_random_num;
output wire        out_request_rand;

//----------Internal Variables-------------------
wire [1:0]  control_to_logic, logic_to_control, direction_state;
wire [63:0] led_array_flat;
wire [5:0]  random_num;
wire        request_rand;

assign out_control_to_logic = control_to_logic; // Bring control signals out
assign out_logic_to_control = logic_to_control; // "
assign out_direction_state = direction_state;   // "
assign out_led_array_flat = led_array_flat;     // "
assign out_random_num = random_num;             // "
assign out_request_rand = request_rand;         // "

//----------Code starts here---------------------------------------------------
controller snake_controller (.clka (in_clka),
                             .clkb (in_clkb),
                             .restart (in_restart),
                             .direction_in (in_direction_in),
                             .from_logic (logic_to_control),
                             .led_array_flat (led_array_flat),
                             .game_state (out_game_state),
                             .direction_state (direction_state),
                             .execution_state (out_execution_state),
                             .to_logic (control_to_logic),
                             .row_cathode (out_row_cathode),
                             .column_anode (out_column_anode)
                             );

logic snake_logic (.clka (in_clka),
                   .clkb (in_clkb),
                   .restart (in_restart),
                   .from_controller (control_to_logic),
                   .direction_state (direction_state),
                   .random_num (random_num),
                   .to_controller (logic_to_control),
                   .led_array_flat (led_array_flat),
                   .request_rand (request_rand)
                   );

prng snake_prng (.clka (in_clka), 
                 .clkb (in_clkb), 
                 .restart (in_restart), 
                 .request_rand (request_rand), 
                 .random_num (random_num)
                 );



endmodule
