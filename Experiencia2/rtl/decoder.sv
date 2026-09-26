module decoder #(parameter IN_WIDTH = 3)
(
    input  logic [IN_WIDTH-1:0] s_in,
    output logic [(1<<IN_WIDTH)-1:0] s_out
);
    always_comb begin
        s_out = '0;
        s_out[s_in] = 1'b1;
    end
endmodule