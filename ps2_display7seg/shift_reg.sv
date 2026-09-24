module shift_reg #()
(
    input logic clk,
    input logic flag,
    input logic [7:0]data_i,
    output logic [63:0] data_o
);

logic [63:0]chars,

always_ff @(posedge clock) begin
    if flag begin
        chars = chars << 8;
        chars[7:0] = data_i;
    end

    assign data_o = chars;
end

endmodule