module sample (
    i_clk,
    i_sw,
    o_led,
    o_sgmnt
    );

    input           i_clk;
    input  [9:0]    i_sw;
    output [9:0]    o_led;
    output [6:0]    o_sgmnt [4];

    wire w_sec;
    clock # (
        .p_divider  (100_000_000)
    )
    clk (
        .i_clk      (i_clk),
        .i_rst      (),
        .i_stop     (),
        .o_out      (w_sec)
    );

    wire [5:0] w_code;
    counter # (
        .p_scale    ('h24)
    )(
        .i_clk      (i_clk),
        .i_rst      (),
        .i_val      (),
        .i_inc      (w_sec),
        .i_dec      (),
        .o_val      (w_code),
        .o_inc      (),
        .o_dec      ()
    );

    logic [5:0] l_code [3];
    logic l_sw;
    always_ff @ (posedge i_clk) begin
        l_sw <= i_sw[0];
        l_code[0] <= (i_sw[0] ^ l_sw) ? w_code : l_code[0];
        l_code[1] <= (i_sw[0] ^ l_sw) ? l_code[0] : l_code[1];
        l_code[2] <= (i_sw[0] ^ l_sw) ? l_code[1] : l_code[2];
    end

    drv_segment_txt (
        .o_drv_sgmnt(o_sgmnt[0]),
        .i_val      (w_code)
    );

    drv_segment_txt (
        .o_drv_sgmnt(o_sgmnt[1]),
        .i_val      (l_code[0])
    );

    drv_segment_txt (
        .o_drv_sgmnt(o_sgmnt[2]),
        .i_val      (l_code[1])
    );

    drv_segment_txt (
        .o_drv_sgmnt(o_sgmnt[3]),
        .i_val      (l_code[2])
    );

endmodule