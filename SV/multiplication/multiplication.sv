module testbench();
   
   logic clk;
   logic reset;
   logic [7:0] a, b;
   logic [15:0] TCout, USout, TCexp, USexp;
   logic 	sum_expected, cout_expected;
   logic [31:0] vectornum, errors;
   logic [47:0] testvectors[10000:0];
   
   integer 	handle3;
   
   // instantiate device under test
   TCmultiplier dut1(a, b, TCout);
   USmultiplier dut2(a, b, USout);
   
   // generate clock
   always 
     begin
	clk = 1; #5; clk = 0; #5;
     end
   
   // at start of test, load vectors and pulse reset
   initial
     begin
	handle3 = $fopen("multiplication.out");	
	$readmemb("multiplication.tv", testvectors);
	vectornum = 0; errors = 0;
	reset = 1; #22; reset = 0;
     end
   
   // apply test vectors on rising edge of clk
   always @(posedge clk)
     begin
	#1; {a[7:0], b[7:0], TCexp[15:0], USexp[15:0]} = testvectors[vectornum];
     end
   
   // check results on falling edge of clk
   always @(negedge clk)
     if (~reset) begin // skip during reset
	$fdisplay(handle3, "%b %b || TCresult: %b | TCexpected: %b || USresult: %b | USexpected: %b ||", 
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
	if (vectornum === 8'b11111111) begin 
           $display("%d tests completed with %d errors", 
	            vectornum, errors);
           $stop;
	end
     end
endmodule

module TCmultiplier(input logic signed [7:0] a, b,
                 output logic signed [15:0] c);
  assign c = a * b; 
endmodule

module USmultiplier(input logic [7:0] a, b,
                 output logic [15:0] c);
  assign c = a * b;
endmodule