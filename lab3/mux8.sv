module mux8( input  logic       d7,d6,d5,d4,d3,d2,d1,d0,
             input  logic[2:0]  s, //s2, s1,s0
             output logic       y); //I only get a 1 or 0 as my output
     always_comb
                begin        
                    if ( s == 3'b111)
                        y <= d7;
                    else if ( s == 3'b110)
                        y <= d6;     
                    else if ( s == 3'b101)  
                        y <= d5;    
                    else if ( s == 3'b100)
                        y <= d4;
                    else if ( s == 3'b011)
                        y <= d3;     
                    else if ( s == 3'b010)
                        y <= d2;     
                    else if ( s == 3'b001)
                        y <= d1;     
                    else if ( s == 3'b000)
                        y <= d0;     
                 end
endmodule