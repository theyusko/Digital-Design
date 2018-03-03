module clockDivider(input  logic clk,
                    int max,
                    output logic newClock );
    
    int counter = 0;
    //int max = 4;
    
    always@(posedge clk) begin
        if (counter == max) begin
            newClock <= 1'b1; //newClock is now 1, on the rising edge
            counter  <= 0;
        end
        else begin
            counter  <= counter+1;
            newClock <= 0;
        end
    end
       
endmodule