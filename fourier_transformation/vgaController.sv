`timescale 1ns / 1ps

module vgaController (  input  logic vgaclk,
                        output logic hsync, vsync,
                        output logic [9:0] x, y );
                        
 // ------------------------------
 // VGA timings using 25 MHz Clock
 // (H for horizontal pixels, V for vertical pixels)
 // ------------------------------                                             
    int HACTIVE = 640; //Visible area
    int HFP     = 18; //Front porch 
    int HSYN    = 92; //Sync pulse
    int HBP     = 50; //Back porch
    int HMAX    = HACTIVE + HFP + HSYN + HBP; //Whole area, 800p
    int VACTIVE = 480; 
    int VFP     = 11; //10?
    int VSYN    = 2; //12?
    int VBP     = 32; //33?
    int VMAX    = VACTIVE + VFP + VSYN + VBP; //Whole area, 525p                             
       
                        
    //counters for horizontal and vertical positions
    always@(posedge vgaclk) begin
        x <= x +1;
        if (x == HMAX) begin
            x <= 0; 
            y <= y + 1;
            if (y == VMAX)
                y <= 0;
        end
    end
    
    //compute sync signals (active low)
    assign hsync = ~(x >= HACTIVE+HFP & x < HACTIVE+HFP+HSYN);
    assign vsync = ~(y >= VACTIVE+VFP & y < VACTIVE+VFP+VSYN);
    
endmodule
