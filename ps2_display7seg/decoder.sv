module decoder #(parameter IN_WIDTH = 3)
(
    input  logic [IN_WIDTH-1:0] s_in,
    output logic [(1<<IN_WIDTH)-1:0]s_out
);

always_comb begin
    s_out = 1'b1 << s_in;
end

endmodule