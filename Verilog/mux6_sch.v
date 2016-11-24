/* Verilog for cell 'mux6{sch}' from library 'Project' */
/* Created on Thu Nov 24, 2016 11:56:14 */
/* Last revised on Thu Nov 24, 2016 14:35:14 */
/* Written on Thu Nov 24, 2016 14:35:55 by Electric VLSI Design System, version 8.06 */

module Project__mux2_c_1x(d0, d1, s, y);
  input d0;
  input d1;
  input s;
  output y;

  supply1 vdd;
  supply0 gnd;
  wire net_12, net_15, net_3, net_4, net_5, sb;

  tranif1 nmos_0(gnd, net_3, d1);
  tranif1 nmos_1(gnd, net_4, d0);
  tranif1 nmos_2(net_3, net_5, s);
  tranif1 nmos_3(net_4, net_5, sb);
  tranif1 nmos_4(gnd, y, net_5);
  tranif1 nmos_5(gnd, sb, s);
  tranif0 pmos_0(net_5, net_15, sb);
  tranif0 pmos_1(net_15, vdd, d1);
  tranif0 pmos_2(net_5, net_12, s);
  tranif0 pmos_3(net_12, vdd, d0);
  tranif0 pmos_4(y, vdd, net_5);
  tranif0 pmos_5(sb, vdd, s);
endmodule   /* Project__mux2_c_1x */

module mux6(d0, d1, s, y);
  input [5:0] d0;
  input [5:0] d1;
  input s;
  output [5:0] y;

  supply1 vdd;
  supply0 gnd;
  Project__mux2_c_1x mux2_c_1_0(.d0(d0[0]), .d1(d1[0]), .s(s), .y(y[0]));
  Project__mux2_c_1x mux2_c_1_1(.d0(d0[1]), .d1(d1[1]), .s(s), .y(y[1]));
  Project__mux2_c_1x mux2_c_1_2(.d0(d0[2]), .d1(d1[2]), .s(s), .y(y[2]));
  Project__mux2_c_1x mux2_c_1_3(.d0(d0[3]), .d1(d1[3]), .s(s), .y(y[3]));
  Project__mux2_c_1x mux2_c_1_4(.d0(d0[4]), .d1(d1[4]), .s(s), .y(y[4]));
  Project__mux2_c_1x mux2_c_1_5(.d0(d0[5]), .d1(d1[5]), .s(s), .y(y[5]));
endmodule   /* mux6 */