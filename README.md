# Custom Health ISA Extension (Version 1)

This project is a custom Instruction Set Architecture (ISA) extension based on RISC-V It adds health-related functionality such as height, weight, BMI, and BMR (Basal Metabolic Rate) calculations, using custom instructions implemented in Verilog.

## 📌 Version 1 Features

Each `MEM[index]` represents a user record, containing:
- Height (in centimeters)
- Weight (in kilograms)
- BMI (Body Mass Index)
- BMR (Basal Metabolic Rate)

### Supported Instructions

| Instruction     | Description                                                  |
|----------------|--------------------------------------------------------------|
| `SET_HEIGHT Rn, value` | Set user height in centimeters                        |
| `SET_WEIGHT Rn, value` | Set user weight in kilograms                         |
| `CALC_BMI Rn`          | Calculate BMI = weight / (height in m)^2             |
| `CALC_BMR Rn, gender, age` | Calculate BMR using Mifflin-St Jeor Equation     |

> `Rn` specifies the user index (i.e., MEM[ Rn ])


## 🔧 Instruction Format Design

- This custom ISA extension includes two types of instructions: I-type for setting user data, and R-type for computing results. All data is stored in memory where each MEM[user_index] holds a pair of values: height and weight.
### 🏗️ Memory Structure
```c
MEM[user_index] = {
  height (cm),   // 32-bit
  weight (kg)    // 32-bit
}
```

| Instruction | Type   | Opcode（7-bit） |
| ----------- | ------ | ----------------- |
| SET\_HEIGHT | I-type | `0001011`         |
| SET\_WEIGHT | I-type | `0001100`         |
| CALC\_BMI   | R-type | `0001101`         |
| CALC\_BMR   | R-type | `0001110`         |

### 📘 I-type Instructions: SET_HEIGHT, SET_WEIGHT
- Used to directly set height or weight for a user.
| 31–20   | 19–15 | 14–12 | 11–7 | 6–0    |
| imm     | rs1   | funct3| rd   | opcode |
- rd: user index → selects MEM[user_index]
- imm: 12-bit immediate height or weight value
- funct3: field selector: 0 = height, 1 = weight
- MEM[rd] = value stored in rs1 + imm
```asm
SET_HEIGHT x0, x1, 180  // Set height = 180 cm for MEM[x1]
SET_WEIGHT x0, x1, 75   // Set weight = 75 kg for MEM[x1]
```

### 📘 R-type Instructions: CALC_BMI, CALC_BMR
- Used to compute BMI or BMR from the user's stored height and weight. The result is written into rs2.
| 31–25   | 24–20 | 19–15 | 14–12 | 11–7 | 6–0    |
| funct7  | rs2   | rs1   | funct3| rd   | opcode |
- rs1: user index → source of height/weight
- rs2: destination register to hold the result
- rd: operation selector:
- 0 = compute BMI
- 1 = compute BMR
- funct7: used to encode additional parameters:
- For BMR: [6] = gender (0=female, 1=male), [5:0] = age (0–63)
```asm
CALC_BMI x2, x1         // Compute BMI for user x1, store result in x2
CALC_BMR x2, x1, M25    // Compute BMR for user x1 (male, age 25), store result in x2
```
> In BMR instruction, funct7 = 0b1_011001 (gender=1, age=25)
