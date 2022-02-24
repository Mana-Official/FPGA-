onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib rom_wave_sawtooth_opt

do {wave.do}

view wave
view structure
view signals

do {rom_wave_sawtooth.udo}

run -all

quit -force
