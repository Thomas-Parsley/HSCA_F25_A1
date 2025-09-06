# HSCA Problem 4: Mealy FSM

###### Thomas Parsley - 09/05/25

**Requirements:** *Write an HDL module for the Finte State Machine (FSM) with the state transition diagram
given in Figure 1. Please make sure you adequately test this design include its reset. FSMs are notoriously difficult to verify, so you should write your testbench to adequately test your FSM and demonstrate that is indeed traversing states correctly.*

**FSM Table (Figure 1)**
>state a b reset | y nextstate
>S0 0 x 0 | 0 S0
>S0 1 x 0 | 0 S1
>S1 x 0 0 | 0 S0
>S1 x 1 0 | 0 S2
>S2 0 x 0 | 0 S0
>S2 x 0 0 | 0 S0
>S2 1 1 0 | 1 S0
>SX x x 1 | 0 S0

**.DO File:**
Filename:
> FSM.do

Run Testbench without ModelSim:
> vsim -do FSM.do -c

Run Testbench with ModelSim:
> vsim -do FSM.do

**Testbench:**
Testbench is a module in SV file:
> FSM.sv

**Testvectors:**
Testvectors can be found in the .TV file:
> FSM.tv

Vectors are organized as following:
>a b reset //Variables
>1'bx 1'bx 1'bx//Types
>x_x_x //Input

General vector info:
>a, b // Affect the output of the Mealy FSM
>reset = 1'b0 //Resets state to S0

**Output File:**
Filename:
>FSM.out

The output should be organized as follow:
>a   b   r   | y   s
>1'b 1'b 1'b | 1'b 2'h