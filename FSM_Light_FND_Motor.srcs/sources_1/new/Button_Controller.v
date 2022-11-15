`timescale 1ns / 1ps

module Button_Controller(
    input i_clk,
    input i_reset,
    input i_button,
    output o_button
    );

    parameter PUSHED   = 1'b1,  // ?ˆŒë¦¬ë©´ 1
              RELEASED = 1'b0,  // ?–¼ë©? 0
              TRUE     = 1'b1,
              FALSE    = 1'b0;
    parameter DEBOUNCE = 500_000; // 10ms

    reg r_prev_State = RELEASED;
    reg r_button;
    reg[31:0] r_counter = 0;

    assign o_button = r_button;

    always @(posedge i_clk or posedge i_reset) begin
        if(i_reset) begin
            r_button <= FALSE;
            r_prev_State <= RELEASED;
            r_counter <= 0;
        end
        else begin
            if((i_button == PUSHED) && (r_prev_State == RELEASED) && (r_counter < DEBOUNCE)) begin 
                r_counter <= r_counter + 1;
                r_button <= FALSE;
            end
            else if((i_button == PUSHED) && (r_prev_State == RELEASED)  && (r_counter == DEBOUNCE)) begin
                r_counter <= 0;
                r_prev_State <= PUSHED;
                r_button <= FALSE;
            end
            else if((i_button == RELEASED) && (r_prev_State == PUSHED) && (r_counter < DEBOUNCE)) begin  
                r_counter <= r_counter + 1;
                r_button <= FALSE;
            end
            else if((i_button == RELEASED) && (r_prev_State == PUSHED)  && (r_counter == DEBOUNCE)) begin
                r_counter <= 0;
                r_prev_State <= RELEASED;
                r_button <= TRUE;
            end
            
            else begin
                r_counter <= 0;
                r_button <= FALSE;
            end
        end
    end

endmodule
