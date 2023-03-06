onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider Clock
add wave -noupdate -color Cyan /uadd_tb/clk
add wave -noupdate -divider {Test Bench}
add wave -noupdate /uadd_tb/sig_of
add wave -noupdate -radix unsigned /uadd_tb/in0
add wave -noupdate -radix unsigned /uadd_tb/in1
add wave -noupdate -radix unsigned /uadd_tb/out
add wave -noupdate -radix unsigned /uadd_tb/overflow
add wave -noupdate -divider Module
add wave -noupdate -group Parameters /uadd_tb/DUT/DATA_WIDTH
add wave -noupdate -group Parameters -radix unsigned /uadd_tb/DUT/MAX
add wave -noupdate -group Parameters -radix unsigned /uadd_tb/DUT/ZERO
add wave -noupdate /uadd_tb/DUT/sig_of
add wave -noupdate -radix unsigned -childformat {{{/uadd_tb/DUT/in0[7]} -radix unsigned} {{/uadd_tb/DUT/in0[6]} -radix unsigned} {{/uadd_tb/DUT/in0[5]} -radix unsigned} {{/uadd_tb/DUT/in0[4]} -radix unsigned} {{/uadd_tb/DUT/in0[3]} -radix unsigned} {{/uadd_tb/DUT/in0[2]} -radix unsigned} {{/uadd_tb/DUT/in0[1]} -radix unsigned} {{/uadd_tb/DUT/in0[0]} -radix unsigned}} -subitemconfig {{/uadd_tb/DUT/in0[7]} {-radix unsigned} {/uadd_tb/DUT/in0[6]} {-radix unsigned} {/uadd_tb/DUT/in0[5]} {-radix unsigned} {/uadd_tb/DUT/in0[4]} {-radix unsigned} {/uadd_tb/DUT/in0[3]} {-radix unsigned} {/uadd_tb/DUT/in0[2]} {-radix unsigned} {/uadd_tb/DUT/in0[1]} {-radix unsigned} {/uadd_tb/DUT/in0[0]} {-radix unsigned}} /uadd_tb/DUT/in0
add wave -noupdate -radix unsigned /uadd_tb/DUT/in1
add wave -noupdate -radix unsigned /uadd_tb/DUT/out
add wave -noupdate -radix unsigned /uadd_tb/DUT/overflow
add wave -noupdate /uadd_tb/DUT/_out
add wave -noupdate /uadd_tb/DUT/_overflow
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {32 ps}
