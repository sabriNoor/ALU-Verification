## 4-bit ALU Verification Testbench

A professional SystemVerilog testbench for verifying a 4-bit Arithmetic Logic Unit (ALU) using UVM-like methodology with comprehensive functional coverage.
---

## Project Overview

This project implements a complete verification environment for a 4-bit ALU with 8 operations. The testbench follows industry-standard UVM-like architecture with constrained random testing, automatic scoreboard checking, and functional coverage.

---

## Features
- 8 ALU operations: ADD, SUB, AND, OR, XOR, NOR, SLT, SLL
- Transaction-based verification environment
- Randomized test generation with weighted distributions
- Automatic scoreboard checking
- Clock-based synchronization
- Professional code structure with packages and interfaces
- Comprehensive functional coverage tracking:
    - Operation coverage (all 8 ALU operations)
    - Reset scenario coverage (active/inactive states)
    - Input value coverage (for both operands)

---

## Project Structure

```palin

alu-verification/
├── rtl/ # RTL Design Files
│ ├── alu_definitions.sv # Operation definitions package
│ ├── alu4bit.sv # ALU design
│ └── alu4bit_if.sv # Interface definition
├── testbench/ # Verification Components
│ ├── transaction.sv # Transaction class
│ ├── generator.sv # Test generator
│ ├── driver.sv # Driver/BFM
│ ├── monitor.sv # Response monitor
│ ├── scoreboard.sv # Checker
│ ├── coverage.sv # Functional coverage
│ ├── environment.sv # Test environment
│ ├── test.sv # Test class
│ └── top.sv # Top module
|


```
---

## ALU Operations

| Operation | Code | Description |
|-----------|------|-------------|
| ADD | 000 | a + b |
| SUB | 001 | a - b |
| AND | 010 | a & b |
| OR  | 011 | a \| b |
| XOR | 100 | a ^ b |
| NOR | 101 | ~(a \| b) |
| SLT | 110 | a < b ? 1 : 0 |
| SLL | 111 | a << b[1:0] |

---

## Verification Components

- Generator: Creates random ALU transactions
- Driver: Applies stimuli to DUT via interface
- Monitor: Captures DUT responses
- Scoreboard: Compares expected vs actual results
- Environment: Orchestrates all components
- Coverage: Tracks functional coverage metrics

---