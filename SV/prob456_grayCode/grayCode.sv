module testbench();

   
   logic clk;
   logic reset;
   logic FSMreset;
   logic [2:0] value, y;
   logic direction, load;
   logic [8:0] vectornum, errors;
   logic [5:0] testvectors[10000:0];
   
   integer 	handle3;
   
   // instantiate device under test
   grayCode dut1(load, direction, clk, FSMreset, value, y);
   
   // generate clock
   always 
     begin
	clk = 1'b1;
	forever #5 clk = ~clk;
     end
   
   // at start of test, load vectors and pulse reset
   initial
     begin
      handle3 = $fopen("grayCode.out");	
      $readmemb("grayCode.tv", testvectors);
      vectornum = 0; errors = 0;
      reset = 1; #22; reset = 0;
     end/**/
   
   // apply test vectors on rising edge of clk
   always @(posedge clk)
     begin
	#1; {load, direction, FSMreset, value} = testvectors[vectornum];
     end
   
   // check results on falling edge of clk
   always @(negedge clk)
     if (~reset) begin // skip during reset
	$fdisplay(handle3,"load value reset direct | y\n%b    %h     %b     %b      | %h\n",
          load, value, FSMreset, direction, y);

	vectornum = vectornum + 1;
	if (vectornum === 5'b11000) begin 
           $display("%d tests completed with %d errors", 
	            vectornum, errors);
           $stop;
	end
     end
endmodule

module grayCode (input logic load, direction, clk, reset, input logic [2:0] value, output logic [2:0] y);

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
	     nextY = (load) ? value : 3'b000;
	  end
	  S1: begin
	     nextState = direction ? S1 : S2;
	     nextY = (load) ? value : ((y >= 3'b100) ? 3'b000 : y + 3'b001);
	  end
	  S2: begin
	     nextState = direction ? S1 : S2;
	     nextY = (load) ? value : ((y <= 3'b000) ? 3'b100 : y - 3'b001); 
	  end
	  default: begin
	     nextState = S0;
	     nextY = (load) ? value : 3'b000;
	  end
	endcase
     end
  
endmodule