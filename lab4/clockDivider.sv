`timescale 1ns / 1ps
module clockDivider(input  logic clk,
                    input  logic[1:0] speed,
                    output logic newClock );
    
    int counter = 0;
    int max = 1000000;
    always@(posedge clk)
        begin
            //Speed 1
            if (speed == 2'b01)
                begin
                    if (counter == 3 *  max) 
                        begin
                            newClock <= 1'b1; //newClock is now 1, on the rising edge
                            counter  <= 0;
                        end
                    else
                        begin
                            counter  <= counter+1;
                            newClock <= 0;
                        end
                end
                
            //Speed 2
            else if (speed == 2'b10)
                begin
                    if (counter == 2 * max)
                        begin
                            newClock <= 1'b1; //newClock is now 1, on the rising edge
                            counter  <= 0;
                        end
                    else
                        begin
                            counter  <= counter+1;
                            newClock <= 0;
                        end
                end
                
            //Speed 3            
            else if (speed == 2'b11)
                begin
                    if (counter == max)
                        begin
                            newClock <= 1'b1; //newClock is now 1, on the rising edge
                            counter  <= 0;
                        end
                    
                    else
                        begin
                            counter  <= counter+1;
                            newClock <= 0;
                        end
                end   
                        
             //Speed 0, clock shall NOT be 1!           
             else if (speed == 2'b00) 
                begin      
                    newClock <= 0;
                    counter  <= 0;
                end
        end
        
endmodule
