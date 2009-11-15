// Test Module for Data Memory
//   expansion from pc_test.v
// data_mem_test.v
`include "config.v"
`timescale 1ns / 1ns

module data_mem_test;
   reg [(`DATA_WIDTH-1):0]    rd2; /* data read from register 2 */
   reg [(`DATA_WIDTH-1):0]    alud; /* data from ALU */
   reg                        MemWrite;
   reg [2-1:0]                mode;
   reg                        clk;
   reg                        reset;
   wire [(`DATA_WIDTH-1):0]   memd; /* data from memory */
   
   always #(`RATE/2) clk = ~clk;
   
   initial
     begin
        #0
          clk = 0;
        reset = 1;
        rd2 = 32'b01010101010101010101010111010101;
        alud = 0;
        MemWrite = 0;
        mode = 2'b00;
        #(`RATE)
        reset = 0;
        MemWrite = 1;
        alud = 3;
        mode = 2'b00;
        #(`RATE)
        alud = 5;
        mode = 2'b01;
        #(`RATE)
        alud = 9;
        mode = 2'b10;
        #(`RATE)
        MemWrite = 0;
        alud = 13;
        mode = 2'b00;
        #(`RATE)
        alud = 3;
        mode = 2'b00;
        #(`RATE)
        mode = 2'b01;
        #(`RATE)
        mode = 2'b10;
     end // initial begin
   
   data_mem data_mem(.raw_data(rd2), .address(alud), .wren(MemWrite),
                     .mode(mode), .clock(clk), .q(memd));
   
endmodule
