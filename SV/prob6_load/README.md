# HSCA Problem 6: Prob 5 Modification - Load

###### Thomas Parsley - 09/05/25

**Requirements:** *Extend your modulo 8 Gray code counter from the previous problem to be an UP/DOWN counter by adding an UP input. If U P = 1, the counter advances to the next number. If U P = 0, the counter retreats to the previous number.*

**.DO File:**
Filename:
> load.do

Run Testbench without ModelSim:
> vsim -do load.do -c

Run Testbench with ModelSim:
> vsim -do load.do

**Testbench:**
Testbench is a module in SV file:
> load.sv

**Testvectors:**
Testvectors can be found in the .TV file:
> load.tv

Vectors are organized as following:
>load direct reset value //Variables
>1'bx 1'bx 1'bx 3'bxxx //Types
>x_x_x_xxx //Input

General vector info:
>load = 1'b1 //Output is set to value
>direction = 1'b1 //Counts UP
>reset = 1'b0 //Resets to S0
>value = 3'bxxx //Value to be loaded

**Output File:**
Filename:
>load.out

The output should be organized as follow:
>load value reset direct | y
>1'b  3'h   1'b   1'b    | 2'h