module mux
#(parameter DATA_WIDTH, parameter PORT_COUNT)
(
    input logic [DATA_WIDTH - 1 : 0] in [PORT_COUNT - 1 : 0],
    input logic [$clog2(PORT_COUNT) - 1 : 0] sel,
    output logic [DATA_WIDTH - 1 : 0] out
);

assign out = in[sel];

endmodule