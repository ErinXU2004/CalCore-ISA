
module alu (
    input logic is_calc_bmi,
    input logic is_calc_bmr,
    input logic [31:0] height,  // in cm
    input logic [31:0] weight,  // in kg
    input logic [6:0] funct7,   // [6] = gender, [5:0] = age
    output logic [31:0] result
);

    logic [31:0] bmi;
    logic [31:0] bmr;
    logic [31:0] height_m;
    logic [31:0] height_m2;
    logic [31:0] weight_x10000; // weight * 10000
    logic [31:0] bmi_temp;
    logic [5:0] age;
    logic gender; // 0=female, 1=male
    assign gender = funct7[6];
    assign age = funct7[5:0];
// BMI = weight / (height_m)^2
    always@(*)begin
        height_mm = height * 10; // convert cm to mm (simulate float)
        height_m2 = (height_mm * height_mm) / 10000; // scale factor for decimal
        weight_x10000 = weight * 10000;
        if (is_calc_bmi) begin
            if (height_m2 != 0)
                bmi = weight_x10000 / height_m2;  // fixed point simulation
            else
                bmi = 0;
            result = bmi;
        end
        // BMR = 10W + 6.25H - 5A + C
        // C = +5 (male) / -161 (female)
        else if (is_calc_bmr) begin
            bmr = (10 * weight) + (625 * height / 100) - (5 * age);
            if (gender)
                bmr = bmr + 5;
            else
                bmr = bmr - 161;
            result = bmr;
        end
        else begin
            result = 0;  // Default output
        end
    end
endmodule
