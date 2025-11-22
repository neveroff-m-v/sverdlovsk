`timescale 1ns / 1ps

/// Драйвер входа / выхода с высоким импедансом
/*
    SVERDLOVSK
    system verilog library

    Neveroff M.V.
    2025
*/

module drv_io_high_z (
    io_drv_port,
    i_val,
    o_val
    );
    
    inout       io_drv_port;
    
    input       i_val;
    output      o_val;

    assign io_drv_port = (i_val) ? 1'bZ : 1'b0;
    assign o_val = io_drv_port;
endmodule