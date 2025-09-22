`timescale 1ns / 1ps

/// Драйвер тактовой кнопки / тумблера (каскад)
module drv_switch_row # (
    parameter p_FILTER = 5,
    parameter p_COUNT = 4
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
    
    input [p_COUNT-1:0]     i_drv_sw;
    
    input       	        i_clk;
    input       	        i_rst;
    output [p_COUNT-1:0]	o_press;
    output [p_COUNT-1:0]    o_click;
    output [p_COUNT-1:0]    o_release;
    output [p_COUNT-1:0]    o_toggle;
    output                  o_toggle_common; 

    wire [p_COUNT-1:0] w_press;
	wire [p_COUNT-1:0] w_click;
	wire [p_COUNT-1:0] w_release;
	wire [p_COUNT-1:0] w_toggle;
	
    genvar i;
    generate
    for (i = 0; i < p_COUNT; i++) begin : switch
        /// Драйвер тактовой кнопки / тумблера
        drv_switch # (
            .p_FILTER 	(p_FILTER)
        )
        sw (
            .i_drv_sw   (i_drv_sw[i]),
            .i_clk      (i_clk),
            .i_rst      (i_rst),
            .o_press    (w_press[i]), 
            .o_click    (w_click[i]),
            .o_release  (w_release[i]),
            .o_toggle   (w_toggle[i])   
        );
    end
    endgenerate
	
	assign o_press = w_press;
	assign o_click = w_click;
	assign o_release = w_release;
	assign o_toggle = w_toggle;
    assign o_toggle_common = |w_toggle;
	
endmodule
