module register( input  logic clk, reset,
                 input  logic [2:0] nextstate, //INPUTS: s0',s1',s2'
                 output logic [2:0] state ); //  OUTPUTS: s0,s1,s2
    always_ff @(posedge clk, posedge reset) //update on the rising edge
        if (reset) state <= 3'b0; //initial state s0 = 000
        else       state <= nextstate; //g gets the value of d (so the next state becomes current state)                 
endmodule
