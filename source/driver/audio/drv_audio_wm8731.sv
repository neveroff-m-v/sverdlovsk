module drv_audio_wm8731 (
    o_drv_xck,
    o_drv_bclk,
    o_drv_dac_dat,
    o_drv_dac_clrck,
    i_drv_adc_dat,
    o_drv_adc_clrck,
    i_clk,
    i_rst,
    i_dat,
    o_ack,
    o_dat,
    o_req
    );

    output          o_drv_xck;
    output          o_drv_bclk;
    output          o_drv_dac_dat;
    output          o_drv_dac_clrck;
    input           i_drv_adc_dat;
    output          o_drv_adc_clrck;

    input           i_clk;
    input           i_rst;
    input  [15:0]   i_dat [1:0];
    output          o_ack;
    output [15:0]   o_dat [1:0];
    output          o_req;

    wire w_bclk;
    tick # (
        .p_divider  (17)
    )
    tck_bclk (
        .i_clk      (i_clk),
        .i_rst      (i_rst),
        .i_stop     (1'b0),
        .o_out      (w_bclk)
    );

    signal sgn_bclk (
        .i_clk      (i_clk),
        .i_rst      (i_rst),
        .o_out      (o_drv_bclk),
        .i_posedge  (),
        .i_negedge  (),
        .i_edge     (w_bclk)
    );

    serial # (
        .p_width    (32)
    )
    srl (
		.i_clk	(i_clk),
    	.i_rst	(i_rst),
    	.i_val	({i_dat[0], i_dat[1]}),
    	.i_stp	(w_bclk),
    	.o_val	(o_drv_dac_dat),
    	.o_stp	(o_ack)
    );

    parallel # (
        .p_width    (32)
    )
    prl (
		.i_clk	(i_clk),
    	.i_rst	(i_rst),
    	.i_val	(i_drv_adc_dat),
    	.i_stp	(w_bclk),
    	.o_val	({o_dat[0], o_dat[1]}),
    	.o_stp	(o_req)
    );

    wire w_clrck;
    tick # (
        .p_divider  (544)
    )
    tck_lrck (
        .i_clk      (i_clk),
        .i_rst      (i_rst),
        .i_stop     (1'b0),
        .o_out      (w_clrck)
    );

    wire w_clrck_out;
    signal sgn_clrck (
        .i_clk      (i_clk),
        .i_rst      (i_rst),
        .o_out      (w_clrck_out),
        .i_posedge  (),
        .i_negedge  (),
        .i_edge     (w_clrck)
    );

    assign o_drv_adc_clrck = w_clrck_out;
    assign o_drv_dac_clrck = w_clrck_out;
endmodule