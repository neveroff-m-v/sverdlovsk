`timescale 1ns / 1ps

/// Таблица символов 7-сегментного индикатора (текстовый)
/*
    SVERDLOVSK
    system verilog library

    Neveroff M.V.
    2025
*/

module segment_ram_txt (
    i_val,
    o_val
    );
    
    input [5:0]     i_val;
    output [6:0]    o_val;

/*
    ╔═ 0 ═╗
    5     1
    ╠═ 6 ═╣
    4     2
    ╚═ 3 ═╝ 
*/

    always_comb begin
        o_val = 'b1111111;

        case (i_val)
            'h00: o_val = 'b1000000; // 0
            'h01: o_val = 'b1111001; // 1
            'h02: o_val = 'b0100100; // 2
            'h03: o_val = 'b0110000; // 3
            'h04: o_val = 'b0011001; // 4
            'h05: o_val = 'b0010010; // 5
            'h06: o_val = 'b0000010; // 6
            'h07: o_val = 'b1111000; // 7
            'h08: o_val = 'b0000000; // 8
            'h09: o_val = 'b0010000; // 9 
            'h0A: o_val = 'b0001000; // A
            'h0B: o_val = 'b0000011; // B
            'h0C: o_val = 'b1000110; // C
            'h0D: o_val = 'b0100001; // D
            'h0E: o_val = 'b0000110; // E 
            'h0F: o_val = 'b0001110; // F
            'h10: o_val = 'b1000010; // G
            'h11: o_val = 'b0001011; // H
            'h12: o_val = 'b1111001; // I
            'h13: o_val = 'b1100001; // J
            'h14: o_val = 'b0001010; // K
            'h15: o_val = 'b1000111; // L
            'h16: o_val = 'b0101010; // M
            'h17: o_val = 'b1001000; // N
            'h18: o_val = 'b1000000; // O
            'h19: o_val = 'b0001100; // P
            'h1A: o_val = 'b0011000; // Q
            'h1B: o_val = 'b0101111; // R
            'h1C: o_val = 'b0010010; // S
            'h1D: o_val = 'b0000111; // T
            'h1E: o_val = 'b1000001; // U
            'h1F: o_val = 'b1100011; // V
            'h20: o_val = 'b1100010; // W
            'h21: o_val = 'b0001001; // X
            'h22: o_val = 'b0010001; // Y
            'h23: o_val = 'b0100100; // Z
            'h24: o_val = 'b0111111; // -
        endcase
    end
endmodule
