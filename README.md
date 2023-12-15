# HW_SYN_LAB_Project
VGA Project Pong Complete Game Verilog Basys 3 FPGA Xilinx Vivado.<br>
**"Main"** branch control by Basys 3 button.<br>
**"Ping"** branch control by External Keyboard.

## Modular design
![design diagram](https://github.com/northsurapee/HW_Project/blob/main/design_diagram.jpg)


## Modules Description
| Module Name  | Description |
| ------------- | ------------- |
| Keyboard Controller (with debouncer) | This module is a PS/2 receiver that uses two instances of the debouncer module (db_clk and db_data) to debounce the clock and data signals from a PS/2 keyboard. |
| VGA Controller | This module generates x, y coordinates representing the current pixel position on a 640x480 VGA display. These signals are used to determine the timing for generating hsync and vsync for VGA output. |
| Graphics Output | This module is responsible for doing game logic and displaying graphical elements on the VGA monitor including “walls”, “paddles” and “ball”. It uses keystrokes with some logic to update the position of objects. |
| Text Output | This module is responsible for displaying text on the VGA monitor including “score” and “rule”. It uses an ASCII ROM to convert characters into pixel patterns. |
| Score Counter | This module counts scores of a player from 00-99. |
| Timer | This module implements a timer that counts down from a specified value to delay out between states. |
| State Machine (Main) | This module is the main state machine controlling the game. It transitions between different states (newgame, play, newball). It initiates all modules and outputs signals for VGA including hsync, vsync from “VGA Controller" and rgb from “Graphics Output” and “Text Output”. |

### Reference
- [FPGA Discovery (Learning How to Work with FPGAs)](https://www.youtube.com/watch?v=tELTeQb-Dc4&t=118s)
- [Basys-3-Keyboard](https://github.com/Digilent/Basys-3-Keyboard/blob/master/src/hdl/PS2Receiver.v)
