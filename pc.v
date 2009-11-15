// Program counter
// From Quartus II Verilog Template
// True Dual Port RAM with single clock
//
// pc.v
`include "config.v"

module pc(p, clock, reset, q);
   /* Parameters */
   input [(`PC_ADDR_WIDTH-1):0] p; // Input Address
   input                        clock; // clock
   input                        reset; // reset trigger(negedge)
   output reg [(`PC_ADDR_WIDTH-1):0] q; // returning value
   
   always @ (posedge clock or negedge reset)
     if(!reset)
       q = 0; // Reset
     else
       q = p;

   //assign q = p;
   
endmodule
