/*
////
== binmux

Takes in two n bits signals (`in0`, `in1`), a single bit selector (`sel`), and outputs a n bit signal `out`.

If sel is high, the signal `in1` is carried on `out` otherwise, the signal `in0` is carried on `out`.

==== Parameters

- `DATA_WIDTH`: Input parameter setting the width of the signals `in0`,in1`,out`, and `overflow`. `DATA_WIDTH` has no value by default.

==== Inputs

[cols="25%,75%"]
|===
| Name
| `in0`

| Size
| `DATA_WIDTH` as `[DATA_WIDTH - 1 : 0]`

| Encoding
| Any

| Description
| The default signal of the bianry muxtiplexer.
|===

[cols="25%,75%"]
|===
| Name
| `in1`

| Size
| `DATA_WIDTH` as `[DATA_WIDTH - 1 : 0]`

| Encoding
| Any

| Description
| The selected signal of the bianry muxtiplexer.
|===

[cols="25%,75%"]
|===
| Name
| `sel`

| Size
| 1

| Encoding
| Boolean

| Description
| The select signal of the bianry multiplexer.
|===

==== Outputs

[cols="25%,75%"]
|===
| Name
| `out`

| Size
| `DATA_WIDTH` as `[DATA_WIDTH - 1 : 0]`

| Encoding
| Any

| Description
| The selected signal from the binary multiplexer. If `sel` is high, carries the signal `in1`, otherwise carried the signal of `in0`.
|===

////
*/

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