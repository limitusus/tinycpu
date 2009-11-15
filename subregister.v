// SubRegister
// From Quartus II Verilog Template
// True Dual Port RAM with single clock
//
// subregister.v
`include "config.v"

module subregister(data_w, addr_w, addr_r, clk, we, q_r, reset, q_w, r3);
   /* Parameters */
   input [(`DATA_WIDTH-1):0] data_w; // data to write
   input [(`ADDR_WIDTH-1):0] addr_w, addr_r; // addr to write, addr to read
   input                     clk; // clock
   input                     we; // write enable
   input                     reset; // reset flag
   output reg [(`DATA_WIDTH-1):0] q_r, q_w; // returning value (reapd data, wrote data)
   output wire [7:0]             r3;
   
   // Declare the RAM variable
   reg [`DATA_WIDTH-1:0]          ram[2**(`ADDR_WIDTH)-1:0];
   integer                        i;

   assign r3 = ram[3][7:0];
   
   // Port A - Read only
   always @ (posedge clk)
     begin : SubReg_Port_A
        q_r = ram[addr_r];
     end

   // Port B - Write only. Write only when write enable is on
   always @ (posedge clk or negedge reset)
     if(!reset) // Reset
       begin
          for (i = 0; i < 2**(`ADDR_WIDTH); i = i + 1)
            ram[i] = 0;
       end
     else
       begin
          if(we) /* Write */
            begin : SubReg_Port_B
               ram[addr_w] = data_w;
               q_w = data_w;
            end // block: SubReg_Port_B
       end // always @ (posedge clk)
endmodule
