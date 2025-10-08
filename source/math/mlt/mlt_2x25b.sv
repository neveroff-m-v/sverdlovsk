/// Произведение (2 числа 25-бит)
module mlt_2x25b (
    i_val,
    o_val
    );

    input [24:0]    i_val [1:0];
    output [24:0]   o_val;

    always_comb begin
        o_val[24] = i_val[0][24] ^ i_val[1][24];
        o_val[23:0] = i_val[0][23:12] * i_val[1][23:12];
    end
endmodule