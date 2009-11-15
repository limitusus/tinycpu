// Test Module for Program Counter and Sequencer
`include "config.v"
`timescale 1ns / 1ns

module pc_test;
   reg                      clk;
   reg                      reset;
   wire [(`PC_ADDR_WIDTH-1):0] apc;
   wire [(`PC_ADDR_WIDTH-1):0] npc;
   reg [(`DATA_WIDTH-1):0]    expanded_imm;
   reg                        PCSrc;
   
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
        #(`RATE)
        #(`RATE)
        #(`RATE)
        expanded_imm = 15;
        #(`RATE)
        PCSrc = 1;
        expanded_imm = 19;
        #(`RATE)
        PCSrc = 0;
        #(`RATE)
        PCSrc = 1;
        expanded_imm = 10;
        #(`RATE)
        PCSrc = 0;
     end // initial begin

   pc pc(.p(apc), .q(npc), .clock(clk), .reset(reset));
   //pc_qadder qadder(.q(npc), .qn(lpc));
   sequencer sequencer(.cur_pc(npc), .pc_add(expanded_imm), .clock(clk), .PCSrc(PCSrc), .next_pc(apc));
   
endmodule
