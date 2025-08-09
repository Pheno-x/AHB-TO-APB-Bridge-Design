module apb_controller(
    hclk, hresetn, valid, hwrite, haddr, hwdata,
    haddr1, haddr2, hwdata1, hwdata2, hwritereg,
    tempselx, hreadyout, pwrite, penable, pselx, pwdata, paddr
);

input valid, hwritereg, hclk, hresetn, hwrite;
input [31:0] haddr1, haddr2, hwdata1, hwdata2, haddr, hwdata;
input [2:0] tempselx;
output reg pwrite, penable;
output reg [2:0] pselx;
output reg hreadyout;
output reg [31:0] pwdata, paddr;

parameter
    st_idle = 3'b000,
    st_wwait = 3'b001,
    st_write = 3'b010,
    st_writep = 3'b011,
    st_wenablep = 3'b100,
    st_wenable = 3'b101,
    st_read = 3'b110,
    st_renable = 3'b111;

reg [2:0] state, next_state;
reg [31:0] paddr_temp, pwdata_temp;
reg penable_temp, pwrite_temp, hreadyout_temp;
reg [2:0] pselx_temp;

always @(posedge hclk) begin
    if (!hresetn)
        state <= st_idle;
    else
        state <= next_state;
end

always @(*) begin
    case (state)
        st_idle: begin
            if (valid && hwrite)
                next_state = st_wwait;
            else if (valid && !hwrite)
                next_state = st_read;
            else
                next_state = st_idle;
        end

        st_wwait: begin
            if (valid)
                next_state = st_writep;
            else
                next_state = st_write;
        end

        st_writep: next_state = st_wenablep;

        st_write: begin
            if (valid)
                next_state = st_wenablep;
            else
                next_state = st_wenable;
        end

        st_wenablep: begin
            if (valid && hwritereg)
                next_state = st_writep;
            else if (!hwritereg)
                next_state = st_read;
            else if (!valid)
                next_state = st_write;
            else
                next_state = st_wenablep;
        end

        st_wenable: begin
            if (valid && !hwrite)
                next_state = st_read;
            else if (!valid)
                next_state = st_idle;
            else
                next_state = st_wenable;
        end

        st_read: next_state = st_read;

        st_renable: begin
            if (valid && !hwrite)
                next_state = st_read;
            else if (valid && hwrite)
                next_state = st_wwait;
            else if (!valid)
                next_state = st_idle;
            else
                next_state = st_renable;
        end

        default: next_state = st_idle;
    endcase
end

always @(*) begin
    case (state)
        st_idle: begin
            if (valid) begin
                pselx_temp = 3'b0;
                penable_temp = 1'b0;
                hreadyout_temp = 1'b1;
            end else if (valid && !hwrite) begin
                paddr_temp = haddr;
                pwrite_temp = 1'b0;
                pselx_temp = tempselx;
                hreadyout_temp = 1'b0;
                penable_temp = 1'b0;
            end else begin
                pselx_temp = 3'b0;
                hreadyout_temp = 1'b1;
                penable_temp = 1'b0;
            end
        end

        st_wwait: begin
            paddr_temp = haddr1;
            pwrite_temp = hwrite;
            pselx_temp = tempselx;
            hreadyout_temp = 1'b0;
            pwdata_temp = hwdata;
        end

        st_write: begin
            paddr_temp = haddr2;
            hreadyout_temp = 1'b0;
            penable_temp = 1'b0;
            pwdata_temp = hwdata;
        end

        st_read: begin
            hreadyout_temp = 1'b1;
            penable_temp = 1'b1;
        end

        st_renable: if (valid && hwrite) begin
            pselx_temp = 3'b0;
            penable_temp = 1'b0;
            hreadyout_temp = 1'b1;
        end else if (valid && !hwrite) begin
            paddr_temp = haddr;
            pwdata_temp = hwdata;
            pselx_temp = tempselx;
            hreadyout_temp = 1'b0;
            penable_temp = 1'b0;
        end else begin
            pselx_temp = 3'b0;
            hreadyout_temp = 1'b1;
            penable_temp = 1'b0;
        end
    endcase
end

always @(posedge hclk) begin
    if (!hresetn) begin
        penable <= 0;
        pselx <= 0;
        hreadyout <= 1'b1;
    end else begin
        pwrite <= pwrite_temp;
        penable <= penable_temp;
        pselx <= pselx_temp;
        pwdata <= pwdata_temp;
        paddr <= paddr_temp;
        hreadyout <= hreadyout_temp;
    end
end

endmodule
