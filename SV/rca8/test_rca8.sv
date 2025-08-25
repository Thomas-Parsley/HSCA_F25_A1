module stimulus;

   logic [7:0]  A, B;
   logic        Cin;
   logic        Clk;
   logic [7:0] 	Sum;
   logic [7:0] 	answer;

   logic [31:0] errors;
   logic [31:0] vectornum;   
   integer 	file;      // file handle
   integer 	j;         // loop counter

   // DUT instantiation
   rca8 dut (.Sum, .A, .B, .Cin);

   // Clock generation
   initial 
     begin	
	Clk = 1'b1;
	forever #10 Clk = ~Clk;
     end

   // Open results file
   initial begin
      file = $fopen("rca8.out", "w");
      vectornum = 0;
      errors = 0;
      if (!file) begin
         $display("ERROR: Could not open rca8.out");
         $finish;
      end
   end

   // Test vector 
   initial
     begin
	// Number of tests
	for (j=0; j < 8; j=j+1)
	  begin
	     // Put vectors before beginning of clk
	     @(posedge Clk)
	       begin
		  // allows better output of randomized signals
		  A = $random;
		  B = $random;
		  Cin = $random;
	       end
	     @(negedge Clk)
	       begin
		  answer = A+B+Cin;
		  vectornum = vectornum + 1;
		  // Check if output of DUT is the same as the correct output
		  if (answer != Sum)
		    begin
		       errors = errors + 1;
		       $display("%h %h %b || %h %h %b", 
				A, B, Cin, Sum, answer, (answer == Sum));
		    end
		  #0 $fdisplay(file, "%h %h %b || %h %h %b", 
			       A, B, Cin, Sum, answer, (answer == Sum));
	       end // @(negedge clk)		  
	  end // for (i=0; i < 16; i=i+1)
	$display("%d tests completed with %d errors", vectornum, errors);
	$finish;	
     end 

endmodule // stimulus
