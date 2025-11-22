`timescale 1ns / 1ps

/// Детектор переднего/заднего фронта и изменения сигнала
/*
    SVERDLOVSK
    system verilog library

    Neveroff M.V.
    2025
*/

module detector (
    i_clk,
    i_rst,
    // ---
    i_in,
    o_posedge,
    o_negedge,
    o_edge
    );
    
                                // CLOCK / RESET
    input       i_clk;          // тактирование
    input       i_rst;          // сброс

                                // INTERCONNECT
    input       i_in;           // вход
    output      o_posedge;      // ___/‾‾‾ передний фронт
    output      o_negedge;      // ‾‾‾\___ задний фронт
    output      o_edge;         // __/‾\__ фронт (изменение сигнла)
    
    logic [1:0] l_pattern = 'd0;
    always_ff @ (posedge i_clk) begin
        if (i_rst) begin
            l_pattern <= 'd0;
        end
        else begin
            l_pattern <= {l_pattern[0], i_in};
        end
    end
    
    assign o_posedge = (~ l_pattern[1]) & (  l_pattern[0]);
    assign o_negedge = (  l_pattern[1]) & (~ l_pattern[0]);
	assign o_edge    = (  l_pattern[1]) ^ (  l_pattern[0]);
endmodule
