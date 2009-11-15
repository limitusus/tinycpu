// Test Module for CPU
`include "config.v"
`timescale 1ns / 1ns

module CPU;
   reg [(`DATA_WIDTH-1):0] data_c;
   reg [(`ADDR_WIDTH-1):0] addr_a, addr_b, addr_c;
   reg                     clk;
   reg                     we;
   wire [(`DATA_WIDTH-1):0] q_a, q_b, q_c;
   
   initial
     begin
        #0
          data_c = 4;
        addr_a = 0;
        addr_b = 1;
        addr_c = 5;
        we = 1;
        clk = 0;
        #200
          data_c = 4;
        addr_a = 0;
        addr_b = 1;
        addr_c = 5;
        we = 1;
        clk = 1;
        #200
          clk = 0;
        #200
          data_c = 5;
        addr_a = 5;
        addr_b = 1;
        addr_c = 10;
        we = 0;
        clk = 1;
     end // initial begin

   register myRegister (
                        .data_c(data_c),
                        .addr_a(addr_a), .addr_b(addr_b), .addr_c(addr_c),
                        .clk(clk),
                        .we(we),
                        .q_a(q_a), .q_b(q_b), .q_c(q_c)
                        );
endmodule
