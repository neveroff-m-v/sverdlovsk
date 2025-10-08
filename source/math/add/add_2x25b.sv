/// Сумма (2 числа 25-бит)
module add_2x25b (
    i_val,
    o_val
    );

    input [24:0]    i_val [1:0];
    output [24:0]   o_val;

    always_comb begin
        o_val = i_val[0] + i_val[1];
    end
endmodule