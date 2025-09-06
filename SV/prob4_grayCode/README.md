# HSCA Problem 4: Gray Code FSM

###### Thomas Parsley - 09/05/25

**Requirements:** *Gray codes have a useful property in that consecutive numbers differ in only a single bit position. Design a 3-bit modulo 8 Gray code counter FSM with no inputs and three outputs. (A modulo N counter counts from 0 to N − 1, then repeats. For example, a watch uses a modulo 60 counter for the minutes and seconds that counts from 0 to 59.) When reset, the output should be 000. Oneach clock edge, the output should advance to the next Gray code. After reaching 100, it should repeat with 000.*

**.DO File:**
Filename:
> grayCode.do

Run Testbench without ModelSim:
> vsim -do grayCode.do -c

Run Testbench with ModelSim:
> vsim -do grayCode.do

**Testbench:**
Testbench is a module in SV file:
> grayCode.sv

**Testvectors:**
Testvectors can be found in the .TV file:
> grayCode.tv

Vectors are organized as following:
>reset //Variables
>1'bx//Types
>x //Input

General vector info:
>reset = 1'b0 //Resets to S0

**Output File:**
Filename:
>grayCode.out

The output should be organized as follow:
>reset | y
>1'b   | 1'h