`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.08.2025 18:10:26
// Design Name: 
// Module Name: pre_processor
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


module pre_processor
#(parameter M=32)
(
input signed [M-1:0] x,
input [1:0] mode,
output reg signed [M-1:0] x_out,y_out,z_out
    );
    localparam signed [M-1:0] plus_pi=32'h6487ed51;
    localparam signed [M-1:0] minus_pi = 32'h9b7812af;
    localparam signed [M-1:0] pi_by_2 = 32'h3243f6a9;
    localparam signed [M-1:0] minus_pi_by_2 = 32'hcdbc0957;
    localparam signed [M-1:0] CORDIC_K = 32'h13510BD6; // 0.607252935
    localparam signed [M-1:0] CORDIC_K_h = 32'h26902de0;
    localparam signed [M-1:0] one_by_4=32'h20000000;
    always @(*) begin
        case(mode)
        2'b00: begin 
            if (x>pi_by_2) begin //2nd quadrant
                x_out<=32'h0;
                y_out<=CORDIC_K;
                z_out<=x-pi_by_2;
                end
            else if (x<(minus_pi_by_2)) begin //3rd quadrant
                x_out<=32'h0;
                y_out<= (-CORDIC_K);
                z_out<=x+pi_by_2;
                end
            else begin
                x_out<=CORDIC_K;
                y_out<=32'h0;
                z_out<=x;
            
            end 
        end    
             
        2'b01: begin
            x_out<=32'h20000000;
            y_out<=x;
            z_out<=0;        
        end
        
        2'b10: begin
            x_out<=CORDIC_K_h;
            y_out<=32'h0;
            z_out<=x;
        end
        
        2'b11: begin
            x_out<=x+one_by_4;
            y_out<=x-one_by_4;
            z_out<=0;
        end
        
        endcase
    end
    
endmodule
