//Counter for vertical pixels and output control signals

module VerticalCounter(
    input clk,
    input en_v_counter,
    output [15:0] v_counter
    );
    
    localparam FRONT_PORCH = 10;
    localparam BACK_PORCH = 33;
    localparam SYNC_PULSE = 2;
    localparam VISIBLE = 480;
    
    reg [$clog2(FRONT_PORCH + BACK_PORCH + SYNC_PULSE + VISIBLE)-1:0] vert_counter;
    
    always_ff @(posedge clk) begin
        if (en_v_counter) begin
            if (vert_counter < 524) begin
                vert_counter <= vert_counter + 1'b1;
            end else begin
                vert_counter <= {$clog2(FRONT_PORCH + BACK_PORCH + SYNC_PULSE + VISIBLE){1'b0}};
            end
        end
    end
    
    assign v_counter = vert_counter;
    
endmodule