module ahb_slave (
    hclk, hresetn, hwrite, hreadyin, htrans, haddr, hwdata, prdata,
    haddr1, haddr2, hwdata1, hwdata2, tempselx, valid, hwritereg,
    hwritereg1, hrdata, hresp, hreadyout
);
input         hclk;
input         hresetn;
input         hwrite;
input         hreadyin;
input  [1:0]  htrans;
input  [31:0] haddr;
input  [31:0] hwdata;
input  [31:0] prdata;

output reg [31:0] haddr1;
output reg [31:0] haddr2;
output reg [31:0] hwdata1;
output reg [31:0] hwdata2;
output reg [2:0]  tempselx;
output reg        valid;
output reg        hwritereg;
output reg        hwritereg1;
output reg [31:0] hrdata;
output reg [1:0]  hresp;
output            hreadyout;

assign hreadyout = 1'b1;

// Address registers
always @(posedge hclk or negedge hresetn) begin
    if (!hresetn) begin
        haddr1 <= 32'd0;
        haddr2 <= 32'd0;
    end else begin
        haddr1 <= haddr;
        haddr2 <= haddr1;
    end
end

// Data registers
always @(posedge hclk or negedge hresetn) begin
    if (!hresetn) begin
        hwdata1 <= 32'd0;
        hwdata2 <= 32'd0;
    end else begin
        hwdata1 <= hwdata;
        hwdata2 <= hwdata1;
    end
end

// Write signal registers
always @(posedge hclk or negedge hresetn) begin
    if (!hresetn) begin
        hwritereg <= 1'b0;
        hwritereg1 <= 1'b0;
    end else begin
        hwritereg <= hwrite;
        hwritereg1 <= hwritereg;
    end
end

// Address decoding for peripheral selection
always @(posedge hclk or negedge hresetn) begin
    if (!hresetn) begin
        tempselx <= 3'b000;
    end else begin
        if (haddr >= 32'h8000_0000 && haddr < 32'h8400_0000)
            tempselx <= 3'b001;
        else if (haddr >= 32'h8400_0000 && haddr < 32'h8800_0000)
            tempselx <= 3'b010;
        else if (haddr >= 32'h8800_0000 && haddr < 32'h8c00_0000)
            tempselx <= 3'b100;
        else
            tempselx <= 3'b000;
    end
end

// Transaction validity
always @(posedge hclk or negedge hresetn) begin
    if (!hresetn) begin
        valid <= 1'b0;
    end else begin
        valid <= (htrans != 2'b00);
    end
end

// Read data
always @(posedge hclk or negedge hresetn) begin
    if (!hresetn) begin
        hrdata <= 32'd0;
    end else if (!hwrite) begin
        hrdata <= prdata;
    end
end

// Response
always @(posedge hclk or negedge hresetn) begin
    if (!hresetn) begin
        hresp <= 2'b00;
    end else begin
        hresp <= 2'b00;
    end
end

endmodule
