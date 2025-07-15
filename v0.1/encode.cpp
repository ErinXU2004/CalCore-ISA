#include <iostream>
#include <sstream>
#include <iomanip>
#include <map>
#include <cmath>

using namespace std;

// Constants
const uint32_t OPCODE = 0b1011011; // 7-bit custom opcode

// Instruction mapping to rd field (lowest 5 bits)
map<string, uint32_t> instr_rd = {
    {"EAT",   0b00001},
    {"EXER",  0b00010},
    {"WEIGH", 0b00011},
    {"SLEEP", 0b00100},
    {"RESET", 0b00101}
};

// Function to encode instruction
uint32_t encode(const string& instr, double value) {
    uint32_t imm = 0;
    if (instr == "WEIGH") {
        imm = static_cast<uint32_t>(round(value * 10)); // e.g., 49.5 → 495
    } else {
        imm = static_cast<uint32_t>(round(value));
    }

    if (imm >= (1 << 20)) {
        cerr << "Error: Immediate value too large for U-type (max 20 bits)." << endl;
        exit(1);
    }

    uint32_t rd = instr_rd[instr];
    uint32_t encoded = (imm << 12) | (rd << 7) | OPCODE;
    return encoded;
}

int main() {
    string line;
    cout << "Enter CalCore-ISA instruction (e.g., EAT 500 or WEIGH 49.5):" << endl;
    while (getline(cin, line)) {
        if (line.empty()) continue;

        string instr;
        double value = 0;
        stringstream ss(line);
        ss >> instr;

        if (instr_rd.find(instr) == instr_rd.end()) {
            cerr << "Unsupported instruction: " << instr << endl;
            continue;
        }

        if (instr != "RESET") {
            if (!(ss >> value)) {
                cerr << "Missing or invalid value for instruction." << endl;
                continue;
            }
        }

        uint32_t code = encode(instr, value);
        cout << "Encoded (hex): 0x" << hex << setw(8) << setfill('0') << code << endl;
    }

    return 0;
}
