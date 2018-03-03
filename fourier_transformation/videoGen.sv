`timescale 1ns / 1ps
module videoGen( input              vgaclk,
                 input  logic [3:0] LED,
                 input  logic [9:0] x, y,
				 output logic [7:0] r, g, b);
	int HACTIVE = 640;
	int VACTIVE = 480;
    
    logic [29:0]inrect;
    logic updateclk;
    int heights [29:0] = {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0};
    
    rectGen  rect0 (x , y,   0,    21,  (480- heights[0]*25),480, inrect[0]);
    rectGen  rect1 (x , y,   21,   42,  (480- heights[1]*25),480, inrect[1]);
    rectGen  rect2 (x , y,   42,   63,  (480-heights[2]*25), 480, inrect[2]);
    rectGen  rect3 (x , y,   63,   84,  (480-heights[3]*25), 480, inrect[3]);
    rectGen  rect4 (x , y,   84,  105,  (480-heights[4]*25), 480, inrect[4]);
    rectGen  rect5 (x , y,   105, 126,  (480-heights[5]*25), 480, inrect[5]);
    rectGen  rect6 (x , y,   126, 147,  (480-heights[6]*25), 480, inrect[6]);
    rectGen  rect7 (x , y,   147, 168,  (480-heights[7]*25), 480, inrect[7]);
    rectGen  rect8 (x , y,   168, 189,  (480-heights[8]*25), 480, inrect[8]);
    rectGen  rect9 (x , y,   189, 210,  (480-heights[9]*25), 480, inrect[9]);
    rectGen  rect10(x , y,   210, 231,  (480-heights[10]*25),480, inrect[10]);
    rectGen  rect11(x , y,   231, 252,  (480-heights[11]*25),480, inrect[11]);
    rectGen  rect12(x , y,   252, 273,  (480-heights[12]*25),480, inrect[12]);
    rectGen  rect13(x , y,   273, 294,  (480-heights[13]*25),480, inrect[13]);
    rectGen  rect14(x , y,   294, 315,  (480-heights[14]*25),480, inrect[14]);
    rectGen  rect15(x , y,   315, 336,  (480-heights[15]*25),480, inrect[15]);
    rectGen  rect16(x , y,   336, 357,  (480-heights[16]*25),480, inrect[16]);
    rectGen  rect17(x , y,   357, 378,  (480-heights[17]*25),480, inrect[17]);
    rectGen  rect18(x , y,   378, 399,  (480-heights[18]*25),480, inrect[18]);
    rectGen  rect19(x , y,   399, 420,  (480-heights[19]*25),480, inrect[19]);
    rectGen  rect20(x , y,   420, 441,  (480-heights[20]*25),480, inrect[20]);
    rectGen  rect21(x , y,   441, 462,  (480-heights[21]*25),480, inrect[21]);
    rectGen  rect22(x , y,   462, 483,  (480-heights[22]*25),480, inrect[22]);
    rectGen  rect23(x , y,   483, 504,  (480-heights[23]*25),480, inrect[23]);
    rectGen  rect24(x , y,   504, 525,  (480-heights[24]*25),480, inrect[24]);
    rectGen  rect25(x , y,   525, 546,  (480-heights[25]*25),480, inrect[25]);
    rectGen  rect26(x , y,   546, 567,  (480-heights[26]*25),480, inrect[26]);
    rectGen  rect27(x , y,   567, 588,  (480-heights[27]*25),480, inrect[27]);
    rectGen  rect28(x , y,   588, 609,  (480-heights[28]*25),480, inrect[28]);
    rectGen  rect29(x , y,   609, 630,  (480-heights[29]*25),480, inrect[29]);
    
    
    assign r = |inrect? ((y > (480-75-2))? 8'h00 : ( (y >= (480-175-2))? 8'hff : 8'hcc )): 8'h00;
    assign g = |inrect? ((y > (480-75-2))? 8'h99 : ( (y >= (480-175-2))? 8'hff : 8'h00 ))  : 8'h00;
    //assign r = |inrect? ((y >= (480-175))? 8'hcc : ( (y >= (480-75))? 8'hff : 8'h00 )): 8'h00;
    //assign g = |inrect? ((y >= (480-175))? 8'h00 : ( (y >= (480-75))? 8'hff : 8'h99 ))  : 8'h00;
    //( (y > 175 )? 8'h40 : 8'h99 ) : 8'h00;
    assign b = 8'h00;

    clockDivider clockdivider(vgaclk, HACTIVE*VACTIVE*4, updateclk );
    
    always@(posedge updateclk) begin
        for (int i = 0; i < 29; ++i)
            heights[i] <= heights[i+1];
        heights[29] <= LED;
         //change it to get next voice 
    end
//    always_comb begin
//        for (int i = 0; i < 19; i++) begin
//            if (inrect[i]) 
//                r <= 8'h
//        end
//    end
    
endmodule

