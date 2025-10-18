`timescale 1ns / 1ps

/// Таймер
module timer # (
    p_scale = 5
    )(
    i_clk,
    i_rst,
    i_stop,
    o_time,
    o_end
    );

    localparam lp_depth = $clog2(p_scale);
    
    input                   i_clk;
    input                   i_rst;
    input                   i_stop;
    output [lp_depth-1:0]   o_time;
    output                  o_end;
    
    enum logic[2:0] {
        IDLE,
        STOP,
        END
    } l_state = IDLE;

    logic [lp_depth-1:0] l_time = 'b0;
    
    always_ff @ (posedge i_clk) begin
        if (i_rst) begin
            l_state <= IDLE;
        end
        else begin
            case (l_state)
                IDLE: begin
                    l_state <=  (i_stop) ? STOP :
                                (l_time == p_scale) ? END :
                                IDLE;
                end

                STOP: begin
                    l_state <=  (i_stop) ? STOP :
                                IDLE;
                end
                
                END: begin
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
            l_time <= 'b0;
        end
        else begin
            case (l_time)
                IDLE: l_time <= l_time + 'b1;
                STOP: l_time <= l_time;
                END: l_time <= 'b0;
                default: l_time <= l_time;
            endcase
        end
    end
    
    assign o_time = l_time;
    assign o_end = (l_state == END) ? 'b1 : 'b0;
endmodule
