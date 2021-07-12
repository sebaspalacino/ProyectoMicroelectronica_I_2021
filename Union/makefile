all: veriCode gtkOnda sedsyn

veriCode:
	iverilog -o out ./all.v
	vvp out

gtkOnda:
	gtkwave ./result.vcd

sedsyn:
	sed 's/mux/mux_synth/g' system.v > system_synth.v

clean:
	rm ./*.vcd ./out ./*synth*
