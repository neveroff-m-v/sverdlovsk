`timescale 1ns / 1ps

/// Триггер Шмитта
module schmitt_trigger # (
    parameter p_FILTER = 5
    )(
    i_clk,
    i_rst,
    i_in,
    o_out,
    );
    
    input       i_clk;
    input       i_rst;
    input       i_in;
    output      o_out;
    
    enum logic [2:0] {
        START,
        LOW,
        RISE,
        HIGH,
        FALL
    } l_state = START;

    localparam lp_WIDTH = $clog2(p_FILTER);
    logic [lp_WIDTH-1:0] l_count = '0;
    
    always_ff @ (posedge i_clk) begin
        if (i_rst) begin
            l_state <= START;
        end
        else begin
            case (l_state)
                START: begin
                    l_count <=  (i_in) ? HIGH :
                                LOW;
                end
                
                LOW: begin
                    l_count <=  (i_in) ? RISE :
                                LOW;
                end
                
                RISE: begin
                    l_count <=  (l_count == p_FILTER) ? HIGH :
                                (i_in) ? RISE :
                                LOW;
                end
                
                HIGH: begin
                    l_count <=  (i_in) ? HIGH :
                                FALL;
                end
                
                FALL: begin
                    l_count <=  (l_count == p_FILTER) ? LOW :
                                (i_in) ? HIGH :
                                FALL;
                end
                
                default: begin
                    l_state <= START;
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
                LOW: l_count <= '0;
                RISE: l_count <= l_count + '1;
                HIGH: l_count <= '0;
                FALL: l_count <= l_count + '1;
                default: l_count <= l_count;
            endcase
        end
    end
    
    assign o_out =  (l_state == HIGH) ? '1 :
					(l_state == FALL) ? '1 : '0;
endmodule
