`timescale 1ns / 1ps

/// Декодер (10 в 4)
module encode_10_4 (
    i_val,
    o_val,
    o_unknown
    );

    input [9:0]     i_val;
    output [3:0]    o_val;
    output          o_unknown;   

    always_comb begin
        o_val = 4'hF;
        o_unknown = 1'b0;

        case (i_val)
            10'b0000000001: o_val = 4'd0;
            10'b0000000010: o_val = 4'd1;
            10'b0000000100: o_val = 4'd2;
            10'b0000001000: o_val = 4'd3;
            10'b0000010000: o_val = 4'd4;
            10'b0000100000: o_val = 4'd5;
            10'b0001000000: o_val = 4'd6;
            10'b0010000000: o_val = 4'd7;
            10'b0100000000: o_val = 4'd8;
            10'b1000000000: o_val = 4'd9;
            default: o_unknown = 1'b1;
        endcase
    end
endmodule