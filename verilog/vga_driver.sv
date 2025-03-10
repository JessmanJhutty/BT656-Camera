module vga_driver(input logic [7:0] r, 
		  input logic [7:0] g, 
		  input logic [7:0] b, 
		  input logic reset_n,
		  input logic clk,
		  output logic [7:0] red,  
		  output logic [7:0] green, 
		  output logic [7:0] blue,
		  output logic H_sync,
		  output logic V_sync,
		  output logic vga_blank,
		  output logic vga_sync,
		  output logic vga_clock);

////////////////////////////////////////////////////////////
//	Horizontal	Parameter
parameter	H_FRONT	=	16;
parameter	H_SYNC	=	96;
parameter	H_BACK	=	48;
parameter	H_ACT	=	640;
parameter	H_BLANK	=	H_FRONT+H_SYNC+H_BACK;
parameter	H_TOTAL	=	H_FRONT+H_SYNC+H_BACK+H_ACT;
////////////////////////////////////////////////////////////
//	Vertical Parameter
parameter	V_FRONT	=	11; // maybe should be 10?
parameter	V_SYNC	=	2;
parameter	V_BACK	=	33; // maygbe should be 33? 
parameter	V_ACT	=	480;
parameter	V_BLANK	=	V_FRONT+V_SYNC+V_BACK;
parameter	V_TOTAL	=	V_FRONT+V_SYNC+V_BACK+V_ACT;


logic [10:0] H_counter, V_counter;

assign vga_blank = ~((H_counter < H_BLANK)) || (V_counter < V_BLANK);
assign vga_sync = 1'b1; 
assign vga_clock = ~clk;
assign red = r;
assign blue = b;
assign green = g;

always @(posedge clk or negedge reset_n) begin
  if(!reset_n) begin
	H_counter <= 0;
	H_sync <= 1;
  end else begin
	if(H_counter < H_TOTAL)
	   H_counter <= H_counter + 1;
	else 
	  H_counter <= 0;
	if (H_counter == H_FRONT-1)
	    H_sync <= 1'b0;
	if(H_counter == H_FRONT +H_SYNC -1)
	   H_sync <= 1'b1;
  end
end

always @(posedge clk or negedge reset_n) begin
    if (!reset_n) begin
	V_counter <= 0;
	V_sync <= 1;
    end else if(H_counter == 10'd112-1) begin
	if(V_counter < V_TOTAL)
	   V_counter <= V_counter +1;
	else 
	   V_counter <= 0;
	if(V_counter == V_FRONT -1)
 	  V_sync <= 1'b0;
	if(V_counter==V_FRONT+V_SYNC-1)
	  V_sync <= 1'b1;
    end


end


endmodule 