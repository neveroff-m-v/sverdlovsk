/*
    SVERDLOVSK
    system verilog library

    Neveroff M.V.
    2025
*/

/// Шахматные часы (fsm)
module chess_tick_fsm (
    i_clk,
    i_rst,
    i_restart,
    i_stop,
    i_player_a_turn,
    i_player_a_zero,
    o_player_a_stop,
    o_player_a_win,
    i_player_b_turn,
    i_player_b_zero,
    o_player_b_stop,
    o_player_b_win,
    o_restart
    );
    
    input           i_clk;
    input           i_rst;
    input           i_restart;
    input           i_stop;
    input           i_player_a_turn;
    input           i_player_a_zero;
    output          o_player_a_stop;
    output          o_player_a_win;
    input           i_player_b_turn;
    input           i_player_b_zero;
    output          o_player_b_stop;
    output          o_player_b_win;
    output          o_restart;
    
    enum logic [2:0] {
        START,
        IDLE,
        TURN_A,
        STOP_A,
        WIN_A,
        TURN_B,
        STOP_B,
        WIN_B
    } l_state = START;
    
    always_ff @ (posedge i_clk) begin
        if (i_rst) begin
            l_state <= START;
        end
        else begin
            case (l_state)
                START: begin
                    l_state  <= IDLE;
                end

                IDLE: begin
                    l_state  <= (i_player_a_turn) ? TURN_A :
                                (i_player_b_turn) ? TURN_B :
                                IDLE;
                end

                TURN_A: begin
                    l_state  <= (i_restart) ? START :
                                (i_stop) ? STOP_A :
                                (i_player_a_zero) ? WIN_B :
                                (i_player_a_turn) ? TURN_B :
                                TURN_A;
                end

                STOP_A: begin
                    l_state  <= (i_restart) ? START :
                                (i_player_a_turn) ? TURN_A :
                                STOP_A;
                end

                WIN_A: begin
                    l_state  <= (i_restart) ? START :
                                WIN_A;
                end

                TURN_B: begin
                    l_state  <= (i_restart) ? START :
                                (i_stop) ? STOP_B :
                                (i_player_b_zero) ? WIN_A :
                                (i_player_b_turn) ? TURN_A :
                                TURN_B;
                end

                STOP_B: begin
                    l_state  <= (i_restart) ? START :
                                (i_player_b_turn) ? TURN_B :
                                STOP_B;
                end

                WIN_B: begin
                    l_state  <= (i_restart) ? START :
                                WIN_B;
                end
                
                default: begin
                    l_state  <= START;
                end
            endcase
        end
    end
    
    assign o_player_a_stop = (l_state == TURN_A) ? 'b0 : 'b1;
    assign o_player_a_win  = (l_state == WIN_A) ? 'b1 : 'b0;
    assign o_player_b_stop = (l_state == TURN_B) ? 'b0 : 'b1;
    assign o_player_b_win  = (l_state == WIN_B) ? 'b1 : 'b0;
    assign o_restart       = (l_state == START) ? 'b1 : 'b0;
endmodule