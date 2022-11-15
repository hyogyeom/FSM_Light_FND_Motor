`timescale 1ns / 1ps

module TOP(
    input i_clk,
    input i_reset,
    input[4:0] i_button,
    input[2:0] i_timer_SW ,
    output[3:0] o_light,
    output o_motor,
    output[3:0] o_digit,
    output [7:0] o_fndfont
    );

    wire[6:0] w_divider_to_counter;  // wire 1
    Clock_Divider Clock_Divider(
    .i_clk(i_clk),
    .i_reset(i_reset),
    .o_clk(w_divider_to_counter)
    );

    wire[9:0] w_counter_to_comparator;  // wire 2
    Counter Counter(
    .i_clk(w_divider_to_counter),  // wire 1
    .i_reset(i_reset),
    .o_counter(w_counter_to_comparator)  // wire 2
    );


    wire [3:0] w_o_power;  // wire 3
    Comparator Comparator(
    .i_counter(w_counter_to_comparator),  // wire 2
    .o_power_1(w_o_power[0]),
    .o_power_2(w_o_power[1]),
    .o_power_3(w_o_power[2]),
    .o_power_4(w_o_power[3])
    );

    wire[4:0] w_o_button;  // wire 4
    Button_Controller btn_0(
    .i_clk(i_clk),
    .i_reset(i_reset),
    .i_button(i_button[0]),
    .o_button(w_o_button[0])  // wire 4
    );

    Button_Controller btn_1(
    .i_clk(i_clk),
    .i_reset(i_reset),
    .i_button(i_button[1]),
    .o_button(w_o_button[1])  // wire 4
    );

    Button_Controller btn_2(
    .i_clk(i_clk),
    .i_reset(i_reset),
    .i_button(i_button[2]),
    .o_button(w_o_button[2])  // wire 4
    );

    Button_Controller btn_3(
    .i_clk(i_clk),
    .i_reset(i_reset),
    .i_button(i_button[3]),
    .o_button(w_o_button[3])  // wire 4
    );

    Button_Controller btn_4(
    .i_clk(i_clk),
    .i_reset(i_reset),
    .i_button(i_button[4]),
    .o_button(w_o_button[4])  // wire 4
    );

    wire[2:0] w_o_light_state;  // wire 5
    FSM FSM(
    .i_clk(i_clk),
    .i_reset(i_reset),
    .i_button(w_o_button),  // wire 4
    .o_light_state(w_o_light_state)  // wire 5
    );

    MUX MUX(
    .i_x(w_o_power),  // wire 3, 5bit 짜리?��.
    .i_sec_10(w_digit_divider_to_MUX_sec_10),  // wire 5
    .i_sec_1(w_digit_divider_to_MUX_sec_1),
    .sel(w_o_light_state),
    .o_y(o_motor)
    );

    


    LED_Decoder LED_Decoder(
    .i_light_state(w_o_light_state),
    .o_light(o_light)
    );


////////////////////////////////////
    wire w_FND_CLock_Divider_to_Counter;
    FND_ClockDivider FND_ClockDivider(
    .i_clk(i_clk),
    .i_reset(i_reset), 
    .o_clk(w_FND_CLock_Divider_to_Counter)
    );

    wire[1:0] w_FND_counter_to_FND_Decoder;
    counter_FND counter_FND(
    .i_clk(w_FND_CLock_Divider_to_Counter),
    .i_reset(i_reset),
    .o_counter(w_FND_counter_to_FND_Decoder)
    );

    FND_Decoder FND_Decoder(
    .i_select(w_FND_counter_to_FND_Decoder),
    .o_digitPosition(o_digit)
    );

    wire[6:0] w_time_clock_counter_to_digit_diver_sec, w_time_clock_counter_to_digit_diver_msec;         
    Time_Clock_Counter Time_Clock_Counter(
    .i_clk(w_FND_CLock_Divider_to_Counter),
    .i_reset(i_reset),
    .i_timer_SW(i_timer_SW),
    .o_sec(w_time_clock_counter_to_digit_diver_sec),
    .o_msec(w_time_clock_counter_to_digit_diver_msec)
    );


    wire[3:0] w_digit_divider_to_MUX_sec_10,
              w_digit_divider_to_MUX_sec_1,
              w_light_state_10,
              w_light_state_1;
    Digit_Divider_Sec Digit_Divider_Sec(
    .i_sec(w_time_clock_counter_to_digit_diver_sec),
    .i_light_state(w_o_light_state),
    .o_sec_10(w_digit_divider_to_MUX_sec_10),
    .o_sec_1(w_digit_divider_to_MUX_sec_1),
    .o_light_state_10(w_light_state_10),
    .o_light_state_1(w_light_state_1)
    );

    wire[3:0] w_MUX_to_BCD_FND_Decoder;
    MUX_4x1 MUX_4x1(
    .i_a(w_light_state_1),
    .i_b(w_light_state_10),
    .i_c(w_digit_divider_to_MUX_sec_1),
    .i_d(w_digit_divider_to_MUX_sec_10),
    .i_sel(w_FND_counter_to_FND_Decoder),
    .o_y(w_MUX_to_BCD_FND_Decoder)
    );

    BCD_to_FND_Decoder BCD_to_FND_Decoder(
    .i_value(w_MUX_to_BCD_FND_Decoder),
    .o_font(o_fndfont)
    );


endmodule