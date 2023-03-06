module encoder
#(parameter DATA_WIDTH, localparam MAX_COUNT_BITS = $clog2(DATA_WIDTH) + 1)
(
    input logic [DATA_WIDTH - 1 : 0] in,
    output logic [MAX_COUNT_BITS - 1 : 0] out
);

logic [DATA_WIDTH - 1 : 0] mux_chain [DATA_WIDTH - 1 : 0];
logic [DATA_WIDTH - 1 : 0] mux_values [DATA_WIDTH : 0];
logic [DATA_WIDTH - 1 : 0] _out;

genvar i;
generate

    for (i = 0; i <= DATA_WIDTH; i++) begin
        assign mux_values[i] = i[DATA_WIDTH - 1 : 0];
    end

    for (i = 0; i < DATA_WIDTH; i++) begin : mux
        if (i == 0) begin
            binmux #(.DATA_WIDTH(DATA_WIDTH)) mux_i (
                .in0(mux_values[i]),
                .in1(mux_values[i + 1]),
                //.sel(~|in[DATA_WIDTH - 1 : i + 1] && in[i]),
                .sel(in[i]),
                .out(mux_chain[i])
            );
        end
        else if (i == DATA_WIDTH - 1) begin
            binmux #(.DATA_WIDTH(DATA_WIDTH)) mux_i (
                .in0(mux_chain[i - 1]),
                .in1(mux_values[i + 1]),
                .sel(in[i]),
                .out(mux_chain[i])
            );
        end
        else begin
            binmux #(.DATA_WIDTH(DATA_WIDTH)) mux_i (
                .in0(mux_chain[i - 1]),
                .in1(mux_values[i + 1]),
                //.sel(~|in[DATA_WIDTH - 1 : i + 1] && in[i]),
                .sel(in[i]),
                .out(mux_chain[i])
            );
        end
    end
endgenerate

always_comb begin
    _out = mux_chain[DATA_WIDTH - 1];
    out = _out[MAX_COUNT_BITS - 1 : 0];
end

endmodule

module encoder_tb();
import std_types::*;

bool clk;
u8 in;
logic [$clog2(U8) : 0] out;

encoder #(.DATA_WIDTH(U8)) DUT (
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