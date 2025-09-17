`timescale 1ns / 1ps

/// Делитель тактовой частоты
module clock # (
    parameter p_DIVIDER = 50000000
    )(
    i_clk,
    i_rst,
    i_stop,
    o_out
    );
    
    input       i_clk;
    input       i_rst;
    input       i_stop;
    output      o_out;
    
    enum logic[2:0] {
        IDLE,
        STOP,
        OVERFLOW
    } l_state;

    localparam lp_WIDTH = $clog2(p_DIVIDER) + 1;
    logic [lp_WIDTH-1:0] l_count = '0;
    
    always_ff @ (posedge i_clk) begin
        if (i_rst) begin
            l_state <= IDLE;
        end
        else begin
            case (l_state)
                IDLE: begin
                    l_state <=  (i_stop) ? STOP :
                                (l_count == p_DIVIDER) ? OVERFLOW :
                                IDLE;
                end

                STOP: begin
                    l_state <=  (i_stop) ? STOP :
                                IDLE;
                end
                
                OVERFLOW: begin
                    l_state <=  IDLE;
                end
                
                default: begin
                    l_state <=  IDLE;
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
                IDLE: l_count <= l_count + '1;
                STOP: l_count <= l_count;
                OVERFLOW: l_count <= '0;
                default: l_count <= l_count;
            endcase
        end
    end
    
    assign o_out = (l_state == OVERFLOW) ? '1 : '0;
endmodule
