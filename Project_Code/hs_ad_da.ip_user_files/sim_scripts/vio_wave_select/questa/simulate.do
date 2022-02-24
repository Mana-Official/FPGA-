onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib vio_wave_select_opt

do {wave.do}

view wave
view structure
view signals

do {vio_wave_select.udo}

run -all

quit -force
