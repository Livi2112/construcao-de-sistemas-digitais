module detector_de_borda
(
    input  logic clk, s_in,
    output logic rise, fall
);
    logic last = 0;

    always_ff @(posedge clk) begin
        if (s_in != last) begin
            rise <= s_in;
            fall <= ~s_in;
        end else begin
            rise <= 0;
            fall <= 0;
        end
        last <= s_in;
    end
endmodule