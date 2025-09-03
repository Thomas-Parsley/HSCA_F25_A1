module testbench();

   
   logic clk;
   logic reset;
   logic FSMreset;
   logic [1:0] FSMstate;
   logic a, b, y;
   logic [31:0] vectornum, errors;
   logic [2:0] testvectors[10000:0];
   
   integer 	handle3;
   
   // instantiate device under test
   FSM dut1(a, b, clk, FSMreset, y, FSMstate);
   
   // generate clock
   always 
     begin
	clk = 1'b1;
	forever #5 clk = ~clk;
     end
   
   // at start of test, load vectors and pulse reset
   initial
     begin
	handle3 = $fopen("FSM.out");	
	$readmemb("FSM.tv", testvectors);
	vectornum = 0; errors = 0;
	reset = 1; #22; reset = 0;
     end
   
   // apply test vectors on rising edge of clk
   always @(posedge clk)
     begin
	#1; {a, b, FSMreset} = testvectors[vectornum];
     end
   
   // check results on falling edge of clk
   always @(negedge clk)
     if (~reset) begin // skip during reset
	$fdisplay(handle3,"a b r | y s\n%b %b %b | %b %h\n",
          a, b, FSMreset, y, FSMstate);

	vectornum = vectornum + 1;
	if (vectornum === 4'b1010) begin 
           $display("%d tests completed with %d errors", 
	            vectornum, errors);
           $stop;
	end
     end
endmodule

module FSM (input logic a, b, clk, reset, output logic y, output logic [1:0] FSMstate);

   typedef enum logic [1:0] {S0, S1, S2} statetype;
   statetype state, nextState;
   
   // State Register
   always_ff @ (posedge clk, negedge reset) 
     begin
	if (~reset)
	  state <= S0;
	else
	  state <= nextState;
     end   

   // Next State Logic
   always_comb 
     begin
	case (state)
	  S0: begin
	     nextState = a ? S1 : S0;	     
	     y = 1'b0;
          FSMstate = a ? 2'b01 : 2'b00;
	  end
	  S1: begin
	     nextState = b ? S2 : S0;
	     y = 1'b0;	    
          FSMstate = b ? 2'b10 : 2'b00; 
	  end
	  S2: begin
	     nextState = (a & b) ? S2 : S0;
	     y = (a & b) ? 1'b1 : 1'b0;
          FSMstate = (a & b) ? 2'b10 : 2'b00; 
	  end
	  default: begin
	     nextState = S0;
	     y = 1'b0;
          FSMstate = 2'b00;
	  end
	endcase
     end
  
endmodule