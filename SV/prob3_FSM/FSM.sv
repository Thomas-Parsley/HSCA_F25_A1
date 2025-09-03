module testbench();
   
   logic clk;
   logic reset;
   logic [3:0] inHex;
   logic [6:0] outBits;
   logic [31:0] vectornum, errors;
   logic [3:0] testvectors[10000:0];
   
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
	$readmemh("seven_segment_display.tv", testvectors);
	vectornum = 0; errors = 0;
	reset = 1; #22; reset = 0;
     end
   
   // apply test vectors on rising edge of clk
   always @(posedge clk)
     begin
	#1; {inHex} = testvectors[vectornum];
     end
   
   // check results on falling edge of clk
   always @(negedge clk)
     if (~reset) begin // skip during reset
	$fdisplay(handle3,"%s\n%s%s%s\n%s%s%s\n",
          (outBits[6] == 1'b1) ? "___" : "   ",
          (outBits[1] == 1'b1) ? "|" : " ",
          (outBits[0] == 1'b1) ? "_" : " ",
          (outBits[5] == 1'b1) ? "|" : " ",
          (outBits[2] == 1'b1) ? "|" : " ",
          (outBits[3] == 1'b1) ? "_" : " ",
          (outBits[4] == 1'b1) ? "|" : " "
          );/*
            ___
            |_|
            |_|
            */

	vectornum = vectornum + 1;
	if (vectornum === 5'b10000) begin 
           $display("%d tests completed with %d errors", 
	            vectornum, errors);
           $stop;
	end
     end
endmodule

module hexToSevenSegment(input logic [3:0] inHex, output logic [6:0] outBits);
     always_comb
          case(inHex)
          4'h0: outBits = 7'b1111110;
          4'h1: outBits = 7'b0110000;
          4'h2: outBits = 7'b1101101;
          4'h3: outBits = 7'b1111001;
          4'h4: outBits = 7'b0110011;
          4'h5: outBits = 7'b1011011;
          4'h6: outBits = 7'b1011111;
          4'h7: outBits = 7'b1110000;
          4'h8: outBits = 7'b1111111;
          4'h9: outBits = 7'b1111011;
          4'hA: outBits = 7'b1110111;
          4'hB: outBits = 7'b0011111;
          4'hC: outBits = 7'b1001110;
          4'hD: outBits = 7'b0111101;
          4'hE: outBits = 7'b1001111;
          4'hF: outBits = 7'b1000111;
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

