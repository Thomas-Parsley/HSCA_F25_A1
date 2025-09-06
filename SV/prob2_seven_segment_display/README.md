# HSCA Problem 4: Seven Segment Display Decoder

###### Thomas Parsley - 09/05/25

**Requirements:** *Write an HDL module for a hexadecimal seven-segment display decoder. The decoder should handle the digits A, B, C, D, E, and F, as well as 0–9. Also, your write a self-checking testbench for this problem. Create a test vector file containing all 16 test cases. Simulate the circuit and show that it works. Introduce an error in the test vector file and show that the testbench reports a mismatch.*

**.DO File:**
Filename:
> seven_segment_display.do

Run Testbench without ModelSim:
> vsim -do seven_segment_display.do -c

Run Testbench with ModelSim:
> vsim -do seven_segment_display.do

**Testbench:**
Testbench is a module in SV file:
> seven_segment_display.sv

**Testvectors:**
Testvectors can be found in the .TV file:
> seven_segment_display.tv

Vectors are organized as following:
>inHex expected //Variables
>4'bx 7'bx //Types
>xxxx_xxxxxxx //Input

General vector info:
>inHex // Input Hexadecimal for SSD
>expected //Shows what the output should be

**Output File:**
Filename:
>seven_segment_display.out

The output should be organized as follow:
>input = 4'b || output = 7'b || expected = 7'b
