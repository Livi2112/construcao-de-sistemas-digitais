module bin_para_display (
    input  logic [7:0] s_in,
    output logic [6:0] s_out
);
    always_comb begin
        s_out = 7'b1111111;

        case (s_in)
            8'h16: s_out = 7'b1001111;
            8'h1E: s_out = 7'b0010010;
            8'h26: s_out = 7'b0000110;
            8'h25: s_out = 7'b1001100;
            8'h2E: s_out = 7'b0100100;
            8'h36: s_out = 7'b0100000;
            8'h3D: s_out = 7'b0001111;
            8'h3E: s_out = 7'b0000000;
            8'h46: s_out = 7'b0000100;
            8'h45: s_out = 7'b0000001;

            8'h15: s_out = 7'b0001100;
            8'h1D: s_out = 7'b1010100;
            8'h24: s_out = 7'b0110000;
            8'h2D: s_out = 7'b1111010;
            8'h2C: s_out = 7'b1110000;
            8'h35: s_out = 7'b1000100;
            8'h3C: s_out = 7'b1100011;
            8'h43: s_out = 7'b1101111;
            8'h44: s_out = 7'b1100010;
            8'h4D: s_out = 7'b0011000;

            8'h1C: s_out = 7'b0001000;
            8'h1B: s_out = 7'b0100100;
            8'h23: s_out = 7'b1000010;
            8'h2B: s_out = 7'b0111000;
            8'h34: s_out = 7'b0100001;
            8'h33: s_out = 7'b1101000;
            8'h3B: s_out = 7'b1000011;
            8'h42: s_out = 7'b1111000;
            8'h4B: s_out = 7'b1110001;

            8'h1A: s_out = 7'b0010010;
            8'h22: s_out = 7'b1001000;
            8'h21: s_out = 7'b0110001;
            8'h2A: s_out = 7'b1000001;
            8'h32: s_out = 7'b1100000;
            8'h31: s_out = 7'b1101010;
            8'h3A: s_out = 7'b0101010;

            8'h29: s_out = 7'b1111111;

            default: s_out = 7'b1111111;
        endcase
    end
endmodule