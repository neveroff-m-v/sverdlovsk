`timescale 1ns / 1ps

/// Преобразователь последовательной шины в паралельную
/*
    SVERDLOVSK
    system verilog library

    Neveroff M.V.
    2025
*/

module parallel # (
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
    input                   i_val;
    input                   i_stp;
    output [p_width-1:0]    o_val;
    output                  o_stp;

    wire w_set;
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
        .o_inc      (w_set),
        .o_dec      (),
    );

    logic [p_width-1:0] l_val;
    always_ff @ (posedge i_clk) begin
        if (i_rst) begin
            l_val <= 'b0;
        end
        else begin
            l_val    <= (w_set) ? 'd0 : 
                        (i_stp) ? {l_val[p_width-2:0], i_val} :
                        l_val;
        end
    end

    assign o_val = l_val;
    assign o_stp = w_set;
endmodule