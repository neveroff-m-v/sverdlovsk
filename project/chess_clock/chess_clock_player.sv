`timescale 1ns / 1ps

/// Шахматные часы (интерфейс игрока)
module chess_clock_player # (
    p_divider = 50_000_000,
    p_scale = 3
    )(
    i_drv_sw,
    o_drv_sgmnt,
	o_drv_led,
    i_clk,
    i_rst,
    i_restart,
    i_init,
    i_stop,
    i_win,
    o_turn,
    o_zero
    );
    
    input           i_drv_sw;
    output [6:0]    o_drv_sgmnt [1:0];
	output [3:0]    o_drv_led;

    input           i_clk;
    input           i_rst;
    input           i_restart;
    input [3:0]     i_init [1:0];
    input           i_stop;
    input           i_win;
    output          o_turn;
    output          o_zero;
     
    /// Драйвер тактовой кнопки / тумблера
    drv_switch # (
        .p_scale    (p_scale),
        .p_mode     ("pullup")   
    )
    sw (
        .i_drv_sw   (i_drv_sw),
        .i_clk      (i_clk),
        .i_rst      (i_rst),
        .o_press    (), 
        .o_click    (o_turn),
        .o_release  (),
        .o_toggle   ()   
    );

    wire w_tick;
    /// Делитель тактовой частоты
    clock # (
        .p_divider  (p_divider)
    ) 
    clk (
        .i_clk      (i_clk),
        .i_rst      (i_restart),
        .i_stop     (i_stop),
        .o_out      (w_tick)
    );

    wire [3:0] w_val [1:0];
    /// Счетчик десятичный (2 разряда)
    counter_dec_2w cnt_player_a (
        .i_clk      (i_clk),
        .i_rst      (i_restart),
        .i_count    (i_init),
        .i_plus     (),
        .i_minus    (w_tick),
        .o_count    (w_val),
        .o_plus     (),
        .o_minus    (),
        .o_zero     (o_zero)
    );

    /// Драйвер 7-сегментного индикатора (десятичный) (каскад)
    drv_segment_dec_w # (
        .p_width    (2)
    ) 
    sgmnt (
        .o_drv_sgmnt(o_drv_sgmnt),
        .i_value    (w_val)
    );

    assign o_drv_led = {4{i_win}};
endmodule