`timescale 1ns / 1ps
module tb_mux8();
    logic [2:0]s;
    logic i0,i1,i2,i4,i5,i6,i7,i3, out;
    mux8 dut(i7,i6,i5,i4,i3,i2,i1,i0, s, out); 
    
    initial begin
        s[2] = 0; s[1] = 1; s[0] = 0; //out should be 1
        i7 = 0; i6 = 0; i5 = 0; i4 = 0; i3 = 0; i2 = 1; i1 = 0; i0 = 0;
        #10;
        s[2] = 1; s[1] = 1; s[0] = 0;
        i7 = 0; i6 = 1; i5 = 0; i4 = 0; i3 = 0; i2 = 0; i1 = 0; i0 = 0;
        #10;
        s[2] = 0; s[1]= 1; s[0] = 0;
        i7 = 0; i6 = 0; i5 = 0; i4 = 1; i3 = 0; i2 = 0; i1 = 0; i0 = 0;
        #10;
        s[2] = 0; s[1] = 1; s[0] = 0;
        i7 = 0; i6 = 0; i5 = 0; i4 = 0; i3 = 0; i2 = 0; i1 = 0; i0 = 0;
        #10;
     end
endmodule