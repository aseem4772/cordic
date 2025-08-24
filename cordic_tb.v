`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 15.08.2025 15:29:06
// Design Name: 
// Module Name: cordic_tsh
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


module cordic_tb;
parameter M=32,N=5;
reg [1:0] mode;
reg signed [M-1:0] x_0,y_0,z_0;
reg rst;
wire signed [M-1:0] x_n,y_n,z_n;
reg signed [31:0] CORDIC_K = 32'h137A5DBB; // Q3.29 // 0.607252935
reg clk;
reg [12:0] ctr;
wire signed [2*M-1:0] x_scaled,y_scaled;
reg signed [M-1:0] phase_step;
wire signed [M-1:0] phase_out;
reg signed [M-1:0] x;
wire signed [M-1:0] e_x;
cordic_pipelined cordic_0(.mode(mode),.x(x),.clk(clk),.rst(rst), .x_n(x_n),.y_n(y_n),.z_n(z_n));
//assign x_scaled=x_n*CORDIC_K;
//assign y_scaled=y_n*CORDIC_K;
phase_acc p1(.clk(clk),.rst(rst),.phase_step(phase_step),.phase_out(phase_out));
assign e_x=x_n+y_n;
initial begin
phase_step=32'h01015bf9;
//z_0=32'h10c15238;//pi/6
//z_0=32'h1921fb54 ;// pi/2;
ctr=13'b0;
//x=32'h1921fb54; pi/4
x=32'h56b851ec;
//x_0=32'h20000000;
x_0=CORDIC_K;
y_0=32'h20000000;
mode=2'b11;
clk=1'b0;
rst=1'b1;
#10 rst=1'b0;
#10000 $finish;
end
always @(*) #5 clk<=~clk;
always @(posedge clk) ctr<=ctr+1;




endmodule
