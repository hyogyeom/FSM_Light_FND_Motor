`timescale 1ns / 1ps

module Comparator(  // 파워
    input[9:0] i_counter,
    output o_power_1, o_power_2, o_power_3, o_power_4
    );

    assign o_power_1 = (i_counter < 300) ? 1'b1 : 1'b0;
    assign o_power_2 = (i_counter < 600) ? 1'b1 : 1'b0;
    assign o_power_3 = (i_counter < 800) ? 1'b1 : 1'b0;
    assign o_power_4 = (i_counter < 990) ? 1'b1 : 1'b0;

endmodule
