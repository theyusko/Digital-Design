`timescale 1ns / 1ps
module driver(  input  logic start, CW, clk, reset,
                output logic[3:0] out ); 
    
    /*
    states are named in the diagram according to AB values, eg 1100 output giving state is S3 (AB, 11, 3)    
    */
    logic [3:0] state, nextstate;
    
    //state register
    always_ff@( posedge clk, posedge reset)
        if (reset) 
            state <= 4'b1100;
        else
            state <= nextstate;
    
    //next state logic
    always_comb
        begin
            if (CW)
                case(state)
                    4'b1100: if (~start)   nextstate <= 4'b1100;
                             else          nextstate <= 4'b0110;
                             
                        
                    4'b0110: if (~start)   nextstate <= 4'b0110;
                             else          nextstate <= 4'b0011;
                             
                        
                    4'b0011: if (~start)   nextstate <= 4'b0011;
                             else          nextstate <= 4'b1001;
                             
                        
                    4'b1001: if (~start)   nextstate <= 4'b1001;
                             else          nextstate <= 4'b1100;
                        
                    default: nextstate <= 4'b1100;
                endcase  
           else //~CW
               case(state)
                   4'b1100: if (~start)   nextstate <= 4'b1100;
                            else          nextstate <= 4'b1001;
                            
                   4'b0110: if (~start)   nextstate <= 4'b0110;
                            else          nextstate <= 4'b1100;
                            
                   4'b0011: if (~start)   nextstate <= 4'b0011;
                            else          nextstate <= 4'b0110;
                            
                   4'b1001: if (~start)   nextstate <= 4'b1001;
                            else          nextstate <= 4'b0011;   
               endcase           
        end    
    //output logic
    assign out = state;
    
endmodule

