/// Интерфейс SPI
interface spi # (
    );

    logic sck;
    logic mosi;
    logic miso;
    logic cs;

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