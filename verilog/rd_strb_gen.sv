module rd_strb_gen(input logic rdempty, input [11:0] wrusedw_sig,  output logic rd_strb, input logic wrfull_sig, 
                   output logic [22:0] address, output logic, input logic clk, input logic reset, input logic frame_rdy, 
                   output logic [1:0] BA, output logic [15:0] data, output logic Dram_select, output_logic, input logic buffer_select, input logic field);

  parameter  BUFFER_A = 0; // this is where Buffer A is located
  parameter  BUFFER_B = 23'h4B000; // this is where Buffer B is located We will swap the buffers when we get the signal to do so. Essentially need to swap starting addresses
  logic  rd_strb;

  assign BA = 2'b00; // Bank address can just be 0 for now We dont need to exceed past Address: 23'h96000

  always_ff @(posedge clk) begin
    if(!reset) 
      rd_strb <= 0;
    else if (wr_usedw_sig > 12'd639 && !rdempty && !wrfull_sig && !frame_rdy) // I want to make sure that write FIFO has at least one line (640 pixels rdy) to be send to write over dram
      rd_strb <= 1;
    else
      rd_strb <= 0;
  end

  always_ff @(posedge clk) begin
    if(!reset || ) 
      address <= 0;
    else if (rd_strb)
      address <= address + 8;
    else
      address <= 0;
  end

endmodule  