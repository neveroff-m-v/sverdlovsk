`timescale 1ns / 1ps

/*
    ╔═ 0 ═╗
    5     1
    ╠═ 6 ═╣
    4     2
    ╚═ 3 ═╝ 
*/

/// Драйвер 7-сегментного индикатора (шестнадцатеричный без знака)
module drv_segment_txt (
    o_drv_sgmnt,
    i_val
    );
    
    output [6:0]    o_drv_sgmnt;
    
    input [5:0]     i_val;

    always_comb begin
        o_drv_sgmnt = 7'b1111111;

        case (i_val)
            6'h00: o_drv_sgmnt = 7'b1000000; // 0
            6'h01: o_drv_sgmnt = 7'b1111001; // 1
            6'h02: o_drv_sgmnt = 7'b0100100; // 2
            6'h03: o_drv_sgmnt = 7'b0110000; // 3
            6'h04: o_drv_sgmnt = 7'b0011001; // 4
            6'h05: o_drv_sgmnt = 7'b0010010; // 5
            6'h06: o_drv_sgmnt = 7'b0000010; // 6
            6'h07: o_drv_sgmnt = 7'b1111000; // 7
            6'h08: o_drv_sgmnt = 7'b0000000; // 8
            6'h09: o_drv_sgmnt = 7'b0010000; // 9 
            6'h0A: o_drv_sgmnt = 7'b0001000; // A
            6'h0B: o_drv_sgmnt = 7'b0000011; // B
            6'h0C: o_drv_sgmnt = 7'b1000110; // C
            6'h0D: o_drv_sgmnt = 7'b0100001; // D
            6'h0E: o_drv_sgmnt = 7'b0000110; // E 
            6'h0F: o_drv_sgmnt = 7'b0001110; // F
            6'h10: o_drv_sgmnt = 7'b1000010; // G
            6'h11: o_drv_sgmnt = 7'b0001011; // H
            6'h12: o_drv_sgmnt = 7'b1111001; // I
            6'h13: o_drv_sgmnt = 7'b1100001; // J
            6'h14: o_drv_sgmnt = 7'b0001010; // K
            6'h15: o_drv_sgmnt = 7'b1000111; // L
            6'h16: o_drv_sgmnt = 7'b0101010; // M
            6'h17: o_drv_sgmnt = 7'b1001000; // N
            6'h18: o_drv_sgmnt = 7'b1000000; // O
            6'h19: o_drv_sgmnt = 7'b0001100; // P
            6'h1A: o_drv_sgmnt = 7'b0011000; // Q
            6'h1B: o_drv_sgmnt = 7'b0101111; // R
            6'h1C: o_drv_sgmnt = 7'b0010010; // S
            6'h1D: o_drv_sgmnt = 7'b0000111; // T
            6'h1E: o_drv_sgmnt = 7'b1000001; // U
            6'h1F: o_drv_sgmnt = 7'b1100011; // V
            6'h20: o_drv_sgmnt = 7'b1100010; // W
            6'h21: o_drv_sgmnt = 7'b0001001; // X
            6'h22: o_drv_sgmnt = 7'b0010001; // Y
            6'h23: o_drv_sgmnt = 7'b0100100; // Z
            6'h24: o_drv_sgmnt = 7'b0111111; // -
        endcase
    end
endmodule
