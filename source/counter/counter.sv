`timescale 1ns / 1ps

/// Счетчик
module counter # (
    p_scale = 10
    )(
    i_clk,
    i_rst,
    i_val,
    i_inc,
    i_dec,
    o_val,
    o_inc,
    o_dec
    );

    localparam lp_depth = $clog2(p_scale);

    input                   i_clk;
    input                   i_rst;
    input  [lp_depth-1:0]   i_val;
    input                   i_inc;
    input                   i_dec;
    output [lp_depth-1:0]   o_val;
    output                  o_inc;
    output                  o_dec;

    enum logic [2:0] {
        START,
        IDLE,
        INCREMENT,
        INCREMENT_OVER,
        DECREMENT,
        DECREMENT_OVER
    } l_state = START;

    logic [lp_depth-1:0] l_val;

    always_ff @ (posedge i_clk) begin
        if (i_rst) begin
            l_state <= START;
        end
        else begin
            case (l_state)
                START: begin
                    l_state  <= IDLE;
                end

                IDLE: begin
                    l_state  <= (i_inc) ? (
                                    (l_val == p_scale) ? INCREMENT_OVER :
                                    INCREMENT
                                    ) :
                                (i_dec) ? (
                                    (l_val == 'b0) ? DECREMENT_OVER :
                                    DECREMENT
                                    ) :
                                IDLE;
                end

                INCREMENT: begin
                    l_state  <= IDLE;
                end

                INCREMENT_OVER: begin
                    l_state  <= IDLE;
                end

                DECREMENT: begin
                    l_state  <= IDLE;
                end

                DECREMENT_OVER: begin
                    l_state  <= IDLE;
                end

                default: begin
                    l_state  <= START;
                end
            endcase
        end
    end

    always_ff @ (posedge i_clk) begin
        if (i_rst) begin
            l_val <= 'd0;
        end
        else begin
            case (l_state)
                START:          l_val <= i_val;
                IDLE:           l_val <= l_val;
                INCREMENT:      l_val <= l_val + 'd1;
                INCREMENT_OVER: l_val <= 'd0;
                DECREMENT:      l_val <= l_val - 'd1;
                DECREMENT_OVER: l_val <= p_scale;
            endcase
        end
    end

    assign o_val = l_val;
    assign o_inc = (l_state == INCREMENT_OVER) ? 1'b1 : 1'b0;
    assign o_dec = (l_state == DECREMENT_OVER) ? 1'b1 : 1'b0;
endmodule