# multiplication.do 
# 

# compile, optimize, and start the simulation
vlog seven_segment_display.sv 
vopt +acc work.testbench -o workopt 
vsim workopt

# Add waveforms and run the simulation
add wave *
run -all
view wave
