/*
////
== uadd

Takes in two `n` bit signals (`in0` and `in1`), and signals the sum of `in0` and `in1` on `out`.

If `out` is unable to encode the sum of `in0` and `in1` and would overflows,`out` is pulled high, `sig_ov` is pulled high, and `overflow` carries the magnitude `out` was overflowed by.

=== Parameters

- `DATA_WIDTH`: Input parameter setting the width of the signals `in0`,in1`,out`, and `overflow`. `DATA_WIDTH` has no value by default.

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
| A signal carrying the first term of the sum.
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
| A signal carrying the second term of the sum.
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
| A signal carrying the sum of `in0` and `in1`. If `out` cannot encode the sum of `in0` and `in1` `out` is pulled high.
|===

[cols="25%,75%"]
|===
| Name
| `overflow`

| Size
| `DATA_WIDTH` as `[DATA_WIDTH - 1 : 0]`

| Encoding
| Unsigned Integer

| Description
| A signal carrying the magnitude that `out` would overflow if the sum of `in0` and `in1` cannot be encoded by `out`. If `out` is capable of encoding the sum of `in0` and `in1`, `overflow' is pulled low. 
|===

[cols="25%,75%"]   
|===
| Name
| `sig_ov`

| Size
| `1`

| Encoding
| Boolean

| Description
| A signal carrying the overflow condition of `out`. `sig_ov` is pulled high if `out` is overflowed by the sum of `in0` and `in1` and otherwise is pulled low.
|===
////
*/

module uadd
#(parameter DATA_WIDTH)
(
    input logic [DATA_WIDTH - 1 : 0] in0, in1,
    output logic [DATA_WIDTH - 1 : 0] out, overflow,
    output logic sig_of
);

//
logic [DATA_WIDTH - 1 : 0] MAX;
assign MAX = '1;
logic [DATA_WIDTH - 1 : 0] ZERO;
assign ZERO = '0;

logic [DATA_WIDTH : 0] sum;
logic [DATA_WIDTH : 0] diff;

always_comb begin
    sum = {1'b0, in0} + {1'b0, in1};
    sig_of = sum[DATA_WIDTH];

    out = sig_of ? MAX : sum[DATA_WIDTH - 1 : 0];
    diff = sum - {1'b0, MAX};
    overflow = sig_of ? diff[DATA_WIDTH - 1 : 0] : ZERO;
end
endmodule

module uadd_tb();
    import std_types::*;
    bool clk, sig_of;
    u8 in0, in1, out, overflow;

    uadd #(.DATA_WIDTH(U8)) DUT (
        .in0(in0),
        .in1(in1),
        .out(out),
        .overflow(overflow),
        .sig_of(sig_of)
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