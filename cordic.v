`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.08.2025 15:34:07
// Design Name: 
// Module Name: cordic
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


module cordic 
#(parameter M=32,N=5)
(
input clk,
input rst,
input signed [M-1:0] x_0,
input signed [M-1:0] y_0,
input signed [M-1:0] z_0,
input [1:0] mode,
input [N-1:0] i,
input signed [M-1:0] z_i,
output reg signed [M-1:0] x_n, y_n ,z_n
    );
    wire [M-1:0] x_shift,y_shift;
    assign x_shift= mode[1] ? x_0>>>(i+1) : x_0>>>i;
    assign y_shift= mode[1] ? y_0>>>(i+1) : y_0>>>i;
    always @(posedge clk) begin
        if (rst==1'b1) begin
            x_n<=0;
            y_n<=0;
            z_n<=0;
        
        end
        else begin 
        
        case (mode)
            2'b00: begin //sin,cos calculation (rotation mode, circular coordinates)
            x_n<= z_0[M-1] ? x_0+y_shift: x_0-y_shift; //signed bit of z_0   
            y_n<= z_0[M-1] ? y_0-x_shift : y_0 +x_shift; 
            z_n<=z_0[M-1] ? z_0+z_i : z_0-z_i;
            end
            
            2'b01: begin //arctan calculation (vectoring mode, circular coordinates)
            x_n<= y_0[M-1] ? x_0-y_shift: x_0+y_shift; //signed bit of z_0
            y_n<= y_0[M-1] ? y_0+x_shift : y_0 -x_shift; 
            z_n<= y_0[M-1] ? z_0-z_i : z_0+z_i;
            end
            2'b10: begin //sinh, cosh calculation (rotation mode, hyberbolic coordinated)
            
                //x_n<= z_0[M-1] ? x_0-(y_shift>>>1) : x_0+(y_shift>>>1); //signed bit of z_0
                //y_n<= z_0[M-1] ? y_0-(x_shift>>>1) : y_0+(x_shift>>>1); 
                //z_n<= z_0[M-1] ? z_0+z_i : z_0-z_i;
                x_n<= z_0[M-1] ? x_0-(y_shift) : x_0+(y_shift); //signed bit of z_0
                y_n<= z_0[M-1] ? y_0-(x_shift) : y_0+(x_shift); 
                z_n<= z_0[M-1] ? z_0+z_i : z_0-z_i;
            end
            
            2'b11: begin //arctanh calculation (vectoring mode, hyperbolic coordinates)
            x_n<= y_0[M-1] ? x_0+y_shift : x_0-y_shift; //signed bit of z_0
            y_n<= y_0[M-1] ? y_0+x_shift : y_0-x_shift; 
            z_n<= y_0[M-1] ? z_0-z_i : z_0+z_i;
            end
            
        endcase
    end
    
    
    
    
    
    end
endmodule
