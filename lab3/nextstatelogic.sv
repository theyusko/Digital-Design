`timescale 1ns / 1ps
module nextstatelogic( input  logic [2:0] s,
                       input  logic sa, sb,
                       output logic [2:0] snext );
                           
    mux8 s2next(0,0,0,1,1,1,1,0, s, snext[2] );
    mux4 s1next(0,1,1,0, s[1:0], snext[1] );
    mux8 s0next(~sa,0,1,0,~sb,0,1,0, s, snext[0] ); 
  
endmodule
