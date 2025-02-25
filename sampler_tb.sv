module sampler_tb();

logic reset, CLK_100, CLK_50;


sampler DUT(.refclk(CLK_50), .rst(reset), .outclk_0(CLK_100));


 initial begin
        CLK_50 = 1;

        forever begin
            CLK_50 = ~CLK_50;
            #10;
        end
end


initial begin

reset = 1;

#30;

reset = 0;



end


endmodule