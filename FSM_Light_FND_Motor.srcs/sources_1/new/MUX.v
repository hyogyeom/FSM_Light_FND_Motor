`timescale 1ns / 1ps

module MUX(
    input[3:0] i_x,  // 모터 동작 power
    input[3:0] i_sec_10, i_sec_1,
    input[2:0] sel,  // 몇 단계?
    output o_y
    );

    reg r_y;
    assign o_y = r_y;

    always @(*) begin
        if((i_sec_10 == 0) && (i_sec_1 == 0)) begin
            r_y <= 1'b0;
        end

        case(sel)
            3'd0 : r_y <= 1'b0;
            3'd1 : r_y <= i_x[0];
            3'd2 : r_y <= i_x[1];
            3'd3 : r_y <= i_x[2];
            3'd4 : r_y <= i_x[3];
            default : r_y <= 1'b0;
        endcase

    end
endmodule
