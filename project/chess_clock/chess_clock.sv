`timescale 1ns / 1ps

/// Шахматные часы
module chess_clock (
    i_sw_stop,
    i_sw_restart,
    i_sw_player_a,
    i_sw_player_b,
	i_sw_init,
    o_sgmnt_player_a,
    o_sgmnt_player_b,
	o_led_player_a,
	o_led_player_b,
    i_clk_50mhz,
    i_rst
    );
    
    input           i_sw_stop;
    input           i_sw_restart;
    input           i_sw_player_a;
    input           i_sw_player_b;
	input [3:0]     i_sw_init [1:0];
    output [6:0]    o_sgmnt_player_a [1:0];
    output [6:0]    o_sgmnt_player_b [1:0];
	output [3:0]    o_led_player_a;
	output [3:0]    o_led_player_b;

    input           i_clk_50mhz;
    input           i_rst;
	 
	wire [3:0] w_init [1:0];
    
	/// Драйвер тактовой кнопки / тумблера (каскад)
    drv_switch_row # (
        .p_FILTER   (5),
        .p_COUNT    (4)
    ) 
    sw_init_0 (
        .i_drv_sw   (~ i_sw_init[0]),
        .i_clk      (i_clk_50mhz),
        .i_rst      (i_rst),
        .o_press    (w_init[0]), 
        .o_click    (),
        .o_release  (),
        .o_toggle   ()   
    );
	 
	/// Драйвер тактовой кнопки / тумблера (каскад)
    drv_switch_row  # (
        .p_FILTER   (5),
        .p_COUNT    (4)
    )
    sw_init_1 (
        .i_drv_sw   (~ i_sw_init[1]),
        .i_clk      (i_clk_50mhz),
        .i_rst      (i_rst),
        .o_press    (w_init[1]), 
        .o_click    (),
        .o_release  (),
        .o_toggle   ()   
    );

    wire w_restart;

    wire w_player_a_stop;
    wire w_player_a_tick;
    /// Делитель тактовой частоты
    clock # (
        .p_DIVIDER  (17_865_771)
    ) 
    clk_player_a (
        .i_clk      (i_clk_50mhz),
        .i_rst      (w_restart),
        .i_stop     (w_player_a_stop),
        .o_out      (w_player_a_tick)
    );

    wire [3:0] w_player_a_val [1:0];
    /// Драйвер 7-сегментного индикатора (десятичный)
    drv_segment_dec sgmnt_player_a_0 (
        .o_drv_sgmnt(o_sgmnt_player_a[0]),
        .i_value    (w_player_a_val[0])
    );

    /// Драйвер 7-сегментного индикатора (десятичный)
    drv_segment_dec sgmnt_player_a_1 (
        .o_drv_sgmnt(o_sgmnt_player_a[1]),
        .i_value    (w_player_a_val[1])
    );

    wire w_player_a_zero;
    /// Счетчик десятичный (2 разряда)
    counter_dec_2w cnt_player_a (
        .i_clk      (i_clk_50mhz),
        .i_rst      (w_restart),
        .i_count    (w_init),
        .i_plus     (),
        .i_minus    (w_player_a_tick),
        .o_count    (w_player_a_val),
        .o_plus     (),
        .o_minus    (),
        .o_zero     (w_player_a_zero)
    );
    
    wire w_player_b_stop;
    wire w_player_b_tick;
    /// Делитель тактовой частоты
    clock # (
        .p_DIVIDER  (17_865_771)
    ) 
    clk_player_b (
        .i_clk      (i_clk_50mhz),
        .i_rst      (w_restart),
        .i_stop     (w_player_b_stop),
        .o_out      (w_player_b_tick)
    );

    wire [3:0] w_player_b_val [1:0];
    /// Драйвер 7-сегментного индикатора (десятичный)
    drv_segment_dec sgmnt_player_b_0 (
        .o_drv_sgmnt(o_sgmnt_player_b[0]),
        .i_value    (w_player_b_val[0])
    );

    /// Драйвер 7-сегментного индикатора (десятичный)
    drv_segment_dec sgmnt_player_b_1 (
        .o_drv_sgmnt(o_sgmnt_player_b[1]),
        .i_value    (w_player_b_val[1])
    );

    wire w_player_b_zero;
    /// Счетчик десятичный (2 разряда)
    counter_dec_2w cnt_player_b (
        .i_clk      (i_clk_50mhz),
        .i_rst      (w_restart),
        .i_count    (w_init),
        .i_plus     (),
        .i_minus    (w_player_b_tick),
        .o_count    (w_player_b_val),
        .o_plus     (),
        .o_minus    (),
        .o_zero     (w_player_b_zero)
    );

    wire w_sw_restart_click;      
    /// Драйвер тактовой кнопки / тумблера
    drv_switch sw_restart (
        .i_drv_sw   (i_sw_restart),
        .i_clk      (i_clk_50mhz),
        .i_rst      (i_rst),
        .o_press    (), 
        .o_click    (w_sw_restart_click),
        .o_release  (),
        .o_toggle   ()   
    );

    wire w_sw_stop_click;      
    /// Драйвер тактовой кнопки / тумблера
    drv_switch sw_stop (
        .i_drv_sw   (i_sw_stop),
        .i_clk      (i_clk_50mhz),
        .i_rst      (i_rst),
        .o_press    (), 
        .o_click    (w_sw_stop_click),
        .o_release  (),
        .o_toggle   ()   
    );

    wire w_sw_player_a_click;      
    /// Драйвер тактовой кнопки / тумблера
    drv_switch sw_player_a (
        .i_drv_sw   (i_sw_player_a),
        .i_clk      (i_clk_50mhz),
        .i_rst      (i_rst),
        .o_press    (), 
        .o_click    (w_sw_player_a_click),
        .o_release  (),
        .o_toggle   ()   
    );

    wire w_sw_player_b_click;      
    /// Драйвер тактовой кнопки / тумблера
    drv_switch sw_player_b (
        .i_drv_sw   (i_sw_player_b),
        .i_clk      (i_clk_50mhz),
        .i_rst      (i_rst),
        .o_press    (), 
        .o_click    (w_sw_player_b_click),
        .o_release  (),
        .o_toggle   ()   
    );

	wire w_player_a_win;
	wire w_player_b_win;
    /// Шахматные часы FSM
    chess_clock_fsm fsm (
        .i_clk          (i_clk_50mhz),
        .i_rst          (i_rst),
        .i_restart      (w_sw_restart_click),
        .i_stop         (w_sw_stop_click),
        .i_player_a     (w_sw_player_a_click),
        .i_player_a_zero(w_player_a_zero),
        .o_player_a_stop(w_player_a_stop),
		.o_player_a_win (w_player_a_win),
        .i_player_b     (w_sw_player_b_click),
        .i_player_b_zero(w_player_b_zero),
        .o_player_b_stop(w_player_b_stop),
		.o_player_b_win (w_player_b_win),
        .o_restart      (w_restart)
    );
	
	assign o_led_player_b = {w_player_a_win, w_player_a_win, w_player_a_win, w_player_a_win};
	assign o_led_player_a = {w_player_b_win, w_player_b_win, w_player_b_win, w_player_b_win};

endmodule