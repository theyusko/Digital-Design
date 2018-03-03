`timescale 1ns / 1ps

module stepMotorCar( input  logic      start, CW, clk, reset,
                     input  logic[1:0] speed,
                     input  logic      btnL,btnR,
                     output logic[3:0] out,
                     output logic[3:0] signal,
                     output            a, b, c, d, e, f, g, dp, //individual LED output for the 7-segment along with the digital point
                     output      [3:0] an,                      
                     output logic      rightLED, leftLED ); 
    
    logic newclock;
    logic [3:0] in0;
    
    clockDivider clock(clk, speed , newclock);
    //clockDivider  clock(.clk(clk),.newClock(temp));
    driver wheels(start, CW, newclock, reset, out);

    always_comb
        begin
            signal[0] = out[0];
            signal[1] = out[1];
            signal[2] = out[2];
            signal[3] = out[3];
        end
    
    SevSeg_4digit display( clk, in0, 4'd0000, 4'd0000, 4'd0000, a, b, c, d, e, f, g, dp, an);
    
    always_comb
        case(speed) 
            2'b00:  in0 = 4'd0000;
            2'b01:  in0 = 4'd0001;
            2'b10:  in0 = 4'd0002;
            2'b11:  in0 = 4'd0003;
        endcase
    
    always_comb
        begin
            leftLED = btnL;
            rightLED = btnR;
        end

endmodule
