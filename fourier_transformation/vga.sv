`timescale 1ns / 1ps

module vga( input  logic       CLK100MHZ, 
            input  logic [3:0] LED,
	 	    output logic       hsync, vsync,
            output logic [3:0] red, green, blue ); // color to video DAC
    
    logic [7:0] r, g, b;  // 0-255 values for RGB
    logic [9:0] x, y;
    
    clockDivider clock(CLK100MHZ, 4, vgaclk); //from 100mHz to 25 mHz
   
    vgaController vgaCont(vgaclk, hsync, vsync,x, y); 
    
    videoGen videoGen(vgaclk, LED, x, y, r, g, b); 
    
    assign red   = {r[7],r[5],r[3],r[1]};
    assign green = {g[7],g[5],g[3],g[1]};
    assign blue  = {b[7],b[5],b[3],b[1]};

endmodule

