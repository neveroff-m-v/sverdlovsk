module drv_audio_wm8731 (
    o_drv_xck,
    o_drv_bclk,
    o_drv_dac_dat,
    o_drv_dac_lrck,
    i_drv_adc_dat,
    o_drv_adc_lrck,
    i_clk,
    i_rst,
    i_val [15:0]
    );

    output          o_drv_xck;
    output          o_drv_bclk;
    output          o_drv_dac_dat;
    output          o_drv_dac_lrck;
    input           i_drv_adc_dat;
    output          o_drv_adc_lrck;

    input           i_clk;
    input           i_rst;
    input  [15:0]   i_val;

    wire w_bclk_edge;
    clock # (
        .p_divider  (17)
    )
    clk_0 (
        .i_clk      (i_clk),
        .i_rst      (1'b0),
        .i_stop     (1'b0),
        .o_out      (w_bclk_edge)
    );

    wire w_bclk_out;
    signal sgnl_0 (
        .i_clk      (i_clk),
        .i_rst      (1'b0),
        .o_out      (w_bclk_out),
        .i_posedge  (),
        .i_negedge  (),
        .i_edge     (w_bclk_edge)
    );

    wire w_dac_lrck_edge;
    clock # (
        .p_divider  (544)
    )
    clk_1 (
        .i_clk      (i_clk),
        .i_rst      (1'b0),
        .i_stop     (1'b0),
        .o_out      (w_dac_lrck_edge)
    );

    wire w_dac_lrck_out; 
    signal sgnl_1 (
        .i_clk      (i_clk),
        .i_rst      (1'b0),
        .o_out      (w_dac_lrck_out),
        .i_posedge  (),
        .i_negedge  (),
        .i_edge     (w_dac_lrck_edge)
    );

    wire w_dac_dat_edge;
    clock # (
        .p_divider  (54400)
    )
    clk_2 (
        .i_clk      (i_clk),
        .i_rst      (1'b0),
        .i_stop     (1'b0),
        .o_out      (w_dac_dat_edge)
    );

    wire w_dac_dat_out; 
    signal sgnl_2 (
        .i_clk      (i_clk),
        .i_rst      (1'b0),
        .o_out      (w_dac_dat_out),
        .i_posedge  (),
        .i_negedge  (),
        .i_edge     (w_dac_dat_edge)
    );   

    assign o_drv_bclk = w_bclk_out;
    assign o_drv_dac_lrck = w_dac_lrck_out;
    assign o_drv_dac_dat = w_dac_dat_out;

endmodule