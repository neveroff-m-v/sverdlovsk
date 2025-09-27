`timescale 1ns / 1ps

/// Детектор переднего/заднего фронта и изменения сигнала
module detector (
    i_clk,
    i_in,
    o_posedge,
    o_negedge,
    o_edge
    );
    
    input       i_clk;
    input       i_in;
    output      o_posedge;
    output      o_negedge;
    output      o_edge;
    
    logic l_past;
    always_ff @ (posedge i_clk) begin
        l_past <= i_in;
    end
    
    // ___/‾‾‾ Передний фронт
    assign o_posedge = (~ l_past) & (  i_in);

    // ‾‾‾\___ Задний фронт
    assign o_negedge = (  l_past) & (~ i_in);

    // __/‾\__ Изменение сигнала
	assign o_edge    = (  l_past) ^ (  i_in);
endmodule
