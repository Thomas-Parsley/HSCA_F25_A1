module testbench();
   
   logic clk;
   logic reset;
   logic [3:0] inHex;
   logic [6:0] expected;
   logic [6:0] outBits;
   logic [31:0] vectornum, errors;
   logic [10:0] testvectors[10000:0];
   
   integer 	handle3;
   
   // instantiate device under test
   hexToSevenSegment dut1(inHex, outBits);
   
   // generate clock
   always 
     begin
	clk = 1; #5; clk = 0; #5;
     end
   
   // at start of test, load vectors and pulse reset
   initial
     begin
	handle3 = $fopen("seven_segment_display.out");	
	$readmemb("seven_segment_display.tv", testvectors);
	vectornum = 0; errors = 0;
	reset = 1; #22; reset = 0;
     end
   
   // apply test vectors on rising edge of clk
   always @(posedge clk)
     begin
	#1; {inHex, expected} = testvectors[vectornum];
     end
   
   // check results on falling edge of clk
   always @(negedge clk)
     if (~reset) begin // skip during reset
	$fdisplay(handle3,"input = %b || output = %b || expected = %b\n             || %s              || %s\n             || %s%s%s              || %s%s%s\n             || %s%s%s              || %s%s%s\n",
          inHex, expected, outBits,
          (outBits[6] == 1'b1) ? "___" : "   ", (expected[6] == 1'b1) ? "___" : "   ",
          (outBits[1] == 1'b1) ? "|" : " ",
          (outBits[0] == 1'b1) ? "_" : " ",
          (outBits[5] == 1'b1) ? "|" : " ",

          (expected[1] == 1'b1) ? "|" : " ",
          (expected[0] == 1'b1) ? "_" : " ",
          (expected[5] == 1'b1) ? "|" : " ",

          (outBits[2] == 1'b1) ? "|" : " ",
          (outBits[3] == 1'b1) ? "_" : " ",
          (outBits[4] == 1'b1) ? "|" : " ",

          (expected[2] == 1'b1) ? "|" : " ",
          (expected[3] == 1'b1) ? "_" : " ",
          (expected[4] == 1'b1) ? "|" : " ",
          );/*
            ___
            |_|
            |_|
            */
     if (outBits != expected) begin  // check result
           $display("Error: Test vector %d expected & outputs are not the same", vectornum);
           errors = errors + 1;
	end

	vectornum = vectornum + 1;
	if (testvectors[vectornum] === 11'bx) begin 
           $display("%d tests completed with %d errors", 
	            vectornum, errors);
           $stop;
	end
     end
endmodule

module hexToSevenSegment(input logic [3:0] inHex, output logic [6:0] outBits);
     always_comb
          case(inHex)
          4'b0000: outBits = 7'b1111110;
          4'b0001: outBits = 7'b0110000;
          4'b0010: outBits = 7'b1101101;
          4'b0011: outBits = 7'b1111001;
          4'b0100: outBits = 7'b0110011;
          4'b0101: outBits = 7'b1011011;
          4'b0110: outBits = 7'b1011111;
          4'b0111: outBits = 7'b1110000;
          4'b1000: outBits = 7'b1111111;
          4'b1001: outBits = 7'b1111011;
          4'b1010: outBits = 7'b1110111;
          4'b1011: outBits = 7'b0011111;
          4'b1100: outBits = 7'b1001110;
          4'b1101: outBits = 7'b0111101;
          4'b1110: outBits = 7'b1001111;
          4'b1111: outBits = 7'b1000111;
          default: outBits = 7'b1111110;
          endcase
endmodule

/*
_a_
f b
>g<
e c
 d

___
|_|
|_|



*/

module sevenSegmentToHex(output logic [3:0] outHex, input logic [6:0] inBits);
     always_comb
          case(inBits)
          7'b1111110 : outHex = 4'h0;
          7'b0110000 : outHex = 4'h1;
          7'b1101101 : outHex = 4'h2;
          7'b1111001 : outHex = 4'h3;
          7'b0110011 : outHex = 4'h4;
          7'b1011011 : outHex = 4'h5;
          7'b1011111 : outHex = 4'h6;
          7'b1110000 : outHex = 4'h7;
          7'b1111111 : outHex = 4'h8;
          7'b1111011 : outHex = 4'h9;
          7'b1110111 : outHex = 4'hA;
          7'b0011111 : outHex = 4'hB;
          7'b1001110 : outHex = 4'hC;
          7'b0111101 : outHex = 4'hD;
          7'b1001111 : outHex = 4'hE;
          7'b1000111 : outHex = 4'hF;
          default: outHex = 4'h0;
          endcase
endmodule


