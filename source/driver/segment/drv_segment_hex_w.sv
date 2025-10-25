`timescale 1ns / 1ps

/// Драйвер 7-сегментного индикатора (шестнадцатеричный без знака) (строка)
module drv_segment_hex_w # (
    p_width = 4
    )(
    o_drv_sgmnt,
    i_val
    );
    
    output [6:0]    o_drv_sgmnt [p_width-1:0];
    
    input [3:0]     i_val [p_width-1:0];

    genvar i;
    generate
    for (i = 0; i < p_width; i++) begin : segment
        /// Драйвер 7-сегментного индикатора (десятичный)
        drv_segment_hex sgmnt (
            .o_drv_sgmnt(o_drv_sgmnt[i]),
            .i_val      (i_val[i])
        );
    end
    endgenerate
endmodule
