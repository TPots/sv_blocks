/*
////
== usub

Takes in two signals (`in0` and `in1`), and signals the differenece of `in0` and `in1` on `out`.

If `out` is unable to encode the difference of `in0` and `in1` and would result in underflow, `out` is pulled low, `sig_ov` is pulled high, and `underflow` carries the magnitude `out` was underflowed by.

=== Parameters

- `DATA_WIDTH`: Input parameter setting the width of the signals `in0`,in1`,out`, and `underflow`. `DATA_WIDTH` has no value by default.

=== Inputs

[cols="25%,75%"]
|===
| Name
| `in0`

| Size
| `DATA_WIDTH` as `[DATA_WIDTH - 1 : 0]`

| Encoding
| Unsigned Integer

| Description
| A signal carrying the first term of the difference.
|===

[cols="25%,75%"]
|===
| Name
| `in0`

| Size
| `DATA_WIDTH` as `[DATA_WIDTH - 1 : 0]`

| Encoding
| Unsigned Integer

| Description
| A signal carrying the second term of the difference.
|===

=== Outputs

[cols="25%,75%"]
|===
| Name
| `out`

| Size
| `DATA_WIDTH` as `[DATA_WIDTH - 1 : 0]`

| Encoding
| Unsigned integer

| Description
| A signal carrying the difference of `in0` and `in1`. If `out` cannot encode the difference of `in0` and `in1` it is pulled low.
|===

[cols="25%,75%"]
|===
| Name
| `underflow`

| Size
| `DATA_WIDTH` as `[DATA_WIDTH - 1 : 0]`

| Encoding
| Unsigned Integer

| Description
| A signal carrying the magnitude that `out` would underflow if the differnece of `in0` and `in1` cannot be encoded by `out`. If `out` is capable of encoding the difference of `in0` and `in1`, `underflow' is pulled low. 
|===

[cols="25%,75%"]
|===
| Name
| `sig_uv`

| Size
| `1`

| Encoding
| Boolean

| Description
| A signal carrying the overflow condition of `out`. `sig_uv` is pulled high if `out` is overflowed by the sum of `in0` and `in1` and otherwise is pulled low.
|===
////
*/

module usub
#(parameter DATA_WIDTH)
(
    input logic [DATA_WIDTH - 1 : 0] in0, in1,
    output logic [DATA_WIDTH - 1 : 0] out, underflow,
    output logic sig_uf
);

logic [DATA_WIDTH - 1 : 0] MAX;
assign MAX = '1;
logic [DATA_WIDTH - 1 : 0] ZERO;
assign ZERO = '0;

logic [DATA_WIDTH : 0] difference;

always_comb begin
    difference = {1'b0, in0} - {1'b0, in1};
    sig_uf = difference[DATA_WIDTH];

    out = sig_uf ? ZERO : difference;
    underflow = sig_uf ? ~difference[DATA_WIDTH - 1 : 0] + {{DATA_WIDTH - 1{1'b0}}, 1'b1} : ZERO;
end
endmodule

module usub_tb();
    import std_types::*;
    bool clk, sig_uf;
    u8 in0, in1, out, underflow;

    usub #(.DATA_WIDTH(U8)) DUT (
        .in0(in0),
        .in1(in1),
        .out(out),
        .underflow(underflow),
        .sig_uf(sig_uf)
    );

    initial begin
        clk = 0;
        in0 = '0;
        in1 = '0;
        forever begin
            clk = ~clk;
            #1;
        end
    end

    always @(posedge clk) begin
        in0 = $urandom();
        in1 = $urandom();
    end
endmodule