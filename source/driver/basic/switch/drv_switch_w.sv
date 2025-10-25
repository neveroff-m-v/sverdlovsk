`timescale 1ns / 1ps

/// Драйвер тактовой кнопки / тумблера (строка)
module drv_switch_w # (
    p_width = 4,
    p_scale = 5,
    p_mode = "pullup"
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
    
    input [p_width-1:0]     i_drv_sw;
    
    input       	        i_clk;
    input       	        i_rst;
    output [p_width-1:0]	o_press;
    output [p_width-1:0]    o_click;
    output [p_width-1:0]    o_release;
    output [p_width-1:0]    o_toggle;
    output                  o_toggle_common; 

	wire [p_width-1:0] w_toggle;
	
    genvar i;
    generate
    for (i = 0; i < p_width; i++) begin : switch
        /// Драйвер тактовой кнопки / тумблера
        drv_switch # (
            .p_scale 	(p_scale),
            .p_mode     (p_mode)
        )
        sw (
            .i_drv_sw   (i_drv_sw[i]),
            .i_clk      (i_clk),
            .i_rst      (i_rst),
            .o_press    (o_press[i]), 
            .o_click    (o_click[i]),
            .o_release  (o_release[i]),
            .o_toggle   (w_toggle[i])   
        );
    end
    endgenerate
	
	assign o_toggle = w_toggle;
    assign o_toggle_common =| w_toggle;
	
endmodule
