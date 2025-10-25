`timescale 1ns / 1ps

/// Генератор переднего/заднего фронта и изменения сигнала
module generator (
    i_clk,
    i_rst,
    // ---
    o_out,
    i_posedge,
    i_negedge,
    i_edge
    );

                                // CLOCK / RESET
    input       i_clk;          // тактирование
    input       i_rst;          // сброс

                                // INTERCONNECT
    output      o_out;          // выход
    input       i_posedge;      // ___/‾‾‾ передний фронт
    input       i_negedge;      // ‾‾‾\___ задний фронт
    input       i_edge;         // __/‾\__ фронт (изменение сигнла)

    logic l_val = 'b0;
    always_ff @ (posedge i_clk) begin
        if (i_rst) begin
            l_val <= 'b0;
        end
        else begin
            l_val <=    (i_posedge) ? 'b1 :
                        (i_negedge) ? 'b0 :
                        (i_edge) ? ~ l_val :
                        l_val;
        end
    end

    assign o_out = l_val;
endmodule