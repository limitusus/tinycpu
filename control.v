// Control
// Instruction to ALUOp
// control.v
`include "config.v"

module control(op, RegDst, Branch, MemtoReg, ALUOp, MemWrite, ALUSrc, RegWrite,
               dmem_mode, Jump, clock_counter, clock, RegDst_r31, PCrs);
   input [(6-1):0] op;
   input [2-1:0]   clock_counter;
   input           clock;
   output reg      RegDst; // 1 if register's destination is rd(not rt)
   output reg      Branch; // 1 if branch instruction
   output reg      MemtoReg; // 1 if instruction which read memory and write to register
   output reg [(`ALUOP_WIDTH-1):0] ALUOp;
   output reg                      MemWrite; // 1 if memory-destination-instruction's 3rd posclk
   output reg                      ALUSrc; // 1 if ALU's source is immediate/displacement
   output reg                      RegWrite; // 1 if register-destination-instruction's 4th posclk
   output reg                      Jump; // 1 if Jump instruction
   output reg                      RegDst_r31; // 1 if Register destination is r31
   output reg [2-1:0]              dmem_mode; // Memory Write mode(See data_mem.v)
   output reg                      PCrs; // 1 if PC's destination is rs
   // Periodic reg
   reg                             RegWriteEnable;
   reg                             MemWriteEnable;
   
   always @(op or clock or clock_counter)
     begin
        RegWriteEnable = clock_counter == 2'b00 ? 1'b1 : 1'b0;
        MemWriteEnable = clock_counter == 2'b11 ? 1'b1 : 1'b0;
        dmem_mode = 2'b11; // init
        Jump = 1'b0;
        RegDst_r31 = 0;
        PCrs = 0;
        case (op)
          `NM_ADD, `NM_SUB, `NM_AND, `NM_OR, `NM_XOR, `NM_NOR,
          `NM_SLL, `NM_SRL, `NM_SRA, `NM_MUL, `NM_DIV:
            /* op is same: If shift operation, ALUSrc must be 1,
             * which is resolved in CPU.v by using XOR operation
             * with ALUSrc from alu_control watching aux[10:6] */
            begin
               RegDst = 1;
               Branch = 0;
               MemtoReg = 0;
               MemWrite = 0;
               ALUSrc = 0;
               RegWrite = 1'b1 & RegWriteEnable;
            end
          `NM_ADDI :
            begin
               RegDst = 0;
               Branch = 0;
               MemtoReg = 0;
               MemWrite = 0;
               ALUSrc = 1;
               RegWrite = 1'b1 & RegWriteEnable;
            end
          `NM_MULI :
            begin
               RegDst = 0;
               Branch = 0;
               MemtoReg = 0;
               MemWrite = 0;
               ALUSrc = 1;
               RegWrite = 1'b1 & RegWriteEnable;
            end
          `NM_DIVI :
            begin
               RegDst = 0;
               Branch = 0;
               MemtoReg = 0;
               MemWrite = 0;
               ALUSrc = 1;
               RegWrite = 1'b1 & RegWriteEnable;
            end
          `NM_LUI :
            begin
               RegDst = 0;
               Branch = 0;
               MemtoReg = 0;
               MemWrite = 0;
               ALUSrc = 1;
               RegWrite = 1'b1 & RegWriteEnable;
            end
          `NM_ANDI :
            begin
               RegDst = 0;
               Branch = 0;
               MemtoReg = 0;
               MemWrite = 0;
               ALUSrc = 1;
               RegWrite = 1'b1 & RegWriteEnable;
            end
          `NM_ORI :
            begin
               RegDst = 0;
               Branch = 0;
               MemtoReg = 0;
               MemWrite = 0;
               ALUSrc = 1;
               RegWrite = 1'b1 & RegWriteEnable;
            end
          `NM_XORI :
            begin
               RegDst = 0;
               Branch = 0;
               MemtoReg = 0;
               MemWrite = 0;
               ALUSrc = 1;
               RegWrite = 1'b1 & RegWriteEnable;
            end
          `NM_LW :
            begin
               RegDst = 0;
               Branch = 0;
               MemtoReg = 1;
               MemWrite = 0;
               ALUSrc = 1;
               RegWrite = 1'b1 & RegWriteEnable;
               dmem_mode = 2'b00;
            end
          `NM_LH :
            begin
               RegDst = 0;
               Branch = 0;
               MemtoReg = 1;
               MemWrite = 0;
               ALUSrc = 1;
               RegWrite = 1'b1 & RegWriteEnable;
               dmem_mode = 2'b01;
            end
          `NM_LB :
            begin
               RegDst = 0;
               Branch = 0;
               MemtoReg = 1;
               MemWrite = 0;
               ALUSrc = 1;
               RegWrite = 1'b1 & RegWriteEnable;
               dmem_mode = 2'b10;
            end
          `NM_SW:
            begin
               RegDst = 0;
               Branch = 0;
               MemtoReg = 0;
               MemWrite = 1'b1 & MemWriteEnable;
               ALUSrc = 1;
               RegWrite = 0;
               dmem_mode = 2'b00;
            end
          `NM_SH :
            begin
               RegDst = 0;
               Branch = 0;
               MemtoReg = 0;
               MemWrite = 1'b1 & MemWriteEnable;
               ALUSrc = 1;
               RegWrite = 0;
               dmem_mode = 2'b01;
            end
          `NM_SB :
            begin
               RegDst = 0;
               Branch = 0;
               MemtoReg = 0;
               MemWrite = 1'b1 & MemWriteEnable;
               ALUSrc = 1;
               RegWrite = 0;
               dmem_mode = 2'b10;
            end
          `NM_BEQ :
            begin
               RegDst = 0;
               Branch = 1;
               MemtoReg = 0;
               MemWrite = 0;
               ALUSrc = 0;
               RegWrite = 0;
            end
          `NM_BNE :
            begin
               RegDst = 0;
               Branch = 1;
               MemtoReg = 0;
               MemWrite = 0;
               ALUSrc = 0;
               RegWrite = 0;
            end
          `NM_BLT :
            begin
               RegDst = 0;
               Branch = 1;
               MemtoReg = 0;
               MemWrite = 0;
               ALUSrc = 0;
               RegWrite = 0;
            end
          `NM_BLE :
            begin
               RegDst = 0;
               Branch = 1;
               MemtoReg = 0;
               MemWrite = 0;
               ALUSrc = 0;
               RegWrite = 0;
            end
          `NM_J :
            begin
               RegDst = 0;
               Branch = 0;
               MemtoReg = 0;
               MemWrite = 0;
               ALUSrc = 0;
               RegWrite = 0;
               Jump = 1;
            end
          `NM_JAL :
            begin
               RegDst = 0;
               Branch = 0;
               MemtoReg = 0;
               MemWrite = 0;
               ALUSrc = 0;
               RegWrite = 1'b1 & RegWriteEnable;
               Jump = 1;
               RegDst_r31 = 1;
            end
          `NM_JR : /* yet */
            begin
               RegDst = 0;
               Branch = 0;
               MemtoReg = 0;
               MemWrite = 0;
               ALUSrc = 0;
               RegWrite = 0;
               PCrs = 1;
            end
	      default:
            begin
               RegDst = 0;
               Branch = 0;
               MemtoReg = 0;
               MemWrite = 0;
               ALUSrc = 0;
               RegWrite = 0;
            end
        endcase // case (cntl_lower)
        ALUOp = op;
     end
endmodule // control
