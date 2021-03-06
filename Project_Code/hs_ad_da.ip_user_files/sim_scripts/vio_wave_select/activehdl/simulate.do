onbreak {quit -force}
onerror {quit -force}

asim -t 1ps +access +r +m+vio_wave_select -L xpm -L xil_defaultlib -L unisims_ver -L unimacro_ver -L secureip -O5 xil_defaultlib.vio_wave_select xil_defaultlib.glbl

do {wave.do}

view wave
view structure

do {vio_wave_select.udo}

run -all

endsim

quit -force
