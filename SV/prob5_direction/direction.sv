module testbench();

   
   logic clk;
   logic reset;
   logic FSMreset;
   logic [2:0] y;
   logic direction;
   logic [8:0] vectornum, errors;
   logic [5:0] testvectors[10000:0];
   
   integer 	handle3;
   
   // instantiate device under test
   grayCode dut1(direction, clk, FSMreset, y);
   
   // generate clock
   always 
     begin
	clk = 1'b1;
	forever #5 clk = ~clk;
     end
   
   // at start of test, load vectors and pulse reset
   initial
     begin
      handle3 = $fopen("direction.out");	
      $readmemb("direction.tv", testvectors);
      vectornum = 0; errors = 0;
      reset = 1; #22; reset = 0;
     end/**/
   
   // apply test vectors on rising edge of clk
   always @(posedge clk)
     begin
	#1; {direction, FSMreset} = testvectors[vectornum];
     end
   
   // check results on falling edge of clk
   always @(negedge clk)
     if (~reset) begin // skip during reset
	$fdisplay(handle3,"reset direct | y\n%b     %b      | %h\n",
          FSMreset, direction, y);

	vectornum = vectornum + 1;
	if (testvectors[vectornum] === 6'bx) begin 
           $display("%d tests completed with %d errors", 
	            vectornum, errors);
           $stop;
	end
     end
endmodule

module grayCode (input logic direction, clk, reset, output logic [2:0] y);

  logic [2:0] nextY;

   typedef enum logic [1:0] {S0, S1, S2} statetype;
   statetype state, nextState;
   
   // State Register
   always_ff @ (posedge clk, negedge reset) 
     begin
      if (~reset) begin
        state <= S0;
        y <= 3'b000;
      end
      else begin
        state <= nextState;
        y <= nextY;
      end
     end   

   // Next State Logic
   always_comb 
     begin
	case (state)
	  S0: begin
	     nextState = S1;
	     nextY = 3'b000;
	  end
	  S1: begin
	     nextState = direction ? S1 : S2;
	     nextY = (y >= 3'b100) ? 3'b000 : y + 3'b001;
	  end
	  S2: begin
	     nextState = direction ? S1 : S2;
	     nextY = (y <= 3'b000) ? 3'b100 : y - 3'b001; 
	  end
	  default: begin
	     nextState = S0;
	     nextY = 3'b000;
	  end
	endcase
     end
  
endmodule