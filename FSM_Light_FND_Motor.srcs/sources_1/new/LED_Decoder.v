`timescale 1ns / 1ps

module LED_Decoder(
    input[2:0] i_light_state,
    output[3:0] o_light
    );


    reg[3:0] r_light;
    assign o_light = r_light;

    always @(*) begin
        case(i_light_state)
            3'b000 : r_light <= 4'b0000;
            3'b001 : r_light <= 4'b0001;
            3'b010 : r_light <= 4'b0011;
            3'b011 : r_light <= 4'b0111;
            3'b100 : r_light <= 4'b1111;
            default :r_light <= 4'b0000;
        endcase
    end
endmodule
