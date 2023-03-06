module umul
#(parameter DATA_WIDTH)
(
    input logic [DATA_WIDTH - 1 : 0] in0, in1,
    output logic [DATA_WIDTH- 1 : 0] out, overflow,
    output logic sig_ov
);

logic [DATA_WIDTH - 1 : 0] MAX;
assign MAX = '1;
logic [DATA_WIDTH - 1 : 0] ZERO;
assign ZERO = '0;

logic [2 * DATA_WIDTH - 1 : 0] sum [DATA_WIDTH];
logic [2 * DATA_WIDTH - 1 : 0] product;
logic [2 * DATA_WIDTH - 1 : 0] difference;

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
    difference = {MAX, MAX} - product;
    overflow = sig_of ? difference[SIZE - 1 : 0] : ZERO;
end

endmodule

module umul_tb();

import std_types::*;

bool clk, sig_of;
u8 in0, in1, out, overflow;
umul #(.SIZE(SIZE)) DUT (
    .in0(in0),
    .in1(in1),
    .out(out),
    .overflow(ov),
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