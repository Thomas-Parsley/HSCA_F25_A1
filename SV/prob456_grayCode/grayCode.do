# multiplication.do 
# 

# compile, optimize, and start the simulation
vlog grayCode.sv 
vopt +acc work.testbench -o workopt 
vsim workopt

# Add waveforms and run the simulation
add wave *
add wave /testbench/dut1/state
add wave /testbench/dut1/nextState
run -all
view wave
