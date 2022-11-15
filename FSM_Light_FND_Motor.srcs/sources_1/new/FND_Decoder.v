`timescale 1ns / 1ps

module FND_Decoder(
    input[1:0] i_select,
    // input i_on_off_SW,
    output[3:0] o_digitPosition
    );

    reg[3:0] r_digitPosition;
    assign o_digitPosition = r_digitPosition;

    always @(i_select)begin
        // if(i_on_off_SW) begin
        //     r_digitPosition <= 4'b1111;
        // end
        // else begin
            case(i_select)
                2'b00 : r_digitPosition <= 4'b1110;  // 숫자선택
                2'b01 : r_digitPosition <= 4'b1101;
                2'b10 : r_digitPosition <= 4'b1011;
                2'b11 : r_digitPosition <= 4'b0111;

                // 3'b100 : r_digitPosition <= 4'b1110;  // 점 선택 
                // 3'b101 : r_digitPosition <= 4'b1101;
                // 3'b110 : r_digitPosition <= 4'b1011;
                // 3'b111 : r_digitPosition <= 4'b0111;
            endcase
        end
    // end
endmodule