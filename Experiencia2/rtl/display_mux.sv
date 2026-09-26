module display_mux #()
(
    input  logic [63:0] s_in,
    input  logic [2:0] mux_in,
    output logic [7:0] s_out = 0
);

always_comb begin
     case (mux_in)
        3'h0: s_out = s_in[7:0];
        3'h1: s_out = s_in[15:8];
        3'h2: s_out = s_in[23:16];
        3'h3: s_out = s_in[31:24];
        3'h4: s_out = s_in[39:32];
        3'h5: s_out = s_in[47:40];
        3'h6: s_out = s_in[55:48];
        3'h7: s_out = s_in[63:56];
        default: s_out = 8'b11111111;
     endcase   
end

endmodule