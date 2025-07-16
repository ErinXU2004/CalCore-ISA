module top (
    input  logic        clk,
    input  logic        reset,
    input  logic [31:0] instr,     
    output logic [31:0] result      
);
    logic is_set_height,
    logic is_set_weight,
    logic is_calc_bmi,
    logic is_calc_bmr,
    logic [31:25] gender_age;
    logic [31:20] imm, //imm
    logic [24:20] rs2,   //rs2
    logic [19:15] rs1,  // rs1
    logic [11:7] rd; //destination
    logic [31:0] height_out;
    logic [31:0] weight_out;
    logic [31:0] alu_result;

    decoder instruction_decoder(.instr(instr),
        .is_set_height(is_set_height),
        .is_set_weight(is_set_weight),
        .is_calc_bmi(is_calc_bmi),
        .is_calc_bmr(is_calc_bmr),
        .funct7(gender_age), //[31]gender,[30:25]age
        .imm(imm), //imm
        .rs2(rs2),   //rs2
        .rs1(rs1),  // rs1
        .rd(rd); //destination
        );

    logic [31:0] imm_extended;
    assign imm_extended = {{20{imm[11]}}, imm}; // sign extended

    always@(*)begin
        if(is_set_height|is_set_weight)begin
            memory write_memory(.clk(clk),
                .reset(reset),
                .we_height(is_set_height),
                .we_weight(is_set_weight),
                .user_index(rd),          
                .data_in(imm_extended),   
                .height_out(height_out),
                .weight_out(weight_out));
        end
        else begin
            memory read_memory(.clk(clk),
                .we_height(0),
                .we_weight(0),
                .user_index(rd),          
                .data_in(imm_extended),   
                .height_out(height_out),
                .weight_out(weight_out));
            alu health_alu (
                .is_calc_bmi(is_calc_bmi),
                .is_calc_bmr(is_calc_bmr),
                .height(height_out),
                .weight(weight_out),
                .funct7(funct7),
                .result(alu_result)
            );
        end
    end
        

endmodule