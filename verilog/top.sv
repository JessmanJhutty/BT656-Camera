module top(input logic CLK_50, 
			  input logic [9:0] SW, 
			  input logic [3:0] KEYS, 
			  output logic [6:0] HEX0,
			  output logic [6:0] HEX1,
			  output logic [6:0] HEX2,
			  output logic [6:0] HEX3,
			  output logic [6:0] HEX4,
			  output logic [6:0] HEX5,
			  inout sda,
			  output scl,
			  output logic [7:0] red,
			  output logic [7:0] green,
			  output logic [7:0] blue,
			  output logic H_SYNC,
			  output logic V_SYNC,
			  output logic vga_blank,
			  output logic vga_sync,
			  output logic vga_clk,
			  input logic [7:0] TV_DATA,
			  input logic TD_V_SYNC,
			  input logic TD_H_SYNC,
			  input logic TD_CLK_27,
			  output logic TD_RESET_N,
			  output logic CLK_100);

	 wire reset, i2c_clk, start, read, clk_25, AV, field, Data_Valid;
	 wire [7:0] data_to_send, data_to_read,reg_dest;
	 wire [15:0] YCbCr;

	 
	 // ** CLOCK DOMAINS **
	 //  Camera: TD_CLK_27: 27 MHz
	 //  VGA PIXel Clock: 25 MHz
	 //  PLL: Generates 100 MHz CLock for SDRAM
	 //  
	 //  ** RESETS **
	 //   reset = KEYS[0] in i2cinput which is high until it is pressed  
	 assign TD_RESET_N = reset; 
	 
	 sampler pll_0(.refclk(CLK_50), .rst(!KEYS[0]), .outclk_0(CLK_100)); // 100 MHz from PLL
	 
	 clock_divider #(.DELAY(500)) i2c_clock(.reset(reset), .ref_clk(CLK_50), .clk_o(i2c_clk)); // 100kHz
	 clock_divider #(.DELAY(0)) clk25(.reset(reset), .ref_clk(CLK_50 ), .clk_o(clk_25)); // 25 MHz

	 bt656_decoder  decoder(.TD_CLK_27(TD_CLK_27), .data(TV_DATA),  .YCbCr(YCbCr), .reset(reset), .field(field), .active_video(AV), .Data_Valid(Data_Valid));
	 
	 image_write_fifo	image_write_fifo_inst (
			.data ( YCbCr ),
			.rdclk ( CLK_100 ),
			.rdreq ( Data_valid ),
			.wrclk ( TD_CLK_27 ),
			.wrreq ( Data_valid ),
			.q ( q_sig ),
			.rdempty ( rdempty_sig ),
			.wrusedw ( rdusedw_sig ),
			.wrfull ( wrfull_sig )
	 );
	 
	 
	 
	 DramController_Verilog   sdram_ctrl(
			 .Clock(CLK_100),								// used to drive the state machine- stat changes occur on positive edge
			 .Reset_L(reset),     						// active low reset 
			 .Address,		// address bus from 68000
			 .DataIn,			// data bus in from 68000
			 .DramSelect_L,     				// active low signal indicating dram is being addressed by 68000
			 .WE_L,  								// active low write signal, otherwise assumed to be read
			 .BA ,

			 .DataOut, 				// data bus out to 68000
			 .SDram_CKE_H,								// active high clock enable for dram chip
			 .SDram_CS_L,								// active low chip select for dram chip
			 .SDram_RAS_L,								// active low RAS select for dram chip
			 .SDram_CAS_L,								// active low CAS select for dram chip		
			 .SDram_WE_L,								// active low Write enable for dram chip
			 .SDram_Addr,			// 13 bit address bus dram chip	
			 .SDram_BA,				// 2 bit bank address
			 .SDram_DQ,			// 16 bit bi-directional data lines to dram chip
			
			 .ResetOut_L,
			 .LDQM,									
			 .HDQM,
			 .SDRAM_WE_L,								
	
			// Use only if you want to simulate dram controller state (e.g. for debugging)
			.DramState()
		); 	

	 vga_driver TV_OUT(.r(8'hAA), .g(8'hBB), .b(8'hCC), .reset_n(reset), .clk(clk_25), .red(red), .green(green), .blue(blue), .H_sync(H_SYNC), .V_sync(V_SYNC), .vga_blank(vga_blank), .vga_sync(vga_sync), .vga_clock(vga_clk));
	 
	 
	 i2cinput IN(.SW(SW), .KEYS(KEYS),.reset(reset), .start(start), .read(read), .clk(CLK_50), .data_to_send(data_to_send), .reg_dest(reg_dest));		  
	 i2c_master DUT(.clk(i2c_clk), .reset(reset), .read(read), .data_to_send(data_to_send), .data_to_read(data_to_read), .sda(sda), .scl(scl), .reg_dest(reg_dest), .start(start));
	 byte2ledhex OUT(.data({reg_dest, data_to_send, data_to_read}), .HEX0(HEX0), .HEX1(HEX1), .HEX2(HEX2), .HEX3(HEX3), .HEX4(HEX4), .HEX5(HEX5));
	 
endmodule
