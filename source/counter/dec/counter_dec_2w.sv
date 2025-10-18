`timescale 1ns / 1ps

/// Счетчик десятичный (2 разряда)
module counter_dec_2w (
    i_clk,
    i_rst,
    i_val,
    i_plus,
    i_minus,
    o_count,
    o_plus,
    o_minus,
    o_zero
    );

    input           i_clk;
    input           i_rst;
    input [3:0]     i_count [1:0];
    input           i_plus;
    input           i_minus;
    output [3:0]    o_count [1:0];
    output          o_plus;
    output          o_minus;
    output          o_zero;

    wire w_plus_0;
    wire w_minus_0;
    wire w_zero_0;
    /// Счетчик десятичный
    counter_dec cnt_0 (
        .i_clk      (i_clk),
        .i_rst      (i_rst),
        .i_count    (i_count[0]),
        .i_plus     (i_plus),
        .i_minus    (i_minus),
        .o_count    (o_count[0]),
        .o_plus     (w_plus_0),
        .o_minus    (w_minus_0),
        .o_zero     (w_zero_0)
    );

    wire w_plus_1;
    wire w_minus_1;
    wire w_zero_1;
    /// Счетчик десятичный
    counter_dec cnt_1 (
        .i_clk      (i_clk),
        .i_rst      (i_rst),
        .i_count    (i_count[1]),
        .i_plus     (w_plus_0),
        .i_minus    (w_minus_0),
        .o_count    (o_count[1]),
        .o_plus     (w_plus_1),
        .o_minus    (w_minus_1),
        .o_zero     (w_zero_1)
    );

    assign o_zero  = w_zero_0 & w_zero_1;
    assign o_plus  = w_plus_1;
    assign o_minus = w_minus_1;
endmodule
