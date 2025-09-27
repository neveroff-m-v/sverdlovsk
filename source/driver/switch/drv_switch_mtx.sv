`timescale 1ns / 1ps

`define PULLUP 0
`define PULLDOWN 1

/// Драйвер тактовой кнопки / тумблера (матрица)
module drv_switch_mtx # (
    p_line = 4,
    p_column = 4,
    p_scale = 5,
    p_mode = `PULLUP
    )(
    i_drv_sw,
    i_clk,
    i_rst,
    o_press,
    o_click,
    o_release,
    o_toggle,
    o_toggle_common
    );
    
    input [p_column-1:0]    i_drv_sw [p_line-1:0];
    
    input       	        i_clk;
    input       	        i_rst;
    output [p_column-1:0]   o_press [p_line-1:0];
    output [p_column-1:0]   o_click [p_line-1:0];
    output [p_column-1:0]   o_release [p_line-1:0];
    output [p_column-1:0]   o_toggle [p_line-1:0];
    output                  o_toggle_common; 

	wire [p_column-1:0] w_toggle_common;
	
    genvar i;
    generate
    for (i = 0; i < p_line; i++) begin : switch
        /// Драйвер тактовой кнопки / тумблера (каскад)
        drv_switch_row # (
            .p_count    (p_column),
            .p_scale 	(p_scale),
            .p_mode     (p_mode)
        )
        sw (
            .i_drv_sw       (i_drv_sw[i]),
            .i_clk          (i_clk),
            .i_rst          (i_rst),
            .o_press        (o_press[i]), 
            .o_click        (o_click[i]),
            .o_release      (o_release[i]),
            .o_toggle       (o_toggle[i]),
            .o_toggle_common(w_toggle_common[i])  
        );
    end
    endgenerate
	
    assign o_toggle_common =| w_toggle_common;
	
endmodule
