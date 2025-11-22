/*
    SVERDLOVSK
    system verilog library

    Neveroff M.V.
    2025
*/

/// Клавиатура PS\2
module ps2_keyboard (
    i_clk,
    i_key_clk,
    i_key_dat,
    o_key,
    o_count,
    o_sgmnt
    );

    input           i_clk;
    input           i_key_clk;
    input           i_key_dat;
    output [10:0]   o_key;
    output [10:0]   o_count;
    output [6:0]    o_sgmnt [3:0];

    wire w_press;
    wire w_relese;
    wire w_emp;
    wire [15:0] w_key;
    drv_ps2_keyboard keyboard (
        .i_drv_clk      (i_key_clk),
        .i_drv_dat      (i_key_dat),
        //---
        .i_clk          (i_clk),
        .i_rst          ('d0),
        //---
        .o_press        (w_press),
        .o_release      (w_relese),
        .o_key          (w_key),
        .o_emp          (w_emp)
    );

    logic [15:0] l_key;
    always_ff @ (posedge i_clk) begin
        l_key <=    (w_press & (~w_emp)) ? w_key :
                    l_key;
    end

    drv_segment_w # (
        .p_symbol   ("hex"),
        .p_width    (4)
    )
    sgmnt (
        .o_drv_sgmnt (o_sgmnt),
        .i_val       ('{l_key[15:12], l_key[11:8], l_key[7:4], l_key[3:0]})
        //.i_val       ('{8'h1, 8'h2, 8'h3, 8'h4})
    );

    assign o_key = l_key[10:0];

endmodule