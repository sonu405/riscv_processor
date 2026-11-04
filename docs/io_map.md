# RISC-V Pipelined Processor Core — Complete Module I/O Map

> **Purpose:** Machine-readable, unambiguous listing of every module's ports (name, direction, width) plus its sub-module instantiations and how they connect. Designed so that any text-based AI can reconstruct a full Harris & Patterson–style block diagram.
>
> **Conventions:**
> - `IN`  = input,  `OUT` = output
> - Widths are in bits.  `1` means a single-bit logic signal.
> - Instance names match the RTL exactly.
> - Pipeline register structs (`IF_ID`, `ID_EX`, `EX_MEM`, `MEM_WB`) are defined in [pipeline_registers.sv](file:///home/sonu/proj_vivado/rvcore/rtl/pipeline_registers.sv) and are listed first.

---

## 0 — Pipeline Register Structs (package `pipeline_registers`)

These are **not** modules. They are `struct packed` types used as wires/registers inside [topmodule.sv](file:///home/sonu/proj_vivado/rvcore/rtl/topmodule.sv).

### IF_ID

| Field         | Width | Description                     |
|---------------|-------|---------------------------------|
| pc            | 32    | PC of fetched instruction       |
| instruction   | 32    | Fetched instruction word        |
| PCPlus4       | 32    | PC + 4                          |

### ID_EX

| Field              | Width | Description                          |
|--------------------|-------|--------------------------------------|
| Branch             | 1     | Branch control signal                |
| MemWrite           | 1     | Data-memory write enable             |
| MemRead            | 1     | Data-memory read enable              |
| RegWrite           | 1     | Register-file write enable           |
| ALUSrc             | 1     | ALU source select (reg vs imm)       |
| Jump               | 1     | Jump control signal                  |
| ResultSrc          | 2     | Writeback result mux select          |
| alu_control_lines  | 4     | ALU operation select                 |
| funct3             | 3     | Instruction funct3 field             |
| opcode             | 7     | Instruction opcode                   |
| funct7             | 7     | Instruction funct7 field             |
| rd                 | 5     | Destination register address         |
| rs1                | 5     | Source register 1 address            |
| rs2                | 5     | Source register 2 address            |
| data1              | 32    | Register file read data 1            |
| data2              | 32    | Register file read data 2            |
| extended_imm       | 32    | Sign-extended immediate              |
| PCPlus4            | 32    | PC + 4                               |
| pc                 | 32    | PC value                             |

### EX_MEM

| Field      | Width | Description                          |
|------------|-------|--------------------------------------|
| MemWrite   | 1     | Data-memory write enable             |
| MemRead    | 1     | Data-memory read enable              |
| RegWrite   | 1     | Register-file write enable           |
| ResultSrc  | 2     | Writeback result mux select          |
| funct3     | 3     | funct3 for memory byte/half/word     |
| rd         | 5     | Destination register address         |
| opcode     | 7     | Opcode (carried for hazard logic)    |
| funct7     | 7     | funct7 (carried for hazard logic)    |
| data2      | 32    | Store data / forwarded data          |
| alu_out    | 32    | ALU result / memory address          |
| PCPlus4    | 32    | PC + 4                               |

### MEM_WB

| Field      | Width | Description                          |
|------------|-------|--------------------------------------|
| RegWrite   | 1     | Register-file write enable           |
| ResultSrc  | 2     | Writeback result mux select          |
| rd         | 5     | Destination register address         |
| alu_out    | 32    | ALU result                           |
| RD         | 32    | Data-memory read data                |
| PCPlus4    | 32    | PC + 4                               |

---

## 1 — Top-Level: `topmodule`

**File:** [topmodule.sv](file:///home/sonu/proj_vivado/rvcore/rtl/topmodule.sv)

### Ports

| Port | Dir | Width | Description       |
|------|-----|-------|-------------------|
| clk  | IN  | 1     | System clock      |
| rst  | IN  | 1     | Active-high reset |

### Instantiated Sub-Modules

| Instance        | Module               | Purpose                                 |
|-----------------|----------------------|-----------------------------------------|
| uut_fetch       | Fetch                | Fetch stage                             |
| uut_hdu         | HazardDectectionUnit | Hazard detection / stall / flush        |
| uut_control_unit| control_logic        | Main control decoder                    |
| uut_alu_control | alu_control          | ALU operation decoder                   |
| uut_decode      | Decode               | Decode stage (reg file + imm gen)       |
| uut_fu_mux1     | fourby1mux           | Forward-unit mux for operand A          |
| uut_fu_mux2     | fourby1mux           | Forward-unit mux for operand B          |
| uut_execute     | Execute              | Execute stage                           |
| uut_memory      | Memory               | Memory stage                            |
| uut_writeback   | Writeback            | Writeback stage                         |

### Topmodule Wiring (instance → instance connections)

```
FETCH STAGE ─► IF_ID register ─► DECODE STAGE ─► ID_EX register ─► EXECUTE STAGE ─► EX_MEM register ─► MEMORY STAGE ─► MEM_WB register ─► WRITEBACK STAGE
```

#### uut_fetch (Fetch)
```
IN   clk             ← topmodule.clk
IN   rst             ← topmodule.rst
IN   PCWrite         ← uut_hdu.PCWrite
IN   Branch          ← BranchE             (= id_ex.Branch)
IN   ToBranch        ← uut_execute.ToBranch (= ToBranchE)
IN   Jump            ← JumpE               (= id_ex.Jump)
IN   PCTarget        ← uut_execute.PCTarget (= PCTargetE)
OUT  pc              → pcF                  → if_id.pc
OUT  instruction     → instructionF         → if_id.instruction
OUT  PCPlus4         → PCPlus4F             → if_id.PCPlus4
```

#### IF_ID Pipeline Register (always_ff in topmodule, lines 65-77)
```
Gated by:  IF_ID_Write (from uut_hdu)
Flushed by: IF_ID_flush (from uut_hdu) — inserts NOP (all zeros)
IN   pcF             → if_id.pc
IN   instructionF    → if_id.instruction
IN   PCPlus4F        → if_id.PCPlus4
```

#### uut_hdu (HazardDectectionUnit)
```
IN   ID_EX_MEMRead        ← id_ex.MemRead
IN   ID_EX_rd             ← id_ex.rd
IN   rs1D                 ← uut_decode.rs1
IN   rs2D                 ← uut_decode.rs2
IN   MemWriteD            ← uut_control_unit.MemWrite
IN   ID_EX_opcode         ← id_ex.opcode
IN   ID_EX_funct7         ← id_ex.funct7
IN   ToBranchE            ← uut_execute.ToBranch
IN   BranchE              ← id_ex.Branch
IN   JumpE                ← id_ex.Jump
IN   functional_unit_stall← uut_execute.functional_unit_stall
OUT  IF_ID_flush          → IF_ID register flush control
OUT  ID_EX_flush          → ID_EX register flush control
OUT  PCWrite              → uut_fetch.PCWrite
OUT  IF_ID_Write          → IF_ID register write-enable
OUT  StallD               → ID_EX register (insert bubble)
OUT  StallE               → EX_MEM register (insert bubble)
```

#### uut_control_unit (control_logic)
```
IN   opcode           ← opcodeD (= uut_decode.opcode)
OUT  Branch           → BranchD
OUT  MemRead          → MemReadD
OUT  MemWrite         → MemWriteD
OUT  ALUSrc           → ALUSrcD
OUT  RegWrite         → RegWriteD
OUT  ImmSrc           → ImmSrcD          → uut_decode.ImmSrc
OUT  Jump             → JumpD
OUT  ResultSrc        → ResultSrcD
OUT  ALUOp            → ALUOpD           → uut_alu_control.ALUOp
```

#### uut_alu_control (alu_control)
```
IN   ALUOp            ← ALUOpD  (from uut_control_unit)
IN   funct3           ← funct3D (from uut_decode)
IN   op5              ← opcodeD[5]
IN   funct7           ← funct7D[5]  (bit 5 of funct7)
OUT  alu_control_lines→ alu_control_linesD → id_ex.alu_control_lines
```

#### uut_decode (Decode)
```
IN   clk              ← topmodule.clk
IN   RegWrite         ← RegWriteW         (from writeback stage)
IN   ImmSrc           ← ImmSrcD           (from uut_control_unit)
IN   instruction      ← if_id.instruction
IN   rdWD             ← rdW               (= mem_wb.rd, from writeback)
IN   dataW            ← ResultW           (from uut_writeback)
OUT  opcode           → opcodeD
OUT  funct7           → funct7D
OUT  rd               → rdD
OUT  rs1              → rs1D
OUT  rs2              → rs2D
OUT  data1            → data1D
OUT  data2            → data2D
OUT  extended_imm     → extended_immD
OUT  funct3           → funct3D
```

#### ID_EX Pipeline Register (always_ff in topmodule, lines 149-188)
```
Gated by:  !StallE
Flushed by: StallD || ID_EX_flush — zeroes control signals, keeps datapath fields

Normal write:
  id_ex.Branch            ← BranchD
  id_ex.RegWrite          ← RegWriteD
  id_ex.MemWrite          ← MemWriteD
  id_ex.MemRead           ← MemReadD
  id_ex.ALUSrc            ← ALUSrcD
  id_ex.Jump              ← JumpD
  id_ex.ResultSrc         ← ResultSrcD
  id_ex.alu_control_lines ← alu_control_linesD
  id_ex.opcode            ← opcodeD
  id_ex.funct7            ← funct7D
  id_ex.funct3            ← funct3D
  id_ex.rs1               ← rs1D
  id_ex.rs2               ← rs2D
  id_ex.rd                ← rdD
  id_ex.data1             ← data1D
  id_ex.data2             ← data2D
  id_ex.extended_imm      ← extended_immD
  id_ex.PCPlus4           ← if_id.PCPlus4
  id_ex.pc                ← if_id.pc
```

#### uut_fu_mux1 (fourby1mux) — Forward Mux A
```
IN   in1   ← id_ex.data1       (no forwarding)
IN   in2   ← ResultW           (forward from WB)
IN   in3   ← ex_mem.alu_out    (forward from MEM)
IN   in4   ← 0                 (unused)
IN   BSel  ← ForwardA [1:0]    (from forwarding logic)
OUT  out   → FU_data1
```

#### uut_fu_mux2 (fourby1mux) — Forward Mux B
```
IN   in1   ← id_ex.data2       (no forwarding)
IN   in2   ← ResultW           (forward from WB)
IN   in3   ← ex_mem.alu_out    (forward from MEM)
IN   in4   ← 0                 (unused)
IN   BSel  ← ForwardB [1:0]    (from forwarding logic)
OUT  out   → FU_data2
```

#### Forwarding Unit (combinational logic in topmodule, lines 320-335)
```
IN   mem_wb.RegWrite, mem_wb.rd, id_ex.rs1, id_ex.rs2
IN   ex_mem.RegWrite, ex_mem.rd
OUT  ForwardA [1:0]   → uut_fu_mux1.BSel
OUT  ForwardB [1:0]   → uut_fu_mux2.BSel

Encoding:
  00 = no forward (use id_ex.data)
  01 = forward from WB  (ResultW)
  10 = forward from MEM (ex_mem.alu_out)
```

#### uut_execute (Execute)
```
IN   clk               ← topmodule.clk
IN   rst               ← topmodule.rst
IN   Jump              ← id_ex.Jump
IN   opcode3           ← id_ex.opcode[3]
IN   ALUSrc            ← id_ex.ALUSrc
IN   data1             ← FU_data1          (from uut_fu_mux1)
IN   data2             ← FU_data2          (from uut_fu_mux2)
IN   extended_imm      ← id_ex.extended_imm
IN   pc                ← id_ex.pc
IN   funct3            ← id_ex.funct3
IN   funct7            ← id_ex.funct7
IN   alu_control_lines ← id_ex.alu_control_lines
OUT  ToBranch          → ToBranchE
OUT  functional_unit_stall → functional_unit_stall (to uut_hdu)
OUT  execute_out       → alu_outE
OUT  PCTarget          → PCTargetE          (to uut_fetch)
```

#### EX_MEM Pipeline Register (always_ff in topmodule, lines 233-281)
```
Stall path (StallE=1): zeroes control signals, keeps funct3/rd/opcode/funct7
Normal path (StallE=0): propagates all signals

  ex_mem.MemWrite    ← id_ex.MemWrite
  ex_mem.MemRead     ← id_ex.MemRead
  ex_mem.RegWrite    ← id_ex.RegWrite
  ex_mem.ResultSrc   ← id_ex.ResultSrc
  ex_mem.funct3      ← id_ex.funct3
  ex_mem.rd          ← id_ex.rd
  ex_mem.opcode      ← id_ex.opcode
  ex_mem.funct7      ← ex_mem.funct7  (self-feedback, note: this is from the RTL)
  ex_mem.data2       ← FU_data2       (or RDM if store-after-load forward)
  ex_mem.alu_out     ← alu_outE
  ex_mem.PCPlus4     ← id_ex.PCPlus4

Special: Store-after-load forwarding:
  if (id_ex.MemWrite && ex_mem.MemRead && id_ex.rs2 == ex_mem.rd)
      ex_mem.data2 ← RDM   (data memory read output)
  else
      ex_mem.data2 ← FU_data2
```

#### uut_memory (Memory)
```
IN   clk       ← topmodule.clk
IN   MemWrite  ← ex_mem.MemWrite
IN   MemRead   ← ex_mem.MemRead
IN   funct3    ← ex_mem.funct3
IN   data2     ← ex_mem.data2
IN   mem_addr  ← ex_mem.alu_out
OUT  RD        → RDM
```

#### MEM_WB Pipeline Register (always_ff in topmodule, lines 294-305)
```
  mem_wb.RegWrite  ← ex_mem.RegWrite
  mem_wb.ResultSrc ← ex_mem.ResultSrc
  mem_wb.rd        ← ex_mem.rd
  mem_wb.alu_out   ← ex_mem.alu_out
  mem_wb.RD        ← RDM
  mem_wb.PCPlus4   ← ex_mem.PCPlus4
```

#### uut_writeback (Writeback)
```
IN   ResultSrc  ← mem_wb.ResultSrc
IN   alu_out    ← mem_wb.alu_out
IN   RD         ← mem_wb.RD
IN   PCPlus4    ← mem_wb.PCPlus4
OUT  Result     → ResultW → uut_decode.dataW (writeback to reg file)
                           → uut_fu_mux1.in2, uut_fu_mux2.in2 (forwarding)
```

#### Writeback-to-Decode feedback
```
rdW       = mem_wb.rd       → uut_decode.rdWD
RegWriteW = mem_wb.RegWrite → uut_decode.RegWrite
ResultW   = uut_writeback.Result → uut_decode.dataW
```

---

## 2 — Fetch Stage: `Fetch`

**File:** [Fetch.sv](file:///home/sonu/proj_vivado/rvcore/rtl/Fetch.sv)

### Ports

| Port        | Dir | Width | Description                                 |
|-------------|-----|-------|---------------------------------------------|
| clk         | IN  | 1     | Clock                                       |
| rst         | IN  | 1     | Reset                                       |
| Branch      | IN  | 1     | Branch signal from Execute                  |
| ToBranch    | IN  | 1     | Branch-taken decision from BranchUnit       |
| Jump        | IN  | 1     | Jump signal from Execute                    |
| PCWrite     | IN  | 1     | PC write enable (stall control)             |
| PCTarget    | IN  | 32    | Branch/jump target address                  |
| pc          | OUT | 32    | Current program counter                     |
| instruction | OUT | 32    | Fetched instruction word                    |
| PCPlus4     | OUT | 32    | PC + 4 (next sequential address)            |

### Sub-Modules

| Instance  | Module          | Connections                                                          |
|-----------|-----------------|----------------------------------------------------------------------|
| uut_mux3  | mux             | in1=PCPlus4, in2=PCTarget, BSel=(ToBranch & Branch)\|Jump, out=PCNext |
| pc_uut    | progcounter     | clk, rst, PCWrite, PCNext→PCNext, pc→pc                             |
| uut_add1  | adder           | in1=pc, in2=4, out=PCPlus4                                          |
| inst_uut  | instruction_mem | pc→pc, instruction→instruction                                      |

### Internal Signals

| Signal | Width | Description                   |
|--------|-------|-------------------------------|
| PCNext | 32    | Next PC value (mux output)    |

---

## 3 — Decode Stage: `Decode`

**File:** [Decode.sv](file:///home/sonu/proj_vivado/rvcore/rtl/Decode.sv)

### Ports

| Port          | Dir | Width | Description                                  |
|---------------|-----|-------|----------------------------------------------|
| clk           | IN  | 1     | Clock                                        |
| RegWrite      | IN  | 1     | Register write enable (from WB stage)        |
| ImmSrc        | IN  | 2     | Immediate type select                        |
| instruction   | IN  | 32    | Instruction word (from IF_ID register)       |
| dataW         | IN  | 32    | Write data for register file (from WB)       |
| rdWD          | IN  | 5     | Write-back destination register (from WB)    |
| opcode        | OUT | 7     | Decoded opcode field [6:0]                   |
| funct7        | OUT | 7     | Decoded funct7 field [31:25]                 |
| rd            | OUT | 5     | Destination register [11:7]                  |
| rs1           | OUT | 5     | Source register 1 [19:15]                    |
| rs2           | OUT | 5     | Source register 2 [24:20]                    |
| data1         | OUT | 32    | Register file read port 1                    |
| data2         | OUT | 32    | Register file read port 2                    |
| extended_imm  | OUT | 32    | Sign-extended immediate                      |
| funct3        | OUT | 3     | Decoded funct3 field [14:12]                 |

### Sub-Modules

| Instance       | Module        | Connections                                                                 |
|----------------|---------------|-----------------------------------------------------------------------------|
| uut_regfile    | reg_file      | RegWrite, clk, rsW=rdWD, rs1, rs2, dataW, out1→data1, out2→data2           |
| imm_gen_uut    | immediate_gen | instr=instruction, ImmSrc, out→extended_imm                                |

### Combinational Decode Logic
```
opcode = instruction[6:0]
funct3 = instruction[14:12]
funct7 = instruction[31:25]
rs1    = instruction[19:15]
rs2    = instruction[24:20]
rd     = instruction[11:7]   (forced to 0 for B-type=1100011 and S-type=0100011)
```

---

## 4 — Execute Stage: `Execute`

**File:** [Execute.sv](file:///home/sonu/proj_vivado/rvcore/rtl/Execute.sv)

### Ports

| Port                  | Dir | Width | Description                                |
|-----------------------|-----|-------|--------------------------------------------|
| clk                   | IN  | 1     | Clock                                      |
| rst                   | IN  | 1     | Reset                                      |
| Jump                  | IN  | 1     | Jump control signal                        |
| opcode3               | IN  | 1     | opcode[3] — distinguishes JAL from JALR    |
| ALUSrc                | IN  | 1     | ALU operand B select (reg vs imm)          |
| data1                 | IN  | 32    | Operand A (forwarded)                      |
| data2                 | IN  | 32    | Operand B (forwarded)                      |
| extended_imm          | IN  | 32    | Sign-extended immediate                    |
| pc                    | IN  | 32    | PC of current instruction                  |
| funct3                | IN  | 3     | funct3 field                               |
| funct7                | IN  | 7     | funct7 field (bit pattern)                 |
| alu_control_lines     | IN  | 4     | ALU operation select                       |
| ToBranch              | OUT | 1     | Branch-taken decision                      |
| functional_unit_stall | OUT | 1     | Stall pipeline for multi-cycle multiply    |
| execute_out           | OUT | 32    | Execute stage result (ALU or multiplier)   |
| PCTarget              | OUT | 32    | Computed branch/jump target address        |

### Sub-Modules

| Instance          | Module           | Connections                                                                           |
|-------------------|------------------|---------------------------------------------------------------------------------------|
| uut_mux4          | mux              | in1=pc, in2=data1, BSel=(Jump & ~opcode3), out=PCTargetAdderInput                     |
| uut_add2          | adder            | in1=extended_imm, in2=PCTargetAdderInput, out=PCTarget                                |
| uut_mux1          | mux              | in1=data2, in2=extended_imm, BSel=ALUSrc, out=mux_out                                 |
| uut_alu           | alu              | alu_control_lines, in1=data1, in2=mux_out, alu_out, ALUFlags                          |
| uut_branch        | BranchUnit       | ALUFlags, funct3, ToBranch                                                            |
| uut_multiplier    | multiplier_unit  | clk, rst, A=data1, B=data2, start=multiply_start, finish=multiply_finish, funct3, out=multiplier_out |
| uut_execute_mux   | mux              | in1=alu_out, in2=multiplier_out, BSel=execute_mux_sel, out=execute_out                |

### Internal Signals

| Signal                | Width | Description                                        |
|-----------------------|-------|----------------------------------------------------|
| PCTargetAdderInput    | 32    | pc (for B/JAL) or data1 (for JALR)                |
| mux_out               | 32    | ALU operand B after mux                            |
| ALUFlags              | 4     | {N, Z, C, V} from ALU                             |
| alu_out               | 32    | ALU result                                         |
| multiplier_out        | 32    | Multiplier result                                  |
| execute_mux_sel       | 1     | 1 if funct7==0000001 (M-extension), else 0         |
| multiply_start        | 1     | Start signal to booth multiplier                   |
| multiply_finish       | 1     | Done signal from booth multiplier                  |

### Multiplier Stall Logic
```
multiply_start = (funct7 == 7'b0000001) && !multiply_finish
functional_unit_stall = (multiply_start == 1) && (multiply_finish == 0)
```

---

## 5 — Memory Stage: `Memory`

**File:** [Memory.sv](file:///home/sonu/proj_vivado/rvcore/rtl/Memory.sv)

### Ports

| Port     | Dir | Width | Description                      |
|----------|-----|-------|----------------------------------|
| clk      | IN  | 1     | Clock                            |
| MemWrite | IN  | 1     | Memory write enable              |
| MemRead  | IN  | 1     | Memory read enable               |
| funct3   | IN  | 3     | Byte/halfword/word select        |
| data2    | IN  | 32    | Write data (store data)          |
| mem_addr | IN  | 32    | Memory address (ALU result)      |
| RD       | OUT | 32    | Read data from data memory       |

### Sub-Modules

| Instance      | Module     | Connections                                                                |
|---------------|------------|----------------------------------------------------------------------------|
| uut_datamem   | datamemory | clk, MEMWrite=MemWrite, MEMRead=MemRead, mem_addr, WD=data2, funct3, RD   |

---

## 6 — Writeback Stage: `Writeback`

**File:** [Writeback.sv](file:///home/sonu/proj_vivado/rvcore/rtl/Writeback.sv)

### Ports

| Port      | Dir | Width | Description                          |
|-----------|-----|-------|--------------------------------------|
| ResultSrc | IN  | 2     | Writeback source select              |
| alu_out   | IN  | 32    | ALU result                           |
| RD        | IN  | 32    | Data memory read data                |
| PCPlus4   | IN  | 32    | PC + 4                               |
| Result    | OUT | 32    | Selected writeback value             |

### Sub-Modules

| Instance         | Module     | Connections                                                        |
|------------------|------------|--------------------------------------------------------------------|
| uut_fourby1mux   | fourby1mux | in1=alu_out, in2=RD, in3=PCPlus4, in4=0, BSel=ResultSrc, out=Result |

### ResultSrc Encoding
```
00 = alu_out       (R-type, I-type arithmetic)
01 = RD            (Load instructions)
10 = PCPlus4       (JAL / JALR — link return address)
11 = 0             (reserved / unused)
```

---

## 7 — Control Logic: `control_logic`

**File:** [control_logic.sv](file:///home/sonu/proj_vivado/rvcore/rtl/control_logic.sv)

### Ports

| Port      | Dir | Width | Description                          |
|-----------|-----|-------|--------------------------------------|
| opcode    | IN  | 7     | Instruction opcode                   |
| Branch    | OUT | 1     | Branch instruction flag              |
| MemRead   | OUT | 1     | Data memory read enable              |
| MemWrite  | OUT | 1     | Data memory write enable             |
| ALUSrc    | OUT | 1     | ALU source select (0=reg, 1=imm)    |
| RegWrite  | OUT | 1     | Register write enable                |
| Jump      | OUT | 1     | Jump instruction flag                |
| ALUOp     | OUT | 2     | ALU operation type                   |
| ImmSrc    | OUT | 2     | Immediate format select              |
| ResultSrc | OUT | 2     | Writeback source select              |

### Control Signal Truth Table

| opcode    | Type    | RegWrite | ALUSrc | MemRead | MemWrite | Branch | ALUOp | ImmSrc | ResultSrc | Jump |
|-----------|---------|----------|--------|---------|----------|--------|-------|--------|-----------|------|
| 0110011   | R-type  | 1        | 0      | 0       | 0        | 0      | 10    | xx     | 00        | 0    |
| 0010011   | I-arith | 1        | 1      | 0       | 0        | 0      | 10    | 00     | 00        | 0    |
| 0000011   | I-load  | 1        | 1      | 1       | 0        | 0      | 00    | 00     | 01        | 0    |
| 1100111   | I-JALR  | 1        | 1      | 0       | 0        | 0      | 00    | 00     | 10        | 1    |
| 0100011   | S-type  | 0        | 1      | 0       | 1        | 0      | 00    | 01     | 00        | 0    |
| 1100011   | B-type  | 0        | 0      | 0       | 0        | 1      | 01    | 10     | 00        | 0    |
| 1101111   | J-JAL   | 1        | 0      | 0       | 0        | 0      | 00    | 11     | 10        | 1    |

---

## 8 — ALU Control: `alu_control`

**File:** [alu_control.sv](file:///home/sonu/proj_vivado/rvcore/rtl/alu_control.sv)

### Ports

| Port               | Dir | Width | Description                              |
|--------------------|-----|-------|------------------------------------------|
| ALUOp              | IN  | 2     | ALU operation type from control_logic    |
| funct3             | IN  | 3     | funct3 field                             |
| op5                | IN  | 1     | opcode[5]                                |
| funct7             | IN  | 1     | funct7 bit 5                             |
| alu_control_lines  | OUT | 4     | ALU operation code                       |

### Decoding Truth Table

| ALUOp | funct3 | {op5,funct7} | alu_control_lines | Operation |
|-------|--------|--------------|-------------------|-----------|
| 00    | x      | x            | 0010              | ADD       |
| 01    | x      | x            | 0110              | SUB       |
| 10    | 000    | 11           | 0110              | SUB       |
| 10    | 000    | other        | 0010              | ADD       |
| 10    | 110    | x            | 0001              | OR        |
| 10    | 111    | x            | 0000              | AND       |

---

## 9 — ALU: `alu`

**File:** [alu.sv](file:///home/sonu/proj_vivado/rvcore/rtl/alu.sv)

### Ports

| Port               | Dir | Width | Description                |
|--------------------|-----|-------|----------------------------|
| alu_control_lines  | IN  | 4     | Operation select           |
| in1                | IN  | 32    | Operand A                  |
| in2                | IN  | 32    | Operand B                  |
| alu_out            | OUT | 32    | Result                     |
| ALUFlags           | OUT | 4     | {V, Z, C, N} status flags  |

### Operations

| alu_control_lines | Operation         |
|-------------------|-------------------|
| 0000              | AND (in1 & in2)   |
| 0001              | OR  (in1 \| in2)  |
| 0010              | ADD (in1 + in2)   |
| 0110              | SUB (in1 - in2)   |

### Flag Encoding (ALUFlags[3:0])

| Bit | Index | Name     | Meaning                                     |
|-----|-------|----------|---------------------------------------------|
| 3   | [3]   | N        | Negative (MSB of result)                    |
| 2   | [2]   | Z        | Zero (result == 0)                          |
| 1   | [1]   | C        | Carry out (add) / ~Borrow (sub)             |
| 0   | [0]   | V        | Signed overflow                             |

---

## 10 — Branch Unit: `BranchUnit`

**File:** [BranchUnit.sv](file:///home/sonu/proj_vivado/rvcore/rtl/BranchUnit.sv)

### Ports

| Port      | Dir | Width | Description                      |
|-----------|-----|-------|----------------------------------|
| ALUFlags  | IN  | 4     | {N, Z, C, V} from ALU           |
| funct3    | IN  | 3     | Branch type select               |
| ToBranch  | OUT | 1     | 1 if branch should be taken      |

### Branch Decisions

| funct3 | Instruction | Condition             |
|--------|-------------|-----------------------|
| 000    | BEQ         | Z == 1                |
| 001    | BNE         | Z == 0                |
| 100    | BLT         | N ⊕ V (signed)       |
| 101    | BGE         | ¬(N ⊕ V) (signed)   |
| 110    | BLTU        | ¬C (unsigned)        |
| 111    | BGEU        | C (unsigned)          |

---

## 11 — Hazard Detection Unit: `HazardDectectionUnit`

**File:** [HazardDectectionUnit.sv](file:///home/sonu/proj_vivado/rvcore/rtl/HazardDectectionUnit.sv)

### Ports

| Port                  | Dir | Width | Description                                           |
|-----------------------|-----|-------|-------------------------------------------------------|
| ID_EX_MEMRead         | IN  | 1     | Previous instruction is a load                        |
| ID_EX_rd              | IN  | 5     | Previous instruction destination register             |
| rs1D                  | IN  | 5     | Current instruction source register 1                 |
| rs2D                  | IN  | 5     | Current instruction source register 2                 |
| MemWriteD             | IN  | 1     | Current instruction is a store (exempts stall)        |
| ID_EX_opcode          | IN  | 7     | Previous instruction opcode                           |
| ID_EX_funct7          | IN  | 7     | Previous instruction funct7 (not used in logic but connected) |
| ToBranchE             | IN  | 1     | Branch taken signal from BranchUnit                   |
| BranchE               | IN  | 1     | Branch control from ID_EX                             |
| JumpE                 | IN  | 1     | Jump control from ID_EX                               |
| functional_unit_stall | IN  | 1     | Multi-cycle unit (multiplier) is busy                 |
| PCWrite               | OUT | 1     | Enable PC update (0 = stall PC)                       |
| IF_ID_Write           | OUT | 1     | Enable IF_ID register write (0 = stall fetch)         |
| StallE                | OUT | 1     | Stall execute stage (for functional unit stall)       |
| IF_ID_flush           | OUT | 1     | Flush IF_ID register (branch/jump taken)              |
| ID_EX_flush           | OUT | 1     | Flush ID_EX register (branch/jump taken)              |
| StallD                | OUT | 1     | Stall decode stage (load-use hazard bubble)           |

### Stall Conditions
```
Load-use hazard:
  IF (ID_EX_MEMRead && !MemWriteD && (rs1D == ID_EX_rd || rs2D == ID_EX_rd))
  THEN PCWrite=0, IF_ID_Write=0, StallD=1, StallE=0

Functional unit stall (multiplier busy):
  IF (functional_unit_stall)
  THEN PCWrite=0, IF_ID_Write=0, StallE=1, StallD=0

No hazard:
  PCWrite=1, IF_ID_Write=1, StallE=0, StallD=0
```

### Flush Conditions
```
Branch taken or Jump:
  IF ((BranchE && ToBranchE) || JumpE)
  THEN IF_ID_flush=1, ID_EX_flush=1
  ELSE IF_ID_flush=0, ID_EX_flush=0
```

---

## 12 — Program Counter: `progcounter`

**File:** [progcounter.sv](file:///home/sonu/proj_vivado/rvcore/rtl/progcounter.sv)

### Ports

| Port    | Dir | Width | Description                       |
|---------|-----|-------|-----------------------------------|
| clk     | IN  | 1     | Clock                             |
| rst     | IN  | 1     | Reset (async, active high)        |
| PCWrite | IN  | 1     | Write enable (0 = hold PC)        |
| PCNext  | IN  | 32    | Next PC value                     |
| pc      | OUT | 32    | Current PC (0 on reset)           |

---

## 13 — 2:1 Multiplexer: `mux`

**File:** [mux.sv](file:///home/sonu/proj_vivado/rvcore/rtl/mux.sv)

### Ports

| Port | Dir | Width | Description                     |
|------|-----|-------|---------------------------------|
| in1  | IN  | 32    | Input 0 (selected when BSel=0)  |
| in2  | IN  | 32    | Input 1 (selected when BSel=1)  |
| BSel | IN  | 1     | Select                          |
| out  | OUT | 32    | Output                          |

---

## 14 — 4:1 Multiplexer: `fourby1mux`

**File:** [fourby1mux.sv](file:///home/sonu/proj_vivado/rvcore/rtl/fourby1mux.sv)

### Ports

| Port | Dir | Width | Description                     |
|------|-----|-------|---------------------------------|
| in1  | IN  | 32    | Input 0 (BSel=00)              |
| in2  | IN  | 32    | Input 1 (BSel=01)              |
| in3  | IN  | 32    | Input 2 (BSel=10)              |
| in4  | IN  | 32    | Input 3 (BSel=11)              |
| BSel | IN  | 2     | Select                          |
| out  | OUT | 32    | Output                          |

---

## 15 — Adder: `adder`

**File:** [adder.sv](file:///home/sonu/proj_vivado/rvcore/rtl/adder.sv)

### Ports

| Port | Dir | Width | Description     |
|------|-----|-------|-----------------|
| in1  | IN  | 32    | Operand A       |
| in2  | IN  | 32    | Operand B       |
| out  | OUT | 32    | in1 + in2       |

---

## 16 — Register File: `reg_file`

**File:** [reg_file.sv](file:///home/sonu/proj_vivado/rvcore/rtl/reg_file.sv)

### Ports

| Port     | Dir | Width | Description                              |
|----------|-----|-------|------------------------------------------|
| clk      | IN  | 1     | Clock (write on posedge)                 |
| RegWrite | IN  | 1     | Write enable                             |
| rsW      | IN  | 5     | Write register address                   |
| rs1      | IN  | 5     | Read register 1 address                  |
| rs2      | IN  | 5     | Read register 2 address                  |
| dataW    | IN  | 32    | Write data                               |
| out1     | OUT | 32    | Read data 1                              |
| out2     | OUT | 32    | Read data 2                              |

### Internal Storage
```
REG_FILE[31:0] — 32 registers × 32 bits, initialized from reg_file.mem
x0 hardwired: writes to rsW==0 are ignored; reads bypass if rsW==rs1 or rsW==rs2 (write-first forwarding)
```

---

## 17 — Immediate Generator: `immediate_gen`

**File:** [immediate_gen.sv](file:///home/sonu/proj_vivado/rvcore/rtl/immediate_gen.sv)

### Ports

| Port   | Dir | Width | Description                     |
|--------|-----|-------|---------------------------------|
| instr  | IN  | 32    | Full instruction word           |
| ImmSrc | IN  | 2     | Immediate format select         |
| out    | OUT | 32    | Sign-extended immediate         |

### Immediate Formats

| ImmSrc | Type   | Bit Extraction                                                   |
|--------|--------|------------------------------------------------------------------|
| 00     | I-type | `{{20{instr[31]}}, instr[31:20]}`                                |
| 01     | S-type | `{{20{instr[31]}}, instr[31:25], instr[11:7]}`                   |
| 10     | B-type | `{{19{instr[31]}}, instr[31], instr[7], instr[30:25], instr[11:8], 1'b0}` |
| 11     | J-type | `{{12{instr[31]}}, instr[19:12], instr[20], instr[30:21], 1'b0}` |

---

## 18 — Instruction Memory: `instruction_mem`

**File:** [instruction_mem.sv](file:///home/sonu/proj_vivado/rvcore/rtl/instruction_mem.sv)

### Ports

| Port        | Dir | Width | Description                         |
|-------------|-----|-------|-------------------------------------|
| pc          | IN  | 32    | Byte address                        |
| instruction | OUT | 32    | 32-bit instruction (little-endian)  |

### Internal Storage
```
INST_MEM[1023:0] — 1024 bytes (1 KB), initialized from instruction_mem.mem
Byte-addressed, little-endian assembly:
  instruction = {INST_MEM[pc+3], INST_MEM[pc+2], INST_MEM[pc+1], INST_MEM[pc]}
```

---

## 19 — Data Memory: `datamemory`

**File:** [datamemory.sv](file:///home/sonu/proj_vivado/rvcore/rtl/datamemory.sv)

### Ports

| Port     | Dir | Width | Description                             |
|----------|-----|-------|-----------------------------------------|
| clk      | IN  | 1     | Clock (writes on posedge)               |
| MEMWrite | IN  | 1     | Write enable                            |
| MEMRead  | IN  | 1     | Read enable                             |
| mem_addr | IN  | 32    | Byte address                            |
| WD       | IN  | 32    | Write data                              |
| funct3   | IN  | 3     | Access width select                     |
| RD       | OUT | 32    | Read data                               |

### Internal Storage
```
MEM[0:1001] — 1002 bytes, initialized from datamemory.mem
```

### Read Operations (combinational, gated by MEMRead)

| funct3 | Instruction | Operation                                  |
|--------|-------------|--------------------------------------------|
| 000    | LB          | Sign-extend byte                           |
| 001    | LH          | Sign-extend halfword (little-endian)       |
| 010    | LW          | Load word (little-endian)                  |
| 100    | LBU         | Zero-extend byte                           |
| 101    | LHU         | Zero-extend halfword (little-endian)       |

### Write Operations (sequential on posedge clk, gated by MEMWrite)

| funct3 | Instruction | Operation                                  |
|--------|-------------|--------------------------------------------|
| 000    | SB          | Store byte                                 |
| 001    | SH          | Store halfword (little-endian)             |
| 010    | SW          | Store word (little-endian)                 |

---

## 20 — Multiplier Unit: `multiplier_unit`

**File:** [multiplier_unit.sv](file:///home/sonu/proj_vivado/rvcore/rtl/multiplier_unit.sv)

### Ports

| Port   | Dir | Width | Description                          |
|--------|-----|-------|--------------------------------------|
| clk    | IN  | 1     | Clock                                |
| rst    | IN  | 1     | Reset                                |
| start  | IN  | 1     | Start multiplication                 |
| A      | IN  | 32    | Multiplicand (data1)                 |
| B      | IN  | 32    | Multiplier (data2)                   |
| funct3 | IN  | 3     | Multiply variant select              |
| finish | OUT | 1     | Multiplication complete              |
| out    | OUT | 32    | 32-bit result (selected half)        |

### Sub-Modules

| Instance  | Module            | Connections                                                    |
|-----------|-------------------|----------------------------------------------------------------|
| uut_booth | booth_multiplier  | clk, rst, start, sign, Q=A, M=B, finish, out=booth_out[63:0]  |

### Internal Signals

| Signal    | Width | Description                  |
|-----------|-------|------------------------------|
| sign      | 1     | 1=signed, 0=unsigned         |
| booth_out | 64    | Full 64-bit product          |

### funct3 Encoding

| funct3 | Instruction | sign | Result Selection   |
|--------|-------------|------|--------------------|
| 000    | MUL         | 1    | booth_out[31:0]    |
| 001    | MULH        | 1    | booth_out[63:32]   |
| 010    | MULHSU      | 0    | booth_out[63:32]   |
| 011    | MULHU       | 0    | booth_out[63:32]   |

---

## 21 — Booth Multiplier: `booth_multiplier`

**File:** [booth_multiplier.sv](file:///home/sonu/proj_vivado/rvcore/rtl/booth_multiplier.sv)

### Parameters

| Parameter | Default | Description         |
|-----------|---------|---------------------|
| n         | 32      | Operand bit width   |

### Ports

| Port   | Dir | Width  | Description                           |
|--------|-----|--------|---------------------------------------|
| clk    | IN  | 1      | Clock                                 |
| rst    | IN  | 1      | Reset (async, active high)            |
| start  | IN  | 1      | Begin multiplication                  |
| sign   | IN  | 1      | 1=signed, 0=unsigned                  |
| Q      | IN  | n (32) | Multiplicand (signed)                 |
| M      | IN  | n (32) | Multiplier (signed)                   |
| finish | OUT | 1      | Done flag                             |
| out    | OUT | 2n (64)| Full product                          |

### Internal Signals

| Signal   | Width   | Description                                |
|----------|---------|--------------------------------------------|
| AQ_reg   | 2n+3    | Accumulator-Q register for signed path     |
| CAQ_reg  | 2n+3    | Accumulator-Q register for unsigned path   |
| Q_us     | n+1     | Zero-extended Q (unsigned)                 |
| M_us     | n+1     | Zero-extended M (unsigned)                 |
| M_us_bar | n+1     | Two's complement of M_us                   |
| Q_s      | n+1     | Sign-extended Q (signed)                   |
| M_s      | n+1     | Sign-extended M (signed)                   |
| M_s_bar  | n+1     | Two's complement of M_s                    |
| counter  | n (32)  | Iteration counter                          |
| busy     | 1       | Multiplication in progress                 |

### Algorithm
```
Radix-2 Booth's algorithm. Takes n+2 clock cycles (34 for n=32).
  - On start: latch operands, initialize AQ_reg or CAQ_reg with {0..0, Q, 0}
  - Each cycle: inspect bits [1:0], add/subtract M, arithmetic-shift-right
  - On counter == n+1: output = AQ_reg[2n:1] or CAQ_reg[2n:1], finish=1
```

---

## 22 — Full Hierarchy Tree

```
topmodule
├── uut_fetch : Fetch
│   ├── uut_mux3  : mux              (PC select: PCPlus4 vs PCTarget)
│   ├── pc_uut    : progcounter       (Program Counter register)
│   ├── uut_add1  : adder             (PC + 4)
│   └── inst_uut  : instruction_mem   (Instruction Memory, 1KB)
│
├── [IF_ID pipeline register]         (in topmodule always_ff)
│
├── uut_hdu          : HazardDectectionUnit  (Stall + Flush control)
├── uut_control_unit : control_logic         (Main Decoder)
├── uut_alu_control  : alu_control           (ALU Decoder)
├── uut_decode       : Decode
│   ├── uut_regfile  : reg_file              (32×32-bit Register File)
│   └── imm_gen_uut  : immediate_gen         (Immediate Generator)
│
├── [ID_EX pipeline register]         (in topmodule always_ff)
│
├── uut_fu_mux1 : fourby1mux          (Forwarding Mux A)
├── uut_fu_mux2 : fourby1mux          (Forwarding Mux B)
├── [Forwarding Unit]                  (combinational in topmodule)
├── uut_execute : Execute
│   ├── uut_mux4         : mux              (PC vs rs1 for target calc)
│   ├── uut_add2         : adder            (Target address adder)
│   ├── uut_mux1         : mux              (ALU src: data2 vs imm)
│   ├── uut_alu          : alu              (Arithmetic Logic Unit)
│   ├── uut_branch       : BranchUnit       (Branch condition evaluator)
│   ├── uut_multiplier   : multiplier_unit  (M-extension multiplier)
│   │   └── uut_booth    : booth_multiplier (Radix-2 Booth algorithm)
│   └── uut_execute_mux  : mux              (ALU vs Multiplier result)
│
├── [EX_MEM pipeline register]        (in topmodule always_ff)
│
├── uut_memory : Memory
│   └── uut_datamem : datamemory       (Data Memory, ~1KB)
│
├── [MEM_WB pipeline register]        (in topmodule always_ff)
│
└── uut_writeback : Writeback
    └── uut_fourby1mux : fourby1mux    (Result source mux)
```

---

## 23 — Global Signal Flow Summary

```
                    ┌─────────────────────────────────────────────────────────────┐
                    │                     HAZARD DETECTION UNIT                    │
                    │  Stalls: PCWrite, IF_ID_Write, StallD, StallE               │
                    │  Flushes: IF_ID_flush, ID_EX_flush                          │
                    └────────┬──────────────────────────────┬─────────────────────┘
                             │                              │
   ┌─────────┐   ┌──────────▼──┐   ┌───────────┐   ┌──────▼──────┐   ┌──────────┐   ┌───────────┐   ┌───────────┐   ┌──────────┐
   │  FETCH  │──►│   IF_ID     │──►│  DECODE   │──►│   ID_EX     │──►│ EXECUTE  │──►│  EX_MEM   │──►│  MEMORY   │──►│  MEM_WB  │──►┌──────────┐
   │         │   │  register   │   │           │   │  register   │   │          │   │ register  │   │           │   │ register │   │WRITEBACK │
   └────▲────┘   └─────────────┘   └─────▲─────┘   └─────────────┘   └──────────┘   └───────────┘   └───────────┘   └──────────┘   └────┬─────┘
        │                                │                                                                                              │
        │                                │              FORWARDING UNIT (combinational)                                                 │
        │                                │         ForwardA ← ex_mem / mem_wb comparison                                                │
        │                                │         ForwardB ← ex_mem / mem_wb comparison                                                │
        │                                │                                                                                              │
        │                                └──────────────────────────────────────────────────────────────────────────────────────────────────┘
        │                                           ResultW, rdW, RegWriteW (writeback → decode)
        │
        └── PCTarget, ToBranch & Branch, Jump (execute → fetch for branch/jump redirect)
```
