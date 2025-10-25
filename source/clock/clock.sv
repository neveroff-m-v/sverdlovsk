module clock # (
    p_divider = 50
    )(
    i_clk,
    i_rst,
    i_stop,
    o_out
    );

    input       i_clk;
    input       i_rst;
    input       i_stop;
    output      o_out;

    wire w_edge;
    tick # (
        .p_divider  (p_divider)
    )
    tck (
        .i_clk      (i_clk),
        .i_rst      (i_rst),
        .i_stop     (i_stop),
        .o_out      (w_edge)
    );

    generator gen (
        .i_clk      (i_clk),
        .i_rst      (i_rst),
        .o_out      (o_out),
        .i_posedge  (),
        .i_negedge  (),
        .i_edge     (w_edge)
    );
endmodule