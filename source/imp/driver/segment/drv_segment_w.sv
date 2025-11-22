`timescale 1ns / 1ps

/// Драйвер 7-сегментного индикатора (строка)
/*
    SVERDLOVSK
    system verilog library

    Neveroff M.V.
    2025
*/

module drv_segment_w # (
    p_symbol = "hex", // "dec" "hex" "txt"
    p_width = 4
    )(
    o_drv_sgmnt,
    i_val
    );

    output [6:0]    o_drv_sgmnt [p_width-1:0];
    
    input [7:0]     i_val [p_width-1:0];

    genvar i;
    generate
    for (i = 0; i < p_width; i++) begin : segment
        /// Драйвер 7-сегментного индикатора
        drv_segment # (
            .p_symbol 	(p_symbol)
        )
        sgmnt (
            .o_drv_sgmnt(o_drv_sgmnt[i]),
            .i_val      (i_val[i])  
        );
    end
    endgenerate
endmodule