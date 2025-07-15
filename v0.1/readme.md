# CalCore-ISA: Custom Instruction Set Architecture for Fat-Loss Tracking

**CalCore-ISA** is a lightweight RISC-V compatible instruction set architecture designed to capture and accelerate **fat-loss-related behaviors** — including calorie intake, exercise, weight, and sleep — at the hardware level.

This is the **first public version (v0.1)** featuring a **custom ISA design**, ready for Verilog implementation and simulation in future versions.

---

## 🎯 Project Vision

Current fitness trackers rely heavily on cloud software and battery-hungry apps. CalCore-ISA proposes a minimal, low-power instruction set that allows edge processors or wearables to **directly log and process health-related data** using hardware-efficient, semantic-friendly instructions.

---

## 🔧 Custom Instruction Set Design (v0.1)

CalCore uses **RISC-V's reserved custom opcode space** and a **U-Type** format to encode health-tracking behaviors as compact 32-bit instructions.

### ✅ U-Type Format Overview
```
| imm[31:12] | rd (5) | opcode (7) |
| value field | type ID | 1011011 |
```


- `imm`: Immediate value (e.g., 500 kcal, 45 min)
- `rd`: Encodes behavior type (see below)
- `opcode`: Custom opcode `1011011` (custom-2)

---

### 📘 Instruction Set Table

| Instruction | `rd[2:0]` | Meaning               | Unit   | Example       |
|-------------|-----------|------------------------|--------|---------------|
| `EAT`       | `000`     | Log food intake        | kcal   | `EAT 500`     |
| `EXER`      | `001`     | Log exercise duration  | min    | `EXER 45`     |
| `WEIGH`     | `010`     | Record body weight     | kg     | `WEIGH 495` → 49.5kg |
| `SLEEP`     | `011`     | Log sleep duration     | min    | `SLEEP 420`   |
| `RESET`     | `100`     | Reset daily counters   | -      | `RESET`       |

> 🔹 Decimal values like 49.5kg are encoded as integers ×10 (e.g., `495`)  
> 🔹 Units are implicit based on instruction type

---

## 🛠 Encoding Example

**Instruction:** `EAT 500`  
- `imm` = 500 = `0x1F4`
- `rd` = 1 (type `000`)
- `opcode` = `0x5B` (custom-2)

**Encoding:**
```
Binary: [imm << 12] | [rd << 7] | opcode
Hex: 0x1F4005B
```
## 🤝 Contribution

This project is currently a solo research endeavor and welcome to feedback or co-development. If you're passionate about **hardware-software co-design** in the health domain, feel free to open an issue or reach out.

---

## 📫 Contact

**Erin (Hua) Xu**  
Email: [erinhua@umich.edu](mailto:erinhua@umich.edu)  
GitHub: [@ErinXU2004](https://github.com/ErinXU2004)  
LinkedIn: [linkedin.com/in/erin-xu-a48031294](https://www.linkedin.com/in/erin-xu-a48031294)

---
