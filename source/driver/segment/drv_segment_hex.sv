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
    i_val
    );
    
    output [6:0]    o_drv_sgmnt;
    
    input [3:0]     i_val;

    always_comb begin
        o_drv_sgmnt = 'b1111111;

        case (i_val)
            'h0: o_drv_sgmnt = 'b1000000; // 0
            'h1: o_drv_sgmnt = 'b1111001; // 1
            'h2: o_drv_sgmnt = 'b0100100; // 2
            'h3: o_drv_sgmnt = 'b0110000; // 3
            'h4: o_drv_sgmnt = 'b0011001; // 4
            'h5: o_drv_sgmnt = 'b0010010; // 5
            'h6: o_drv_sgmnt = 'b0000010; // 6
            'h7: o_drv_sgmnt = 'b1111000; // 7
            'h8: o_drv_sgmnt = 'b0000000; // 8
            'h9: o_drv_sgmnt = 'b0010000; // 9 
            'hA: o_drv_sgmnt = 'b0001000; // A
            'hB: o_drv_sgmnt = 'b0000011; // B
            'hC: o_drv_sgmnt = 'b1000110; // C
            'hD: o_drv_sgmnt = 'b0100001; // D
            'hE: o_drv_sgmnt = 'b0000110; // E 
            'hF: o_drv_sgmnt = 'b0001110; // F
        endcase
    end
endmodule
