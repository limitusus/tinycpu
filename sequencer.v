// Sequencer
//
// sequencer.v
`include "config.v"

module sequencer(cur_pc, pc_add, clock, PCSrc, next_pc, Jump, inst_addr, reset, clock_counter, PCrs, rs_d);
   /* Parameters */
   input [(`PC_ADDR_WIDTH-1):0] cur_pc; // Input Address
   input [(`DATA_WIDTH-1):0]    pc_add; // for branch
   input [(`DATA_WIDTH-1):0]    inst_addr; // Address given by instruction(For jump)
   input                        clock;   // Clock
   input                        PCSrc; // Program Counter Source
   reg [(`PC_ADDR_WIDTH-1):0]   shifted_inst_addr;
   reg [(`PC_ADDR_WIDTH-1):0]   ia_aa;
   output reg [(`PC_ADDR_WIDTH-1):0] next_pc; // New Program Counter
   input                             Jump;
   input                             reset; // This module's reset must be posedge of reset
   input                             PCrs;
   input [(`DATA_WIDTH-1):0]         rs_d;
   
   reg [(`PC_ADDR_WIDTH-1):0]        incremented_pc;
   reg [(`PC_ADDR_WIDTH-1):0]        added_pc;

   output reg [2-1:0]                clock_counter;
   
   always @(posedge clock or negedge reset)
     if(!reset) //Reset
       begin
          clock_counter = 1;
          incremented_pc = 0;
          added_pc = 0;
          ia_aa = 0;
          shifted_inst_addr = 0;
          next_pc = 5'b00000;
       end
     else
       begin
          clock_counter = clock_counter + 2'b01;
          if(clock_counter == 2'b00)
            begin
               incremented_pc = cur_pc + 2'b01;
               added_pc = cur_pc + pc_add[6:2];
               ia_aa = PCSrc ? added_pc : incremented_pc;
               shifted_inst_addr[(`PC_ADDR_WIDTH-1):0] = inst_addr[(`PC_ADDR_WIDTH-1+2):2];
               next_pc = PCrs ? rs_d[4:0] : (Jump ? shifted_inst_addr : ia_aa);
            end
       end
endmodule
