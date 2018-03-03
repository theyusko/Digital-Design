`timescale 1ns / 1ps
module top( input logic clk, reset, sa, sb, 
            output logic [2:0] lighta, lightb  );
            
    parameter GREEN = 2'b00;
    parameter YELLOW = 2'b01;
    parameter RED = 2'b10;
    
    logic [1:0] la, lb;    
    fsm  clockfsm( clk, reset, sa, sb, la, lb);
    
    
    //LIGHTS!!!
    always_comb
        begin
            case(la)
                GREEN : lighta = 3'b010;
                YELLOW : lighta = 3'b011;
                RED : lighta = 3'b111; 
                default : lighta = 3'b0;
            endcase;
            
            case(lb)
                GREEN : lightb = 3'b010;
                YELLOW : lightb = 3'b011;
                RED : lightb = 3'b111;
                default : lightb = 3'b0;
            endcase;                    
        end  
    
endmodule
