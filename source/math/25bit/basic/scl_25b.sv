/// Масштабирование f(x) = x * 2 ^ (-scale) (25-бит)
module scl_25b # (
    p_scale = 1
    )(
    i_val,
    o_val
    );

    input [25:0]    i_val;
    output [25:0]   o_val;

    always_comb begin
        o_val = {i_val[24], {p_scale{1'b0}} , i_val[23:p_scale]};
    end
endmodule