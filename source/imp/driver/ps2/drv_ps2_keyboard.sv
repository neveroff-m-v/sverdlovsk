/*
    SVERDLOVSK
    system verilog library

    Neveroff M.V.
    2025
*/

module drv_ps2_keyboard (
    i_drv_clk,
    i_drv_dat,
    //---
    i_clk,
    i_rst,
    //---
    o_press,
    o_release,
    o_key,
    o_emp
    );

    input           i_drv_clk;
    input           i_drv_dat;

    input           i_clk;
    input           i_rst;

    output          o_press;
    output          o_release;
    output [15:0]   o_key;
    output          o_emp;

    wire [7:0] w_ps2_dat;
    wire w_ps2_emp;
    drv_ps2 ps2 (
        .i_drv_clk   (i_drv_clk),
        .i_drv_dat   (i_drv_dat),
        //---
        .i_clk       (i_clk),
        .i_rst       (i_rst),
        //---
        .o_dat       (w_ps2_dat),
        .o_emp       (w_ps2_emp)
    );

    enum logic [2:0] {
        START,
        WAIT,
        SPECIAL,
        RELEASE,
        KEY_CODE,
        SEND
    } l_state = START;

    always_ff @ (posedge i_clk) begin
        if (i_rst) begin
            l_state <= START;
        end
        else begin
            case (l_state)
                START: begin
                    l_state <=  WAIT;
                end

                WAIT: begin
                    l_state <=  (w_ps2_emp) ? WAIT : (
                                    (w_ps2_dat == 'hE0) ? SPECIAL : 
                                    (w_ps2_dat == 'hF0) ? RELEASE :
                                    KEY_CODE
                                );
                end

                SPECIAL: begin
                    l_state <=  WAIT;
                end

                RELEASE: begin
                    l_state <=  WAIT;
                end

                KEY_CODE: begin
                    l_state <=  SEND;
                end

                SEND: begin
                    l_state <=  START;
                end
            endcase
        end
    end

    logic l_release;
    logic [15:0] l_key;
    always_ff @ (posedge i_clk) begin
        if (i_rst) begin
            l_release <= 'd0;
            l_key <= 'd0;
        end
        else begin
            l_release <=    (l_state == START) ? 'b0 :
                            (l_state == RELEASE) ? 'b1 :
                            l_release;

            l_key[7:0] <=   (l_state == START) ? 'd0 :
                            (l_state == KEY_CODE) ? w_ps2_dat :
                            l_key[7:0];

            l_key[15:8] <=  (l_state == START) ? 'd0 :
                            (l_state == SPECIAL) ? w_ps2_dat :
                            l_key[15:8];
        end
    end

    assign o_press      = ~l_release;
    assign o_release    = l_release;
    assign o_key        = l_key;
    assign o_emp        = (l_state == SEND) ? 'b0 : 'b1;

endmodule