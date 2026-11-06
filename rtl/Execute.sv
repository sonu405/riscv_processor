`timescale 1ns / 1ps

module Execute (
    input logic Jump,
    input logic [6:0] opcode,
    input logic ALUSrc,
    input logic clk,
    input logic rst,
    input logic [31:0] data1,
    input logic [31:0] data2,
    input logic [31:0] extended_imm,
    input logic [31:0] pc,
    input logic [6:0] funct7,
    input logic [2:0] funct3,
    input logic [3:0] alu_control_lines,
    output logic ToBranch,
    output logic functional_unit_stall,
    output logic [31:0] execute_out,
    output logic [31:0] PCTarget
);

  logic [31:0] PCTargetAdderInput, mux_out;
  logic [3:0] ALUFlags;  // N, Z, C, V
  logic [31:0] alu_out, multiplier_out;
  logic execute_mux_sel, multiply_start, multiply_finish;

  // ADRESS CALCULATING UNIT
  // deciding either to do PC + imm or data1 + imm.
  // data1 comes from register file. Note that, we only select data1 for jalr instruction.
  // Note: opcode3 means opcode[3]
  mux uut_mux4 (
      .in1 (pc),
      .in2 (data1),
      .BSel(Jump & (~opcode[3])),
      .out (PCTargetAdderInput)
  );

  // calculating PCTarget for jalr, jalr and branch
  adder uut_add2 (
      .in1(extended_imm),
      .in2(PCTargetAdderInput),
      .out(PCTarget)
  );  // calculates PCTarget for B and J type instructions

  // ARITHMETIC UNIT
  mux uut_mux1 (
      .in1 (data2),
      .in2 (extended_imm),
      .BSel(ALUSrc),
      .out (mux_out)
  );

  alu uut_alu (
      .alu_control_lines(alu_control_lines),
      .in1(data1),
      .in2(mux_out),
      .alu_out(alu_out),
      .ALUFlags(ALUFlags)
  );

  // BRANCH UNIT
  BranchUnit uut_branch (
      .ALUFlags(ALUFlags),
      .funct3  (funct3),
      .ToBranch(ToBranch)
  );


  // MULTIPLIER UNIT
  multiplier_unit uut_multiplier (
      .clk(clk),
      .rst(rst),
      .A(data1),
      .B(data2),
      .start(multiply_start),
      .finish(multiply_finish),
      .funct3(funct3),
      .out(multiplier_out)
  );

  // MUX Choosing between alu_out and Multiplier out

  logic is_mul;
  assign is_mul = (opcode == 7'b0110011) && (funct7 == 7'b0000001);

  always_comb begin
    // controlling the mux
    execute_mux_sel = is_mul;

    multiply_start  = is_mul && ~multiply_finish;
  end
  mux uut_execute_mux (
      .in1 (alu_out),
      .in2 (multiplier_out),
      .BSel(execute_mux_sel),
      .out (execute_out)
  );

  always_comb begin
    // setting the output signal: functional_unit_stall
    if (multiply_start == 1'b1 && multiply_finish == 1'b0) functional_unit_stall = 1'b1;
    //    else if (multiply_start == 1'b1 && multiply_finish == 1'b1) functional_unit_stall = 1'b0;
    else
      functional_unit_stall = 1'b0;
  end
endmodule
