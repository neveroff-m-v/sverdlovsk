/*
    SVERDLOVSK
    system verilog library

    Neveroff M.V.
    2025
*/

module ep2c20f484c7 (
    i_clk_50m,
    i_clk_27m,
    i_clk_24m,
    i_clk_ext,
    i_switch,
    i_key,
    o_led_r,
    o_led_g,
    o_hex,
    io_gpio,
    o_vga_r,
    o_vga_g,
    o_vga_b,
    o_vga_sync_h,
    o_vga_sync_v, 
    o_ps2_clk,
    io_ps2_dat,
    i_uart_rxd,
    o_uart_txd,
    io_dram_dat,
    o_dram_adr,
    o_dram_clk,
    o_dram_cke,
    o_dram_ldqm,
    o_dram_udqm,
    o_dram_we,
    o_dram_cas,
    o_dram_ras,
    o_dram_cs,
    o_dram_ba,
    io_sram_dat,
    o_sram_adr,
    o_sram_ce,
    o_sram_oe,
    o_sram_we,
    o_sram_lb,
    o_sram_ub,
    io_flash_dat,
    o_flash_adr,
    o_flash_we,
    o_flash_rst,
    o_flash_ce,
    o_flash_oe,
    o_sd_clk,
    io_sd_dat,
    o_sd_dat3,
    o_sd_cmd,
    io_wm8731_i2s_dat,
    o_wm8731_i2s_clk,
    o_wm8731_xck,
    o_wm8731_bclk,
    o_wm8731_dac_dat,
    o_wm8731_dac_clrck,
    i_wm8731_adc_dat,
    o_wm8731_adc_clrck
    );

    /// Тактовый генератор
    input           i_clk_50m;
    input           i_clk_27m;
    input           i_clk_24m;
    input           i_clk_ext;

    /// Кнопка / переключатель
    input  [9:0]    i_switch;
    input  [3:0]    i_key;

    /// Светодиод
    output [9:0]    o_led_r;
    output [7:0]    o_led_g;

    /// Семисегментный индикатор
    output [6:0]    o_hex [3:0];

    /// Вход / выход общего назначения
    inout [35:0]    io_gpio [1:0];

    /// Интерфейс VGA
    output [3:0]    o_vga_r;
    output [3:0]    o_vga_g;
    output [3:0]    o_vga_b;
    output          o_vga_sync_h;
    output          o_vga_sync_v;

    /// Интерфейс Клавиатуры PS/2 
    output          o_ps2_clk;
    inout           io_ps2_dat;

    /// Интерфейс UART / RS232
    input           i_uart_rxd;
    output          o_uart_txd;

    /// Микросхема памяти SDRAM (8 MB)
    inout  [15:0]   io_dram_dat;
    output [11:0]   o_dram_adr;
    output          o_dram_clk;
    output          o_dram_cke;
    output          o_dram_ldqm;
    output          o_dram_udqm;
    output          o_dram_we;
    output          o_dram_cas;
    output          o_dram_ras;
    output          o_dram_cs;
    output [1:0]    o_dram_ba;

    /// Микросхема памяти SRAM (512 kB)
    inout  [15:0]   io_sram_dat;
    output [17:0]   o_sram_adr;
    output          o_sram_ce;
    output          o_sram_oe;
    output          o_sram_we;
    output          o_sram_lb;
    output          o_sram_ub;

    /// Микросхема памяти FLASH (4 MB)
    inout  [7:0]    io_flash_dat;
    output [21:0]   o_flash_adr;
    output          o_flash_we;
    output          o_flash_rst;
    output          o_flash_ce;
    output          o_flash_oe;

    /// Внешняя память SD
    output          o_sd_clk;
    inout           io_sd_dat;
    output          o_sd_dat3;
    output          o_sd_cmd;

    /// Аудио-кодек WM8731
    inout           io_wm8731_i2s_dat;
    output          o_wm8731_i2s_clk;
    output          o_wm8731_xck;
    output          o_wm8731_bclk;
    output          o_wm8731_dac_dat;
    output          o_wm8731_dac_clrck;
    input           i_wm8731_adc_dat;
    output          o_wm8731_adc_clrck;

    /*
    Место для вашего экземпляра модуля высокого уровня
    */
endmodule