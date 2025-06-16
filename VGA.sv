`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/08/2025 09:38:28 PM
// Design Name: 
// Module Name: VGA
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


module VGA(
    input clk,
//    input [3:0] curr_r,
//    input [3:0] curr_g,
//    input [3:0] curr_b,
    input en_greyscale,
    output reg h_sync,
    output reg v_sync,
    output reg [3:0] r_val,
    output reg [3:0] g_val,
    output reg [3:0] b_val
);

    reg [15:0] h_counter, v_counter;
    reg en_v_counter;
    
    wire [3:0] grey_pixel;

    HorizontalCounter h0 (
        .clk(clk),
        .en_v_counter(en_v_counter),
        .h_counter(h_counter)
    );
    
    VerticalCounter v0 (
        .clk(clk),
        .en_v_counter(en_v_counter),
        .v_counter(v_counter)
    );
    
    always_ff @(posedge clk) begin
        //Matrix multiplication for RGB
    
        if (v_counter > 34 && v_counter < 515) begin
            v_sync <= 1'b1;
        end else begin
            v_sync <= 1'b0;
        end
        
        if (h_counter > 143 && h_counter < 784) begin
            h_sync <= 1'b1;
        end else begin
            h_sync <= 1'b0;
        end
     
        
        if (v_counter > 34 && v_counter < 515 && h_counter > 143 && h_counter < 784) begin //If we are within drawing boundaries
            if (en_greyscale) begin //If greyscale switch is on
                r_val <= grey_pixel;
                g_val <= grey_pixel;
                b_val <= grey_pixel; 
            end else begin
//                r_val <= curr_r;
//                g_val <= curr_g;
//                b_val <= curr_b;
                  r_val <= 4'b0;
                  g_val <= 4'b0;
                  b_val <= 4'b0;
            end
        end else begin
            r_val <= 4'b0;
            g_val <= 4'b0;
            b_val <= 4'b0;
        end
        
    end
    
    assign grey_pixel = 4'b1111;
    
    
    
endmodule
