`timescale 1ns / 1ps

/// Счетчик десятичный
module counter_dec (
    i_clk,
    i_rst,
    i_count,
    i_plus,
    i_minus,
    o_count,
    o_plus,
    o_minus,
    o_zero
    );
    
    input           i_clk;
    input           i_rst;
    input [3:0]     i_count;
    input           i_plus;
    input           i_minus;
    output [3:0]    o_count;
    output          o_plus;
    output          o_minus;
    output          o_zero;
    
    enum logic [2:0] {
        START,
        IDLE,
        PLUS,
        MINUS,
        PLUS_OVERFLOW,
        MINUS_OVERFLOW
    } l_state = START;

    logic [3:0] l_count = 4'd0;
    
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
                    l_state  <= (i_plus) ? PLUS :
                                (i_minus) ? MINUS :
                                IDLE;
                end
                
                PLUS: begin
                    l_state  <= (l_count == 4'd9) ? PLUS_OVERFLOW :
                                IDLE;
                end
                
                MINUS: begin
                    l_state  <= (l_count == 4'd0) ? MINUS_OVERFLOW :
                                IDLE;
                end
                
                PLUS_OVERFLOW: begin
                    l_state  <= IDLE;
                end
                
                MINUS_OVERFLOW: begin
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
            l_count <= '0;
        end
        else begin
            case (l_state)
                START: l_count <= i_count;
                IDLE: l_count <= l_count;
                PLUS: l_count <= l_count + 4'd1;
                MINUS: l_count <= l_count - 4'd1;
                PLUS_OVERFLOW: l_count <= 4'd0;
                MINUS_OVERFLOW: l_count <= 4'd9;
                default: l_count <= l_count;
            endcase
        end
    end
    
    assign o_count = l_count;
    assign o_plus  = (l_state == PLUS_OVERFLOW) ? '1 : '0;
    assign o_minus = (l_state == MINUS_OVERFLOW) ? '1 : '0;
    assign o_zero  = (l_count == 4'd0) ? '1 : '0;
endmodule
