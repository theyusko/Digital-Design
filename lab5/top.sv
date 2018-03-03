`timescale 1ns / 1ps

module top( input  logic clk, reset,a,
                      output logic out

    );
    
    clockDivider clock(clk, 1 , newclock);
    mooreSnail snail(newClk, reset,a,out);
endmodule
