module memory (
    input  logic        clk,
    input  logic        reset,
    input  logic        we_height,
    input  logic        we_weight,
    input  logic [4:0]  user_index,
    input  logic [31:0] data_in,
    output logic [31:0] height_out,
    output logic [31:0] weight_out
);

    (* keep = "true" *) reg [31:0] mem_height [0:31];
    (* keep = "true" *) reg [31:0] mem_weight [0:31];

    initial begin
        for (int i = 0; i < 32; i++) begin
            mem_height[i] = 32'd0;    //default 0cm
            mem_weight[i] = 32'd0;     //default 0kg
        end
    end

    //write in
    always @(posedge clk or posedge reset) begin
         if (reset) begin
           for (int i = 0; i < 32; i++) begin
                mem_height[i] = 32'd0;    //default 0cm
                mem_weight[i] = 32'd0;     //default 0kg
            end
        end else begin
            if (we_height) mem_height[user_index] <= data_in;
            if (we_weight) mem_weight[user_index] <= data_in;
        end
    end

    // read out
    assign height_out = mem_height[user_index];
    assign weight_out = mem_weight[user_index];

endmodule