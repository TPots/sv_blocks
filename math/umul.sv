/*
////
== umul

Takes in two `n` bit signals (`in0` and `in1`), and outputs the product on the signal `out`.

If `out` is unable to encode the product of `in0`, and `in1` it is pulled high and the overflow is singaled on the output `sig_of`.

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
| Unsigned Integer

| Description
| A signal carrying the second term of the product.
|===


[cols="25%,75%"]
|===
| Name
| `in1`

| Size
| `DATA_WIDTH` as `[DATA_WIDTH - 1 : 0]`

| Encoding
| Unsigned Integer

| Description
| A signal carrying the second term of the product.
|===

==== Outputs

[cols="25%,75%"]
|===
| Name
| `out`

| Size
| `DATA_WIDTH` as `[DATA_WIDTH - 1 : 0]`

| Encoding
| Unsigned Integer

| Description
| A signal carrying the product of `in0` and `in1`. If `out` cannot enocde the product of `in0` and `in1`, `out` is pulled high.
|===

[cols="25%,75%"]
|===
| Name
| `sig_ov`

| Size
| 1

| Encoding
| Boolean

| Description
| | A signal carrying the overflow condition of `out`. `sig_ov` is pulled high if `out` is overflowed by the product of `in0` and `in1` and otherwise is pulled low.
|===

////
*/

module umul
#(parameter DATA_WIDTH)
(
    input logic [DATA_WIDTH - 1 : 0] in0, in1,
    output logic [DATA_WIDTH- 1 : 0] out,
    output logic sig_ov
);

logic [DATA_WIDTH - 1 : 0] MAX;
assign MAX = '1;
logic [DATA_WIDTH - 1 : 0] ZERO;
assign ZERO = '0;

logic [2 * DATA_WIDTH - 1 : 0] sum [DATA_WIDTH];
logic [2 * DATA_WIDTH - 1 : 0] product;

genvar i;
generate
    for(i = 0; i < SIZE; i++ ) begin
        assign sum[i] = in1[i] ? {2 * DATA_WIDTH{1'b0}} + (in0 << i) : '0;
    end

    always_comb begin
        product = '0;
        for (i = 0; i < SIZE; i++) begin
            product += sum[i];
        end
    end
endgenerate

always_comb begin
    sig_of = ~|product[2*SIZE - 1 : SIZE];
    out = sig_of ? MAX : product[SIZE - 1 : 0];
end

endmodule

module umul_tb();

import std_types::*;

bool clk, sig_of;
u8 in0, in1, out;
umul #(.SIZE(SIZE)) DUT (
    .in0(in0),
    .in1(in1),
    .out(out),
    .sig_ov(sig_ov)
);

initial begin
    clk = 0;
    in0 = 0;
    in1 = 0;
    forever begin
        clk = ~clk;
        #1;
    end
end

always @(posedge clk) begin
    in0 = $urandom_range(0,$pow(2,SIZE));
    in1 = $urandom_range(0,$pow(2,SIZE/2));
end

endmodule