`timescale 1ns / 1ps

module top( input  logic       CLK100MHZ, vauxp6, //vauxn6, vauxp7, vauxn7, vauxp15, vauxn15, vauxp14, vauxn14,
            output logic [3:0] red, green, blue, LEDfreq, LEDloud, 
            output logic hsync, vsync);
            
    XADCdemo xadc( CLK100MHZ, vauxp6, LEDfreq, LEDloud );    
    vga vga1( CLK100MHZ, LEDfreq, hsync, vsync, red, green, blue);