module shift_reg
(
    input  logic clk,
    input  logic rst,
    input  logic flag,
    input  logic [7:0] data_i,
    output logic [63:0] data_o
);
    logic [7:0] last_char = 0;
    logic [63:0] chars = 0;
    logic get_next = 0;

    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            chars <= 0;
        end
        else begin
            if(flag) begin
                if(last_char == '0) begin
                    last_char <= data_i;
                end        
                else begin
                    if(get_next) begin
                        chars <= {chars[55:0], data_i};
                        get_next <= '0;
                        last_char <= '0;
                    end
                
                    if(data_i == 8'hF0) begin
                        get_next = '1;
                    end
                end
            end
        end
    end

    assign data_o = chars;
endmodule