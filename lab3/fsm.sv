`timescale 1ns / 1ps
module fsm( input logic clk, reset, sa, sb,
            output logic [1:0] la, lb);
    
    logic [2:0] s = 0, snext = 0;
    
    //nextstatelogic nsl( s, sa, sb, snext );  
        always_comb
            case(s)
                3'b000 : if (sa) snext<=3'b000;
                         else snext <= 3'b001;
                3'b001 : snext<=3'b010;
                3'b010 : snext<=3'b011;
                3'b011 : snext<=3'b100;
                3'b100 : if (sb)snext<=3'b100;
                         else snext <=3'b101;
                3'b101 : snext <= 3'b110;
                3'b110 : snext <= 3'b111;
                3'b111 : snext <= 3'b000;
            endcase
    
    
    logic clk_en;
    logic [28:0]count;
        always @(posedge clk) 
        begin
            count <= count+ 1;
            if (count == 300_000000) //D: last value for counter
                count <= 28'd0; //N: lengt of counter
            if (count == 28'd0)
                clk_en <= 1'b1;
            else
                clk_en <= 1'b0;
        end
    
    
    //register r( clk, reset, snext,s );
    always_ff @(posedge clk_en, posedge reset) //update on the rising edge
           if (reset)
             s <= 3'b0; //initial state s0 = 000
           else       
             s <= snext;
    
    //outputlogic ol( s, la, lb);
    logic [7:0] minterm ;
    decoder dec(s, minterm);
        
    or(la[1], minterm[6], minterm[5], minterm[4], minterm[3], minterm[2]);
    or(la[0], minterm[1], minterm[7]);
    or(lb[1], minterm[0], minterm[1], minterm[2], minterm[6] , minterm[7]);
    or(lb[0], minterm[3], minterm[5]);
      
    //mux8 s2next(0,0,0,1,1,1,1,0, s, snext[2] );
    //mux4 s1next(0,1,1,0, s[1:0], snext[1] );
    //mux8 s0next(~sa,0,1,0,~sb,0,1,0, s, snext[0] );
    
    /*    always_comb
        begin
            y = s[2] ? (s[1] ? (s[0] ? d7 : d6)
                             : (s[0] ? d5 : d4)) 
                     : (s[1] ? (s[0] ? d3 : d2)
                             : (s[0] ? d1 : d0)); 
        end    
    */ 
    
endmodule
