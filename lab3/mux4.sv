
module mux4( input  logic       d3,d2,d1,d0,
             input  logic [1:0] s,
             output logic       y);
     always_comb
        begin        
            if ( {s[1],s[0]} == 2'b11)
                y <= d3;
            else if ( {s[1],s[0]} == 2'b10)
                y <= d2;     
            else if ( {s[1],s[0]} == 2'b01)  
                y <= d1;    
            else  ( {s[1],s[0]} == 2'b00)
                y <= d0;
         end
   endmodule 

