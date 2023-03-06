module binmux
#(parameter DATA_WIDTH)
(
    input logic [DATA_WIDTH - 1 : 0] in0, in1,
    input logic sel,
    output logic [DATA_WIDTH - 1 : 0] out
);

always_comb begin
    out = sel ? in1 : in0;
end

endmodule

module binmux_tb();
import std_types::*;

bool clk, sel;
u8 in0, in1, out;

binmux #(.DATA_WIDTH(U8)) DUT (
    .in0(in0),
    .in1(in1),
    .sel(sel),
    .out(out)
);

initial begin
    clk = '0;
    in0 = '0;
    in1 = '0;
    sel = '0;
    forever begin
        clk = ~clk;
        #1;
    end
end

always @(posedge clk) begin
    in0 <= $urandom();
    in1 <= $urandom();
    sel <= $urandom();
end
endmodule