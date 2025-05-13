`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.05.2025 15:48:19
// Design Name: 
// Module Name: water_level_tb
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


module water_level_tb;

    //inputs    
    reg clk;
    reg reset;
    reg [3:1] s;
    
    //outputs
    reg fr1;
    reg fr2;
    reg fr3;
    reg dfr;
    
    
    //instantiation
    
    water_level uut (
        .clk(clk),
        .reset(reset),
        .s(s),
        .fr1(fr1),
        .fr2(fr2),
        .fr3(fr3),
        .dfr(dfr)
    
    ); 
    
    //clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // 10ns clock period
    end
    
    //test stimulus
    initial begin 
        reset=0;
        
        s = 3'b000;
        #20; //hold for 20 seceonds
        
        
        // Test case 1: Stay in state A (s[1]=0)
        s = 3'b000;
        #20;

        // Test case 2: Transition A -> B1 (s[1]=1)
        s = 3'b001;
        #20;

        // Test case 3: Transition B1 -> C1 (s[2]=1)
        s = 3'b011;
        #20;

        // Test case 4: Transition C1 -> D (s[3]=1)
        s = 3'b111;
        #20;

        // Test case 5: Stay in D (s[3]=1)
        s = 3'b100;
        #20;

        // Test case 6: Transition D -> C0 (s[3]=0)
        s = 3'b011;
        #20;

        // Test case 7: Transition C0 -> B0 (s[2]=0, s[3]=0)
        s = 3'b001;
        #20;

        // Test case 8: Transition B0 -> A (s[1]=0)
        s = 3'b000;
        #20;

        // Test case 9: Apply reset to return to A
//        reset = 1;
//        #20;
//        reset = 0;
//        #20;

        // Test case 10: Alternative path B1 -> A (s[1]=0)
        s = 3'b001;
        #20;
        s = 3'b000;
        #20;

        // End simulation
        $finish;
    end    
        

endmodule
