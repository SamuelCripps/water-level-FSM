`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12.05.2025 21:44:38
// Design Name: 
// Module Name: water_level
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module water_level(
    input clk,
    input reset,
    input [3:1] s,
    output reg fr1,
    output reg fr2,
    output reg fr3,
    output reg dfr
    );
    
parameter [2:0]  A=3'd0,//water level is below s1
    			 B0=3'd1,//water level has fallen to a level between s1 and s2
    			 B1=3'd2,//water level has risen to a level between s1 and s2
    			 C0=3'd3,//water level has fallen to a level between s2 and s3 
    			 C1=3'd4,//water level has risen to a level between s2 and s3
    			 D=3'd5; //water level is above s3
          
          
      reg[2:0] state, next_state;
      always@(*) begin
        case(state)
            A : next_state = s[1]?B1:A;
            B0 : next_state = (s[2])?C1:(s[1]?B0:A);
            B1 : next_state = (s[2])?C1:(s[1]?B1:A);
            C0 : next_state = (s[3])?D:(s[2]?C0:B0);
            C1 : next_state = (s[3])?D:(s[2]?C1:B0);
            D : next_state = (s[3])?D:C0;
            
            default: next_state=3'bxxx;
            
        endcase    
        
      end
      
      
          always@(posedge clk)
              begin
                  if(reset)
                    state <= A;
                  else
                    state <= next_state;
              end
          
      always@(*)begin
        case(state)
            A: {fr3, fr2, fr1, dfr} = 4'b1111;
            B1:{fr3, fr2, fr1, dfr} = 4'b0110;
            B0:{fr3, fr2, fr1, dfr} = 4'b0111;
            C1:{fr3, fr2, fr1, dfr} = 4'b0010;
            C0:{fr3, fr2, fr1, dfr} = 4'b0011;
            D: {fr3, fr2, fr1, dfr} = 4'b0000;
            default : {fr3, fr2, fr1, dfr} = 4'bxxxx;
            
      endcase 
      
      end            
        
            
            
                   
      
      
                
    
endmodule
