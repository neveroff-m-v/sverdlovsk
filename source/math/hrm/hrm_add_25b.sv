/// Сумма (2 угла sin/cos 25-бит)
module hrm_add_25b (
    i_alpha,
    i_delta,
    o_theta
    );

    input [24:0]    i_alpha [1:0];
    input [24:0]    i_delta [1:0];
    output [24:0]   o_theta [1:0];

    /*
    θ = α + δ
    sin(θ) = sin(α + δ) = sin(α)cos(δ) + cos(α)sin(δ)
    cos(θ) = cos(α + δ) = cos(α)cos(δ) - sin(α)sin(δ)
    */

    wire [24:0] w_sina_sind;
    mlt_2x25b mlt_0 (
        .i_val  ('{i_alpha[0], i_delta[0]}),
        .o_val  (w_sina_sind)
    );

    wire [24:0] w_sina_cosd;
    mlt_2x25b mlt_1 (
        .i_val  ('{i_alpha[0], i_delta[1]}),
        .o_val  (w_sina_cosd)
    );

    wire [24:0] w_cosa_sind;
    mlt_2x25b mlt_2 (
        .i_val  ('{i_alpha[1], i_delta[0]}),
        .o_val  (w_cosa_sind)
    );

    wire [24:0] w_cosa_cosd;
    mlt_2x25b mlt_3 (
        .i_val  ('{i_alpha[1], i_delta[1]}),
        .o_val  (w_cosa_cosd)
    );

    add_2x25b add (
        .i_val  ('{w_sina_cosd, w_cosa_sind}),
        .o_val  (o_theta[0])
    );

    dff_2x25b dff (
        .i_val  ('{w_cosa_cosd, w_sina_sind}),
        .o_val  (o_theta[1])
    );
endmodule