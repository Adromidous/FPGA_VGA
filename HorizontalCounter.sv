//Counter for horizontal pixels and output control signals

module HorizontalCounter(
    input clk,
    output reg en_v_counter,
    output [15:0] h_counter
    );
    
    localparam FRONT_PORCH = 16;
    localparam BACK_PORCH = 48;
    localparam SYNC_PULSE = 96;
    localparam VISIBLE = 640;
    
    reg [$clog2(FRONT_PORCH + BACK_PORCH + SYNC_PULSE + VISIBLE)-1:0] horz_counter;
    
    always_ff @(posedge clk) begin
        if (horz_counter < 799) begin
            horz_counter <= horz_counter + 1'b1;
            en_v_counter <= 1'b0;
        end else begin
            horz_counter <= {$clog2(FRONT_PORCH + BACK_PORCH + SYNC_PULSE + VISIBLE){1'b0}};
            en_v_counter <= 1'b1;
        end
    end
    
    assign h_counter = horz_counter;
    
endmodule