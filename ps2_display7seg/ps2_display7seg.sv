module ps2_display7seg #()
(
    input  logic clock, reset,
    input  logic ps2_clk, ps2_data,
    output logic [6:0] display,
    output logic [7:0] display_en
);

logic clock_controle_display_en;
logic [2:0]count_controle_display_en;
logic [7:0]display_en_inv;

logic [3:0]dig_display;

logic fsm_o;
logic flag;
logic flag_rise;
logic flag_fall;

// ------------ Logica principal -------------

// Maquina de estados para leitura do input
fsm fsm(
    .rst(rst),
    .clk(ps2_clk),
    .data(ps2_data),
    .data_o(fsm_o),
    .flag(flag)
)

// Detector de borda para flag de novo input 
detector_de_borda fsm_flag_db(
    .s_in(flag),
    .clk(clk),
    .rise(flag_rise),
    .fall(flag_fall)
);

// Shift register para armazenar valores 
shift_reg shift_reg(
    .clk(clk),
    .rst(rst),
    .data_i(fsm_o),
    .flag(flag_rise),

);

// ------------ Logica display -------------

// Divisor de clock para display_decoder_mux
divisor_de_clock #(.METADE_DIVISOR(100000/2))
divisor_de_clock_controle_display_en
(
    .clk_in(clock),
    .clk_out(clock_controle_display_en)
);

// Contador para controlar display_en
contador controle_display_en
(
    .clk(clock_controle_display_en),
    .s_out(count_controle_display_en)
);

// Decodifica o contador e ativa a respectiva entrada do display_en
decoder decoder_display_en
(
    .s_in(count_controle_display_en),
    .s_out(display_en_inv)
);

// Usa o contador para decidir qual  mandar
display_decoder_mux u_display_decoder_mux
(
    .s_a(count_a),
    .s_b(count_b),
    .mux_in(count_controle_display_en),
    .s_out(dig_display)
);

// Transforma uma tecla para a sua representação no display de sete segmentos
bin_para_display u_bin_para_display
(
    .s_in(dig_display),
    .s_out(display)
);

assign display_en = ~display_en_inv;

endmodule