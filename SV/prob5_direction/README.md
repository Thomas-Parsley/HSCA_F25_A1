# HSCA Problem 5: Prob 4 Extension - Direction

###### Thomas Parsley - 09/05/25

**Requirements:** *Extend your modulo 8 Gray code counter from the previous problem to be an UP/DOWN counter by adding an UP input. If U P = 1, the counter advances to the next number. If U P = 0, the counter retreats to the previous number.*

**.DO File:**
Filename:
> direction.do

Run Testbench without ModelSim:
> vsim -do direction.do -c

Run Testbench with ModelSim:
> vsim -do direction.do

**Testbench:**
Testbench is a module in SV file:
> direction.sv

**Testvectors:**
Testvectors can be found in the .TV file:
> direction.tv

Vectors are organized as following:
>direct reset //Variables
>1'bx 1'bx //Types
>x_x //Input

General vector info:
>direction = 1'b1 //Counts UP
>reset = 1'b0 //Resets to S0

**Output File:**
Filename:
>direction.out

The output should be organized as follow:
>reset direct | y
>1'b   1'b    | 1'h