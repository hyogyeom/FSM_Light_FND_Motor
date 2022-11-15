`timescale 1ns / 1ps

module FSM(
    input i_clk,
    input i_reset,
    input[4:0] i_button, // 0: off, 1~4: state_1~4
    output[2:0] o_light_state
    );

    parameter LS_STATE_0 = 3'b000,
              LS_STATE_1 = 3'b001,
              LS_STATE_2 = 3'b010,
              LS_STATE_3 = 3'b011,
              LS_STATE_4 = 3'b100;
    
    reg[2:0] cur_state, next_state;
    reg[2:0] r_light_state;

    assign o_light_state = r_light_state;

    always @(posedge i_clk or posedge i_reset) begin

        if(i_reset) cur_state <= LS_STATE_0;
        else cur_state <= next_state;

    end

    always @(cur_state or i_button) begin
        case(cur_state)

            LS_STATE_0 : begin
                if     (i_button[0]) next_state <= LS_STATE_0;
                else if(i_button[1]) next_state <= LS_STATE_1;
                else if(i_button[2]) next_state <= LS_STATE_2;
                else if(i_button[3]) next_state <= LS_STATE_3;
                else if(i_button[4]) next_state <= LS_STATE_4;
                else                 next_state <= LS_STATE_0;
            end

            LS_STATE_1 : begin
                if     (i_button[0]) next_state <= LS_STATE_0;
                else if(i_button[1]) next_state <= LS_STATE_1;
                else if(i_button[2]) next_state <= LS_STATE_2;
                else if(i_button[3]) next_state <= LS_STATE_3;
                else if(i_button[4]) next_state <= LS_STATE_4;
                else                 next_state <= LS_STATE_1;
            end

            LS_STATE_2 : begin
                if     (i_button[0]) next_state <= LS_STATE_0;
                else if(i_button[1]) next_state <= LS_STATE_1;
                else if(i_button[2]) next_state <= LS_STATE_2;
                else if(i_button[3]) next_state <= LS_STATE_3;
                else if(i_button[4]) next_state <= LS_STATE_4;
                else                 next_state <= LS_STATE_2;
            end

            LS_STATE_3 : begin
                if     (i_button[0]) next_state <= LS_STATE_0;
                else if(i_button[1]) next_state <= LS_STATE_1;
                else if(i_button[2]) next_state <= LS_STATE_2;
                else if(i_button[3]) next_state <= LS_STATE_3;
                else if(i_button[4]) next_state <= LS_STATE_4;
                else                 next_state <= LS_STATE_3;
            end

            LS_STATE_4 : begin
                if     (i_button[0]) next_state <= LS_STATE_0;
                else if(i_button[1]) next_state <= LS_STATE_1;
                else if(i_button[2]) next_state <= LS_STATE_2;
                else if(i_button[3]) next_state <= LS_STATE_3;
                else if(i_button[4]) next_state <= LS_STATE_4;
                else                 next_state <= LS_STATE_4;
            end
            
            default :                next_state <= LS_STATE_0;
        endcase
    end

    always @(cur_state) begin
        case(cur_state)
            LS_STATE_0 : r_light_state <= 3'b000; 
            LS_STATE_1 : r_light_state <= 3'b001;
            LS_STATE_2 : r_light_state <= 3'b010;
            LS_STATE_3 : r_light_state <= 3'b011;
            LS_STATE_4 : r_light_state <= 3'b100;
            default    : r_light_state <= 3'b000;
        endcase
    end

endmodule
