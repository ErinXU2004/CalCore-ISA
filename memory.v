module memory (
    input  logic clk,
    input  logic we_height,      // write enable for height
    input  logic we_weight,      // write enable for weight
    input  logic [4:0] user_index, // user id (0–31)
    input  logic [31:20] data_in,   // data to write
    output logic [11:0] height_out,
    output logic [11:0] weight_out
);

    // Write logic
    always @(posedge clk) begin
        if (we_height)
            mem_height[user_index] <= data_in;
        if (we_weight)
            mem_weight[user_index] <= data_in;
    end

    // Read logic (combinational)
    always@(*) begin
        height_out = mem_height[user_index];
        weight_out = mem_weight[user_index];
    end

endmodule
