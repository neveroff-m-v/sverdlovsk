`timescale 1ns / 1ps

/// Драйвер 7-сегментного индикатора
/*
    SVERDLOVSK
    system verilog library

    Neveroff M.V.
    2025
*/

module drv_segment # (
    p_symbol = "hex" // "dec" "hex" "txt"
    )(
    o_drv_sgmnt,
    i_val
    );

    output [6:0]    o_drv_sgmnt;

    input [7:0]     i_val;

    generate
    if (p_symbol == "dec") begin
    /// Таблица символов 7-сегментного индикатора (десятичная система счисления)   
    segment_ram_dec ram (
        .i_val  (i_val[3:0]),
        .o_val  (o_drv_sgmnt)
    );
    end

    if (p_symbol == "hex") begin
    /// Таблица символов 7-сегментного индикатора (шестнадцатеричная система счисления)  
    segment_ram_hex ram (
        .i_val  (i_val[3:0]),
        .o_val  (o_drv_sgmnt)
    );
    end

    if (p_symbol == "txt") begin
    /// Таблица символов 7-сегментного индикатора (текстовый)
    segment_ram_txt ram (
        .i_val  (i_val[5:0]),
        .o_val  (o_drv_sgmnt)
    );
    end
    endgenerate
endmodule