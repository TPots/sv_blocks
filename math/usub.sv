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