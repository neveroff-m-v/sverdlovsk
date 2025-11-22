/*
    SVERDLOVSK
    system verilog library

    Neveroff M.V.
    2025
*/

/// Кодовый замок
module code_lock # (
    p_divider = 17_865_771,
    p_scale = 3
    )(
    i_sw,
    o_sgmnt,
    i_clk_50m,
    i_rst
    );

    input [9:0]     i_sw;
    output [6:0]    o_sgmnt [3:0];

    input           i_clk_50m;
    input           i_rst;

    wire [3:0] w_sw_code;
    wire w_sw_code_vld;
    wire w_sw_unknown;
    wire w_sw_toggle;
    /// Драйвер тактовой кнопки / тумблера (строка 10 разрядов + декодер)
    drv_switch_10w_enc # (
        .p_scale    (p_scale),
        .p_mode     ("pulldown")
    )
    sw (
        .i_drv_sw   (i_sw),
        .i_clk      (i_clk_50m),
        .i_rst      (i_rst),
        .o_val      (w_sw_code),
        .o_unknown  (w_sw_unknown),
        .o_toggle   (w_sw_toggle)
    );
    assign w_sw_code_vld = w_sw_toggle & (~w_sw_unknown);
    
    wire [3:0] w_cnt_val [3:0];

    /// Счетчик десятичный
    counter_dec cnt_0 (
        .i_clk      (i_clk_50m),
        .i_rst      (w_sw_code_vld),
        .i_count    (w_sw_code),
        .i_plus     (),
        .i_minus    (),
        .o_count    (w_cnt_val[0]),
        .o_plus     (),
        .o_minus    (),
        .o_zero     ()
    );

    /// Счетчик десятичный
    counter_dec cnt_1 (
        .i_clk      (i_clk_50m),
        .i_rst      (w_sw_code_vld),
        .i_count    (w_cnt_val[0]),
        .i_plus     (),
        .i_minus    (),
        .o_count    (w_cnt_val[1]),
        .o_plus     (),
        .o_minus    (),
        .o_zero     ()
    );

    /// Счетчик десятичный
    counter_dec cnt_2 (
        .i_clk      (i_clk_50m),
        .i_rst      (w_sw_code_vld),
        .i_count    (w_cnt_val[1]),
        .i_plus     (),
        .i_minus    (),
        .o_count    (w_cnt_val[2]),
        .o_plus     (),
        .o_minus    (),
        .o_zero     ()
    );

    /// Счетчик десятичный
    counter_dec cnt_3 (
        .i_clk      (i_clk_50m),
        .i_rst      (w_sw_code_vld),
        .i_count    (w_cnt_val[2]),
        .i_plus     (),
        .i_minus    (),
        .o_count    (w_cnt_val[3]),
        .o_plus     (),
        .o_minus    (),
        .o_zero     ()
    );

    /// Драйвер 7-сегментного индикатора (десятичный без знака) (строка)
    drv_segment_dec_w #(
        .p_width        (4)
    ) sgmnt (
        .o_drv_sgmnt    (o_sgmnt),
        .i_value        (w_cnt_val)
    );

    /// Кодовый замок (fsm)
    code_lock_fsm fsm (
        .i_clk      (i_clk_50m),
        .i_rst      (i_rst),
        .i_code     (w_sw_code),
        .i_code_vld (w_sw_code_vld),
        .i_close    (),
        .o_open     ()
    );

endmodule
