/// Генератор гармонических колебаний sin/cos (25-бит)
module harm_gen_25b (
    i_clk,
    i_rst,
    i_tick,
    i_alpha,
    i_delta,
    o_theta
    );

    input           i_clk;
    input           i_rst;
    input           i_tick;
    input [24:0]    i_alpha [1:0];
    input [24:0]    i_delta [1:0];
    output [24:0]   o_theta [1:0];

    logic [24:0] l_alpha [1:0];
    logic [24:0] l_delta [1:0];

    wire [24:0] w_theta [1:0];
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

    assign o_theta = w_theta;
endmodule
