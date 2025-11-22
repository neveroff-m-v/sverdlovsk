/*
    SVERDLOVSK
    system verilog library

    Neveroff M.V.
    2025
*/

module audio (
    i_clk_50m,
    o_hex,
    o_xck,
    o_bclk,
    o_dac_dat,
    o_dac_clrck,
    i_adc_dat,
    o_adc_clrck
    );

    input           i_clk_50m;

    output [6:0]    o_hex [3:0];

    output          o_xck;
    output          o_bclk;
    output          o_dac_dat;
    output          o_dac_clrck;
    input           i_adc_dat;
    output          o_adc_clrck;

    wire [15:0] w_cos;
    drv_segment_w # (
        .p_symbol   ("hex"),
        .p_width    (4)
    )
    sgmnt (
        .o_drv_sgmnt(o_hex),
        .i_val      ('{w_cos[15:12], w_cos[11:8], w_cos[7:4], w_cos[3:0]})
    );

    wire w_tck_50k;
    tick # (
        .p_divider  (1_00)
    )
    tck (
        .i_clk      (i_clk_50m),
        .i_rst      ('b0),
        .i_stop     ('b0),
        .o_out      (w_tck_50k)
    );

    logic [15:0] l_val = 'd0;
    ram_cos cos (
        .i_val   (l_val),
        .o_val   (w_cos)
    );

    wire [15:0] w_mic [1:0];
    drv_audio_wm8731 wm8731 (
        .o_drv_xck          (o_xck),
        .o_drv_bclk         (o_bclk),
        .o_drv_dac_dat      (o_dac_dat),
        .o_drv_dac_clrck    (o_dac_clrck),
        .i_drv_adc_dat      (i_adc_dat),
        .o_drv_adc_clrck    (o_adc_clrck),
        // ---
        .i_clk              (i_clk_50m),
        .i_rst              ('b0),
        // ---
        .i_dat              ('{w_cos[15:0], w_cos[15:0]}),
        //.i_dat              (w_mic),
        .o_ack              (),
        .o_dat              (),
        .o_req              ()
    );

    always_ff @ (posedge i_clk_50m) begin
        l_val <= (w_tck_50k) ? l_val + 'd1 : l_val;
    end

endmodule