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
    i_value
    );
    
    output [6:0]    o_drv_sgmnt;
    
    input [3:0]     i_value;

    always_comb begin
        o_drv_sgmnt = 7'b1111111;

        case (i_value)
            4'd0: o_drv_sgmnt = 7'b1000000; // 0
            4'd1: o_drv_sgmnt = 7'b1111001; // 1
            4'd2: o_drv_sgmnt = 7'b0100100; // 2
            4'd3: o_drv_sgmnt = 7'b0110000; // 3
            4'd4: o_drv_sgmnt = 7'b0011001; // 4
            4'd5: o_drv_sgmnt = 7'b0010010; // 5
            4'd6: o_drv_sgmnt = 7'b0000010; // 6
            4'd7: o_drv_sgmnt = 7'b1111000; // 7
            4'd8: o_drv_sgmnt = 7'b0000000; // 8
            4'd9: o_drv_sgmnt = 7'b0010000; // 9 
        endcase
    end
endmodule
