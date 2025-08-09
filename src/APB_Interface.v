module APB_Interface(
    input pwrite,
    input penable,
    input [2:0] pselx,
    input [31:0] paddr,
    input [31:0] pwdata,
    output pwrite_out,
    output penable_out,
    output [2:0] psel_out,
    output [31:0] paddr_out,      // <-- Added
    output [31:0] pwdata_out,     // <-- Added
    output reg [31:0] prdata
);

assign pwrite_out = pwrite;
assign psel_out = pselx;
assign paddr_out = paddr;
assign pwdata_out = pwdata;
assign penable_out = penable;

always @(*) begin
    if (!pwrite && penable) begin
        prdata = 8'd25;
    end else begin
        prdata = 32'd0; // <-- optional: prevents latch
    end
end

endmodule
