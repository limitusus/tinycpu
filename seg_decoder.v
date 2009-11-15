// Seg Decoder for output
module seg_decoder(mo, mi);

   input [3:0] mi;
   output [7:0] mo;

   function [7:0] seg_decode;
	  input [3:0] mi;
	  case( mi )
		4'h0:	seg_decode = 8'b11111100;
		4'h1:	seg_decode = 8'b01100000;
		4'h2:	seg_decode = 8'b11011010;
		4'h3:	seg_decode = 8'b11110010;
		4'h4:	seg_decode = 8'b01100110;
		4'h5:	seg_decode = 8'b10110110;
		4'h6:	seg_decode = 8'b10111110;
		4'h7:	seg_decode = 8'b11100000;
		4'h8:	seg_decode = 8'b11111110;
		4'h9:	seg_decode = 8'b11110110;
		4'ha:	seg_decode = 8'b11101110;
		4'hb:	seg_decode = 8'b00111110;
		4'hc:	seg_decode = 8'b00011010;
		4'hd:	seg_decode = 8'b01111010;
		4'he:	seg_decode = 8'b10011110;
		4'hf:	seg_decode = 8'b10001110;
	  endcase	// unique case
   endfunction		

   assign mo = seg_decode(mi);

endmodule	


module seg_decoder32(mi, mo);

   input [7:0] mi;
   output [15:0] mo;

   seg_decoder dec0(mo[7:0],   mi[3:0]);
   seg_decoder dec1(mo[15:8],  mi[7:4]);
//    seg_decoder dec2(mo[23:16], mi[11:8]);
//    seg_decoder dec3(mo[31:24], mi[15:12]);
//    seg_decoder dec4(mo[39:32], mi[19:16]);
//    seg_decoder dec5(mo[47:40], mi[23:20]);
//    seg_decoder dec6(mo[55:48], mi[27:24]);
//    seg_decoder dec7(mo[63:56], mi[31:28]);

endmodule // seg_decoder32
