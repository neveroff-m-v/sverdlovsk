`timescale 1ns / 1ps

/// Драйвер выхода с широтно импульсной модуляцией (шим)
/*
    SVERDLOVSK
    system verilog library

    Neveroff M.V.
    2025
*/

module drv_pwm # (
    p_depth = 10
    )(
    o_drv_port,
    i_clk,
    i_rst,
    i_val
    );

    output                  o_drv_port;

    input                   i_clk;
    input                   i_rst;
    input  [p_depth-1:0]    i_val;

    enum logic {
        LOW,
        HIGH
    } l_state = LOW;

    logic [p_depth-1:0] l_count;

    always_ff @ (posedge i_clk) begin
        if (i_rst) begin
            l_state <= LOW;
        end
        else begin
            case (l_state)
                LOW: begin
                    if(l_count == i_val) l_state <= HIGH;
                    else l_state <= LOW;
                end

                HIGH: begin
                    if(l_count == 'd0) l_state <= LOW;
                    else l_state <= HIGH;
                end

                default: l_state <= LOW;
            endcase
        end
    end
    
    always_ff @ (posedge i_clk) begin
        if (i_rst) begin
            l_count <= 'd0;
        end
        else begin
            l_count <= l_count + 'd1;
        end
    end

    assign o_drv_port = (l_state == HIGH) ? 'b1 : 'b0;
endmodule