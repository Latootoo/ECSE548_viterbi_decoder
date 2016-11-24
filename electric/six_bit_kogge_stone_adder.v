/* Verilog for cell 'six_bit_kogge_stone_adder{sch}' from library 'Project' */
/* Created on Thu Nov 24, 2016 14:25:08 */
/* Last revised on Thu Nov 24, 2016 15:13:58 */
/* Written on Thu Nov 24, 2016 16:21:10 by Electric VLSI Design System, version 8.06 */

module Project__and2_1x(a, b, y);
  input a;
  input b;
  output y;

  supply1 vdd;
  supply0 gnd;
  wire net_1, net_2;

  tranif1 nmos_0(net_1, net_2, b);
  tranif1 nmos_1(gnd, net_1, a);
  tranif1 nmos_2(gnd, y, net_2);
  tranif0 pmos_0(net_2, vdd, b);
  tranif0 pmos_1(net_2, vdd, a);
  tranif0 pmos_2(y, vdd, net_2);
endmodule   /* Project__and2_1x */

module Project__xor2_1x(a, b, y);
  input a;
  input b;
  output y;

  supply1 vdd;
  supply0 gnd;
  wire ab, bb, net_3, net_4, net_7, net_8;

  tranif1 nmos_0(gnd, net_3, a);
  tranif1 nmos_1(gnd, net_4, ab);
  tranif1 nmos_2(net_3, y, b);
  tranif1 nmos_3(net_4, y, bb);
  tranif1 nmos_4(gnd, bb, b);
  tranif1 nmos_5(gnd, ab, a);
  tranif0 pmos_0(y, net_7, b);
  tranif0 pmos_1(net_7, vdd, ab);
  tranif0 pmos_2(y, net_8, bb);
  tranif0 pmos_3(net_8, vdd, a);
  tranif0 pmos_4(bb, vdd, b);
  tranif0 pmos_5(ab, vdd, a);
endmodule   /* Project__xor2_1x */

module Project__bit_prop_gen(A, B, G, P);
  input A;
  input B;
  output G;
  output P;

  supply1 vdd;
  supply0 gnd;
  Project__and2_1x and2_1x_0(.a(A), .b(B), .y(G));
  Project__xor2_1x xor2_1x_0(.a(A), .b(B), .y(P));
endmodule   /* Project__bit_prop_gen */

module Project__a2o1_1x(a, b, c, y);
  input a;
  input b;
  input c;
  output y;

  supply1 vdd;
  supply0 gnd;
  wire net_0, net_11, net_19;

  tranif1 nmos_0(gnd, net_19, a);
  tranif1 nmos_1(net_19, net_0, b);
  tranif1 nmos_2(gnd, net_0, c);
  tranif1 nmos_3(gnd, y, net_0);
  tranif0 pmos_0(net_0, net_11, c);
  tranif0 pmos_1(net_11, vdd, b);
  tranif0 pmos_2(net_11, vdd, a);
  tranif0 pmos_3(y, vdd, net_0);
endmodule   /* Project__a2o1_1x */

module Project__group_gen(G0, G1, P1, G2);
  input G0;
  input G1;
  input P1;
  output G2;

  supply1 vdd;
  supply0 gnd;
  Project__a2o1_1x a2o1_1x_0(.a(G0), .b(P1), .c(G1), .y(G2));
endmodule   /* Project__group_gen */

module Project__group_prop_gen(G0, G1, P0, P1, G2, P2);
  input G0;
  input G1;
  input P0;
  input P1;
  output G2;
  output P2;

  supply1 vdd;
  supply0 gnd;
  Project__a2o1_1x a2o1_1x_0(.a(G0), .b(P1), .c(G1), .y(G2));
  Project__and2_1x and2_1x_0(.a(P0), .b(P1), .y(P2));
endmodule   /* Project__group_prop_gen */

module six_bit_kogge_stone_adder(A, B, S);
  input [5:0] A;
  input [5:0] B;
  output [5:0] S;

  supply1 vdd;
  supply0 gnd;
  wire bit_prop_5_G, net_0, net_115, net_119, net_120, net_14, net_141, net_142;
  wire net_143, net_144, net_15, net_18, net_19, net_2, net_20, net_21, net_24;
  wire net_25, net_26, net_27, net_4, net_6, net_71;
  wire [5:0] P;

  Project__bit_prop_gen bit_prop_0(.A(A[0]), .B(B[0]), .G(net_0), .P(P[0]));
  Project__bit_prop_gen bit_prop_1(.A(A[1]), .B(B[1]), .G(net_2), .P(P[1]));
  Project__bit_prop_gen bit_prop_2(.A(A[2]), .B(B[2]), .G(net_4), .P(P[2]));
  Project__bit_prop_gen bit_prop_3(.A(A[3]), .B(B[3]), .G(net_6), .P(P[3]));
  Project__bit_prop_gen bit_prop_4(.A(A[4]), .B(B[4]), .G(net_144), .P(P[4]));
  Project__bit_prop_gen bit_prop_5(.A(A[5]), .B(B[5]), .G(bit_prop_5_G), 
      .P(P[5]));
  Project__group_gen group_ge_0(.G0(gnd), .G1(net_0), .P1(P[0]), .G2(net_71));
  Project__group_gen group_ge_1(.G0(gnd), .G1(net_20), .P1(net_21), 
      .G2(net_143));
  Project__group_gen group_ge_2(.G0(net_71), .G1(net_18), .P1(net_19), 
      .G2(net_120));
  Project__group_gen group_ge_3(.G0(gnd), .G1(net_26), .P1(net_27), 
      .G2(net_119));
  Project__group_gen group_ge_4(.G0(net_71), .G1(net_24), .P1(net_25), 
      .G2(net_115));
  Project__group_prop_gen group_pr_0(.G0(net_2), .G1(net_4), .P0(P[1]), 
      .P1(P[2]), .G2(net_18), .P2(net_19));
  Project__group_prop_gen group_pr_1(.G0(net_0), .G1(net_2), .P0(P[0]), 
      .P1(P[1]), .G2(net_20), .P2(net_21));
  Project__group_prop_gen group_pr_2(.G0(net_4), .G1(net_6), .P0(P[2]), 
      .P1(P[3]), .G2(net_141), .P2(net_142));
  Project__group_prop_gen group_pr_3(.G0(net_6), .G1(net_144), .P0(P[3]), 
      .P1(P[4]), .G2(net_14), .P2(net_15));
  Project__group_prop_gen group_pr_5(.G0(net_20), .G1(net_141), .P0(net_21), 
      .P1(net_142), .G2(net_26), .P2(net_27));
  Project__group_prop_gen group_pr_6(.G0(net_18), .G1(net_14), .P0(net_19), 
      .P1(net_15), .G2(net_24), .P2(net_25));
  Project__xor2_1x xor2_1x_0(.a(net_115), .b(P[5]), .y(S[5]));
  Project__xor2_1x xor2_1x_4(.a(net_119), .b(P[4]), .y(S[4]));
  Project__xor2_1x xor2_1x_5(.a(net_120), .b(P[3]), .y(S[3]));
  Project__xor2_1x xor2_1x_6(.a(net_143), .b(P[2]), .y(S[2]));
  Project__xor2_1x xor2_1x_7(.a(net_71), .b(P[1]), .y(S[1]));
  Project__xor2_1x xor2_1x_8(.a(gnd), .b(P[0]), .y(S[0]));
endmodule   /* six_bit_kogge_stone_adder */
