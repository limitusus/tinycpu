// Test Module for Instruction Memory
//   expansion from pc_test.v
// inst_mem_test.v
`include "config.v"
`timescale 1ns / 1ns

module inst_mem_test;
   reg                      clk;
   reg                      reset;
   wire [(`PC_ADDR_WIDTH-1):0] apc;
   wire [(`PC_ADDR_WIDTH-1):0] npc;
   wire [(`DATA_WIDTH-1):0]    inst;
   reg [(`DATA_WIDTH-1):0]     expanded_imm;
   reg                         PCSrc;
   
   always #(`RATE/2) clk = ~clk;
   
   initial
     begin
        #0
          clk = 0;
        reset = 1;
        PCSrc = 0;
        expanded_imm = 0;
        #(`RATE)
        reset = 0;
     end // initial begin

   pc pc(.p(apc), .q(npc), .clock(clk), .reset(reset));
   //pc_qadder qadder(.q(npc), .qn(lpc));
   sequencer sequencer(.cur_pc(npc), .pc_add(expanded_imm), .clock(clk), .PCSrc(PCSrc), .next_pc(apc));
   instruction_memory inst_mem(.address(npc), .q(inst), .clock(clk));
endmodule
