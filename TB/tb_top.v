`timescale 1ns/1ps

module tb_top();
    // 时钟和复位
    logic clk = 0;
    logic reset;
    logic [31:0] instr;
    logic [31:0] result;
    
    // 实例化被测设计
    top dut (
        .clk(clk),
        .reset(reset),
        .instr(instr),
        .result(result)
    );
    
    always #5 clk = ~clk;
    
    initial begin
        // wave
        $dumpfile("wave.vcd");
        $dumpvars(0, tb_top);
        
        // reset
        reset = 1;
        instr = 32'h0;
        #20;
        reset = 0;
        
        $display("[TEST] SET_HEIGHT x0, 180");
        instr = {12'd180, 5'b0, 3'b000, 5'd0, 7'b0001011}; // SET_HEIGHT x0, 180
        #10;
        
        $display("[TEST] SET_WEIGHT x0, 75");
        instr = {12'd75, 5'b0, 3'b001, 5'd0, 7'b0001011}; // SET_WEIGHT x0, 75
        #10;
        
        $display("[TEST] CALC_BMI x1, x0");
        instr = {7'b0, 5'b0, 5'd0, 3'b000, 5'd1, 7'b0001101}; // CALC_BMI x1, x0
        #20;
        $display("  BMI = %d (expected≈20)", result); // 75/(1.8^2)=23.14
        
        $display("[TEST] CALC_BMR x1, x0, M25");
        instr = {7'b1_011001, 5'b0, 5'd0, 3'b000, 5'd1, 7'b0001110}; // CALC_BMR x1, x0
        #20;
        $display("  BMR = %d (expected≈1695)", result); // 10*75 + 6.25*180 - 5*25 +5 = 1695
        
        // 结束仿真
        $display("[TEST] All Done");
        $finish;
    end
    
    // 监视器
    always @(posedge clk) begin
        if (dut.is_calc_bmi)
            $display("在 %t ns calculate BMI", $time);
    end
endmodule