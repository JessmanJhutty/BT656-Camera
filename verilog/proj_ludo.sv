`timescale 1ns/1ns
module i2c_master_tb();
    logic clk, reset, read, i2c_clk, start, END, ACK, reset_i2c;
    wire sda;
    wire scl;
    logic [7:0] data_to_send, data_to_read, reg_dest;
    logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	
    clock_divider i2c_clock(.reset(reset), .ref_clk(clk), .i2c_clk(i2c_clk));
    i2c_master DUT(.clk(i2c_clk), .reset(reset), .read(read), .data_to_send(data_to_send), .data_to_read(data_to_read), .sda(sda), .scl(scl), .reg_dest(reg_dest), .start(start));
    byte2ledhex OUT(.data({reg_dest, data_to_send, data_to_read}), .HEX0(HEX0), .HEX1(HEX1), .HEX2(HEX2), .HEX3(HEX3), .HEX4(HEX4), .HEX5(HEX5));
    
// I2C_Controller  DUT2(.CLOCK(i2c_clk),.I2C_SCLK(scl),.I2C_SDAT(sda),.I2C_DATA({8'h40,reg_dest, data_to_send}),.GO(start),      .END(END),   .W_R(read),     .ACK(ACK),      .RESET(reset_i2c)) ;   


    initial begin
        clk = 1;

        forever begin
            clk = ~clk;
            #10;
        end
    end


/* 
   initial begin
    reset = 1;
    read = 1;
    reset_i2c = 1;
    start = 0;
    data_to_send = 8'hAA;
    reg_dest = 8'h11;
   #30;
reset_i2c = 0;
reset = 0;
#30;
reset_i2c = 1;
reset = 1;
#12000;
start = 1;
    end
*/



   initial begin
    reset = 1;
    read = 0;
    reset_i2c = 1;
    start = 0;
    data_to_send = 8'hAA;
    reg_dest = 8'h11;
    #1000;
     reset = 0;
    #3000;
    reset = 1;




    end



endmodule
