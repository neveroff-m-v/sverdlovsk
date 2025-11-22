`timescale 1ns / 1ps

/// Драйвер тактовой кнопки / тумблера
/*
    SVERDLOVSK
    system verilog library

    Neveroff M.V.
    2025
*/

module drv_switch # (
    p_scale = 5,
    p_mode = "pullup"
    )(
    i_drv_sw,
    i_clk,
    i_rst,
    o_press,
    o_click,
    o_release,
    o_toggle
    );
    
    input       i_drv_sw;
    
    input       i_clk;
    input       i_rst;
    output      o_press;
    output      o_click;
    output      o_release;
    output      o_toggle; 

    wire w_sw_signal;
    generate
    if (p_mode == "pullup") begin
        /// Триггер Шмитта
        schmitt_trigger # (
            .p_scale 	(p_scale)
        )
        schmitt_trg (
            .i_clk      (i_clk),
            .i_rst      (i_rst),
            .i_in       (~ i_drv_sw),
            .o_out      (w_sw_signal)
        );
    end

    if (p_mode == "pulldown") begin
        /// Триггер Шмитта
        schmitt_trigger # (
            .p_scale 	(p_scale)
        )
        schmitt_trg (
            .i_clk      (i_clk),
            .i_rst      (i_rst),
            .i_in       (i_drv_sw),
            .o_out      (w_sw_signal)
        );
    end
    endgenerate
    
    wire w_posedge;
    wire w_negedge;
    wire w_edge;
    /// Детектор переднего/заднего фронта и изменения сигнала
    detector dtct (
        .i_clk      (i_clk),
        .i_in       (w_sw_signal),
        .o_posedge  (w_posedge),
        .o_negedge  (w_negedge),
        .o_edge     (w_edge)
    );
    
    assign o_press      = w_sw_signal;
    assign o_click      = w_posedge;
    assign o_release    = w_negedge;
    assign o_toggle     = w_edge;
endmodule
