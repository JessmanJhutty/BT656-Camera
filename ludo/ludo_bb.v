
module ludo (
	clk_clk,
	hex_external_connection_export,
	led_external_connection_export);	

	input		clk_clk;
	output	[7:0]	hex_external_connection_export;
	output	[2:0]	led_external_connection_export;
endmodule
