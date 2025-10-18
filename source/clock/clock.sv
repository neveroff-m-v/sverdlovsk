`timescale 1ns / 1ps

/// Делитель тактовой частоты
module clock # (
    p_divider = 50000000
    )(
    i_clk,
    i_rst,
    i_stop,
    o_out
    );

    localparam lp_depth = $clog2(p_divider);
    localparam lp_divider = p_divider - 2;
    
    input       i_clk;
    input       i_rst;
    input       i_stop;
    output      o_out;
    
    enum logic[2:0] {
        IDLE,
        STOP,
        OVERFLOW
    } l_state = IDLE;

    logic [lp_depth-1:0] l_count = 'd0;
    
    always_ff @ (posedge i_clk) begin
        if (i_rst) begin
            l_state <= IDLE;
        end
        else begin
            case (l_state)
                IDLE: begin
                    l_state <=  (i_stop) ? STOP :
                                (l_count == lp_divider) ? OVERFLOW :
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
            l_count <= 'd0;
        end
        else begin
            case (l_state)
                IDLE: l_count <= l_count + 'd1;
                STOP: l_count <= l_count;
                OVERFLOW: l_count <= 'd0;
                default: l_count <= l_count;
            endcase
        end
    end
    
    assign o_out = (l_state == OVERFLOW) ? 'b1 : 'b0;
endmodule
