## 🧾 Custom Instruction Set for Health Tracking

To make CalCore-ISA more expressive and tailored for fat-loss scenarios, we introduce a set of **domain-specific instructions** that represent health-related activities. These instructions simplify the software-hardware interface by directly expressing the user's daily actions.

### ✨ Sample Custom Instructions

| Instruction | Operand | Meaning |
|-------------|---------|---------|
| `EAT`       | kcal    | Log food intake in calories |
| `EXER`      | mins    | Log exercise duration (minutes) |
| `WEIGH`     | kg      | Record current body weight |
| `SLEEP`     | mins    | Log sleep duration |
| `RESET`     | -       | Reset daily counter |

### 💡 Example Usage
```
EAT 500 ; Eat 500 kcal
EXER 30 ; Exercise for 30 mins
WEIGH 49.5 ; Weigh-in at 49.5 kg
SLEEP 420 ; Slept for 7 hours
```

### 🛠 ISA Encoding (planned)

We plan to implement these instructions as **custom R-type** or **U-type extensions** to the RV32I base ISA. An example encoding strategy might be:

| Field | Bits | Description |
|-------|------|-------------|
| opcode | 7   | Custom opcode (e.g., `1011011`) |
| funct3 | 3   | Function category (`EAT`, `EXER`, etc.) |
| imm   | 20  | Value (e.g., 500 for `EAT`) |
| rd    | 5   | Destination register or log address |

```
| imm[19:0] | rd | funct3 | opcode |
```


### 📦 Storage Model

- All logs are written to a circular memory buffer
- Weight entries are stored with timestamps for trend detection
- Calorie balance is computed from `EAT` - `EXER` daily

