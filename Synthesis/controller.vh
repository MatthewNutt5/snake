/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Expert(TM) in wire load mode
// Version   : U-2022.12-SP7
// Date      : Sat Mar 15 18:20:49 2025
/////////////////////////////////////////////////////////////


module controller ( clka, clkb, restart, direction_in, from_logic, 
        led_array_flat, game_state, direction_state, execution_state, to_logic, 
        row_cathode, column_anode );
  input [3:0] direction_in;
  input [1:0] from_logic;
  input [63:0] led_array_flat;
  output [1:0] game_state;
  output [1:0] direction_state;
  output [1:0] execution_state;
  output [1:0] to_logic;
  output [7:0] row_cathode;
  output [7:0] column_anode;
  input clka, clkb, restart;
  wire   \game_state_temp[1] , \current_row[2]1 , \current_row[1]1 ,
         \current_row[0]1 , \cycle_count[1]1 , \cycle_count[0]1 , N115, N116,
         N117, N118, N119, N120, N121, N122, N123, N124, N125, N126, N127,
         N128, N129, N130, N131, N132, n1, n2, n3, n4, n5, n7, n8, n9, n10,
         n11, n12, n13, n14, n15, n16, n17, n18, n19, n20, n21, n22, n23, n24,
         n25, n26, n27, n28, n29, n30, n31, n32, n33, n34, n35, n36, n37, n38,
         n39, n40, n41, n42, n43, n44, n45, n46, n47, n48, n49, n50, n51, n52,
         n53, n54, n55, n56, n57, n58, n59, n60, n61, n62, n63, n64, n65, n66,
         n67, n68, n69, n70, n71, n72, n73, n74, n75, n76, n77, n78, n79, n80,
         n81, n82, n83, n84, n85, n86, n87, n88, n89, n90, n91, n92, n93, n94,
         n95, n96, n97, n98, n99, n100, n101, n102, n103, n104, n105, n106,
         n107, n108, n109, n110, n111, n112, n113, n114, n115, n116, n117,
         n118, n119, n120, n121, n122, n123, n124, n125, n126, n127, n128,
         n129, n130, n131, n132, n133, n134, n135, n136, n137, n138, n139,
         n140, n141, n142, n143, n144, n145, n146, n147, n148, n149, n150,
         n151, n152;
  wire   [1:0] direction_state_temp;
  wire   [1:0] execution_state_temp;
  wire   [1:0] game_state_next;
  wire   [1:0] direction_state_next;
  wire   [1:0] execution_state_next;

  DFFNEGX1 \game_state_reg[0]  ( .D(game_state_next[0]), .CLK(n151), .Q(
        game_state[0]) );
  DFFNEGX1 \game_state_next_reg[1]  ( .D(\game_state_temp[1] ), .CLK(clka), 
        .Q(game_state_next[1]) );
  DFFNEGX1 \game_state_reg[1]  ( .D(game_state_next[1]), .CLK(n151), .Q(
        game_state[1]) );
  DFFNEGX1 \game_state_next_reg[0]  ( .D(n14), .CLK(clka), .Q(
        game_state_next[0]) );
  DFFNEGX1 \direction_state_reg[1]  ( .D(direction_state_next[1]), .CLK(n151), 
        .Q(direction_state[1]) );
  DFFNEGX1 \direction_state_next_reg[1]  ( .D(direction_state_temp[1]), .CLK(
        clka), .Q(direction_state_next[1]) );
  DFFNEGX1 \direction_state_reg[0]  ( .D(direction_state_next[0]), .CLK(n151), 
        .Q(direction_state[0]) );
  DFFNEGX1 \direction_state_next_reg[0]  ( .D(direction_state_temp[0]), .CLK(
        clka), .Q(direction_state_next[0]) );
  DFFNEGX1 \execution_state_reg[0]  ( .D(execution_state_next[0]), .CLK(clkb), 
        .Q(execution_state[0]) );
  DFFNEGX1 \execution_state_next_reg[1]  ( .D(execution_state_temp[1]), .CLK(
        clka), .Q(execution_state_next[1]) );
  DFFNEGX1 \execution_state_reg[1]  ( .D(execution_state_next[1]), .CLK(clkb), 
        .Q(execution_state[1]) );
  DFFNEGX1 \current_row_reg[0]  ( .D(n148), .CLK(clka), .Q(\current_row[0]1 )
         );
  DFFNEGX1 \current_row_reg[1]  ( .D(n149), .CLK(clka), .Q(\current_row[1]1 )
         );
  DFFNEGX1 \current_row_reg[2]  ( .D(n147), .CLK(clka), .Q(\current_row[2]1 )
         );
  DFFNEGX1 \cycle_count_reg[0]  ( .D(n145), .CLK(clka), .Q(\cycle_count[0]1 )
         );
  DFFNEGX1 \cycle_count_reg[1]  ( .D(n146), .CLK(clka), .Q(\cycle_count[1]1 )
         );
  DFFNEGX1 \execution_state_next_reg[0]  ( .D(execution_state_temp[0]), .CLK(
        clka), .Q(execution_state_next[0]) );
  DFFNEGX1 \to_logic_reg[0]  ( .D(N115), .CLK(clkb), .Q(to_logic[0]) );
  DFFNEGX1 \to_logic_reg[1]  ( .D(N116), .CLK(clkb), .Q(to_logic[1]) );
  DFFNEGX1 \row_cathode_reg[7]  ( .D(N124), .CLK(clkb), .Q(row_cathode[7]) );
  DFFNEGX1 \row_cathode_reg[6]  ( .D(N123), .CLK(clkb), .Q(row_cathode[6]) );
  DFFNEGX1 \row_cathode_reg[5]  ( .D(N122), .CLK(clkb), .Q(row_cathode[5]) );
  DFFNEGX1 \row_cathode_reg[3]  ( .D(N120), .CLK(n151), .Q(row_cathode[3]) );
  DFFNEGX1 \row_cathode_reg[1]  ( .D(N118), .CLK(n151), .Q(row_cathode[1]) );
  DFFNEGX1 \row_cathode_reg[4]  ( .D(N121), .CLK(n151), .Q(row_cathode[4]) );
  DFFNEGX1 \row_cathode_reg[2]  ( .D(N119), .CLK(n151), .Q(row_cathode[2]) );
  DFFNEGX1 \row_cathode_reg[0]  ( .D(N117), .CLK(n151), .Q(row_cathode[0]) );
  DFFNEGX1 \column_anode_reg[7]  ( .D(N132), .CLK(n151), .Q(column_anode[7])
         );
  DFFNEGX1 \column_anode_reg[6]  ( .D(N131), .CLK(n151), .Q(column_anode[6])
         );
  DFFNEGX1 \column_anode_reg[5]  ( .D(N130), .CLK(n151), .Q(column_anode[5])
         );
  DFFNEGX1 \column_anode_reg[4]  ( .D(N129), .CLK(n151), .Q(column_anode[4])
         );
  DFFNEGX1 \column_anode_reg[3]  ( .D(N128), .CLK(n151), .Q(column_anode[3])
         );
  DFFNEGX1 \column_anode_reg[2]  ( .D(N127), .CLK(n151), .Q(column_anode[2])
         );
  DFFNEGX1 \column_anode_reg[1]  ( .D(N126), .CLK(n151), .Q(column_anode[1])
         );
  DFFNEGX1 \column_anode_reg[0]  ( .D(N125), .CLK(n151), .Q(column_anode[0])
         );
  AND2X2 U3 ( .A(\cycle_count[1]1 ), .B(n31), .Y(n146) );
  AND2X2 U4 ( .A(n39), .B(n21), .Y(\game_state_temp[1] ) );
  AND2X2 U5 ( .A(n69), .B(n70), .Y(n68) );
  AND2X2 U6 ( .A(n78), .B(n79), .Y(n77) );
  AND2X2 U7 ( .A(n87), .B(n88), .Y(n86) );
  AND2X2 U8 ( .A(n96), .B(n97), .Y(n95) );
  AND2X2 U9 ( .A(n105), .B(n106), .Y(n104) );
  AND2X2 U10 ( .A(n114), .B(n115), .Y(n113) );
  AND2X2 U11 ( .A(n123), .B(n124), .Y(n122) );
  AND2X2 U12 ( .A(execution_state_next[1]), .B(execution_state_next[0]), .Y(
        n66) );
  AND2X2 U13 ( .A(n132), .B(n133), .Y(n131) );
  AND2X2 U14 ( .A(n141), .B(\current_row[0]1 ), .Y(n142) );
  AND2X2 U15 ( .A(n141), .B(n13), .Y(n143) );
  INVX2 U16 ( .A(execution_state_next[0]), .Y(n1) );
  INVX2 U17 ( .A(n47), .Y(n2) );
  INVX2 U18 ( .A(\cycle_count[1]1 ), .Y(n3) );
  INVX2 U19 ( .A(\cycle_count[0]1 ), .Y(n4) );
  INVX2 U20 ( .A(n33), .Y(n5) );
  INVX2 U23 ( .A(\current_row[2]1 ), .Y(n8) );
  INVX2 U26 ( .A(\current_row[1]1 ), .Y(n11) );
  INVX2 U27 ( .A(n38), .Y(n12) );
  INVX2 U29 ( .A(n40), .Y(n14) );
  INVX2 U30 ( .A(game_state[1]), .Y(n15) );
  INVX2 U31 ( .A(game_state[0]), .Y(n16) );
  INVX2 U32 ( .A(direction_state[1]), .Y(n17) );
  INVX2 U33 ( .A(execution_state[1]), .Y(n18) );
  INVX2 U34 ( .A(n32), .Y(n19) );
  INVX2 U35 ( .A(execution_state[0]), .Y(n20) );
  INVX2 U36 ( .A(restart), .Y(n21) );
  INVX2 U37 ( .A(n62), .Y(n22) );
  INVX2 U38 ( .A(n61), .Y(n23) );
  INVX2 U39 ( .A(direction_in[3]), .Y(n24) );
  INVX2 U40 ( .A(direction_in[2]), .Y(n25) );
  INVX2 U41 ( .A(direction_in[1]), .Y(n26) );
  INVX2 U42 ( .A(direction_in[0]), .Y(n27) );
  INVX2 U43 ( .A(from_logic[1]), .Y(n28) );
  OAI21X1 U44 ( .A(n29), .B(n4), .C(n30), .Y(n145) );
  NAND3X1 U45 ( .A(n29), .B(n4), .C(n19), .Y(n30) );
  OAI21X1 U46 ( .A(\cycle_count[0]1 ), .B(n32), .C(n29), .Y(n31) );
  OAI21X1 U47 ( .A(n32), .B(n33), .C(n21), .Y(n29) );
  OAI21X1 U48 ( .A(n12), .B(n8), .C(n34), .Y(n147) );
  NAND2X1 U49 ( .A(n19), .B(n35), .Y(n34) );
  OAI21X1 U50 ( .A(n13), .B(n9), .C(n7), .Y(n35) );
  OAI22X1 U51 ( .A(n13), .B(n36), .C(\current_row[0]1 ), .D(n32), .Y(n148) );
  OAI21X1 U52 ( .A(n12), .B(n11), .C(n37), .Y(n149) );
  NAND3X1 U53 ( .A(\current_row[0]1 ), .B(n11), .C(n19), .Y(n37) );
  OAI21X1 U54 ( .A(\current_row[0]1 ), .B(n32), .C(n36), .Y(n38) );
  NAND2X1 U55 ( .A(n21), .B(n32), .Y(n36) );
  OAI21X1 U56 ( .A(n28), .B(n16), .C(n15), .Y(n39) );
  NAND3X1 U57 ( .A(n15), .B(n21), .C(n41), .Y(n40) );
  OAI21X1 U58 ( .A(from_logic[1]), .B(n16), .C(n42), .Y(n41) );
  OAI21X1 U59 ( .A(direction_in[0]), .B(n43), .C(n16), .Y(n42) );
  AOI21X1 U60 ( .A(n44), .B(n45), .C(restart), .Y(execution_state_temp[1]) );
  OAI21X1 U61 ( .A(n46), .B(execution_state[1]), .C(n20), .Y(n45) );
  NOR2X1 U62 ( .A(game_state[1]), .B(game_state[0]), .Y(n46) );
  OAI21X1 U63 ( .A(n18), .B(n47), .C(execution_state[0]), .Y(n44) );
  OAI21X1 U64 ( .A(n2), .B(n32), .C(n48), .Y(execution_state_temp[0]) );
  OAI21X1 U65 ( .A(from_logic[0]), .B(n18), .C(n49), .Y(n48) );
  NOR2X1 U66 ( .A(restart), .B(execution_state[0]), .Y(n49) );
  NAND3X1 U67 ( .A(execution_state[0]), .B(n21), .C(execution_state[1]), .Y(
        n32) );
  NAND3X1 U68 ( .A(n5), .B(n3), .C(\cycle_count[0]1 ), .Y(n47) );
  NAND3X1 U69 ( .A(n50), .B(n21), .C(n51), .Y(direction_state_temp[1]) );
  AOI22X1 U70 ( .A(n52), .B(n53), .C(direction_state[1]), .D(n22), .Y(n51) );
  NOR2X1 U71 ( .A(direction_in[3]), .B(direction_in[1]), .Y(n53) );
  NOR2X1 U72 ( .A(direction_in[0]), .B(n25), .Y(n52) );
  OAI21X1 U73 ( .A(n54), .B(n17), .C(n55), .Y(direction_state_temp[0]) );
  AOI21X1 U74 ( .A(n56), .B(n17), .C(restart), .Y(n55) );
  NAND2X1 U75 ( .A(n57), .B(n50), .Y(n56) );
  NAND3X1 U76 ( .A(direction_in[3]), .B(n27), .C(n58), .Y(n50) );
  NOR2X1 U77 ( .A(direction_in[2]), .B(direction_in[1]), .Y(n58) );
  OAI21X1 U78 ( .A(n59), .B(n60), .C(direction_state[0]), .Y(n57) );
  NAND2X1 U79 ( .A(direction_in[2]), .B(n27), .Y(n60) );
  NAND2X1 U80 ( .A(n26), .B(n24), .Y(n59) );
  AOI21X1 U81 ( .A(direction_state[0]), .B(n22), .C(n23), .Y(n54) );
  OAI21X1 U82 ( .A(n43), .B(n27), .C(n61), .Y(n62) );
  NAND3X1 U83 ( .A(direction_in[1]), .B(n27), .C(n63), .Y(n61) );
  NOR2X1 U84 ( .A(direction_in[3]), .B(direction_in[2]), .Y(n63) );
  NAND3X1 U85 ( .A(n25), .B(n24), .C(n26), .Y(n43) );
  NOR2X1 U86 ( .A(n64), .B(n65), .Y(N132) );
  OAI21X1 U87 ( .A(led_array_flat[63]), .B(n33), .C(n66), .Y(n65) );
  OAI21X1 U88 ( .A(led_array_flat[55]), .B(n67), .C(n68), .Y(n64) );
  OAI21X1 U89 ( .A(n71), .B(n72), .C(n13), .Y(n70) );
  OAI22X1 U90 ( .A(led_array_flat[23]), .B(n9), .C(led_array_flat[7]), .D(n10), 
        .Y(n72) );
  NOR2X1 U91 ( .A(led_array_flat[39]), .B(n7), .Y(n71) );
  OAI21X1 U92 ( .A(n73), .B(n74), .C(\current_row[0]1 ), .Y(n69) );
  OAI22X1 U93 ( .A(led_array_flat[31]), .B(n9), .C(led_array_flat[15]), .D(n10), .Y(n74) );
  NOR2X1 U94 ( .A(led_array_flat[47]), .B(n7), .Y(n73) );
  NOR2X1 U95 ( .A(n75), .B(n76), .Y(N131) );
  OAI21X1 U96 ( .A(led_array_flat[62]), .B(n33), .C(n66), .Y(n76) );
  OAI21X1 U97 ( .A(led_array_flat[54]), .B(n67), .C(n77), .Y(n75) );
  OAI21X1 U98 ( .A(n80), .B(n81), .C(n13), .Y(n79) );
  OAI22X1 U99 ( .A(led_array_flat[22]), .B(n9), .C(led_array_flat[6]), .D(n10), 
        .Y(n81) );
  NOR2X1 U100 ( .A(led_array_flat[38]), .B(n7), .Y(n80) );
  OAI21X1 U101 ( .A(n82), .B(n83), .C(\current_row[0]1 ), .Y(n78) );
  OAI22X1 U102 ( .A(led_array_flat[30]), .B(n9), .C(led_array_flat[14]), .D(
        n10), .Y(n83) );
  NOR2X1 U103 ( .A(led_array_flat[46]), .B(n7), .Y(n82) );
  NOR2X1 U104 ( .A(n84), .B(n85), .Y(N130) );
  OAI21X1 U105 ( .A(led_array_flat[61]), .B(n33), .C(n66), .Y(n85) );
  OAI21X1 U106 ( .A(led_array_flat[53]), .B(n67), .C(n86), .Y(n84) );
  OAI21X1 U107 ( .A(n89), .B(n90), .C(n13), .Y(n88) );
  OAI22X1 U108 ( .A(led_array_flat[21]), .B(n9), .C(led_array_flat[5]), .D(n10), .Y(n90) );
  NOR2X1 U109 ( .A(led_array_flat[37]), .B(n7), .Y(n89) );
  OAI21X1 U110 ( .A(n91), .B(n92), .C(\current_row[0]1 ), .Y(n87) );
  OAI22X1 U111 ( .A(led_array_flat[29]), .B(n9), .C(led_array_flat[13]), .D(
        n10), .Y(n92) );
  NOR2X1 U112 ( .A(led_array_flat[45]), .B(n7), .Y(n91) );
  NOR2X1 U113 ( .A(n93), .B(n94), .Y(N129) );
  OAI21X1 U114 ( .A(led_array_flat[60]), .B(n33), .C(n66), .Y(n94) );
  OAI21X1 U115 ( .A(led_array_flat[52]), .B(n67), .C(n95), .Y(n93) );
  OAI21X1 U116 ( .A(n98), .B(n99), .C(n13), .Y(n97) );
  OAI22X1 U117 ( .A(led_array_flat[20]), .B(n9), .C(led_array_flat[4]), .D(n10), .Y(n99) );
  NOR2X1 U118 ( .A(led_array_flat[36]), .B(n7), .Y(n98) );
  OAI21X1 U119 ( .A(n100), .B(n101), .C(\current_row[0]1 ), .Y(n96) );
  OAI22X1 U120 ( .A(led_array_flat[28]), .B(n9), .C(led_array_flat[12]), .D(
        n10), .Y(n101) );
  NOR2X1 U121 ( .A(led_array_flat[44]), .B(n7), .Y(n100) );
  NOR2X1 U122 ( .A(n102), .B(n103), .Y(N128) );
  OAI21X1 U123 ( .A(led_array_flat[59]), .B(n33), .C(n66), .Y(n103) );
  OAI21X1 U124 ( .A(led_array_flat[51]), .B(n67), .C(n104), .Y(n102) );
  OAI21X1 U125 ( .A(n107), .B(n108), .C(n13), .Y(n106) );
  OAI22X1 U126 ( .A(led_array_flat[19]), .B(n9), .C(led_array_flat[3]), .D(n10), .Y(n108) );
  NOR2X1 U127 ( .A(led_array_flat[35]), .B(n7), .Y(n107) );
  OAI21X1 U128 ( .A(n109), .B(n110), .C(\current_row[0]1 ), .Y(n105) );
  OAI22X1 U129 ( .A(led_array_flat[27]), .B(n9), .C(led_array_flat[11]), .D(
        n10), .Y(n110) );
  NOR2X1 U130 ( .A(led_array_flat[43]), .B(n7), .Y(n109) );
  NOR2X1 U131 ( .A(n111), .B(n112), .Y(N127) );
  OAI21X1 U132 ( .A(led_array_flat[58]), .B(n33), .C(n66), .Y(n112) );
  OAI21X1 U133 ( .A(led_array_flat[50]), .B(n67), .C(n113), .Y(n111) );
  OAI21X1 U134 ( .A(n116), .B(n117), .C(n13), .Y(n115) );
  OAI22X1 U135 ( .A(led_array_flat[18]), .B(n9), .C(led_array_flat[2]), .D(n10), .Y(n117) );
  NOR2X1 U136 ( .A(led_array_flat[34]), .B(n7), .Y(n116) );
  OAI21X1 U137 ( .A(n118), .B(n119), .C(\current_row[0]1 ), .Y(n114) );
  OAI22X1 U138 ( .A(led_array_flat[26]), .B(n9), .C(led_array_flat[10]), .D(
        n10), .Y(n119) );
  NOR2X1 U139 ( .A(led_array_flat[42]), .B(n7), .Y(n118) );
  NOR2X1 U140 ( .A(n120), .B(n121), .Y(N126) );
  OAI21X1 U141 ( .A(led_array_flat[57]), .B(n33), .C(n66), .Y(n121) );
  OAI21X1 U142 ( .A(led_array_flat[49]), .B(n67), .C(n122), .Y(n120) );
  OAI21X1 U143 ( .A(n125), .B(n126), .C(n13), .Y(n124) );
  OAI22X1 U144 ( .A(led_array_flat[17]), .B(n9), .C(led_array_flat[1]), .D(n10), .Y(n126) );
  NOR2X1 U145 ( .A(led_array_flat[33]), .B(n7), .Y(n125) );
  OAI21X1 U146 ( .A(n127), .B(n128), .C(\current_row[0]1 ), .Y(n123) );
  OAI22X1 U147 ( .A(led_array_flat[25]), .B(n9), .C(led_array_flat[9]), .D(n10), .Y(n128) );
  NOR2X1 U148 ( .A(led_array_flat[41]), .B(n7), .Y(n127) );
  NOR2X1 U149 ( .A(n129), .B(n130), .Y(N125) );
  OAI21X1 U150 ( .A(led_array_flat[56]), .B(n33), .C(n66), .Y(n130) );
  OAI21X1 U151 ( .A(led_array_flat[48]), .B(n67), .C(n131), .Y(n129) );
  OAI21X1 U152 ( .A(n134), .B(n135), .C(n13), .Y(n133) );
  OAI22X1 U153 ( .A(led_array_flat[16]), .B(n9), .C(led_array_flat[0]), .D(n10), .Y(n135) );
  NOR2X1 U154 ( .A(led_array_flat[32]), .B(n7), .Y(n134) );
  OAI21X1 U155 ( .A(n136), .B(n137), .C(\current_row[0]1 ), .Y(n132) );
  OAI22X1 U156 ( .A(led_array_flat[24]), .B(n9), .C(led_array_flat[8]), .D(n10), .Y(n137) );
  NOR2X1 U157 ( .A(led_array_flat[40]), .B(n7), .Y(n136) );
  NAND2X1 U158 ( .A(n141), .B(n5), .Y(N124) );
  NAND3X1 U159 ( .A(\current_row[1]1 ), .B(\current_row[0]1 ), .C(
        \current_row[2]1 ), .Y(n33) );
  NAND2X1 U160 ( .A(n141), .B(n150), .Y(N123) );
  NAND3X1 U161 ( .A(\current_row[1]1 ), .B(n13), .C(\current_row[2]1 ), .Y(n67) );
  NAND2X1 U162 ( .A(n142), .B(n140), .Y(N122) );
  NAND2X1 U163 ( .A(n143), .B(n140), .Y(N121) );
  NOR2X1 U164 ( .A(n8), .B(\current_row[1]1 ), .Y(n140) );
  NAND2X1 U165 ( .A(n142), .B(n139), .Y(N120) );
  NAND2X1 U166 ( .A(n143), .B(n139), .Y(N119) );
  NOR2X1 U167 ( .A(n11), .B(\current_row[2]1 ), .Y(n139) );
  NAND2X1 U168 ( .A(n142), .B(n138), .Y(N118) );
  NAND2X1 U169 ( .A(n143), .B(n138), .Y(N117) );
  NOR2X1 U170 ( .A(\current_row[1]1 ), .B(\current_row[2]1 ), .Y(n138) );
  NOR2X1 U171 ( .A(n1), .B(N115), .Y(n141) );
  NOR2X1 U172 ( .A(n15), .B(n144), .Y(N116) );
  NAND2X1 U173 ( .A(N115), .B(n16), .Y(n144) );
  NOR2X1 U174 ( .A(n1), .B(execution_state_next[1]), .Y(N115) );
  INVX2 U175 ( .A(\current_row[0]1 ), .Y(n13) );
  INVX2 U176 ( .A(n139), .Y(n9) );
  INVX2 U177 ( .A(n140), .Y(n7) );
  INVX2 U178 ( .A(n138), .Y(n10) );
  INVX2 U179 ( .A(n152), .Y(n151) );
  INVX2 U180 ( .A(clkb), .Y(n152) );
  INVX2 U181 ( .A(n67), .Y(n150) );
endmodule

