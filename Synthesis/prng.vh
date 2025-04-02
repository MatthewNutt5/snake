/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Expert(TM) in wire load mode
// Version   : U-2022.12-SP7
// Date      : Tue Apr  1 19:56:14 2025
/////////////////////////////////////////////////////////////


module prng ( clka, clkb, restart, request_rand, random_num );
  output [5:0] random_num;
  input clka, clkb, restart, request_rand;
  wire   restart_temp, request_rand_temp, n1, n2, n3, n4, n5, n6, n7, n8, n9,
         n10, n11, n12, n13, n14, n15, n16, n17, n18, n19, n20, n21, n22;

  DFFNEGX1 restart_temp_reg ( .D(restart), .CLK(clka), .Q(restart_temp) );
  DFFNEGX1 request_rand_temp_reg ( .D(request_rand), .CLK(clka), .Q(
        request_rand_temp) );
  DFFNEGX1 \random_num_reg[0]  ( .D(n22), .CLK(clkb), .Q(random_num[0]) );
  DFFNEGX1 \random_num_reg[5]  ( .D(n17), .CLK(clkb), .Q(random_num[5]) );
  DFFNEGX1 \random_num_reg[4]  ( .D(n18), .CLK(clkb), .Q(random_num[4]) );
  DFFNEGX1 \random_num_reg[3]  ( .D(n19), .CLK(clkb), .Q(random_num[3]) );
  DFFNEGX1 \random_num_reg[2]  ( .D(n20), .CLK(clkb), .Q(random_num[2]) );
  DFFNEGX1 \random_num_reg[1]  ( .D(n21), .CLK(clkb), .Q(random_num[1]) );
  INVX2 U3 ( .A(n10), .Y(n1) );
  INVX2 U4 ( .A(restart_temp), .Y(n2) );
  INVX2 U5 ( .A(request_rand_temp), .Y(n3) );
  INVX2 U6 ( .A(random_num[4]), .Y(n4) );
  INVX2 U7 ( .A(random_num[3]), .Y(n5) );
  INVX2 U8 ( .A(random_num[2]), .Y(n6) );
  INVX2 U9 ( .A(random_num[1]), .Y(n7) );
  INVX2 U10 ( .A(random_num[0]), .Y(n8) );
  OAI21X1 U11 ( .A(n9), .B(n10), .C(n11), .Y(n17) );
  NAND3X1 U12 ( .A(n3), .B(n2), .C(random_num[5]), .Y(n11) );
  XOR2X1 U13 ( .A(n8), .B(random_num[1]), .Y(n9) );
  OAI21X1 U14 ( .A(n12), .B(n4), .C(n13), .Y(n18) );
  AOI21X1 U15 ( .A(n1), .B(random_num[5]), .C(restart_temp), .Y(n13) );
  OAI21X1 U16 ( .A(n12), .B(n5), .C(n14), .Y(n19) );
  AOI21X1 U17 ( .A(random_num[4]), .B(n1), .C(restart_temp), .Y(n14) );
  OAI21X1 U18 ( .A(n12), .B(n6), .C(n15), .Y(n20) );
  AOI21X1 U19 ( .A(random_num[3]), .B(n1), .C(restart_temp), .Y(n15) );
  OAI22X1 U20 ( .A(n7), .B(n12), .C(n10), .D(n6), .Y(n21) );
  OAI21X1 U21 ( .A(n8), .B(n12), .C(n16), .Y(n22) );
  AOI21X1 U22 ( .A(n1), .B(random_num[1]), .C(restart_temp), .Y(n16) );
  NAND2X1 U23 ( .A(n2), .B(n10), .Y(n12) );
  NAND2X1 U24 ( .A(request_rand_temp), .B(n2), .Y(n10) );
endmodule

