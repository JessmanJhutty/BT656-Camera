module byte2ledhex(input logic [23:0] data, output logic [6:0] HEX0, output logic [6:0] HEX1, output logic [6:0] HEX2, output logic [6:0] HEX3, output logic [6:0] HEX4, output logic [6:0] HEX5 );
    logic [6:0]  HEX0_O, HEX1_O, HEX2_O, HEX3_O, HEX4_O, HEX5_O ; 
    nibble2hex firstNibble(.nibble(data[3:0]), .HEX(HEX0_O));
    nibble2hex secondNibble(.nibble(data[7:4]), .HEX(HEX1_O));
    nibble2hex thirdNibble(.nibble(data[11:8]), .HEX(HEX2_O));
    nibble2hex fourthNibble(.nibble(data[15:12]), .HEX(HEX3_O));
    nibble2hex fifthNibble(.nibble(data[19:16]), .HEX(HEX4_O));
    nibble2hex sixthNibble(.nibble(data[23:20]), .HEX(HEX5_O));

    assign HEX0[6:0] = HEX0_O[6:0];
    assign HEX1[6:0] = HEX1_O[6:0];
    assign HEX2[6:0] = HEX2_O[6:0];
    assign HEX3[6:0] = HEX3_O[6:0];
    assign HEX4[6:0] = HEX4_O[6:0];
    assign HEX5[6:0] = HEX5_O[6:0];

endmodule


module nibble2hex(input logic [3:0] nibble, output logic [6:0] HEX);
    always_comb begin
        case (nibble[3:0])
            4'h0: HEX = 7'b1000000;//1000000
            4'h1: HEX = 7'b1111001;//1111001
            4'h2: HEX = 7'b0100100;//0100100
            4'h3: HEX = 7'b0110000;//1110000
            4'h4: HEX = 7'b0011001;//0011001
            4'h5: HEX = 7'b0010010;//0010010
            4'h6: HEX = 7'b0000010;//0000010
            4'h7: HEX = 7'b1111000;//1111000
            4'h8: HEX = 7'b0000000;//0000000
            4'h9: HEX = 7'b0011000;//0011000
            4'hA: HEX = 7'b0001000;//0001000
            4'hB: HEX = 7'b0000011;//0000011
            4'hC: HEX = 7'b1000110;//1000110
            4'hD: HEX = 7'b0100001;//0100001
            4'hE: HEX = 7'b0000110;//0000110
            4'hF: HEX = 7'b0001110;//0001110
            default: HEX = 7'b1110001;
        endcase
    end

endmodule