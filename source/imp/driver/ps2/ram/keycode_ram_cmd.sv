/*
    SVERDLOVSK
    system verilog library

    Neveroff M.V.
    2025
*/

module keycode_ram_cmd (
    i_key,
    o_ctrl,
    o_shft,
    o_entr,
    o_bksp
);

    input  [15:0]   i_key;
    output          o_ctrl;
    output          o_shft;
    output          o_entr;
    output          o_bksp;
    output          o_bksp;

    always_comb begin
        o_ctrl = 'b0;
        o_alt  = 'b0;
        o_func = 'b0;
        o_esc  = 'b0;
        o_mcro = 'b0; 

        o_shft = 'b0;
        o_entr = 'b0;
        o_bksp = 'b0;
        o_del  = 'b0;
        o_cslk = 'b0;
        o_tabs = 'b0;
        o_nmlk = 'b0;

        o_f1   = 'b0;
        o_f2   = 'b0;
        o_f3   = 'b0;
        o_f4   = 'b0;
        o_f5   = 'b0;
        o_f6   = 'b0;
        o_f7   = 'b0;
        o_f8   = 'b0;
        o_f9   = 'b0;
        o_f10  = 'b0;
        o_f11  = 'b0;
        o_f12  = 'b0;

        o_ptsc = 'b0;
        o_sllk = 'b0;
        o_psbk = 'b0;

        o_insr = 'b0;
        o_home = 'b0;
        o_end  = 'b0;
        o_pgup = 'b0;
        o_pgdn = 'b0;

        o_up   = 'b0;
        o_down = 'b0;
        o_left = 'b0;
        o_rght = 'b0;

        case (i_key)
            'h0014: o_ctrl = 'b1;   // CONTROL (L)
            'he014: o_ctrl = 'b1;   // CONTROL (R)
            'h0011: o_alt  = 'b1;   // ALT (L)
            'he011: o_alt  = 'b1;   // ALT (R)
            'h0012: o_shft = 'b1;   // SHIFT (L)
            'h0059: o_shft = 'b1;   // SHIFT (R)
            'h005a: o_entr = 'b1;   // ENTER
            'he05a: o_entr = 'b1;   // ENTER (NUMPAD)
            'h0066: o_bksp = 'b1;   // BACKSPACE
            'h0058: o_cslk = 'b1;   // CAPS LOCK
            'h000d: o_tab  = 'b1;   // TABS
            'h0076: o_esc  = 'b1;   // ESCAPE
            'h0005: o_f1   = 'b1;   // F1
            'h0005: o_f2   = 'b1;   // F2
            'h0005: o_f3   = 'b1;   // F3
            'h0005: o_f4   = 'b1;   // F4
            'h0005: o_f5   = 'b1;   // F5
            'h0005: o_f6   = 'b1;   // F6
            'h0005: o_f7   = 'b1;   // F7
            'h0005: o_f8   = 'b1;   // F8
            'h0005: o_f9   = 'b1;   // F9
            'h0005: o_f10  = 'b1;   // F10
            'h0005: o_f11  = 'b1;   // F11
            'h0005: o_f12  = 'b1;   // F12
        endcase
    end
endmodule