/// Инвертирование f(x) = - x (25-бит)
module inv_25b (
    i_val,
    o_val
    );

    input  [24:0]   i_val;
    output [24:0]   o_val;

    always_comb begin
        o_val = {~i_val[24], i_val[23:0]};
    end
endmodule