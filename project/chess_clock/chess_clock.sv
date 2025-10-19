`timescale 1ns / 1ps

/// Шахматные часы
module chess_tick # (
    p_divider = 17_865_771,
    p_scale = 3
    )(
    i_sw_stop,
    i_sw_restart,
    i_sw_init,
    i_player_a_sw,
    o_player_a_sgmnt,
    o_player_a_led,
    i_player_b_sw,
    o_player_b_sgmnt,
	o_player_b_led,

    i_clk_50m,
    i_rst
    );
    
    input           i_sw_stop;
    input           i_sw_restart;
	input [3:0]     i_sw_init [1:0];
    input           i_player_a_sw;
    output [6:0]    o_player_a_sgmnt [1:0];
    output [3:0]    o_player_a_led;
    input           i_player_b_sw;
    output [6:0]    o_player_b_sgmnt [1:0];
	output [3:0]    o_player_b_led;

    input           i_clk_50m;
    input           i_rst;

    wire w_restart;
    wire w_sw_restart_click;      
    /// Драйвер тактовой кнопки / тумблера
    drv_switch # (
        .p_scale    (p_scale),
        .p_mode     ("pullup")   
    )
    sw_restart (
        .i_drv_sw   (i_sw_restart),
        .i_clk      (i_clk_50m),
        .i_rst      (i_rst),
        .o_press    (), 
        .o_click    (w_sw_restart_click),
        .o_release  (),
        .o_toggle   ()   
    );

    wire w_sw_stop_click;      
    /// Драйвер тактовой кнопки / тумблера
    drv_switch # (
        .p_scale    (p_scale),
        .p_mode     ("pullup")   
    )
    sw_stop (
        .i_drv_sw   (i_sw_stop),
        .i_clk      (i_clk_50m),
        .i_rst      (i_rst),
        .o_press    (), 
        .o_click    (w_sw_stop_click),
        .o_release  (),
        .o_toggle   ()   
    );
	 
	wire [3:0] w_init [1:0];
    wire w_init_change;
	/// Драйвер тактовой кнопки / тумблера (матрица)
    drv_switch_h_w # (
        .p_height       (2),
        .p_width        (4),
        .p_scale        (p_scale),
        .p_mode         ("pulldown")        
    ) 
    sw_init (
        .i_drv_sw       (i_sw_init),
        .i_clk          (i_clk_50m),
        .i_rst          (i_rst),
        .o_press        (w_init), 
        .o_click        (),
        .o_release      (),
        .o_toggle       (),
        .o_toggle_common(w_init_change)     
    );

    wire w_player_a_stop;
    wire w_player_a_win;
    wire w_player_a_turn;
    wire w_player_a_zero;
    /// Шахматные часы (интерфейс игрока)
    chess_tick_player # (
        .p_divider  (p_divider),
        .p_scale    (p_scale)
    )
    player_a (
        .i_drv_sw   (i_player_a_sw),
        .o_drv_sgmnt(o_player_a_sgmnt),
        .o_drv_led  (o_player_a_led),
        .i_clk      (i_clk_50m),
        .i_rst      (i_rst),
        .i_restart  (w_restart),
        .i_init     (w_init),
        .i_stop     (w_player_a_stop),
        .i_win      (w_player_a_win),
        .o_turn     (w_player_a_turn),
        .o_zero     (w_player_a_zero)
    );
    
    wire w_player_b_stop;
    wire w_player_b_win;
    wire w_player_b_turn;
    wire w_player_b_zero;
    /// Шахматные часы (интерфейс игрока)
    chess_tick_player # (
        .p_divider  (p_divider),
        .p_scale    (p_scale)
    )
    player_b (
        .i_drv_sw   (i_player_b_sw),
        .o_drv_sgmnt(o_player_b_sgmnt),
        .o_drv_led  (o_player_b_led),
        .i_clk      (i_clk_50m),
        .i_rst      (i_rst),
        .i_restart  (w_restart),
        .i_init     (w_init),
        .i_stop     (w_player_b_stop),
        .i_win      (w_player_b_win),
        .o_turn     (w_player_b_turn),
        .o_zero     (w_player_b_zero)
    );

    /// Шахматные часы FSM
    chess_tick_fsm fsm (
        .i_clk          (i_clk_50m),
        .i_rst          (i_rst),
        .i_restart      (w_sw_restart_click | w_init_change),
        .i_stop         (w_sw_stop_click),
        .i_player_a_turn(w_player_a_turn),
        .i_player_a_zero(w_player_a_zero),
        .o_player_a_stop(w_player_a_stop),
		.o_player_a_win (w_player_a_win),
        .i_player_b_turn(w_player_b_turn),
        .i_player_b_zero(w_player_b_zero),
        .o_player_b_stop(w_player_b_stop),
		.o_player_b_win (w_player_b_win),
        .o_restart      (w_restart)
    );

endmodule