# multiplication.do 
# 

# compile, optimize, and start the simulation
vlog FSM.sv 
vopt +acc work.testbench -o workopt 
vsim workopt

# Add waveforms and run the simulation
add wave *
run -all
view wave
