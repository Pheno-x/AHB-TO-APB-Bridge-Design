module ahb_apb_top (
  input wire        hclk,
  input wire        hresetn,
  input wire        hwrite,
  input wire        hreadyin,
  input wire [1:0]  htrans,
  input wire [31:0] haddr,
  input wire [31:0] hwdata,
  input wire [31:0] prdata,

  output wire [31:0] hrdata,
  output wire [1:0]  hresp,
  output wire        hreadyout,

  output wire        pwrite,
  output wire        penable,
  output wire [2:0]  pselx,
  output wire [31:0] pwdata,
  output wire [31:0] paddr
  

);

  // Internal signals
  wire [31:0] haddr1, haddr2;
  wire [31:0] hwdata1, hwdata2;
  wire [2:0]  tempselx;
  wire        valid;
  wire        hwritereg, hwritereg1;

  // AHB Slave Instantiation
  ahb_slave ahb_S(
    hclk, hresetn, hwrite, hreadyin, htrans, haddr, hwdata, prdata,
    haddr1, haddr2, hwdata1, hwdata2, tempselx, valid, hwritereg,
    hwritereg1, hrdata, hresp, hreadyout
  );

  // APB Controller Instantiation
  apb_controller apb_c(
    hclk, hresetn, valid, hwrite, haddr, hwdata,
    haddr1, haddr2, hwdata1, hwdata2, hwritereg,
    tempselx, hreadyout, pwrite, penable, pselx, pwdata, paddr
);

endmodule
