/*
    SVERDLOVSK
    system verilog library

    Neveroff M.V.
    2025
*/

module drv_ps2 (
    i_drv_clk,
    i_drv_dat,
    //---
    i_clk,
    i_rst,
    //---
    o_dat,
    o_emp,
    o_err
    );

    input           i_drv_clk;
    input           i_drv_dat;

    input           i_clk;
    input           i_rst;

    output [7:0]    o_dat;
    output          o_emp;
    output          o_err;

    wire w_clk_negedge;
    detector clk_dtctr (
        .i_clk      (i_clk),
        .i_rst      (i_rst),
        // ---
        .i_in       (i_drv_clk),
        .o_posedge  (),
        .o_negedge  (w_clk_negedge),
        .o_edge     ()
    );
    /*
    wire [10:0] w_dat;
    wire w_stp;
    parallel # (
        .p_width    (11)
    )
    prll (
        .i_clk      (i_clk),
        .i_rst      (i_rst),
        .i_val      (i_drv_dat),
        .i_stp      (w_clk_negedge),
        .o_val      (w_dat),
        .o_stp      (w_stp)
    );*/

    logic [10:0] l_dat;
    logic [4:0] l_cnt;
    always_ff @ (posedge i_clk) begin
        l_dat <=    (i_rst) ? 'd0 :
                    (w_clk_negedge) ? {i_drv_dat, l_dat[10:1]} :
                    l_dat;

        l_cnt <=    (i_rst) ? 'd0 :
                    (l_cnt == 5'd11) ? 'd0 :
                    (w_clk_negedge) ? l_cnt + 'd1 :
                    l_cnt;
    end

    assign o_dat = {l_dat[8:1]};
    assign o_emp = (l_cnt == 5'd11) ? 'b0 : ~l_err;
    assign o_err = '0;

endmodule