module instruction_decoder (
    input  logic [31:0] instr,
    output logic is_set_height,
    output logic is_set_weight,
    output logic is_calc_bmi,
    output logic is_calc_bmr,
    output logic [31:25] funct7,
    output logic [31:20] imm, //imm
    output logic [24:20] rs2,   //rs2
    output logic [19:15] rs1,  // rs1
    output logic [11:7] rd; //destination
);

    logic [6:0] opcode;
    assign opcode = instr[6:0];
    always@(*) begin
        is_set_height = (opcode == 7'b0001011);
        is_set_weight = (opcode == 7'b0001100);
        is_calc_bmi   = (opcode == 7'b0001101);
        is_calc_bmr   = (opcode == 7'b0001110);
    end
    assign rd = instr[11:7];
    assign rs2 = instr[24:20];
    assign rs1 = instr[19:15];
    assign funct7 = (is_calc_bmr)?instr[31:25]:7'b0;

endmodule