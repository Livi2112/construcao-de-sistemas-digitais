`timescale 1ns/1ps

module tb_placar_eletronico_digital;

    logic [0:7] display_en;
    logic [0:6] display;

    logic clock;
    logic reset;

    logic incr_a;
    logic decr_a;
    logic incr_b;
    logic decr_b;

    placar_eletronico_digital dut_placar_eletronico_digital
    (
        .clock      (clock),
        .reset      (reset),
        .incr_a     (incr_a),
        .decr_a     (decr_a),
        .incr_b     (incr_b),
        .decr_b     (decr_b),
        .display_en (display_en),
        .display    (display)
    );

    // Clock 10ns
    initial begin
        clock = 0;

        forever #5 clock = ~clock;
    end

    // Pulso de botoes
    task press_incr_a;
        begin
            incr_a = 1;
            #20;
            incr_a = 0;
            #20;
        end
    endtask
    task press_decr_a;
        begin
            decr_a = 1;
            #20;
            decr_a = 0;
            #20;
        end
    endtask
    task press_incr_b;
        begin
            incr_b = 1;
            #20;
            incr_b = 0;
            #20;
        end
    endtask
    task press_decr_b;
        begin
            decr_b = 1;
            #20;
            decr_b = 0;
            #20;
        end
    endtask

    initial begin

        reset  = 0;

        incr_a = 0;
        decr_a = 0;

        incr_b = 0;
        decr_b = 0;
        
        // Inicio dos testes
        #20;
        reset = 1;
        #20;
        reset = 0;
        #20;

        
        press_incr_a;

        press_incr_a;
        press_incr_a;
        press_incr_a;
        press_incr_a;

        press_decr_a;

        press_decr_a;
        press_decr_a;

        press_incr_b;

        press_incr_b;
        press_incr_b;
        press_incr_b;
        press_incr_b;
        press_incr_b;
        press_incr_b;
        press_incr_b;
        press_incr_b;
        press_incr_b;

        press_decr_b;
        press_decr_b;
        press_decr_b;
        press_decr_b;
        press_decr_b;

        press_incr_a;
        press_incr_a;
        press_incr_a;

        press_incr_b;
        press_incr_b;

        reset = 1;

        #20;

        reset = 0;

        #20;

        repeat (10) begin
            press_incr_a;
        end

        repeat (5) begin
            press_decr_a;
        end

        repeat (20) begin
            press_incr_b;
        end

        repeat (10) begin
            press_decr_b;
        end

        press_incr_a;
        press_incr_b;

        press_incr_a;
        press_decr_b;

        press_decr_a;
        press_incr_b;

        press_incr_a;
        press_incr_b;

        press_decr_a;
        press_decr_b;

        reset = 1;

        #20;

        reset = 0;

        #50;

    end

endmodule

