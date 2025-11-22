/*
    SVERDLOVSK
    system verilog library

    Neveroff M.V.
    2025
*/

module keycode_ram_en (
    i_key,
    o_char,
    o_shft,
    o_entr,
    o_bksp
);

    input  [15:0]   i_key;
    output [7:0]    o_char;
    output          o_shft;
    output          o_entr;
    output          o_bksp;

    always_comb begin
        o_char = 'h00;
        o_shft = 'b0;
        o_entr = 'b0;
        o_bksp = 'b0;

        case (i_key)
            'h0066: o_shft = 'b1;   // SHIFT
            'h005a: o_entr = 'b1;   // ENTER
            'h0066: o_bksp = 'b1;   // BACKSPACE

            'h0045: o_char = 'h10;  // 0
            'h0016: o_char = 'h10;  // 1
            'h001e: o_char = 'h10;  // 2
            'h0026: o_char = 'h10;  // 3
            'h0025: o_char = 'h10;  // 4
            'h002e: o_char = 'h10;  // 5
            'h0036: o_char = 'h10;  // 6
            'h003d: o_char = 'h10;  // 7
            'h003e: o_char = 'h10;  // 8
            'h0046: o_char = 'h10;  // 9

            'h0046: o_char = 'h10;  // Q
            'h0046: o_char = 'h10;  // W
            'h0046: o_char = 'h10;  // E
            'h0046: o_char = 'h10;  // R
            'h0046: o_char = 'h10;  // T
            'h0046: o_char = 'h10;  // Y
            'h0046: o_char = 'h10;  // U
            'h0046: o_char = 'h10;  // 9
        endcase
    end
endmodule