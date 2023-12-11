`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.12.2023 11:18:17
// Design Name: 
// Module Name: pong_key
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


module KeyboardController (
  input clk,
  input PS2Data,
  input PS2Clk,
  output reg uppad1, // key[3] = uppad1 (W), key[2] = downpad1 (S), key[1] = uppad2 (Up), key[0] = downpad2 (Down)
  output reg downpad1,
  output reg uppad2,
  output reg downpad2
);

  wire flag;
  wire [15:0] keycode;
  reg CLK50MHZ=0;
  
  always @(posedge(clk))begin
        CLK50MHZ<=~CLK50MHZ;
    end
  
  PS2Receiver uut (
        .clk(CLK50MHZ),
        .kclk(PS2Clk),
        .kdata(PS2Data),
        .keycode(keycode),
        .oflag(flag)
  );
    
  always @(posedge clk) begin
    if(flag == 1'b1) begin
        if(keycode == 16'hF01D) // keyW
            uppad1 = 1'b0;
        else if (keycode[7:0] == 8'h1D)
            uppad1 = 1'b1;
            
        if(keycode == 16'hF01B) // keyS
            downpad1 = 1'b0;
        else if (keycode[7:0] == 8'h1B)
            downpad1 = 1'b1;
            
        if(keycode == 16'hF075) // keyUp
            uppad2 = 1'b0;
        else if (keycode[7:0] == 8'h75)
            uppad2 = 1'b1;
            
        if(keycode == 16'hF073) // keyDown
            downpad2 = 1'b0;
        else if (keycode[7:0] == 8'h73)
            downpad2 = 1'b1;
    end
  end
endmodule
