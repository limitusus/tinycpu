// Test Module for Register
`include "config.v"
`timescale 1ns / 1ns

module register_test;
   reg                      clk;
   reg                      reset;
   reg [(`ADDR_WIDTH-1):0]  rs; /* register address to read 1 */
   reg [(`ADDR_WIDTH-1):0]      rt; /* register address to read 2 */
   reg [(`ADDR_WIDTH-1):0]      rd; /* register address to write */
   wire [(`DATA_WIDTH-1):0] rd1; /* data read from register 1, data to ALU 1 */
   wire [(`DATA_WIDTH-1):0] rd2; /* data read from register 2 */
   wire [(`DATA_WIDTH-1):0] rd3; /* data read from register 3 */
   reg [(`DATA_WIDTH-1):0]  d_regw; /* data to write to register */
   /* Control Lines */
   reg                          RegWrite;

   always #(`RATE/2) clk = ~clk;
   
   initial
     begin
        #0
          clk = 0;
        RegWrite = 0;
        reset = 1;
        #(`RATE)
        reset = 0;
        #(`RATE)
        RegWrite = 1;
        rs = 2;
        rt = 5;
        rd = 6;
        d_regw = 39;
        #(`RATE)
        #(`RATE)
        RegWrite = 0;
        rs = 6;
        rt = 3;
        rd = 9;
        d_regw = 589;
     end // initial begin

   register register(.data_c(d_regw),
                     .addr_a(rs), .addr_b(rt), .addr_c(rd),
                     .clk(clk), .we(RegWrite),
                     .q_a(rd1), .q_b(rd2), .q_c(rd3),
                     .reset(reset)
                     );
   
endmodule
