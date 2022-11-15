`timescale 1ns / 1ps

module counter_FND(
    input i_clk,
    input i_reset,
    output[1:0] o_counter
    );

    reg[1:0] r_counter = 0;
    reg r_clk = 0;
    assign o_counter = r_counter;

    always @(posedge i_clk or posedge i_reset)begin
        if(i_reset)begin
            r_counter <= 0;
            r_clk <= 0;
        end
        else begin
            r_counter <= r_counter + 1;
        end
    end
endmodule
