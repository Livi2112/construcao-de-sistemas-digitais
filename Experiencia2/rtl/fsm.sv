module fsm
(
    input  logic rst,
    input  logic clk,
    input  logic data,
    output logic [7:0] data_o,
    output logic flag = 0
);
    typedef enum logic [1:0] {
        IDLE,
        READ_DATA,
        PARITY_BIT,
        STOP_BIT
    } state_t;

    state_t state = IDLE;
    logic [2:0] count = 0;
    logic [7:0] out_reg = 0;

    always_ff @(negedge clk or posedge rst) begin
        if (rst) begin
            out_reg <= 0;
            count   <= 0;
            state   <= IDLE;
        end else begin
            case (state)
                IDLE: begin
                    count <= 0;
                    if (!data) begin
                        state <= READ_DATA;
                    end
                end

                READ_DATA: begin
                    out_reg[count] <= data;
                    count <= count + 1;
                    if (count == 7) begin
                        state <= PARITY_BIT;
                    end
                end

                PARITY_BIT: begin
                    state <= STOP_BIT;
                end

                STOP_BIT: begin
                    if (data) begin
                        flag <= ~flag;
                    end
                    state <= IDLE;
                end

                default: state <= IDLE;
            endcase
        end
    end

    assign data_o = out_reg;

endmodule