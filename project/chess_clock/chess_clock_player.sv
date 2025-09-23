`timescale 1ns / 1ps

/// Шахматные часы (интерфейс игрока)
module chess_clock_player # (
    p_divider = 17_865_771,
    p_scale = 3
    )(
    i_sw_turn,
    o_sgmnt,
	o_led,
    i_clk_50m,
    i_rst,
    i_init
    );
    
    input           i_sw_turn;
    output [6:0]    o_sgmnt_player_a [1:0];
    output [6:0]    o_sgmnt_player_b [1:0];
	output [3:0]    o_led_player_a;
	output [3:0]    o_led_player_b;

    input           i_clk_50m;
    input           i_rst;
    input [3:0]     i_init [1:0];