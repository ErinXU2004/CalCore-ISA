module decoder (
    input [31:0] instr,
    output [2:0] type_id,     // EAT/EXER/WEIGH/SLEEP
    output [19:0] imm
);
    assign type_id = instr[11:9];      
    assign imm     = instr[31:12];        //immediate value
    
endmodule
