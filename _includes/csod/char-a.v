// Verilog module to display character A on your screen.
// Contains a LUT and an output module.

module char_a_lut(x, y, out);
	input [7:0] x;
	input [7:0] y;
	output reg [6:0] out;

	always@(*)
	begin
		out[6] <= 1'b1;
		case({x, y})
			16'h0400: out[5:0] <= 6'b111111;
			16'h0500: out[5:0] <= 6'b111111;
			
			16'h0401: out[5:0] <= 6'b111111;
			16'h0501: out[5:0] <= 6'b111111;
			
			16'h0302: out[5:0] <= 6'b111111;
			16'h0402: out[5:0] <= 6'b111111;
			16'h0502: out[5:0] <= 6'b111111;
			16'h0602: out[5:0] <= 6'b111111;
			
			16'h0303: out[5:0] <= 6'b111111;
			16'h0603: out[5:0] <= 6'b111111;
			
			16'h0304: out[5:0] <= 6'b111111;
			16'h0604: out[5:0] <= 6'b111111;
			
			16'h0205: out[5:0] <= 6'b111111;
			16'h0305: out[5:0] <= 6'b111111;
			16'h0605: out[5:0] <= 6'b111111;
			16'h0705: out[5:0] <= 6'b111111;
			
			16'h0206: out[5:0] <= 6'b111111;
			16'h0306: out[5:0] <= 6'b111111;
			16'h0406: out[5:0] <= 6'b111111;
			16'h0506: out[5:0] <= 6'b111111;
			16'h0606: out[5:0] <= 6'b111111;
			16'h0706: out[5:0] <= 6'b111111;
			
			16'h0207: out[5:0] <= 6'b111111;
			16'h0707: out[5:0] <= 6'b111111;
			
			16'h0208: out[5:0] <= 6'b111111;
			16'h0708: out[5:0] <= 6'b111111;
			
			16'h0109: out[5:0] <= 6'b111111;
			16'h0209: out[5:0] <= 6'b111111;
			16'h0709: out[5:0] <= 6'b111111;
			16'h0809: out[5:0] <= 6'b111111;
			default: out[6] <= 1'b0;
		endcase
	end
endmodule

module char_a(x, y, flush_x, flush_y, colour, enable);
	input [7:0] x;
	input [7:0] y;
	input [7:0] flush_x;
	input [7:0] flush_y;
	
	output [5:0] colour;
	output enable;
	
	wire [6:0] lut_out;
	
	char_a_lut(flush_x - x, flush_y - y, lut_out);
	
	assign colour = lut_out[5:0];
	assign enable = lut_out[6];
endmodule