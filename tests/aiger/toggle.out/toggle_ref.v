/* Generated by Yosys 0.8+316 (git sha1 57c2763f, clang 4.0.1-6 -fPIC -Os) */

module \../toggle.aig (clk, n1, n1_inv);
  input clk;
  (* init = 32'd0 *)
  output n1;
  reg n1 = 32'd0;
  output n1_inv;
  always @(posedge clk)
      n1 <= n1_inv;
  assign n1_inv = ~n1;
endmodule
