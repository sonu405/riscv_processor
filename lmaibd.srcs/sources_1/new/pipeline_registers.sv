
package pipeline_registers;

    typedef struct packed {
        logic [31:0] pc;
        logic [31:0] instruction;
        logic [31:0] PCPlus4;
    }IF_ID;

    typedef struct packed {
        logic Branch, MemWrite, MemRead, RegWrite, ALUSrc, Jump;
        logic [1:0] ResultSrc;
        logic [3:0] alu_control_lines;
        logic [2:0] funct3;
        logic [6:0] opcode, funct7;
        logic [4:0] rd, rs1, rs2;
        logic [31:0] data1, data2, extended_imm, PCPlus4, pc;
    } ID_EX;

    typedef struct packed {
        logic MemWrite, MemRead, RegWrite;
        logic [1:0] ResultSrc;
        logic [2:0] funct3;
        logic [4:0] rd;
        logic [6:0] opcode, funct7;
        logic [31:0] data2, alu_out, PCPlus4;
    } EX_MEM;

    typedef struct packed{
        logic RegWrite;
        logic [1:0] ResultSrc;
        logic [4:0] rd;
        logic [31:0] alu_out, RD, PCPlus4;
    } MEM_WB;
endpackage
