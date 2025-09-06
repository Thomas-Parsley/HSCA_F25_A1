# HSCA Problem 4: 64 Bit Behavioral Multiplication

###### Thomas Parsley - 09/05/25

**Requirements:** *Z = A × B. You should treat both A and B as unsigned and two’s complement 64-bit values and use behavioral constructs to design your HDL. That is, it should output both unsigned and two’s complement results (i.e., 2 outputs). Make sure you adequately test your design with a testbench.*

**.DO File:**
Filename:
> multiplication.do

Run Testbench without ModelSim:
> vsim -do multiplication.do -c

Run Testbench with ModelSim:
> vsim -do multiplication.do

**Testbench:**
Testbench is a module in SV file:
> multiplication.sv

**Testvectors:**
Testvectors can be found in the .TV file:
> multiplication.tv

Vectors are organized as following:
>A B TCexp USexp //Variables
>64'hx 64'hx 128'hx 128'hx //Types
>xxxxxxxxxxxxxxxx_xxxxxxxxxxxxxxxx_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx //Input

General vector info:
>inHex // Input Hexadecimal for SSD
>expected //Shows what the output should be

**Output File:**
Filename:
>multiplication.out

The output should be organized as follow:
>64'h 64'h || TCresult: 128'h | TCexpected: 128'h || USresult: 128'h | USexpected: 128'h ||
