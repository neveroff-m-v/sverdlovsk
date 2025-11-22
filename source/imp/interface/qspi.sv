/// Интерфейс QUAD SPI
interface qspi # (
    );

    logic       sck;
    logic [3:0] mosi;
    logic [3:0] miso;
    logic       cs;

    modport mst (
        output sck;
        output mosi;
        input  miso;
        output cs;
    );

    modport slv (
        input  sck;
        input  mosi;
        output miso;
        input  cs;
    );
    
endinterface