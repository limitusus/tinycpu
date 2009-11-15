// CPU Main module
`include "config.v"
`timescale 1ns / 1ns
`define DEBUG

`ifdef DEBUG
module CPU;
`else
module CPU(clk, reset, seg);
`endif
   wire [(`WORD_WIDTH-1):0] inst;
`ifdef DEBUG
   reg                      clk;
   reg                      reset;
`else
   input                    clk;
   input                    reset;
`endif
   wire [(`PC_ADDR_WIDTH-1):0] apc;
   wire [(`PC_ADDR_WIDTH-1):0] npc;
   //wire [(`PC_ADDR_WIDTH-1):0] lpc;
   wire [(`ADDR_WIDTH-1):0]    rs; /* register address to read 1 */
   wire [(`ADDR_WIDTH-1):0]    rt; /* register address to read 2 */
   wire [(`ADDR_WIDTH-1):0]    rd; /* register address to write */
   wire [(`DATA_WIDTH-1):0]    rd1; /* data read from register 1, data to ALU 1 */
   wire [(`DATA_WIDTH-1):0]    rd2; /* data read from register 2 */
   wire [(`DATA_WIDTH-1):0]    rd3; /* data read from register 3 */
   wire [(`DATA_WIDTH-1):0]    dalu2; /* data to ALU 2 */
   wire [(`DATA_WIDTH-1):0]    memd; /* data from memory */
   wire [(`DATA_WIDTH-1):0]    d_regw; /* data to write to register */
   wire [(`DATA_WIDTH-1):0]    alud; /* data from ALU */
   wire [(`ASM_OP_WIDTH-1):0]  op; /* Assembly op code */
   wire [2-1:0]                data_mem_mode; /* data memory mode */
   wire [(`WORD_WIDTH-`ASM_OP_WIDTH-(3-1)*`ADDR_WIDTH-1):0] imm_addr;
   wire [25:0]                                              addr;
   wire [(`DATA_WIDTH-1):0]                                 expanded_imm;
   wire [(`CTRL_WIDTH-1):0]                                 alu_ctrl;
   
   /* Control Lines */
   wire                                                     RegDst;
   wire                                                     RegDst_r31;
   wire                                                     Branch;
   wire                                                     MemtoReg;
   wire [(`ALUOP_WIDTH-1):0]                                ALUOp;
   wire                                                     MemWrite;
   wire                                                     RegWrite;
   wire                                                     Jump;
   wire                                                     PCrs;
   /* ALU Source */
   wire                                                     ALUSrc;
   // From Control
   wire                                                     ALUSrc_c;
   // From ALU Control
   wire                                                     ALUSrc_ac;
   assign ALUSrc = ALUSrc_c ^ ALUSrc_ac;
   /* Compliment Line */
   wire                                                     PCSrc;
   wire                                                     ALUiszero;
   wire [2-1:0]                                             clock_counter;
   
   /* Output (7Seg) */
`ifdef DEBUG
   wire [15:0]                                              seg;
`else                                              
   output wire [15:0]                                       seg;
`endif
   wire [7:0]                                               seg_in;
   
   assign op = inst[31:26];
   assign rs = inst[25:21];
   assign rt = inst[20:16];
   assign rd = RegDst_r31 ? 5'b11111 : (RegDst ?  inst[15:11] : inst[20:16]);
   assign imm_addr = inst[15:0];
   assign addr = inst[25:0];
   assign PCSrc = ALUiszero & Branch;
   assign dalu2 = ALUSrc ? expanded_imm : rd2;
   assign d_regw = RegDst_r31 ? (npc + 1) : (MemtoReg ? memd : alud);
   assign expanded_imm[15:0] = imm_addr[15:0];
   assign expanded_imm[(`DATA_WIDTH-1):(16)] = imm_addr[15] == 1
                                               ? 16'b1111111111111111
                                               : 16'b0000000000000000;

`ifdef DEBUG
   always #(`RATE/2)	clk = ~clk;

   initial
     begin
        #0
          clk = 0;
        reset=1;
        #(305)
        reset = 0;
        #(5)
        reset = 1;
     end // initial begin
`endif

   instruction_memory inst_mem(.address(npc), .q(inst), .clock(clk));
   pc pc(.p(apc), .q(npc), .clock(clk), .reset(reset));
   //pc_qadder qadder(.q(npc), .qn(lpc));
   sequencer sequencer(.cur_pc(npc), .pc_add(expanded_imm), .clock(clk),
                       .PCSrc(PCSrc), .next_pc(apc), .Jump(Jump),
                       .inst_addr(addr), .reset(reset), .clock_counter(clock_counter),
                       .PCrs(PCrs), .rs_d(rd1));
   register register(.data_c(d_regw),
                     .addr_a(rs), .addr_b(rt), .addr_c(rd),
                     .clk(clk), .we(RegWrite),
                     .q_a(rd1), .q_b(rd2), .q_c(rd3),
                     .reset(reset), .r3(seg_in)
                     );
   alu32 alu(.in1(rd1), .in2(dalu2), .ctrl(alu_ctrl),
             .iszero(ALUiszero), .result(alud));
   control control(.op(op), .RegDst(RegDst), .Branch(Branch), .MemtoReg(MemtoReg),
                   .ALUOp(ALUOp), .MemWrite(MemWrite), .ALUSrc(ALUSrc_c),
                   .RegWrite(RegWrite), .dmem_mode(data_mem_mode), .Jump(Jump),
                   .clock_counter(clock_counter), .clock(clk), .RegDst_r31(RegDst_r31),
                   .PCrs(PCrs));
   data_mem data_mem(.raw_data(rd2), .address(alud[7:0]), .wren(MemWrite),
                     .mode(data_mem_mode), .clock(clk), .q(memd));
   alu_control alu_control(.low_inst(imm_addr[5:0]), .ALUOp(ALUOp),
                           .alu_ctrl(alu_ctrl), .ALUSrc(ALUSrc_ac));
   seg_decoder32 seg_decoder32(seg_in, seg);
endmodule
