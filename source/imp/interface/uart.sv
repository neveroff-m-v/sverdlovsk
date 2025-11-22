/// Интерфейс UART
interface uart # (
    );

    logic tx;
    logic rx;

    modport mst (
        output tx;
        input  rx;
    );

    modport slv (
        input  tx;
        output rx;
    );
    
endinterface