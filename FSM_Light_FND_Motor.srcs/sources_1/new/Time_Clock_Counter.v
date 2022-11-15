`timescale 1ns / 1ps

module Time_Clock_Counter(
    input i_clk,
    input i_reset,
    input[2:0] i_timer_SW ,
    output[6:0] o_sec, 
    output[6:0] o_msec
    );

    reg[6:0] r_sec  = 0;
    reg[9:0] r_msec = 0;
    
    assign o_sec  = r_sec;
    assign o_msec = r_msec / 10;

    always @(posedge i_clk or posedge i_reset) begin
        if(i_reset) begin
           r_msec <= 0;
            r_sec <= 0;
            
        end

        else begin
            if(i_timer_SW[0]) begin
                r_msec <= 0000;
                r_sec <= 10;
               
            end

            else if(i_timer_SW[1]) begin
                
                r_msec <= 0000;
                r_sec <= 20;
            end

            else if(i_timer_SW[2]) begin
               r_msec <= 0000;
               r_sec <= 30;
                
            end

            else begin
                r_msec <= r_msec - 1;
                if(r_msec == 0) begin
                    r_sec <= r_sec - 1;
                    if(r_sec == 0)begin 
                     r_sec <= 0;
                     r_msec <=0;
                    end
                end
            end
        end 
    end
endmodule
