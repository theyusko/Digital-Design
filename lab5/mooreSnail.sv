`timescale 1ns / 1ps

module mooreSnail(input  logic clk, reset,a,
                  output logic out
                  //output logic [2:0] s
                  );
                  
    typedef enum logic [2:0] {S0, S1, S2, S3, S4, S5, S6, S7} statetype;
                                  
    statetype [2:0] state, nextstate;
                          
    //State Register
    always_ff @(posedge clk, posedge reset)
        if (reset) state <= S0;
        else       state <= nextstate;
                           
    //Next State Logic    
    always_comb
    begin
        case (state)
        S0: if (~a) nextstate = S1;
            else nextstate = S0;
        S1: if (~a) nextstate = S5;
            else nextstate = S2;
        S2: if (~a) nextstate = S1;
            else nextstate = S3;
        S3: if (~a) nextstate = S1;
            else nextstate = S0; 
        S5: if (~a) nextstate = S5;
            else nextstate = S6;
        S6: if (~a) nextstate = S1;
            else nextstate = S3;
        //S7: if (~a) nextstate = S5; // not sure if this one is redundant
            //else nextstate = S2;                                
        endcase
        //s = state;
    end                          
    assign out = (state == S0) | (state == S1);
                          
endmodule