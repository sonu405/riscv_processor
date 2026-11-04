# RISC-V 5-Stage Pipelined Processor

A fully functional 5-stage pipelined implementation of the RISC-V (RV32I) architecture, designed in hardware description language with complete handling of all data and control hazards.

---

## Table of Contents

- [Overview](#overview)
- [Architecture](#architecture)
- [Pipeline Stages](#pipeline-stages)
- [Hazard Handling](#hazard-handling)
  - [Data Hazards](#data-hazards)
  - [Control Hazards](#control-hazards)
- [Branch Strategy](#branch-strategy)
- [Supported Instructions](#supported-instructions)
- [Project Structure](#project-structure)
- [Getting Started](#getting-started)
- [Limitations & Future Work](#limitations--future-work)

---

## Overview

This project implements a classic 5-stage RISC-V pipeline capable of executing RV32I base integer instructions. The primary focus of this implementation is correctness under all pipeline hazard conditions — every RAW (Read After Write) data dependency and control flow dependency is resolved, ensuring the processor produces architecturally correct results across all instruction sequences.

**Key highlights:**
- Full RV32I instruction support
- Data hazard resolution via forwarding and stalling
- Control hazard resolution via the **Branch Not Taken** prediction strategy
- No exception/interrupt handling (planned for future work)

---

## Architecture

```
IF  →  ID  →  EX  →  MEM  →  WB
```

The processor follows the textbook 5-stage pipeline model with inter-stage registers (IF/ID, ID/EX, EX/MEM, MEM/WB) separating each stage. Hazard detection and forwarding units sit alongside the pipeline and intervene when necessary.

```
        ┌────────┐   ┌────────┐   ┌────────┐   ┌─────────┐   ┌────────┐
        │   IF   │──▶│   ID   │──▶│   EX   │──▶│   MEM   │──▶│   WB   │
        └────────┘   └────────┘   └────────┘   └─────────┘   └────────┘
              ▲             │            ▲  ▲          ▲
              │      Hazard │     Forward│  │   Forward│
              │    Detection│      (EX) │  │   (MEM)  │
              │             ▼            │  └──────────┘
              └─── Flush / Stall Control ┘
```

---

## Pipeline Stages

### 1. Instruction Fetch (IF)
- Fetches the instruction from instruction memory at the current PC.
- PC is updated to `PC + 4` by default (branch not taken).
- On a taken branch (resolved in EX), the pipeline is flushed and PC is corrected.

### 2. Instruction Decode (ID)
- Decodes the fetched instruction and reads the register file.
- Generates all control signals for downstream stages.
- Detects load-use hazards and inserts a stall (bubble) when required.

### 3. Execute (EX)
- Performs ALU operations.
- Resolves branch conditions and computes branch target addresses.
- Receives forwarded operands from EX/MEM and MEM/WB stages when applicable.

### 4. Memory Access (MEM)
- Handles load (`lw`, `lb`, `lh`, etc.) and store (`sw`, `sb`, `sh`) operations.
- Non-memory instructions pass through this stage unchanged.

### 5. Write Back (WB)
- Writes the result (from ALU or memory) back into the register file.
- The destination register and write-enable signal are used by the forwarding unit.

---

## Hazard Handling

### Data Hazards

Data hazards occur when an instruction depends on the result of a preceding instruction that has not yet completed its write-back. This implementation handles all categories:

#### RAW Hazards — Forwarding (EX-EX and MEM-EX)

The **Forwarding Unit** monitors the destination registers of instructions in the EX/MEM and MEM/WB pipeline registers and compares them against the source registers of the instruction currently in EX. When a match is detected, the correct value is muxed directly into the ALU input, bypassing the register file read.

```
EX-EX Forward:
  if (EX/MEM.RegWrite AND EX/MEM.Rd != 0
      AND EX/MEM.Rd == ID/EX.Rs1)  → ForwardA = EX/MEM ALU result

MEM-EX Forward:
  if (MEM/WB.RegWrite AND MEM/WB.Rd != 0
      AND MEM/WB.Rd == ID/EX.Rs1)  → ForwardA = MEM/WB write data
```

*(Same logic applies symmetrically for Rs2 / ForwardB.)*

#### RAW Hazards — Load-Use Stall

Forwarding alone cannot resolve a **load-use hazard** — when the instruction immediately following a load reads the register being loaded into (the data isn't available until after the MEM stage).

The **Hazard Detection Unit** identifies this case and:
1. **Stalls** the IF and ID stages (holds their pipeline registers).
2. **Inserts a bubble (NOP)** into the EX stage for one cycle.

```
Load-Use Stall condition:

  if (ID/EX.MemRead
      AND (ID/EX.Rd == IF/ID.Rs1 OR ID/EX.Rd == IF/ID.Rs2))
  → Stall
```

---

### Control Hazards

Control hazards arise from branch and jump instructions since the correct next PC is not known at the IF stage.

---

## Branch Strategy

This implementation uses the **Branch Not Taken (BNT)** static prediction strategy.

**How it works:**
- Every branch is predicted as *not taken* — the processor always fetches `PC + 4` after a branch instruction.
- The branch condition and target are evaluated at the end of the **EX stage**.
- If the branch is actually *not taken* → no penalty, execution continues correctly.
- If the branch is actually *taken* → the 2 instructions fetched speculatively (in IF and ID) are **flushed** (converted to NOPs/bubbles), and the PC is redirected to the branch target.

**Branch penalty:** 2 cycles per misprediction (taken branch).

**Why Branch Not Taken?**
- Simple to implement with no branch predictor hardware.
- Zero penalty cost for not-taken branches, which are statistically common in many workloads (loop exits, guard conditions).
- Deterministic and easy to verify for correctness.

> **Not implemented:** Dynamic branch prediction, branch delay slots, or early branch resolution in the ID stage.

---

## Supported Instructions

| Category | Instructions |
|---|---|
| **R-Type** | `add`, `sub`, `and`, `or`, `xor`, `sll`, `srl`, `sra`, `slt`, `sltu` |
| **I-Type ALU** | `addi`, `andi`, `ori`, `xori`, `slli`, `srli`, `srai`, `slti`, `sltiu` |
| **Load** | `lw`, `lh`, `lb`, `lhu`, `lbu` |
| **Store** | `sw`, `sh`, `sb` |
| **Branch** | `beq`, `bne`, `blt`, `bge`, `bltu`, `bgeu` |
| **Jump** | `jal`, `jalr` |
| **Upper Imm.** | `lui`, `auipc` |

---

## Project Structure

```
risc-v-pipeline/
│
├── src/
│   ├── top.v                     # Top-level module
│   ├── fetch/
│   │   └── instruction_fetch.v
│   ├── decode/
│   │   ├── instruction_decode.v
│   │   └── register_file.v
│   ├── execute/
│   │   ├── alu.v
│   │   └── branch_unit.v
│   ├── memory/
│   │   └── data_memory.v
│   ├── writeback/
│   │   └── writeback.v
│   ├── hazard/
│   │   ├── hazard_detection_unit.v
│   │   └── forwarding_unit.v
│   └── pipeline_registers/
│       ├── if_id_reg.v
│       ├── id_ex_reg.v
│       ├── ex_mem_reg.v
│       └── mem_wb_reg.v
│
├── testbench/
│   ├── tb_top.v                  # Top-level testbench
│   ├── tb_alu.v
│   ├── tb_forwarding.v
│   └── tb_hazard.v
│
├── programs/
│   └── test_program.hex          # Sample instruction memory hex file
│
└── README.md
```

---

## Limitations & Future Work

| Feature | Status |
|---|---|
| RV32I Base ISA | ✅ Implemented |
| Data Hazard Forwarding | ✅ Implemented |
| Load-Use Stall | ✅ Implemented |
| Control Hazard (Branch Not Taken) | ✅ Implemented |
| Exception & Interrupt Handling | ❌ Not implemented |
| CSR Instructions | ❌ Not implemented |
| Dynamic Branch Prediction | ❌ Not implemented |
| RV32M (Multiply/Divide) | ❌ Not implemented |
| Cache Memory | ❌ Not implemented |

Exception and interrupt handling (trap mechanism, CSR registers, `mtvec`, `mepc`, `mcause`) are the primary planned additions for the next revision.

---

## License

This project is released under the [MIT License](LICENSE).