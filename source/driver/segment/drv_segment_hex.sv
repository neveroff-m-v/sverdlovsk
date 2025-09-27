`timescale 1ns / 1ps

/*
    ╔═ 0 ═╗
    5     1
    ╠═ 6 ═╣
    4     2
    ╚═ 3 ═╝ 
*/

/// Драйвер 7-сегментного индикатора (шестнадцатеричный без знака)
module drv_segment_hex (
    o_drv_sgmnt,
    i_value
    );
    
    output [6:0]    o_drv_sgmnt;
    
    input [4:0]     i_value;

    always_comb begin
        o_drv_sgmnt = 7'b1111111;

        case (i_value)
            4'h0: o_drv_sgmnt = 7'b1000000; // 0
            4'h1: o_drv_sgmnt = 7'b1111001; // 1
            4'h2: o_drv_sgmnt = 7'b0100100; // 2
            4'h3: o_drv_sgmnt = 7'b0110000; // 3
            4'h4: o_drv_sgmnt = 7'b0011001; // 4
            4'h5: o_drv_sgmnt = 7'b0010010; // 5
            4'h6: o_drv_sgmnt = 7'b0000010; // 6
            4'h7: o_drv_sgmnt = 7'b1111000; // 7
            4'h8: o_drv_sgmnt = 7'b0000000; // 8
            4'h9: o_drv_sgmnt = 7'b0010000; // 9 
            4'hA: o_drv_sgmnt = 7'b0010010; // A
            4'hB: o_drv_sgmnt = 7'b0000010; // B
            4'hC: o_drv_sgmnt = 7'b1111000; // C
            4'hD: o_drv_sgmnt = 7'b0000000; // D
            4'hE: o_drv_sgmnt = 7'b0010000; // E 
            4'hF: o_drv_sgmnt = 7'b0010000; // F
        endcase
    end
endmodule
