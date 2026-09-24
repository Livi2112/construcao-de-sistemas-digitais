module fsm #()
(
    input  logic rst,
    input  logic clk,
    input  logic data,
    output logic [7:0] data_o,
    output logic flag = 0
);

typedef enum {
    IDLE,
    READ_DATA,
    PARITY_BIT,
    STOP_BIT
} State;

State state;
logic aux;
logic [2:0] count;
logic [7:0] out_reg = 0;

contador contador(
    parameter MAX = 10
)(
    .clk(ps2_clk),
    .s_out(count)
)

always_ff@(negedge ps2_clk or posedge rst) begin
    if rst begin
        out_reg <= 0;
        state = IDLE;
    end

    case(state)
        IDLE: begin
            if !ps2_data begin
                state = READ_DATA;
            end
        end

        READ_DATA: begin
            out_reg[count] = ps2_data;
            if count == 7 begin
                state = PARITY_BIT;
            end
        end
        
        PARITY_BIT: begin
            aux = ^out_reg;
            // Não faz nada se parity bit esta errado
            if aux ^ ps2_data begin
                state = STOP_BIT;
            end
        end
        
        STOP_BIT: begin
            if ps2_data begin
                flag <= ~flag;
                state = IDLE;
            end
        end

        default: begin
            state = IDLE;
        end
    endcase
end

endmodule

