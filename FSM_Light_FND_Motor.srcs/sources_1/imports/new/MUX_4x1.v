`timescale 1ns / 1ps

module MUX_4x1(
    input[3:0] i_a, i_b, i_c, i_d,
                // o_light_state_10 = i_c
                // o_light_state_1  = i_d
    input[1:0] i_sel,
    output[3:0] o_y
    );

    reg[3:0] r_y;
    assign o_y = r_y;

    always @(*)begin  // 모든 입력 바라봄
        case(i_sel)
            2'b00 : r_y <= i_a;  // 제일 오른쪽
            2'b01 : r_y <= i_b;
            2'b10 : r_y <= i_c;
            2'b11 : r_y <= i_d;
        endcase
    end
endmodule
