module demux
#(parameter DATA_WIDTH, parameter PORT_COUNT)
(
    input logic [DATA_WIDTH - 1 : 0] in,
    input logic [$clog2(PORT_COUNT) - 1 : 0] sel,
    output logic [DATA_WIDTH - 1 : 0] out [PORT_COUNT - 1 : 0]
);

genvar i;
generate
    for (i = 0; i < PORT_COUNT; i++) begin
        assign out[i] = (sel == i) ? in : '0;
    end
endgenerate
endmodule