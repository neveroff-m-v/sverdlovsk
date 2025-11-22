`timescale 1ns / 1ps

/// Триггер Шмитта
/*
    SVERDLOVSK
    system verilog library

    Neveroff M.V.
    2025
*/

module schmitt_trigger # (
    p_scale = 5
    )(
    i_clk,
    i_rst,
    i_in,
    o_out
    );

    localparam lp_depth = $clog2(p_scale);

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

    logic [lp_depth-1:0] l_count = 'b0;
    
    always_ff @ (posedge i_clk) begin
        if (i_rst) begin
            l_state <= START;
        end
        else begin
            case (l_state)
                START: begin
                    l_state  <= (i_in) ? HIGH :
                                LOW;
                end
                
                LOW: begin
                    l_state  <= (i_in) ? RISE :
                                LOW;
                end
                
                RISE: begin
                    l_state  <= (l_count == p_scale) ? HIGH :
                                (i_in) ? RISE :
                                LOW;
                end
                
                HIGH: begin
                    l_state  <= (i_in) ? HIGH :
                                FALL;
                end
                
                FALL: begin
                    l_state  <= (l_count == p_scale) ? LOW :
                                (i_in) ? HIGH :
                                FALL;
                end
                
                default: begin
                    l_state  <= START;
                end
            endcase
        end
    end

    always_ff @ (posedge i_clk) begin
        if (i_rst) begin
            l_count <= 'b0;
        end
        else begin
            case (l_state)
                LOW: l_count <= 'b0;
                RISE: l_count <= l_count + 'b1;
                HIGH: l_count <= 'b0;
                FALL: l_count <= l_count + 'b1;
                default: l_count <= l_count;
            endcase
        end
    end
    
    assign o_out =
        (l_state == HIGH) ? 'b1 :
		(l_state == FALL) ? 'b1 : 'b0;
endmodule
