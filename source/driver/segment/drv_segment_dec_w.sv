`timescale 1ns / 1ps

/*
    ╔═ 0 ═╗
    5     1
    ╠═ 6 ═╣
    4     2
    ╚═ 3 ═╝ 
*/

/// Драйвер 7-сегментного индикатора (десятичный без знака) (строка)
module drv_segment_dec_w # (
    p_width = 4
    )(
    o_drv_sgmnt,
    i_value
    );
    
    output [6:0]    o_drv_sgmnt [p_width-1:0];
    
    input [3:0]     i_value [p_width-1:0];

    genvar i;
    generate
    for (i = 0; i < p_width; i++) begin : segment
        /// Драйвер 7-сегментного индикатора (десятичный)
        drv_segment_dec sgmnt (
            .o_drv_sgmnt(o_drv_sgmnt[i]),
            .i_value    (i_value[i])
        );
    end
    endgenerate
endmodule
