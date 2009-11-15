// megafunction wizard: %RAM: 1-PORT%
// GENERATION: STANDARD
// VERSION: WM1.0
// MODULE: altsyncram 


// synopsys translate_off
//`timescale 1 ns / 1 ns
// synopsys translate_on
module data_mem (address, clock, raw_data, wren, mode, q);
   input [7:0] address;
   input       clock;
   input [31:0] raw_data;
   input        wren;
   input [2-1:0] mode;
   output reg [31:0] q;

   reg [31:0]        data;
   wire [31:0]       sub_wire0;
   always @ (mode or raw_data)
     begin
        data = 32'b00000000000000000000000000000000;
        case(mode)
          2'b00:
            data = raw_data;
          2'b01:
            begin
               data[15:0] = raw_data[15:0];
               data[31:16] = data[15] == 1 ? 16'b1111111111111111 : 16'b0000000000000000;
            end
          2'b10:
            begin
               data[7:0] = raw_data[7:0];
               data[31:8] = data[7] == 1 ? 24'b111111111111111111111111 : 24'b000000000000000000000000;
            end
          default:
            ;
        endcase
     end 

   always @ (mode or sub_wire0)
     begin
        q = 32'b00000000000000000000000000000000;
        case(mode)
          2'b00:
            q = sub_wire0;
          2'b01:
            begin
               q[15:0] = sub_wire0[15:0];
               q[31:16] = sub_wire0[15] == 1 ? 16'b1111111111111111 : 16'b0000000000000000;
            end
          2'b10:
            begin
               q[7:0] = sub_wire0[7:0];
               q[31:8] = sub_wire0[7] == 1 ? 24'b111111111111111111111111 : 24'b000000000000000000000000;
            end
          default:
            ;
        endcase
     end

   altsyncram	altsyncram_component (
				                      .wren_a (wren),
				                      .clock0 (clock),
				                      .address_a (address),
				                      .data_a (data),
				                      .q_a (sub_wire0),
				                      .aclr0 (1'b0),
				                      .aclr1 (1'b0),
				                      .address_b (1'b1),
				                      .addressstall_a (1'b0),
				                      .addressstall_b (1'b0),
				                      .byteena_a (1'b1),
				                      .byteena_b (1'b1),
				                      .clock1 (1'b1),
				                      .clocken0 (1'b1),
				                      .clocken1 (1'b1),
				                      .clocken2 (1'b1),
				                      .clocken3 (1'b1),
				                      .data_b (1'b1),
				                      .eccstatus (),
				                      .q_b (),
				                      .rden_a (1'b1),
				                      .rden_b (1'b1),
				                      .wren_b (1'b0));
   defparam
	 altsyncram_component.address_aclr_a = "NONE",
	 altsyncram_component.indata_aclr_a = "NONE",
`ifdef NO_PLI
	   altsyncram_component.init_file = "data_memory.init.rif"
`else
		 altsyncram_component.init_file = "data_memory.init.hex"
`endif
           ,
   altsyncram_component.intended_device_family = "Cyclone",
	 altsyncram_component.lpm_hint = "ENABLE_RUNTIME_MOD=NO",
	 altsyncram_component.lpm_type = "altsyncram",
	 altsyncram_component.numwords_a = 256,
	 altsyncram_component.operation_mode = "SINGLE_PORT",
	 altsyncram_component.outdata_aclr_a = "NONE",
	 altsyncram_component.outdata_reg_a = "UNREGISTERED",
	 altsyncram_component.power_up_uninitialized = "FALSE",
	 altsyncram_component.widthad_a = 8,
	 altsyncram_component.width_a = 32,
	 altsyncram_component.width_byteena_a = 1,
	 altsyncram_component.wrcontrol_aclr_a = "NONE";


endmodule

// ============================================================
// CNX file retrieval info
// ============================================================
// Retrieval info: PRIVATE: ADDRESSSTALL_A NUMERIC "0"
// Retrieval info: PRIVATE: AclrAddr NUMERIC "0"
// Retrieval info: PRIVATE: AclrByte NUMERIC "0"
// Retrieval info: PRIVATE: AclrData NUMERIC "0"
// Retrieval info: PRIVATE: AclrOutput NUMERIC "0"
// Retrieval info: PRIVATE: BYTE_ENABLE NUMERIC "0"
// Retrieval info: PRIVATE: BYTE_SIZE NUMERIC "8"
// Retrieval info: PRIVATE: BlankMemory NUMERIC "0"
// Retrieval info: PRIVATE: CLOCK_ENABLE_INPUT_A NUMERIC "0"
// Retrieval info: PRIVATE: CLOCK_ENABLE_OUTPUT_A NUMERIC "0"
// Retrieval info: PRIVATE: Clken NUMERIC "0"
// Retrieval info: PRIVATE: DataBusSeparated NUMERIC "1"
// Retrieval info: PRIVATE: IMPLEMENT_IN_LES NUMERIC "0"
// Retrieval info: PRIVATE: INIT_FILE_LAYOUT STRING "PORT_A"
// Retrieval info: PRIVATE: INIT_TO_SIM_X NUMERIC "0"
// Retrieval info: PRIVATE: INTENDED_DEVICE_FAMILY STRING "Cyclone"
// Retrieval info: PRIVATE: JTAG_ENABLED NUMERIC "0"
// Retrieval info: PRIVATE: JTAG_ID STRING "NONE"
// Retrieval info: PRIVATE: MAXIMUM_DEPTH NUMERIC "0"
// Retrieval info: PRIVATE: MIFfilename STRING "data_memory.init.hex"
// Retrieval info: PRIVATE: NUMWORDS_A NUMERIC "256"
// Retrieval info: PRIVATE: RAM_BLOCK_TYPE NUMERIC "0"
// Retrieval info: PRIVATE: READ_DURING_WRITE_MODE_PORT_A NUMERIC "3"
// Retrieval info: PRIVATE: RegAddr NUMERIC "1"
// Retrieval info: PRIVATE: RegData NUMERIC "1"
// Retrieval info: PRIVATE: RegOutput NUMERIC "0"
// Retrieval info: PRIVATE: SYNTH_WRAPPER_GEN_POSTFIX STRING "0"
// Retrieval info: PRIVATE: SingleClock NUMERIC "1"
// Retrieval info: PRIVATE: UseDQRAM NUMERIC "1"
// Retrieval info: PRIVATE: WRCONTROL_ACLR_A NUMERIC "0"
// Retrieval info: PRIVATE: WidthAddr NUMERIC "8"
// Retrieval info: PRIVATE: WidthData NUMERIC "32"
// Retrieval info: PRIVATE: rden NUMERIC "0"
// Retrieval info: CONSTANT: ADDRESS_ACLR_A STRING "NONE"
// Retrieval info: CONSTANT: INDATA_ACLR_A STRING "NONE"
// Retrieval info: CONSTANT: INIT_FILE STRING "data_memory.init.hex"
// Retrieval info: CONSTANT: INTENDED_DEVICE_FAMILY STRING "Cyclone"
// Retrieval info: CONSTANT: LPM_HINT STRING "ENABLE_RUNTIME_MOD=NO"
// Retrieval info: CONSTANT: LPM_TYPE STRING "altsyncram"
// Retrieval info: CONSTANT: NUMWORDS_A NUMERIC "256"
// Retrieval info: CONSTANT: OPERATION_MODE STRING "SINGLE_PORT"
// Retrieval info: CONSTANT: OUTDATA_ACLR_A STRING "NONE"
// Retrieval info: CONSTANT: OUTDATA_REG_A STRING "UNREGISTERED"
// Retrieval info: CONSTANT: POWER_UP_UNINITIALIZED STRING "FALSE"
// Retrieval info: CONSTANT: WIDTHAD_A NUMERIC "8"
// Retrieval info: CONSTANT: WIDTH_A NUMERIC "32"
// Retrieval info: CONSTANT: WIDTH_BYTEENA_A NUMERIC "1"
// Retrieval info: CONSTANT: WRCONTROL_ACLR_A STRING "NONE"
// Retrieval info: USED_PORT: address 0 0 8 0 INPUT NODEFVAL address[7..0]
// Retrieval info: USED_PORT: clock 0 0 0 0 INPUT NODEFVAL clock
// Retrieval info: USED_PORT: data 0 0 32 0 INPUT NODEFVAL data[31..0]
// Retrieval info: USED_PORT: q 0 0 32 0 OUTPUT NODEFVAL q[31..0]
// Retrieval info: USED_PORT: wren 0 0 0 0 INPUT NODEFVAL wren
// Retrieval info: CONNECT: @address_a 0 0 8 0 address 0 0 8 0
// Retrieval info: CONNECT: q 0 0 32 0 @q_a 0 0 32 0
// Retrieval info: CONNECT: @clock0 0 0 0 0 clock 0 0 0 0
// Retrieval info: CONNECT: @data_a 0 0 32 0 data 0 0 32 0
// Retrieval info: CONNECT: @wren_a 0 0 0 0 wren 0 0 0 0
// Retrieval info: LIBRARY: altera_mf altera_mf.altera_mf_components.all
// Retrieval info: GEN_FILE: TYPE_NORMAL data_mem.v TRUE
// Retrieval info: GEN_FILE: TYPE_NORMAL data_mem.inc FALSE
// Retrieval info: GEN_FILE: TYPE_NORMAL data_mem.cmp FALSE
// Retrieval info: GEN_FILE: TYPE_NORMAL data_mem.bsf FALSE
// Retrieval info: GEN_FILE: TYPE_NORMAL data_mem_inst.v FALSE
// Retrieval info: GEN_FILE: TYPE_NORMAL data_mem_bb.v FALSE
// Retrieval info: GEN_FILE: TYPE_NORMAL data_mem_waveforms.html FALSE
// Retrieval info: GEN_FILE: TYPE_NORMAL data_mem_wave*.jpg FALSE
// Retrieval info: LIB_FILE: altera_mf
