module signal (
    i_clk,
    i_rst,
    o_out,
    i_posedge,
    i_negedge,
    i_edge
    );

    input       i_clk;
    input       i_rst;
    output      o_out;
    input       i_posedge;
    input       i_negedge;
    input       i_edge;

    logic l_out = 1'b0;
    always_ff @ (posedge i_clk) begin
        if (i_rst) begin
            l_out <= 1'b0;
        end
        else begin
            l_out <=    (i_posedge) ? 1'b1 :
                        (i_negedge) ? 1'b0 :
                        (i_edge) ? ~ l_out :
                        l_out;
        end
    end

    assign o_out = l_out;
endmodule