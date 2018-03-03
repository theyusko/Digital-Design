`timescale 1ns / 1ps

module mealySnail(input  logic clk, reset, a2,
                  output logic out2);
    
    typedef enum logic [2:0] {S0, S1, S2, S3, S4, S5} statetype;
    
    statetype [2:0] state, nextstate;
    
    //State Register
    always_ff @(posedge clk, posedge reset)
        if (reset) state <= S0;
        else       state <= nextstate;
     
    //Next State Logic    
    always_comb
        case (state)
            S0: if (~a) nextstate = S1;
                else nextstate = S0;
            S1: if (~a) nextstate = S3;
                else nextstate = S2;
            S2: if (~a) nextstate = S1;
                else nextstate = S0;
            S3: if (~a) nextstate = S3;
                else nextstate = S4;
            S4: if (~a) nextstate = S1;
                else nextstate = S0;
            //S5: if (~a) nextstate = S1;
                //else nextstate = S0; // S5 is not redundant, check the FSM diagram
        endcase
    assign out = ((state == S4) & (~a)) | ((state == S0) & a);    
    
endmodule
