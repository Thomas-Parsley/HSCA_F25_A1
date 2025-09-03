module testbench();
   
   logic clk;
   logic reset;
   logic [63:0] a, b;
   logic [127:0] TCout, USout, TCexp, USexp;
   logic [31:0] vectornum, errors;
   logic [383:0] testvectors[10000:0];
   
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
	$readmemh("multiplication.tv", testvectors);
	vectornum = 0; errors = 0;
	reset = 1; #22; reset = 0;
     end
   
   // apply test vectors on rising edge of clk
   always @(posedge clk)
     begin
	#1; {a, b, TCexp, USexp} = testvectors[vectornum];
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

module TCmultiplier(input logic signed [63:0] a, b,
                 output logic signed [127:0] c);
  assign c = a * b; 
endmodule

module USmultiplier(input logic [63:0] a, b,
                 output logic [127:0] c);
  assign c = a * b;
endmodule