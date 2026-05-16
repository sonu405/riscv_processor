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
- [RV32M — Booth Multiplier](#rv32m--booth-multiplier)
- [Supported Instructions](#supported-instructions)
- [Project Structure](#project-structure)
- [Getting Started](#getting-started)
- [Limitations & Future Work](#limitations--future-work)

---

## Overview

This project implements a classic 5-stage RISC-V pipeline capable of executing RV32I base integer instructions, with partial support for the RV32M multiplication extension. The primary focus of this implementation is correctness under all pipeline hazard conditions — every RAW (Read After Write) data dependency and control flow dependency is resolved, ensuring the processor produces architecturally correct results across all instruction sequences.

**Key highlights:**
- Full RV32I instruction support
- Partial RV32M support — `mul` instruction via a 32-bit Booth multiplier
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

## RV32M — Booth Multiplier

This implementation includes partial support for the RISC-V **M extension**, covering the `mul` instruction. The multiplier is implemented as a dedicated **32-bit Radix-2 Booth multiplier** operating alongside the main pipeline.

### How Booth Multiplication Works Here

Booth's algorithm recodes the multiplier into a signed digit representation, reducing the number of partial products that need to be summed. For a 32-bit operand, this means up to 16 partial products instead of 32, with each partial product being either `0`, `+multiplicand`, or `-multiplicand`.

The 32-bit result (lower 32 bits of the 64-bit product) is written back to the destination register via the normal WB stage.

### Pipeline Integration

Since multiplication takes multiple cycles, the pipeline **stalls** while the Booth multiplier completes. The hazard detection unit recognizes a `mul` instruction and holds the pipeline until the result is ready, at which point execution resumes normally.

> **Note:** Only `mul` (lower 32 bits of the product) is implemented. `mulh`, `mulhu`, `mulhsu`, `div`, `divu`, `rem`, and `remu` are not yet supported.

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
| **RV32M (partial)** | `mul` (32-bit Booth multiplier) |

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
| RV32M — `mul` (Booth Multiplier) | ✅ Implemented |
| RV32M — `mulh`, `div`, `rem`, etc. | ❌ Not implemented |
| Cache Memory | ❌ Not implemented |

Exception and interrupt handling (trap mechanism, CSR registers, `mtvec`, `mepc`, `mcause`) are the primary planned additions for the next revision.

---

## License

This project is released under the [MIT License](LICENSE).