module ps2_display7seg
(
    input  logic clk, rst,
    input  logic ps2_clk, ps2_data,
    output logic [6:0] display,
    output logic [7:0] display_en
);

    logic clock_controle_display_en;
    logic [2:0] count_controle_display_en;
    logic [7:0] display_en_inv;

    logic [7:0] scancode_sel;
    logic [7:0] fsm_o;
    logic flag, flag_rise, flag_fall, flag_edge;
    logic [63:0] chars;

    fsm fsm_inst (
        .rst(rst),
        .clk(ps2_clk),
        .data(ps2_data),
        .data_o(fsm_o),
        .flag(flag)
    );

    detector_de_borda fsm_flag_db (
        .s_in(flag),
        .clk(clk),
        .rise(flag_rise),
        .fall(flag_fall)
    );

    assign flag_edge = flag_rise | flag_fall;

    shift_reg shift_reg_inst (
        .clk(clk),
        .rst(rst),
        .data_i(fsm_o),
        .flag(flag_edge),
        .data_o(chars)
    );

    divisor_de_clock #(.METADE_DIVISOR(100000/2)) divisor_de_clock_controle_display_en (
        .clk_in(clk),
        .clk_out(clock_controle_display_en)
    );

    contador #(.MAX(8)) controle_display_en (
        .clk(clock_controle_display_en),
        .s_out(count_controle_display_en)
    );

    decoder #(.IN_WIDTH(3)) decoder_display_en (
        .s_in(count_controle_display_en),
        .s_out(display_en_inv)
    );

    display_mux u_display_mux (
        .s_in(chars),
        .mux_in(count_controle_display_en),
        .s_out(scancode_sel)
    );

    bin_para_display u_bin_para_display (
        .s_in(scancode_sel),
        .s_out(display)
    );

    assign display_en = ~display_en_inv;

endmodule