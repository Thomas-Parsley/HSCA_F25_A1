module testbench();
   
   logic clk;
   logic reset;
   logic [3:0] inHex;
   logic [127:0] TCout, USout, TCexp, USexp;
   logic [31:0] vectornum, errors;
   logic [383:0] testvectors[10000:0];
   
   integer 	handle3;
   
   // instantiate device under test
   hexToSevenSegment dut1(inHex);
   
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
	$fdisplay(handle3, "%h %h || TCresult: %h | TCexpected: %h || USresult: %h | USexpected: %h ||", 
		  a, b, TCout, TCexp, USout, USexp);/**/
	
	/*if (USout != USexp) begin  // check result
           $display("Error: inputs = %b", {a, b});
           $display("  outputs = %b (%b expected)",USout, USexp);
           errors = errors + 1;
	end
     if (TCout !== TCexp) begin  // check result
           $display("Error: inputs = %b", {a, b});
           $display("  outputs = %b (%b expected)",TCout, TCexp);
           errors = errors + 1;
	end*/
	vectornum = vectornum + 1;
	if (vectornum === 32'b0000000000000000000000001000) begin 
           $display("%d tests completed with %d errors", 
	            vectornum, errors);
           $stop;
	end
     end
endmodule

module hexToSevenSegment(input logic [3:0] inHex, output logic [7:0] outBits);
     always_comb
          case(a)
          1'h0: outBits = 7'b1111110;
          1'h1: outBits = 7'b1100000;
          1'h2: outBits = 7'b1100000;
          1'h3: outBits = 7'b1100000;
          1'h4: outBits = 7'b1100000;
          1'h5: outBits = 7'b1100000;
          1'h6: outBits = 7'b1100000;
          1'h7: outBits = 7'b1100000;
          1'h8: outBits = 7'b1100000;
          1'h9: outBits = 7'b1100000;
          1'hA: outBits = 7'b1100000;
          1'hB: outBits = 7'b1100000;
          1'hC: outBits = 7'b1100000;
          1'hD: outBits = 7'b1100000;
          1'hE: outBits = 7'b1100000;
          1'hF: outBits = 7'b1100000;
          default: outBits = 7'b1111110
          endcase
     
endmodule
/*
_a_
f b
>g<
e c



*/

