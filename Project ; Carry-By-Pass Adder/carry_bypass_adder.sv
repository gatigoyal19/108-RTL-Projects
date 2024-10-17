`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.09.2024 11:18:05
// Design Name: 
// Module Name: carry_bypass_adder
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


module carry_bypass_adder #(parameter WIDTH = 16) (
    input  logic [WIDTH-1:0] A, B,
    output logic [WIDTH-1:0] SUM,
    output logic             COUT
);

    logic [WIDTH-1:0] P, G, C; // Propagate, Generate, Carry
    logic [WIDTH/4:0] block_carry; // Carry for each block (assuming 4-bit blocks)
    logic [3:0] propagate_block; // Propagate signal for each block

    // Step 1: Generate and Propagate signals
    assign G = A & B;
    assign P = A ^ B;

    // Step 2: Initial carry
    assign block_carry[0] = 0; // First block carry is 0 (Carry-in)

    // Step 3: Divide into 4-bit blocks
    genvar i;
    generate
        for (i = 0; i < WIDTH/4; i = i + 1) begin
            // Calculate propagate for each block (block propagate signal is AND of all bit propagates in the block)
            assign propagate_block[i] = &P[4*i +: 4]; // AND the propagate signals of 4-bit block
            // Generate carry for the next block
            assign block_carry[i+1] = G[4*i + 3] | (propagate_block[i] & block_carry[i]);
        end
    endgenerate

    // Step 4: Calculate carries for each bit
    generate
        for (i = 0; i < WIDTH; i = i + 1) begin
            if (i % 4 == 0)
                assign C[i] = block_carry[i/4];
            else
                assign C[i] = G[i-1] | (P[i-1] & C[i-1]);
        end
    endgenerate

    // Step 5: Calculate sum
    assign SUM = P ^ {C[WIDTH-1:0], 1'b0}; // Sum is A ^ B ^ Carry_in

    // Step 6: Final carry-out
    assign COUT = block_carry[WIDTH/4];

endmodule

