// ALU Control
//
// alu_control.v
`include "config.v"

module alu_control(low_inst, ALUOp, alu_ctrl, ALUSrc);
   input [(6-1):0] low_inst;
   input [(`ALUOP_WIDTH-1):0] ALUOp;
   output reg                 ALUSrc;
   output reg [(`CTRL_WIDTH-1):0] alu_ctrl;
   
   always @(ALUOp or low_inst)
     begin
        alu_ctrl = 4'b0000;
        ALUSrc = 0;
        case (ALUOp)
          0: /* R-Type */
            begin
               case(low_inst)
                 0: alu_ctrl = 4'b0010;
                 2: alu_ctrl = 4'b0110;
                 4: alu_ctrl = 4'b0101;
                 6: alu_ctrl = 4'b0111;
                 8: alu_ctrl = 4'b0000;
                 9: alu_ctrl = 4'b0001;
                 10: alu_ctrl = 4'b0011;
                 11: alu_ctrl = 4'b0100;
                 16: alu_ctrl = 4'b1000;
                 17: alu_ctrl = 4'b1001;
                 18: alu_ctrl = 4'b1010;
                 default: alu_ctrl = 4'b0000;
               endcase // case (low_inst)
               if(low_inst[4]) // Shift Operation
                 ALUSrc = 1;
            end // case: 0
          `NM_ADDI: alu_ctrl = 4'b0010;
          `NM_MULI: alu_ctrl = 4'b0101;
          `NM_DIVI: alu_ctrl = 4'b0111;
          `NM_LUI: alu_ctrl = 4'b1011;
          `NM_ANDI: alu_ctrl = 4'b0000;
          `NM_ORI: alu_ctrl = 4'b0001;
          `NM_XORI: alu_ctrl = 4'b0011;
          `NM_LW, `NM_LH, `NM_LB,
            `NM_SW, `NM_SH, `NM_SB:
              alu_ctrl = 4'b0010;
          `NM_BEQ: alu_ctrl = 4'b1100;
          `NM_BNE: alu_ctrl = 4'b1101;
          `NM_BLT: alu_ctrl = 4'b1110;
          `NM_BLE: alu_ctrl = 4'b1111;
          default:
            alu_ctrl = 4'b0000;
        endcase // case (cntl_lower)
     end
endmodule // control
