`timescale 1ns / 1ps

/// Преобразователь паралельной шины в последовательную
/*
    SVERDLOVSK
    system verilog library

    Neveroff M.V.
    2025
*/

module serial # (
    p_width = 8
    )(
    i_clk,
    i_rst,
    i_val,
    i_stp,
    o_val,
    o_stp
    );

    input                   i_clk;
    input                   i_rst;
    input  [p_width-1:0]    i_val;
    input                   i_stp;
    output                  o_val;
    output                  o_stp;

    wire w_get;
    counter # (
        .p_scale    (p_width-1)
    )
    cnt (
        .i_clk      (i_clk),
        .i_rst      (i_rst),
        .i_val      ('d0),
        .i_inc      (i_stp),
        .i_dec      (1'b0),
        .o_val      (),
        .o_inc      (w_get),
        .o_dec      (),
    );

    logic [p_width-1:0] l_val;
    always_ff @ (posedge i_clk) begin
        if (i_rst) begin
            l_val <= 'd0;
        end
        else begin
            l_val    <= (w_get) ? i_val : 
                        (i_stp) ? {l_val[0], l_val[p_width-1:1]} :
                        l_val;
        end
    end

    assign o_val = l_val[0];
    assign o_stp = w_get;
endmodule