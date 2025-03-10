module vga_driver_tb();
          logic [7:0] r, g, b, red, green, blue;
	  logic reset_n, clk, H_sync, V_sync, vga_sync, vga_blank, vga_clk;


 clock_divider #(.DELAY(0)) clk25(.reset(reset_n), .ref_clk(clk), .clk_o(clk_25)); // 25 MHz
vga_driver DUT(.r(r), .g(g), .b(b), .red(red), .blue(blue), .green(green), .reset_n(reset_n), .clk(clk_25), .H_sync(H_sync), .V_sync(V_sync),.vga_sync(vga_sync), .vga_blank(vga_blank), .vga_clock(vga_clk));



 initial begin
        clk = 1;

        forever begin
            clk = ~clk;
            #10;
        end
end



initial begin
reset_n = 0;
r= 8'hAA;
b = 8'hBB;
g = 8'hCC;
#50;
reset_n = 1;



end

endmodule 
