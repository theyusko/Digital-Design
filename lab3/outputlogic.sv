module outputlogic( input logic  [2:0] s,
                    output logic [1:0] la, lb);
    
    logic [7:0] minterma, mintermb;
    decoder deca(s, minterma);
    decoder decb(s, mintermb); //gets the minterms of s2s1s0
    /*
    GREEN = 00
    YELLOW = 01
    RED = 10
    */
    
          assign  la[1] = minterm[6] | minterm[5] | minterm[4] | minterm[3] | minterm[2];
          assign  la[0] = minterm[1] | minterm[7];
          assign  lb[0] = minterm[3] | minterm[5];
          assign  lb[1] = minterm[0] | minterm[1] | minterm[2] | minterm[6] | minterm[7];    
    /*      
    always_comb
        case(minterma)
            8'b00000001 : la = 2'b00;
            8'b00000010 : la = 2'b01;
            8'b00000100 : la = 2'b10;
            8'b00001000 : la = 2'b10;
            8'b00010000 : la = 2'b10;
            8'b00100000 : la = 2'b10;
            8'b01000000 : la = 2'b10;
            8'b10000000 : la = 2'b01;            
        endcase
        
    always_comb
        case(mintermb)
            8'b00000001 : lb = 2'b10;
            8'b00000010 : lb = 2'b10;
            8'b00000100 : lb = 2'b10;
            8'b00001000 : lb = 2'b01;
            8'b00010000 : lb = 2'b00;
            8'b00100000 : lb = 2'b01;
            8'b01000000 : lb = 2'b10;
            8'b10000000 : lb = 2'b10;            
        endcase    
    */      
endmodule