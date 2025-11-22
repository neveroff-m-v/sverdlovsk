/// Генератор экспоненциального затухания (25-бит)
/// f(t) = αδ^t
/*
    SVERDLOVSK
    system verilog library

    Neveroff M.V.
    2025
*/

module gen_exp_25b (
    i_clk,
    i_rst,
    i_tick,
    i_alpha,
    i_delta,
    o_val
    );

    input           i_clk;
    input           i_rst;
    input           i_tick;
    input [25:0]    i_alpha;
    input [25:0]    i_delta;
    output [25:0]   o_val;

    logic [25:0] l_alpha;
    logic [25:0] l_delta;

    wire [25:0] w_theta;
    mlt_25b mlt (
        .i_val  ('{l_alpha, l_delta}),
        .o_val  (w_theta)
    );   

    always_ff @ (posedge i_clk) begin
        if (i_rst) begin
            l_alpha <= i_alpha;
            l_delta <= i_delta;
        end
        else begin
            l_alpha <= (i_tick) ? w_theta : l_alpha;
            l_delta <= l_delta;
        end
    end

    assign o_val = w_theta;
endmodule