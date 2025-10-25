`timescale 1ns / 1ps

/// Таблица символов 7-сегментного индикатора (десятичная система счисления)
module segment_ram_dec (
    i_val,
    o_val
    );
    
    input [7:0]     i_val;
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

        case (i_val[3:0])
            'd0: o_val = 'b1000000; // 0
            'd1: o_val = 'b1111001; // 1
            'd2: o_val = 'b0100100; // 2
            'd3: o_val = 'b0110000; // 3
            'd4: o_val = 'b0011001; // 4
            'd5: o_val = 'b0010010; // 5
            'd6: o_val = 'b0000010; // 6
            'd7: o_val = 'b1111000; // 7
            'd8: o_val = 'b0000000; // 8
            'd9: o_val = 'b0010000; // 9 
        endcase
    end
endmodule
