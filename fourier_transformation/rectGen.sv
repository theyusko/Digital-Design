`timescale 1ns / 1ps
module rectGen(  input logic[9:0] x, y, 
                 input int left, right, top, bottom, //"input is optional"
				 output logic inrect);
				 
    assign inrect = (x >= left & x < right & y >= top & y < bottom);
endmodule
