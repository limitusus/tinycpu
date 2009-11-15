// Register module
// From Quartus II Verilog Template
// True Triple Port RAM with single clock
//
// register.v
`include "config.v"

module register(data_c, addr_a, addr_b, addr_c, clk, we, q_a, q_b, q_c, reset, r3);
   /* Parameters */
   input [(`DATA_WIDTH-1):0] data_c; // Data to write
   input [(`ADDR_WIDTH-1):0] addr_a, addr_b, addr_c; // Addresses Read(a,b) Write(c)
   input                     clk; // clock signal
   input                     we; // Write enable 1:write 0:not write
   input                     reset; // reset flag
   output [(`DATA_WIDTH-1):0] q_a, q_b, q_c; // read value(q_c is same as data_c)
   /* Inner variables */
   wire [(`DATA_WIDTH-1):0]   tempout1, tempout2;
   output wire [7:0]         r3;

   /* 2 Sub registers
    * Read: access to 1 subregister
    * Write: access to 2 subregisters (for data synchronization) 
    */
   subregister subRegister1(.data_w(data_c), .addr_w(addr_c), .addr_r(addr_a),
                            .clk(clk), .we(we), .q_r(q_a), .q_w(tempout1), .reset(reset), .r3(r3));
   subregister subRegister2(.data_w(data_c), .addr_w(addr_c), .addr_r(addr_b),
                            .clk(clk), .we(we), .q_r(q_b), .q_w(tempout2), .reset(reset), .r3());
   assign q_c = tempout1;
   
endmodule
