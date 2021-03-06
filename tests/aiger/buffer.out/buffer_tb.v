`ifndef outfile
	`define outfile "/dev/stdout"
`endif
module testbench;

integer i;
integer file;

reg [31:0] xorshift128_x = 123456789;
reg [31:0] xorshift128_y = 362436069;
reg [31:0] xorshift128_z = 521288629;
reg [31:0] xorshift128_w = 1554578918; // <-- seed value
reg [31:0] xorshift128_t;

task xorshift128;
begin
	xorshift128_t = xorshift128_x ^ (xorshift128_x << 11);
	xorshift128_x = xorshift128_y;
	xorshift128_y = xorshift128_z;
	xorshift128_z = xorshift128_w;
	xorshift128_w = xorshift128_w ^ (xorshift128_w >> 19) ^ xorshift128_t ^ (xorshift128_t >> 8);
end
endtask

wire [0:0] \sig_../buffer.aig_n1 ;
\../buffer.aig  \uut_../buffer.aig (
	.n1(\sig_../buffer.aig_n1 )
);

task \../buffer.aig_reset ;
begin
	#0;
	#0;
	#0;
end
endtask

task \../buffer.aig_update_data ;
begin
	#0;
end
endtask

task \../buffer.aig_update_clock ;
begin
end
endtask

task \../buffer.aig_print_status ;
begin
	$fdisplay(file, "#OUT# %b %b %b %t %d", { 1'bx }, { 1'bx }, { \sig_../buffer.aig_n1  }, $time, i);
end
endtask

task \../buffer.aig_print_header ;
begin
	$fdisplay(file, "#OUT#");
	$fdisplay(file, "#OUT#   A   \sig_../buffer.aig_n1 ");
	$fdisplay(file, "#OUT#");
	$fdisplay(file, {"#OUT# ", "#", " ", "#", " ", "A"});
end
endtask

task \../buffer.aig_test ;
begin
	$fdisplay(file, "#OUT#\n#OUT# ==== \../buffer.aig  ====");
	\../buffer.aig_reset ;
	for (i=0; i<1000; i=i+1) begin
		if (i % 20 == 0) \../buffer.aig_print_header ;
		#100; \../buffer.aig_update_data ;
		#100; \../buffer.aig_update_clock ;
		#100; \../buffer.aig_print_status ;
	end
end
endtask

initial begin
	// $dumpfile("testbench.vcd");
	// $dumpvars(0, testbench);
	file = $fopen(`outfile);
	\../buffer.aig_test ;
	$fclose(file);
	$finish;
end

endmodule
