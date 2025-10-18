/// Генератор гармонических колебаний sin/cos (25-бит)
/// f(t) = α + δt
module gen_hrm_25b (
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
    input  [24:0]   i_alpha [2];
    input  [24:0]   i_delta [2];
    output [24:0]   o_val [2];

    logic [24:0] l_alpha [2];
    logic [24:0] l_delta [2];

    wire [24:0] w_theta [2];
    hrm_25b hrm (
        .i_alpha    (l_alpha),
        .i_delta    (l_delta),
        .o_theta    (w_theta)
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
