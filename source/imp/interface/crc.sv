/// Интерфейс Clock\Reset
interface crc # (
    );

    logic clk;
    logic rst;

    modport mst (
        output clk;
        output rst;
    );

    modport slv (
        input  clk;
        input  rst;
    );
    
endinterface