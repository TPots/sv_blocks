module leading_zeros
#(parameter SIZE)
(
    input logic [SIZE - 1 : 0] in,
    output logic [$clog2(SIZE) - 1 : 0] out
);

logic [SIZE - 1 : 0] _in;
logic [SIZE - 1 : 0] zero_bits;

assign _in = {<<{in}};

genvar i;
generate
    for (i = 0; i < SIZE ; i++) begin
        assign zero_bits[i] = ~|_in[i : 0];
    end
endgenerate

always_comb begin
    out = '0;
    foreach(zero_bits[idx]) begin
        if (zero_bits[idx]) begin
            out += 1'b1;
        end
        else begin
            out = out;
        end
    end
end

endmodule


module leading_zeros_tb();

localparam SIZE_IN = 8;
localparam SIZE_OUT = $clog2(SIZE_IN);

logic clk;
logic [SIZE_IN - 1 : 0] in;
logic [SIZE_OUT - 1 : 0] out;

leading_zeros #(.SIZE(SIZE_IN)) DUT(
    .in(in),
    .out(out)
);

initial begin
clk = '0;
in = '0;
forever begin
    clk = ~clk;
    #1;
end
end

always @(posedge clk) begin
    in <= $urandom();
end

endmodule