/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Expert(TM) in wire load mode
// Version   : U-2022.12-SP7
// Date      : Mon Apr 14 17:30:18 2025
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
         \current_row[0]1 , \cycle_count[1]1 , \cycle_count[0]1 , N114, N115,
         N116, N117, N118, N119, N120, N121, N122, N123, N124, N125, N126,
         N127, N128, N129, N130, N131, n1, n2, n3, n4, n5, n7, n9, n10, n11,
         n12, n13, n14, n16, n17, n18, n19, n20, n21, n22, n23, n24, n25, n26,
         n27, n28, n29, n30, n31, n32, n33, n34, n35, n36, n37, n38, n39, n40,
         n41, n42, n43, n44, n45, n46, n47, n48, n49, n50, n51, n52, n53, n54,
         n55, n56, n57, n58, n59, n60, n61, n62, n63, n64, n65, n66, n67, n68,
         n69, n70, n71, n72, n73, n74, n75, n76, n77, n78, n79, n80, n81, n82,
         n83, n84, n85, n86, n87, n88, n89, n90, n91, n92, n93, n94, n95, n96,
         n97, n98, n99, n100, n101, n102, n103, n104, n105, n106, n107, n108,
         n109, n110, n111, n112, n113, n114, n115, n116, n117, n118, n119,
         n120, n121, n122, n123, n124, n125, n126, n127, n128, n129, n130,
         n131, n132, n133, n134, n135, n136, n137, n138, n139, n140, n141,
         n142, n143, n144, n145, n146, n147, n148, n149, n150, n151, n152,
         n153, n154, n155, n156, n157, n158;
  wire   [1:0] direction_state_temp;
  wire   [1:0] execution_state_temp;
  wire   [1:0] game_state_next;
  wire   [1:0] direction_state_next;
  wire   [1:0] execution_state_next;

  DFFNEGX1 \game_state_reg[0]  ( .D(game_state_next[0]), .CLK(n157), .Q(
        game_state[0]) );
  DFFNEGX1 \game_state_next_reg[1]  ( .D(\game_state_temp[1] ), .CLK(clka), 
        .Q(game_state_next[1]) );
  DFFNEGX1 \game_state_reg[1]  ( .D(game_state_next[1]), .CLK(n157), .Q(
        game_state[1]) );
  DFFNEGX1 \game_state_next_reg[0]  ( .D(n16), .CLK(clka), .Q(
        game_state_next[0]) );
  DFFNEGX1 \direction_state_reg[1]  ( .D(direction_state_next[1]), .CLK(n157), 
        .Q(direction_state[1]) );
  DFFNEGX1 \direction_state_next_reg[1]  ( .D(direction_state_temp[1]), .CLK(
        clka), .Q(direction_state_next[1]) );
  DFFNEGX1 \direction_state_reg[0]  ( .D(direction_state_next[0]), .CLK(n157), 
        .Q(direction_state[0]) );
  DFFNEGX1 \direction_state_next_reg[0]  ( .D(direction_state_temp[0]), .CLK(
        clka), .Q(direction_state_next[0]) );
  DFFNEGX1 \execution_state_reg[0]  ( .D(execution_state_next[0]), .CLK(clkb), 
        .Q(execution_state[0]) );
  DFFNEGX1 \execution_state_next_reg[1]  ( .D(execution_state_temp[1]), .CLK(
        clka), .Q(execution_state_next[1]) );
  DFFNEGX1 \execution_state_reg[1]  ( .D(execution_state_next[1]), .CLK(clkb), 
        .Q(execution_state[1]) );
  DFFNEGX1 \current_row_reg[0]  ( .D(n152), .CLK(clka), .Q(\current_row[0]1 )
         );
  DFFNEGX1 \current_row_reg[1]  ( .D(n153), .CLK(clka), .Q(\current_row[1]1 )
         );
  DFFNEGX1 \current_row_reg[2]  ( .D(n151), .CLK(clka), .Q(\current_row[2]1 )
         );
  DFFNEGX1 \cycle_count_reg[0]  ( .D(n149), .CLK(clka), .Q(\cycle_count[0]1 )
         );
  DFFNEGX1 \cycle_count_reg[1]  ( .D(n150), .CLK(clka), .Q(\cycle_count[1]1 )
         );
  DFFNEGX1 \execution_state_next_reg[0]  ( .D(execution_state_temp[0]), .CLK(
        clka), .Q(execution_state_next[0]) );
  DFFNEGX1 \to_logic_reg[0]  ( .D(N114), .CLK(clkb), .Q(to_logic[0]) );
  DFFNEGX1 \to_logic_reg[1]  ( .D(N115), .CLK(clkb), .Q(to_logic[1]) );
  DFFNEGX1 \row_cathode_reg[7]  ( .D(N123), .CLK(clkb), .Q(row_cathode[7]) );
  DFFNEGX1 \row_cathode_reg[6]  ( .D(N122), .CLK(clkb), .Q(row_cathode[6]) );
  DFFNEGX1 \row_cathode_reg[5]  ( .D(N121), .CLK(clkb), .Q(row_cathode[5]) );
  DFFNEGX1 \row_cathode_reg[3]  ( .D(N119), .CLK(n157), .Q(row_cathode[3]) );
  DFFNEGX1 \row_cathode_reg[1]  ( .D(N117), .CLK(n157), .Q(row_cathode[1]) );
  DFFNEGX1 \row_cathode_reg[4]  ( .D(N120), .CLK(n157), .Q(row_cathode[4]) );
  DFFNEGX1 \row_cathode_reg[2]  ( .D(N118), .CLK(n157), .Q(row_cathode[2]) );
  DFFNEGX1 \row_cathode_reg[0]  ( .D(N116), .CLK(n157), .Q(row_cathode[0]) );
  DFFNEGX1 \column_anode_reg[7]  ( .D(N131), .CLK(n157), .Q(column_anode[7])
         );
  DFFNEGX1 \column_anode_reg[6]  ( .D(N130), .CLK(n157), .Q(column_anode[6])
         );
  DFFNEGX1 \column_anode_reg[5]  ( .D(N129), .CLK(n157), .Q(column_anode[5])
         );
  DFFNEGX1 \column_anode_reg[4]  ( .D(N128), .CLK(n157), .Q(column_anode[4])
         );
  DFFNEGX1 \column_anode_reg[3]  ( .D(N127), .CLK(n157), .Q(column_anode[3])
         );
  DFFNEGX1 \column_anode_reg[2]  ( .D(N126), .CLK(n157), .Q(column_anode[2])
         );
  DFFNEGX1 \column_anode_reg[1]  ( .D(N125), .CLK(n157), .Q(column_anode[1])
         );
  DFFNEGX1 \column_anode_reg[0]  ( .D(N124), .CLK(n157), .Q(column_anode[0])
         );
  AND2X2 U3 ( .A(n43), .B(n23), .Y(\game_state_temp[1] ) );
  AND2X2 U4 ( .A(n73), .B(n74), .Y(n72) );
  AND2X2 U5 ( .A(n82), .B(n83), .Y(n81) );
  AND2X2 U6 ( .A(n91), .B(n92), .Y(n90) );
  AND2X2 U7 ( .A(n100), .B(n101), .Y(n99) );
  AND2X2 U8 ( .A(n109), .B(n110), .Y(n108) );
  AND2X2 U9 ( .A(n118), .B(n119), .Y(n117) );
  AND2X2 U10 ( .A(n127), .B(n128), .Y(n126) );
  AND2X2 U11 ( .A(execution_state_next[1]), .B(execution_state_next[0]), .Y(
        n70) );
  AND2X2 U12 ( .A(n136), .B(n137), .Y(n135) );
  AND2X2 U13 ( .A(n145), .B(\current_row[0]1 ), .Y(n146) );
  AND2X2 U14 ( .A(n145), .B(n156), .Y(n147) );
  INVX2 U15 ( .A(execution_state_next[0]), .Y(n1) );
  INVX2 U16 ( .A(n32), .Y(n2) );
  INVX2 U17 ( .A(n51), .Y(n3) );
  INVX2 U18 ( .A(\cycle_count[1]1 ), .Y(n4) );
  INVX2 U19 ( .A(\cycle_count[0]1 ), .Y(n5) );
  INVX2 U21 ( .A(n31), .Y(n7) );
  INVX2 U24 ( .A(\current_row[2]1 ), .Y(n10) );
  INVX2 U27 ( .A(\current_row[1]1 ), .Y(n13) );
  INVX2 U28 ( .A(n42), .Y(n14) );
  INVX2 U30 ( .A(n44), .Y(n16) );
  INVX2 U31 ( .A(game_state[1]), .Y(n17) );
  INVX2 U32 ( .A(game_state[0]), .Y(n18) );
  INVX2 U33 ( .A(direction_state[1]), .Y(n19) );
  INVX2 U34 ( .A(execution_state[1]), .Y(n20) );
  INVX2 U35 ( .A(n36), .Y(n21) );
  INVX2 U36 ( .A(execution_state[0]), .Y(n22) );
  INVX2 U37 ( .A(restart), .Y(n23) );
  INVX2 U38 ( .A(n66), .Y(n24) );
  INVX2 U39 ( .A(n65), .Y(n25) );
  INVX2 U40 ( .A(direction_in[3]), .Y(n26) );
  INVX2 U41 ( .A(direction_in[2]), .Y(n27) );
  INVX2 U42 ( .A(direction_in[1]), .Y(n28) );
  INVX2 U43 ( .A(direction_in[0]), .Y(n29) );
  INVX2 U44 ( .A(from_logic[1]), .Y(n30) );
  OAI22X1 U45 ( .A(n31), .B(n5), .C(n7), .D(n32), .Y(n149) );
  OAI21X1 U46 ( .A(n4), .B(n31), .C(n33), .Y(n150) );
  AOI21X1 U47 ( .A(n34), .B(n35), .C(n2), .Y(n33) );
  NAND3X1 U48 ( .A(n21), .B(n5), .C(\cycle_count[1]1 ), .Y(n32) );
  NOR2X1 U49 ( .A(\cycle_count[1]1 ), .B(n7), .Y(n35) );
  NOR2X1 U50 ( .A(n36), .B(n5), .Y(n34) );
  OAI21X1 U51 ( .A(n36), .B(n37), .C(n23), .Y(n31) );
  OAI21X1 U52 ( .A(n14), .B(n10), .C(n38), .Y(n151) );
  NAND2X1 U53 ( .A(n21), .B(n39), .Y(n38) );
  OAI21X1 U54 ( .A(n156), .B(n11), .C(n9), .Y(n39) );
  OAI22X1 U55 ( .A(n156), .B(n40), .C(\current_row[0]1 ), .D(n36), .Y(n152) );
  OAI21X1 U56 ( .A(n14), .B(n13), .C(n41), .Y(n153) );
  NAND3X1 U57 ( .A(n21), .B(n13), .C(\current_row[0]1 ), .Y(n41) );
  OAI21X1 U58 ( .A(\current_row[0]1 ), .B(n36), .C(n40), .Y(n42) );
  NAND2X1 U59 ( .A(n23), .B(n36), .Y(n40) );
  OAI21X1 U60 ( .A(n30), .B(n18), .C(n17), .Y(n43) );
  NAND3X1 U61 ( .A(n17), .B(n23), .C(n45), .Y(n44) );
  OAI21X1 U62 ( .A(from_logic[1]), .B(n18), .C(n46), .Y(n45) );
  OAI21X1 U63 ( .A(direction_in[0]), .B(n47), .C(n18), .Y(n46) );
  AOI21X1 U64 ( .A(n48), .B(n49), .C(restart), .Y(execution_state_temp[1]) );
  OAI21X1 U65 ( .A(n50), .B(execution_state[1]), .C(n22), .Y(n49) );
  NOR2X1 U66 ( .A(game_state[1]), .B(game_state[0]), .Y(n50) );
  OAI21X1 U67 ( .A(n20), .B(n51), .C(execution_state[0]), .Y(n48) );
  OAI21X1 U68 ( .A(n3), .B(n36), .C(n52), .Y(execution_state_temp[0]) );
  OAI21X1 U69 ( .A(from_logic[0]), .B(n20), .C(n53), .Y(n52) );
  NOR2X1 U70 ( .A(restart), .B(execution_state[0]), .Y(n53) );
  NAND3X1 U71 ( .A(execution_state[0]), .B(n23), .C(execution_state[1]), .Y(
        n36) );
  NAND3X1 U72 ( .A(n5), .B(n4), .C(n155), .Y(n51) );
  NAND3X1 U73 ( .A(n54), .B(n23), .C(n55), .Y(direction_state_temp[1]) );
  AOI22X1 U74 ( .A(n56), .B(n57), .C(direction_state[1]), .D(n24), .Y(n55) );
  NOR2X1 U75 ( .A(direction_in[3]), .B(direction_in[1]), .Y(n57) );
  NOR2X1 U76 ( .A(direction_in[0]), .B(n27), .Y(n56) );
  OAI21X1 U77 ( .A(n58), .B(n19), .C(n59), .Y(direction_state_temp[0]) );
  AOI21X1 U78 ( .A(n60), .B(n19), .C(restart), .Y(n59) );
  NAND2X1 U79 ( .A(n61), .B(n54), .Y(n60) );
  NAND3X1 U80 ( .A(direction_in[3]), .B(n29), .C(n62), .Y(n54) );
  NOR2X1 U81 ( .A(direction_in[2]), .B(direction_in[1]), .Y(n62) );
  OAI21X1 U82 ( .A(n63), .B(n64), .C(direction_state[0]), .Y(n61) );
  NAND2X1 U83 ( .A(direction_in[2]), .B(n29), .Y(n64) );
  NAND2X1 U84 ( .A(n28), .B(n26), .Y(n63) );
  AOI21X1 U85 ( .A(direction_state[0]), .B(n24), .C(n25), .Y(n58) );
  OAI21X1 U86 ( .A(n47), .B(n29), .C(n65), .Y(n66) );
  NAND3X1 U87 ( .A(direction_in[1]), .B(n29), .C(n67), .Y(n65) );
  NOR2X1 U88 ( .A(direction_in[3]), .B(direction_in[2]), .Y(n67) );
  NAND3X1 U89 ( .A(n27), .B(n26), .C(n28), .Y(n47) );
  NOR2X1 U90 ( .A(n68), .B(n69), .Y(N131) );
  OAI21X1 U91 ( .A(led_array_flat[63]), .B(n37), .C(n70), .Y(n69) );
  OAI21X1 U92 ( .A(led_array_flat[55]), .B(n71), .C(n72), .Y(n68) );
  OAI21X1 U93 ( .A(n75), .B(n76), .C(n156), .Y(n74) );
  OAI22X1 U94 ( .A(led_array_flat[23]), .B(n11), .C(led_array_flat[7]), .D(n12), .Y(n76) );
  NOR2X1 U95 ( .A(led_array_flat[39]), .B(n9), .Y(n75) );
  OAI21X1 U96 ( .A(n77), .B(n78), .C(\current_row[0]1 ), .Y(n73) );
  OAI22X1 U97 ( .A(led_array_flat[31]), .B(n11), .C(led_array_flat[15]), .D(
        n12), .Y(n78) );
  NOR2X1 U98 ( .A(led_array_flat[47]), .B(n9), .Y(n77) );
  NOR2X1 U99 ( .A(n79), .B(n80), .Y(N130) );
  OAI21X1 U100 ( .A(led_array_flat[62]), .B(n37), .C(n70), .Y(n80) );
  OAI21X1 U101 ( .A(led_array_flat[54]), .B(n71), .C(n81), .Y(n79) );
  OAI21X1 U102 ( .A(n84), .B(n85), .C(n156), .Y(n83) );
  OAI22X1 U103 ( .A(led_array_flat[22]), .B(n11), .C(led_array_flat[6]), .D(
        n12), .Y(n85) );
  NOR2X1 U104 ( .A(led_array_flat[38]), .B(n9), .Y(n84) );
  OAI21X1 U105 ( .A(n86), .B(n87), .C(\current_row[0]1 ), .Y(n82) );
  OAI22X1 U106 ( .A(led_array_flat[30]), .B(n11), .C(led_array_flat[14]), .D(
        n12), .Y(n87) );
  NOR2X1 U107 ( .A(led_array_flat[46]), .B(n9), .Y(n86) );
  NOR2X1 U108 ( .A(n88), .B(n89), .Y(N129) );
  OAI21X1 U109 ( .A(led_array_flat[61]), .B(n37), .C(n70), .Y(n89) );
  OAI21X1 U110 ( .A(led_array_flat[53]), .B(n71), .C(n90), .Y(n88) );
  OAI21X1 U111 ( .A(n93), .B(n94), .C(n156), .Y(n92) );
  OAI22X1 U112 ( .A(led_array_flat[21]), .B(n11), .C(led_array_flat[5]), .D(
        n12), .Y(n94) );
  NOR2X1 U113 ( .A(led_array_flat[37]), .B(n9), .Y(n93) );
  OAI21X1 U114 ( .A(n95), .B(n96), .C(\current_row[0]1 ), .Y(n91) );
  OAI22X1 U115 ( .A(led_array_flat[29]), .B(n11), .C(led_array_flat[13]), .D(
        n12), .Y(n96) );
  NOR2X1 U116 ( .A(led_array_flat[45]), .B(n9), .Y(n95) );
  NOR2X1 U117 ( .A(n97), .B(n98), .Y(N128) );
  OAI21X1 U118 ( .A(led_array_flat[60]), .B(n37), .C(n70), .Y(n98) );
  OAI21X1 U119 ( .A(led_array_flat[52]), .B(n71), .C(n99), .Y(n97) );
  OAI21X1 U120 ( .A(n102), .B(n103), .C(n156), .Y(n101) );
  OAI22X1 U121 ( .A(led_array_flat[20]), .B(n11), .C(led_array_flat[4]), .D(
        n12), .Y(n103) );
  NOR2X1 U122 ( .A(led_array_flat[36]), .B(n9), .Y(n102) );
  OAI21X1 U123 ( .A(n104), .B(n105), .C(\current_row[0]1 ), .Y(n100) );
  OAI22X1 U124 ( .A(led_array_flat[28]), .B(n11), .C(led_array_flat[12]), .D(
        n12), .Y(n105) );
  NOR2X1 U125 ( .A(led_array_flat[44]), .B(n9), .Y(n104) );
  NOR2X1 U126 ( .A(n106), .B(n107), .Y(N127) );
  OAI21X1 U127 ( .A(led_array_flat[59]), .B(n37), .C(n70), .Y(n107) );
  OAI21X1 U128 ( .A(led_array_flat[51]), .B(n71), .C(n108), .Y(n106) );
  OAI21X1 U129 ( .A(n111), .B(n112), .C(n156), .Y(n110) );
  OAI22X1 U130 ( .A(led_array_flat[19]), .B(n11), .C(led_array_flat[3]), .D(
        n12), .Y(n112) );
  NOR2X1 U131 ( .A(led_array_flat[35]), .B(n9), .Y(n111) );
  OAI21X1 U132 ( .A(n113), .B(n114), .C(\current_row[0]1 ), .Y(n109) );
  OAI22X1 U133 ( .A(led_array_flat[27]), .B(n11), .C(led_array_flat[11]), .D(
        n12), .Y(n114) );
  NOR2X1 U134 ( .A(led_array_flat[43]), .B(n9), .Y(n113) );
  NOR2X1 U135 ( .A(n115), .B(n116), .Y(N126) );
  OAI21X1 U136 ( .A(led_array_flat[58]), .B(n37), .C(n70), .Y(n116) );
  OAI21X1 U137 ( .A(led_array_flat[50]), .B(n71), .C(n117), .Y(n115) );
  OAI21X1 U138 ( .A(n120), .B(n121), .C(n156), .Y(n119) );
  OAI22X1 U139 ( .A(led_array_flat[18]), .B(n11), .C(led_array_flat[2]), .D(
        n12), .Y(n121) );
  NOR2X1 U140 ( .A(led_array_flat[34]), .B(n9), .Y(n120) );
  OAI21X1 U141 ( .A(n122), .B(n123), .C(\current_row[0]1 ), .Y(n118) );
  OAI22X1 U142 ( .A(led_array_flat[26]), .B(n11), .C(led_array_flat[10]), .D(
        n12), .Y(n123) );
  NOR2X1 U143 ( .A(led_array_flat[42]), .B(n9), .Y(n122) );
  NOR2X1 U144 ( .A(n124), .B(n125), .Y(N125) );
  OAI21X1 U145 ( .A(led_array_flat[57]), .B(n37), .C(n70), .Y(n125) );
  OAI21X1 U146 ( .A(led_array_flat[49]), .B(n71), .C(n126), .Y(n124) );
  OAI21X1 U147 ( .A(n129), .B(n130), .C(n156), .Y(n128) );
  OAI22X1 U148 ( .A(led_array_flat[17]), .B(n11), .C(led_array_flat[1]), .D(
        n12), .Y(n130) );
  NOR2X1 U149 ( .A(led_array_flat[33]), .B(n9), .Y(n129) );
  OAI21X1 U150 ( .A(n131), .B(n132), .C(\current_row[0]1 ), .Y(n127) );
  OAI22X1 U151 ( .A(led_array_flat[25]), .B(n11), .C(led_array_flat[9]), .D(
        n12), .Y(n132) );
  NOR2X1 U152 ( .A(led_array_flat[41]), .B(n9), .Y(n131) );
  NOR2X1 U153 ( .A(n133), .B(n134), .Y(N124) );
  OAI21X1 U154 ( .A(led_array_flat[56]), .B(n37), .C(n70), .Y(n134) );
  OAI21X1 U155 ( .A(led_array_flat[48]), .B(n71), .C(n135), .Y(n133) );
  OAI21X1 U156 ( .A(n138), .B(n139), .C(n156), .Y(n137) );
  OAI22X1 U157 ( .A(led_array_flat[16]), .B(n11), .C(led_array_flat[0]), .D(
        n12), .Y(n139) );
  NOR2X1 U158 ( .A(led_array_flat[32]), .B(n9), .Y(n138) );
  OAI21X1 U159 ( .A(n140), .B(n141), .C(\current_row[0]1 ), .Y(n136) );
  OAI22X1 U160 ( .A(led_array_flat[24]), .B(n11), .C(led_array_flat[8]), .D(
        n12), .Y(n141) );
  NOR2X1 U161 ( .A(led_array_flat[40]), .B(n9), .Y(n140) );
  NAND2X1 U162 ( .A(n145), .B(n155), .Y(N123) );
  NAND3X1 U163 ( .A(\current_row[1]1 ), .B(\current_row[0]1 ), .C(
        \current_row[2]1 ), .Y(n37) );
  NAND2X1 U164 ( .A(n145), .B(n154), .Y(N122) );
  NAND3X1 U165 ( .A(\current_row[1]1 ), .B(n156), .C(\current_row[2]1 ), .Y(
        n71) );
  NAND2X1 U166 ( .A(n146), .B(n144), .Y(N121) );
  NAND2X1 U167 ( .A(n147), .B(n144), .Y(N120) );
  NOR2X1 U168 ( .A(n10), .B(\current_row[1]1 ), .Y(n144) );
  NAND2X1 U169 ( .A(n146), .B(n143), .Y(N119) );
  NAND2X1 U170 ( .A(n147), .B(n143), .Y(N118) );
  NOR2X1 U171 ( .A(n13), .B(\current_row[2]1 ), .Y(n143) );
  NAND2X1 U172 ( .A(n146), .B(n142), .Y(N117) );
  NAND2X1 U173 ( .A(n147), .B(n142), .Y(N116) );
  NOR2X1 U174 ( .A(\current_row[1]1 ), .B(\current_row[2]1 ), .Y(n142) );
  NOR2X1 U175 ( .A(n1), .B(N114), .Y(n145) );
  NOR2X1 U176 ( .A(n17), .B(n148), .Y(N115) );
  NAND2X1 U177 ( .A(N114), .B(n18), .Y(n148) );
  NOR2X1 U178 ( .A(n1), .B(execution_state_next[1]), .Y(N114) );
  INVX2 U179 ( .A(n143), .Y(n11) );
  INVX2 U180 ( .A(n144), .Y(n9) );
  INVX2 U181 ( .A(n142), .Y(n12) );
  INVX2 U182 ( .A(n158), .Y(n157) );
  INVX2 U183 ( .A(\current_row[0]1 ), .Y(n156) );
  INVX2 U184 ( .A(n37), .Y(n155) );
  INVX2 U185 ( .A(clkb), .Y(n158) );
  INVX2 U186 ( .A(n71), .Y(n154) );
endmodule

