// Main ALU (32 bit)
// alu32.v
`include "config.v"

module alu32(in1, in2, ctrl, iszero, result);
   input signed [(`DATA_WIDTH-1):0] in1;
   input signed [(`DATA_WIDTH-1):0] in2;
   input [(`CTRL_WIDTH-1):0] ctrl;
   output reg                iszero;
   output reg [(`DATA_WIDTH-1):0] result;

   
   always @(in1 or in2 or ctrl)
     begin
        iszero = 0;
        case (ctrl)
	      4'b0000: result = in1 & in2;
	      4'b0001: result = in1 | in2;
	      4'b0010: result = in1 + in2;
	      4'b0011: result = in1 ^ in2;
	      4'b0100: result = ~(in1 | in2);
	      4'b0101: result = in1 * in2; // Extended
          4'b0110: result = in1 + (~in2 + 1); // in1 - in2;
	      4'b0111: result = in1 / in2; // Extended
          4'b1000: result = in1 << in2[10:6];
	      4'b1001: result = in1 >> in2[10:6];
	      4'b1010: result = in1 >>> in2[10:6];
	      4'b1011: result = in2 << 16;
          /* For Branch */
	      4'b1100: result = in1 == in2 ? 1 : 0;
	      4'b1101: result = in1 == in2 ? 0 : 1;
	      4'b1110: result = in1 < in2 ? 1 : 0;
	      4'b1111: result = in1 <= in2 ? 1 : 0;
	    endcase // case (ctrl)
        if((ctrl[3:2] != 2'b11) && (result == 0))
          iszero = 1;
        else if((ctrl[3:2] == 2'b11) && (result == 1))
          iszero = 1;
     end
endmodule // alu32
