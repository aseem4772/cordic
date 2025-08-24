`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.08.2025 11:54:52
// Design Name: 
// Module Name: phase_acc
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


module phase_acc
#(parameter M=32)
(
input signed [M-1:0] phase_step,
input clk,
input rst,
output reg signed [M-1:0] phase_out
    );
    localparam signed [M-1:0] plus_pi=32'h6487ed51;
    localparam signed [M-1:0] minus_pi = 32'h9b7812af;
    localparam signed [M-1:0] pi_by_2 = 32'h3243f6a9;
    localparam signed [M-1:0] minus_pi_by_2 = 32'hcdbc0957;
    wire  signed [M-1:0] phase1=phase_out-plus_pi;
    always @(posedge clk) begin
        if(rst==1'b1) phase_out<=32'h0;
        else begin 
            if (phase_out>=plus_pi) phase_out<=phase1-plus_pi;
            else begin
                phase_out<=phase_out+phase_step;
            end
            
        end
    end
endmodule
