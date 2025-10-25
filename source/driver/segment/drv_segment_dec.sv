`timescale 1ns / 1ps

/*
    ╔═ 0 ═╗
    5     1
    ╠═ 6 ═╣
    4     2
    ╚═ 3 ═╝ 
*/

/// Драйвер 7-сегментного индикатора (десятичный без знака)
module drv_segment_dec (
    o_drv_sgmnt,
    i_val
    );
    
    output [6:0]    o_drv_sgmnt;
    
    input [3:0]     i_val;

    always_comb begin
        o_drv_sgmnt = 7'b1111111;

        case (i_val)
            'd0: o_drv_sgmnt = 'b1000000; // 0
            'd1: o_drv_sgmnt = 'b1111001; // 1
            'd2: o_drv_sgmnt = 'b0100100; // 2
            'd3: o_drv_sgmnt = 'b0110000; // 3
            'd4: o_drv_sgmnt = 'b0011001; // 4
            'd5: o_drv_sgmnt = 'b0010010; // 5
            'd6: o_drv_sgmnt = 'b0000010; // 6
            'd7: o_drv_sgmnt = 'b1111000; // 7
            'd8: o_drv_sgmnt = 'b0000000; // 8
            'd9: o_drv_sgmnt = 'b0010000; // 9 
        endcase
    end
endmodule
