`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.09.2024 11:18:56
// Design Name: 
// Module Name: tb_carry_bypass_adder
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


module tb_carry_bypass_adder;

    parameter WIDTH = 16;

    logic [WIDTH-1:0] A, B;
    logic [WIDTH-1:0] SUM;
    logic             COUT;

    // Instantiate the DUT (Device Under Test)
    carry_bypass_adder #(WIDTH) dut (
        .A(A),
        .B(B),
        .SUM(SUM),
        .COUT(COUT)
    );

    initial begin
        // Test Case 1
        A = 16'h1234;
        B = 16'h5678;
        #10;
        $display("A = %h, B = %h, SUM = %h, COUT = %b", A, B, SUM, COUT);

        // Test Case 2
        A = 16'hAAAA;
        B = 16'h5555;
        #10;
        $display("A = %h, B = %h, SUM = %h, COUT = %b", A, B, SUM, COUT);

        // Test Case 3
        A = 16'hFFFF;
        B = 16'h0001;
        #10;
        $display("A = %h, B = %h, SUM = %h, COUT = %b", A, B, SUM, COUT);

        // Test Case 4
        A = 16'h7FFF;
        B = 16'h8001;
        #10;
        $display("A = %h, B = %h, SUM = %h, COUT = %b", A, B, SUM, COUT);

        // Test Case 5
        A = 16'h0F0F;
        B = 16'hF0F0;
        #10;
        $display("A = %h, B = %h, SUM = %h, COUT = %b", A, B, SUM, COUT);

        $stop;
    end

endmodule

