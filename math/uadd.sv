module uadd
#(parameter DATA_WIDTH)
(
    input logic [DATA_WIDTH - 1 : 0] in0, in1,
    output logic [DATA_WIDTH - 1 : 0] out, overflow,
    output logic sig_of
);

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