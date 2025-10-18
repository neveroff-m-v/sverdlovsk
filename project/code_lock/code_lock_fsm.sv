`timescale 1ns / 1ps

/// Кодовый замок (fsm)
module code_lock_fsm (
    i_clk,
    i_rst,
    i_code,
    i_code_vld,
    i_close,
    o_open
    );

    input           i_clk;
    input           i_rst;

    input [3:0]     i_code;
    input           i_code_vld;
    input           i_close;
    output          o_open;

    enum logic [3:0] {
        CODE_,
        CODE_2,
        CODE_23,
        CODE_232,
        CODE_2327,
        OPEN
    } l_state = CODE_;

    always_ff @ (posedge i_clk) begin
        if (i_rst) begin
            l_state <= CODE_;
        end
        else begin
            case (l_state)
                CODE_: begin
                    l_state  <= (i_code_vld) ? (
                                    (i_code == 4'd2) ? CODE_2 :
                                    CODE_
                                ) :
                                CODE_;
                end

                CODE_2: begin
                    l_state  <= (i_code_vld) ? (
                                    (i_code == 4'd3) ? CODE_23 :
                                    CODE_
                                ) :
                                CODE_;
                end

                CODE_23: begin
                    l_state  <= (i_code_vld) ? (
                                    (i_code == 4'd2) ? CODE_232 :
                                    CODE_
                                ) :
                                CODE_;
                end

                CODE_232: begin
                    l_state  <= (i_code_vld) ? (
                                    (i_code == 4'd7) ? CODE_2327 :
                                    (i_code == 4'd3) ? CODE_23 :
                                    CODE_
                                ) :
                                CODE_;
                end

                CODE_2327: begin
                    l_state  <= OPEN;
                end

                OPEN: begin
                    l_state  <= (i_close) ? CODE_ : 
                                OPEN;
                end
            endcase
        end
    end

    assign o_open = (l_state == OPEN) ? 'b1 : 'b0;
endmodule
