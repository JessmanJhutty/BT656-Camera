module i2cinput(input logic [9:0] SW, input logic [3:0] KEYS, output logic reset, output logic read, output logic start,
		input logic clk, output logic [7:0] data_to_send, output logic [7:0] reg_dest);
    
	 assign reset = KEYS[0]; // KEY[0] is high until it is pressed
    assign start = KEYS[1];
    assign read = SW[0];

    always_ff @(posedge clk) begin
	  if(!KEYS[0]) begin 
		  data_to_send[7:0] = 8'h00;
		  reg_dest[7:0] = 8'h00;
	  end
		else if(!KEYS[2])
			data_to_send[7:0] <= SW[8:1];
		else if (!KEYS[3])
			reg_dest[7:0] <= SW[8:1];
		else begin
			data_to_send <= data_to_send;
			reg_dest <= reg_dest;
		end
	 end
endmodule
