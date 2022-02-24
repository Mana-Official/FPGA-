onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib ila_grid_opt

do {wave.do}

view wave
view structure
view signals

do {ila_grid.udo}

run -all

quit -force
