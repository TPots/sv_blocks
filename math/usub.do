onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider Clock
add wave -noupdate /usub_tb/clk
add wave -noupdate -divider {Test Bench}
add wave -noupdate /usub_tb/sig_uf
add wave -noupdate -radix unsigned /usub_tb/in0
add wave -noupdate -radix unsigned /usub_tb/in1
add wave -noupdate -radix unsigned /usub_tb/out
add wave -noupdate -radix unsigned /usub_tb/underflow
add wave -noupdate -divider Module
add wave -noupdate -group Parameters /usub_tb/DUT/DATA_WIDTH
add wave -noupdate -group Parameters /usub_tb/DUT/MAX
add wave -noupdate -group Parameters /usub_tb/DUT/ZERO
add wave -noupdate -radix unsigned /usub_tb/DUT/in0
add wave -noupdate -radix unsigned /usub_tb/DUT/in1
add wave -noupdate -radix unsigned /usub_tb/DUT/out
add wave -noupdate -radix unsigned -childformat {{{/usub_tb/DUT/underflow[7]} -radix unsigned} {{/usub_tb/DUT/underflow[6]} -radix unsigned} {{/usub_tb/DUT/underflow[5]} -radix unsigned} {{/usub_tb/DUT/underflow[4]} -radix unsigned} {{/usub_tb/DUT/underflow[3]} -radix unsigned} {{/usub_tb/DUT/underflow[2]} -radix unsigned} {{/usub_tb/DUT/underflow[1]} -radix unsigned} {{/usub_tb/DUT/underflow[0]} -radix unsigned}} -subitemconfig {{/usub_tb/DUT/underflow[7]} {-height 16 -radix unsigned} {/usub_tb/DUT/underflow[6]} {-height 16 -radix unsigned} {/usub_tb/DUT/underflow[5]} {-height 16 -radix unsigned} {/usub_tb/DUT/underflow[4]} {-height 16 -radix unsigned} {/usub_tb/DUT/underflow[3]} {-height 16 -radix unsigned} {/usub_tb/DUT/underflow[2]} {-height 16 -radix unsigned} {/usub_tb/DUT/underflow[1]} {-height 16 -radix unsigned} {/usub_tb/DUT/underflow[0]} {-height 16 -radix unsigned}} /usub_tb/DUT/underflow
add wave -noupdate /usub_tb/DUT/sig_uf
add wave -noupdate -radix unsigned /usub_tb/DUT/difference
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {60 ps} 0}
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
WaveRestoreZoom {40 ps} {104 ps}
