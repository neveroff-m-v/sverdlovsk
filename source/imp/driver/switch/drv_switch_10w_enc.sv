`timescale 1ns / 1ps

/// Драйвер тактовой кнопки / тумблера (строка 10 разрядов + декодер)
/*
    SVERDLOVSK
    system verilog library

    Neveroff M.V.
    2025
*/

module drv_switch_10w_enc # (
    p_scale = 5,
    p_mode = "pullup"
    )(
    i_drv_sw,
    i_clk,
    i_rst,
    o_val,
    o_unknown,
    o_toggle
    );
    
    input [9:0]     i_drv_sw;
    
    input       	i_clk;
    input       	i_rst;
    output [3:0]    o_val;
    output          o_unknown;
    output          o_toggle;

    wire [9:0] w_val;
    /// Драйвер тактовой кнопки / тумблера (каскад)
    drv_switch_w # (
        .p_width        (10),
        .p_scale        (p_scale),
        .p_mode         (p_mode)        
    ) 
    sw (
        .i_drv_sw       (i_drv_sw),
        .i_clk          (i_clk),
        .i_rst          (i_rst),
        .o_press        (w_val), 
        .o_click        (),
        .o_release      (),
        .o_toggle       (),
        .o_toggle_common(o_toggle)   
    );

    encode_10_4 enc (
        .i_val        (w_val),
        .o_val        (o_val),
        .o_unknown    (o_unknown)
    );
	
endmodule
