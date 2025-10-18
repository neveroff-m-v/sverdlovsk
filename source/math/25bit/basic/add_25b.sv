/// Сумма f(x,y) = x + y (25-бит)
module add_25b (
    i_val,
    o_val
    );

    input  [24:0]   i_val [2];
    output [24:0]   o_val;

    always_comb begin
        o_val = i_val[0] + i_val[1];
    end
endmodule