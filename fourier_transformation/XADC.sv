`timescale 1ns / 1ps

module XADC( input  logic       CLK100MHZ, vauxp6,
                 output logic [3:0] LEDfreq, LEDloud );
   
//---------Analog to Digital Converter---------//   
    logic enable, ready;
    logic [15:0] data;   
    logic [32:0] decimal;   
    int dig0, dig1, dig2, dig3, dig4, dig5, dig6;
    logic [6:0] add;
    assign add = 8'h1e;
      
   xadc_wiz_0  XLXI_7 (.daddr_in(add), //addresses can be found in the artix 7 XADC user guide DRP register space
                       .dclk_in(CLK100MHZ), 
                       .den_in(enable), 
                       .di_in(), 
                       .dwe_in(), 
                       .busy_out(),                    
                       .vauxp6(vauxp6),
                       .vauxn6(),
                       .vauxp7(),
                       .vauxn7(),
                       .vauxp14(),
                       .vauxn14(),
                       .vauxp15(),
                       .vauxn15(),
                       .vn_in(), 
                       .vp_in(), 
                       .alarm_out(), 
                       .do_out(data), 
                       //.reset_in(),
                       .eoc_out(enable),
                       .channel_out(),
                       .drdy_out(ready));
                     
//---------Fast Fourier Transform---------//   
    logic s_axis_config_tready, s_axis_data_tready, m_axis_data_tlast, event_frame_started, event_tlast_unexpected, event_tlast_missing;
    logic event_data_in_channel_halt, event_data_out_channel_halt, event_status_channel_halt, DATA_VALID;
    logic [31:0] data_out;
    
    xfft_0 fft(.aclk(CLK100MHZ), 
               .s_axis_config_tvalid(1), //Active high
               .s_axis_config_tready(s_axis_config_tready), //Signals that it is ready to accept data 
               .s_axis_config_tdata(8'b00000001),             
               .s_axis_data_tvalid(1), 
               .s_axis_data_tready(s_axis_data_tready), 
               .s_axis_data_tdata(data), //input data
               .s_axis_data_tlast(1), 
               .m_axis_data_tvalid(DATA_VALID),
               .m_axis_data_tready(1),
               .m_axis_data_tdata(data_out),//output data
               //m_axis_data_tuser
               .m_axis_data_tlast(m_axis_data_tlast), 
               .event_frame_started(event_frame_started), 
               .event_tlast_unexpected(event_tlast_unexpected), 
               .event_tlast_missing(event_tlast_missing), 
               //event_fft_overflow 
               .event_data_in_channel_halt(event_data_in_channel_halt), 
               .event_data_out_channel_halt(event_data_out_channel_halt), 
               .event_status_channel_halt(event_status_channel_halt)
               );    
    
//---------Calculate a Scale of Signal's Frequency---------//    
    logic [15:0] Y0, Y1, Y0_abs, Y1_abs, mag;
    
    assign Y0 = data_out[15:0];
    assign Y1 = data_out[31:16];
    assign Y0_abs = Y0[15]? -Y0: Y0;
    assign Y1_abs = Y1[15]? -Y1: Y1;
    assign mag = (Y0_abs + Y1_abs)*25;                     
                     
//---------LEDs---------//              
    always @( posedge(CLK100MHZ)) begin           
        if(ready == 1'b1) begin
            //LED <= (1 << data[15:12] + 1 ) >> 12;           
            case (mag[15:12])
                1:  LEDfreq <= 4'b1;
                2:  LEDfreq <= 4'b11;
                3:  LEDfreq <= 4'b111;
                4:  LEDfreq <= 4'b1111; 
            endcase
            case (data[15:12])
                12: LEDloud <= 4'b1;   
                13: LEDloud <= 4'b11;  
                14: LEDloud <= 4'b111; 
                15: LEDloud <= 4'b1111;
            endcase        
        end  
    end

    
//    logic [7:0] LEDrest;
//    //Or I can take the last 4 digits and use them in my vga
//    always_ff @ (posedge CLK100MHZ) begin
//        if (dig6 == 1)
//            LEDrest <= 8'b11111111;
//        else if (dig5 < 2 && dig4 < 3) 
//            LEDrest <= 8'b1;
//        else if (dig5 < 3 && dig4 < 6)
//            LEDrest <= 8'b11;
//        else if (dig5 < 4 && dig4 < 8)
//            LEDrest <= 8'b111;
//        else if (dig5 < 6 && dig4 == 0)
//            LEDrest <= 8'b1111;
//        else if (dig5 < 7 && dig4 < 3)
//            LEDrest <= 8'b11111;
//        else if (dig5 < 8 && dig4 < 6)
//            LEDrest <= 8'b111111;
//        else if (dig5 < 9 && dig4 < 8)
//            LEDrest <= 8'b1111111;
//        else LEDrest <= 8'b0;
//    end

endmodule
