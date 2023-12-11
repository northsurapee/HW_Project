`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.10.2023 02:03:49
// Design Name: 
// Module Name: uart
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module uart(
    input clk,
    input RsRx,
    output RsTx,
    output wire led_up1,
    output wire led_down1
//    output reg key_up1,
//    output reg key_down1
    );
    
    reg temp_led_up1;
    initial temp_led_up1 = 0;
    assign led_up1 = temp_led_up1;
    
    reg temp_led_down1;
    initial temp_led_down1 = 0;
    assign led_down1 = temp_led_down1;
    
//    reg temp_key_up1;
//    initial temp_key_up1 = 0;
//    assign key_up1 = temp_key_up1;
    
//    reg temp_key_down1;
//    initial temp_key_down1 = 0;
//    assign key_down1 = temp_key_down1;
    
    reg en, last_rec;
    reg [7:0] data_in;
    wire [7:0] data_out;
    wire sent, received, baud;
    reg key_up1, key_down1;
    wire btnW, btnS;
    
    baudrate_gen baudrate_gen(clk, baud);
    uart_rx receiver(baud, RsRx, received, data_out);
    uart_tx transmitter(baud, data_in, en, sent, RsTx);
    
    always @(posedge baud) begin
        if (temp_led_up1) temp_led_up1 = 0;
        if (temp_led_down1) temp_led_down1 = 0;
        if (key_up1) key_up1 = 0;
        if (key_down1) key_down1 = 0;
        if (en) en = 0;
        if (~last_rec & received) begin
            data_in = data_out;
//             + 8'h01;
            if (data_in <= 8'h7A && data_in >= 8'h3A) en = 1;
            if (data_in == 8'h57 | data_in == 8'h77) begin
                temp_led_up1 = 1;
                key_up1 = 1;
            end
            if (data_in == 8'h53 | data_in == 8'h73) begin 
                temp_led_down1 = 1;
                key_down1 = 1;
            end
        end
        last_rec = received;
    end
    
//    debounce(clk,btn_in,btn_out);
    
endmodule
