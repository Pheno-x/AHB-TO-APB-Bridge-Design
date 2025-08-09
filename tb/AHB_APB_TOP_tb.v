module AHB_APB_TOP_tb;

// Clock and reset
reg hclk;
reg hresetn;

// AHB signals
wire hwrite, hreadyin;
wire [1:0] htrans, hresp;
wire [31:0] haddr, hwdata, hrdata;
wire hreadyout;

// APB signals
wire pwrite, penable;
wire [2:0] pselx;
wire [31:0] pwdata, paddr, prdata;

// Clock generation
initial begin
  hclk = 0;
  forever #10 hclk = ~hclk;
end

// Reset logic
initial begin
  hresetn = 0;
  #20;
  hresetn = 1;
end

// Instantiate AHB Master
AHB_Master  ahb_m (
    hclk, hresetn, hreadyout, hrdata,
    haddr, hwdata, hwrite, hreadyin, htrans
);

// Instantiate AHB to APB Interface (Top-level bridge module)
ahb_apb_top ahb_apb_top_I(
  hclk, hresetn, hwrite, hreadyin, htrans, haddr, hwdata, prdata,
  hrdata, hresp, hreadyout,
  pwrite, penable, pselx, pwdata, paddr
);


// Instantiate APB Interface (used for simulation only)
APB_Interface  apb_I(
    pwrite, penable, pselx, paddr, pwdata,
    pwrite_out, penable_out, psel_out, paddr_out, pwdata_out, prdata
);

// Reset task
task reset();
begin
  @(negedge hclk);
  hresetn = 1'b0;
  @(negedge hclk);
  hresetn = 1'b1;
end
endtask

// Test sequence
initial begin
  reset();
  // Assuming these tasks are defined in AHB_Master module
  //ahb_m.single_write();
  //ahb_m.burst_write();
  //ahb_m.single_read();
  #200 $finish;
end

endmodule
