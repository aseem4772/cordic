`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.08.2025 21:46:25
// Design Name: 
// Module Name: cordic_pipelined
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


module cordic_pipelined
#(parameter M=32, N=5)
(input [1:0] mode,
input rst,
input clk,
input signed [M-1:0] x,
output signed [M-1:0] x_n,y_n,z_n
    );
    wire signed [M-1:0] x_0,y_0,z_0;
    localparam signed [M-1:0] plus_pi=32'h6487ed51;
    localparam signed [M-1:0] minus_pi = 32'h9b7812af;
    localparam signed [M-1:0] pi_by_2 = 32'h3243f6a9;
    localparam signed [M-1:0] minus_pi_by_2 = 32'hcdbc0957;
    wire signed [M-1:0] out_x [0:M];
    wire signed [M-1:0] out_y [0:M];
    wire signed [M-1:0] out_z [0:M];
    wire signed [M-1:0] atan[0:M-1];
    pre_processor pre_1(.x(x),.mode(mode),.x_out(x_0),.y_out(y_0),.z_out(z_0));
    assign out_x[0]= x_0 ; //rotation by +- pi/2 if z_0>pi/2 or <-pi/2
    assign out_y[0]=y_0 ; //rotation by +- pi/2 if z_0>pi/2 or <-pi/2
    assign out_z[0]=z_0; //rotation by +- pi/2 if z_0>pi/2 or <-pi/2
    assign x_n=out_x[M];
    assign y_n=out_y[M];
    assign z_n=out_z[M];
    assign atan[0]  = 32'h1921FB54; // atan(1.0)
    assign atan[1]  = 32'h0ED63383; // atan(0.5)
    assign atan[2]  = 32'h07D6DD7E;
    assign atan[3]  = 32'h03FAB753;
    assign atan[4]  = 32'h01FF55BB;
    assign atan[5]  = 32'h00FFEAAE;
    assign atan[6]  = 32'h007FFD55;
    assign atan[7]  = 32'h003FFFAB;
    assign atan[8]  = 32'h001FFFF5;
    assign atan[9]  = 32'h000FFFFF;
    assign atan[10] = 32'h00080000;
    assign atan[11] = 32'h00040000;
    assign atan[12] = 32'h00020000;
    assign atan[13] = 32'h00010000;
    assign atan[14] = 32'h00008000;
    assign atan[15] = 32'h00004000;
    assign atan[16] = 32'h00002000;
    assign atan[17] = 32'h00001000;
    assign atan[18] = 32'h00000800;
    assign atan[19] = 32'h00000400;
    assign atan[20] = 32'h00000200;
    assign atan[21] = 32'h00000100;
    assign atan[22] = 32'h00000080;
    assign atan[23] = 32'h00000040;
    assign atan[24] = 32'h00000020;
    assign atan[25] = 32'h00000010;
    assign atan[26] = 32'h00000008;
    assign atan[27] = 32'h00000004;
    assign atan[28] = 32'h00000002;
    assign atan[29] = 32'h00000001;
    assign atan[30] = 32'h00000000;
    assign atan[31] = 32'h00000000;
    
    wire signed [M-1:0] atanh [0:M-1];

    // Precomputed atanh(2^-i) values in Q3.29
   assign atanh[0]  = 32'h119C275A; //  294912074  → 0.549306144
    assign atanh[1]  = 32'h082E6EBC; //  137338700  → 0.255412811
    assign atanh[2]  = 32'h0406B213; //   67560291  → 0.125657214
    assign atanh[3]  = 32'h02020470; //   33652944  → 0.062581571
    assign atanh[4]  = 32'h01009357; //   16818791  → 0.031260178
    assign atanh[5]  = 32'h0080517C; //    8412140  → 0.015626271
    assign atanh[6]  = 32'h00403091; //    4205809  → 0.007812658
    assign atanh[7]  = 32'h0020096F; //    2102927  → 0.003906270
    assign atanh[8]  = 32'h00100267; //    1051463  → 0.001953127
    assign atanh[9]  = 32'h00080144; //     525732  → 0.000976563
    assign atanh[10] = 32'h00040069; //     262866  → 0.000488281
    assign atanh[11] = 32'h00020039; //     131433  → 0.000244141
    assign atanh[12] = 32'h00010014; //      65716  → 0.000122070
    assign atanh[13] = 32'h0000800A; //      32858  → 0.000061035
    assign atanh[14] = 32'h0000402D; //      16429  → 0.000030518
    assign atanh[15] = 32'h00002017; //       8215  → 0.000015259
    assign atanh[16] = 32'h0000100B; //       4107  → 0.000007629
    assign atanh[17] = 32'h00000805; //       2053  → 0.000003815
    assign atanh[18] = 32'h00000402; //       1026  → 0.000001907
    assign atanh[19] = 32'h00000201; //        513  → 0.000000954
    assign atanh[20] = 32'h00000100; //        256  → 0.000000477
    assign atanh[21] = 32'h00000080; //        128  → 0.000000238
    assign atanh[22] = 32'h00000040; //         64  → 0.000000119
    assign atanh[23] = 32'h00000020; //         32  → 0.000000060
    assign atanh[24] = 32'h00000010; //         16  → 0.000000030
    assign atanh[25] = 32'h00000008; //          8  → 0.000000015
    assign atanh[26] = 32'h00000004; //          4  → 0.000000007
    assign atanh[27] = 32'h00000002; //          2  → 0.000000004
    assign atanh[28] = 32'h00000001; //          1  → 0.000000002
    assign atanh[29] = 32'h00000000; // rounds to 0
    assign atanh[30] = 32'h00000000; // rounds to 0
    assign atanh[31] = 32'h00000000; // rounds to 0
    // ------------------------------
    // Pre-scaling constant K (Q3.29)
    // ------------------------------
    localparam signed [31:0] CORDIC_K = 32'h13510BD6; // 0.607252935
    
    genvar i;  // Special variable for generate loops
    generate
        for (i = 1; i < M+1; i = i + 1) begin
            cordic cordic_stage (.clk(clk),.rst(rst),.mode(mode),.x_0(out_x[i-1]),.y_0(out_y[i-1]),.z_0(out_z[i-1]),.x_n(out_x[i]),.y_n(out_y[i]),.z_n(out_z[i]),.z_i(atanh[i-1]),.i(i-1));
            // Hardware that repeats for each i
        end
endgenerate

endmodule
