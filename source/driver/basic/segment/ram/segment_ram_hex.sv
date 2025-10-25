`timescale 1ns / 1ps

/// Таблица символов 7-сегментного индикатора (шестнадцатеричная система счисления)
module segment_ram_hex (
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
            'h0: o_val = 'b1000000; // 0
            'h1: o_val = 'b1111001; // 1
            'h2: o_val = 'b0100100; // 2
            'h3: o_val = 'b0110000; // 3
            'h4: o_val = 'b0011001; // 4
            'h5: o_val = 'b0010010; // 5
            'h6: o_val = 'b0000010; // 6
            'h7: o_val = 'b1111000; // 7
            'h8: o_val = 'b0000000; // 8
            'h9: o_val = 'b0010000; // 9 
            'hA: o_val = 'b0001000; // A
            'hB: o_val = 'b0000011; // B
            'hC: o_val = 'b1000110; // C
            'hD: o_val = 'b0100001; // D
            'hE: o_val = 'b0000110; // E 
            'hF: o_val = 'b0001110; // F
        endcase
    end
endmodule
