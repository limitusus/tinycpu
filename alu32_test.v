// Test Module for ALU(32bit)
`include "config.v"
`timescale 1ns / 1ns

module alu32_test;
   reg [(`DATA_WIDTH-1):0] in1;
   reg [(`DATA_WIDTH-1):0] in2;
   wire [(`DATA_WIDTH-1):0] out;
   wire                     iszero;
   reg [(`CTRL_WIDTH-1):0]  ctrl;
   
   initial
     begin
        #0
          in1 = 39;
        in2 = 589;
        ctrl = 4'b0000;
        #100
          ctrl = 4'b0001;
        #100
          ctrl = 4'b0010;
        #100
          ctrl = 4'b0011;
        #100
          ctrl = 4'b0100;
        #100
          ctrl = 4'b0110;
        #100
          ctrl = 4'b1011;
        #100
          ctrl = 4'b1110;
     end // initial begin

   alu32 alu(.in1(in1), .in2(in2), .ctrl(ctrl), .iszero(iszero), .result(out));
   
endmodule
