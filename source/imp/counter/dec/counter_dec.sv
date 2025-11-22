`timescale 1ns / 1ps

/// Счетчик десятичный
/*
    SVERDLOVSK
    system verilog library

    Neveroff M.V.
    2025
*/

module counter_dec (
    i_clk,
    i_rst,
    i_val,
    i_inc,
    i_dec,
    o_val,
    o_inc,
    o_dec
    );
    
    input           i_clk;
    input           i_rst;
    input  [3:0]    i_val;
    input           i_inc;
    input           i_dec;
    output [3:0]    o_val;
    output          o_inc;
    output          o_dec;
    
    /// Счетчик
    counter # (
        .p_scale(10)
    )
    cnt (
        .i_clk  (i_clk),
        .i_rst  (i_rst),
        .i_val  (i_val),
        .i_inc  (i_inc),
        .i_dec  (i_dec),
        .o_val  (o_val),
        .o_inc  (o_inc),
        .o_dec  (o_dec)
    );

endmodule
