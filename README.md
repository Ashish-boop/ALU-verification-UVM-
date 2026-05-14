# ALU-verification-UVM-
Developed a UVM-based verification environment to validate arithmetic and logical operations of an ALU design. Implemented sequencers, drivers, monitors, and scoreboards to verify functional correctness using constrained-random stimulus and self-checking mechanisms. 
# ALU Verification using UVM

## Overview
This project implements a UVM-based verification environment for validating the functionality of an Arithmetic Logic Unit (ALU). The verification environment supports arithmetic and logical operation testing using constrained-random stimulus and self-checking mechanisms.

---

## Features Verified
- Addition
- Subtraction
- AND / OR / XOR
- Shift Operations
- Overflow Conditions
- Zero Flag Generation
- Corner-Case Input Scenarios

---

## Verification Methodology
- Universal Verification Methodology (UVM)
- Constrained-Random Verification
- Functional Coverage
- Self-Checking Scoreboard Architecture

---

## Testbench Components
- Sequencer
- Driver
- Monitor
- Agent
- Scoreboard
- Functional Coverage Collector
- Assertions

---

## Tools Used
- SystemVerilog
- UVM
- Synopsys VCS / ModelSim
- Linux Environment

---

## Coverage Achieved
- Functional Coverage: 100%

---

## Directory Structure

alu_uvm/
├── rtl/
├── tb/
├── sequences/
├── agent/
├── scoreboard/
├── coverage/
├── assertions/
├── sim/
└── README.md

---

## How to Run

Compile:
```bash
make compile
