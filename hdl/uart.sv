module uart_counter (
        input             clk,
        output            en_115200hz, // clk's 115200Hz enable signal
        output reg [16:0] cnt_115200hz // count 0-115199 @115200Hz 
);

// Note that: 30M / 115200 == 260.4166667.
reg [8:0] cnt; // count 0-259 @30MHz
always @(posedge clk)
    cnt <= cnt == 9'd259 ? 0 : cnt + 1;
assign en_115200hz = cnt == 0;

always @(posedge clk)
    if (en_115200hz)
        cnt_115200hz <= cnt_115200hz == 17'd115199 ? 0 : cnt_115200hz + 1;

endmodule

module uart_controller (
        input        clk,
        // UART device interface:
        input        pin_cts,
        output       pin_tx,
        // CPU interface:
        output       ready,
        input  [7:0] data
);

wire en_115200hz;
wire [16:0] cnt_115200hz;
uart_counter uart_counter (
        .clk(clk),
        .en_115200hz(en_115200hz),
        .cnt_115200hz(cnt_115200hz)
);

assign pin_tx = cnt_115200hz == 0 ? 1'b0 : // start bit
                 cnt_115200hz == 1 ? data[0] :
                 cnt_115200hz == 2 ? data[1] :
                 cnt_115200hz == 3 ? data[2] :
                 cnt_115200hz == 4 ? data[3] :
                 cnt_115200hz == 5 ? data[4] :
                 cnt_115200hz == 6 ? data[5] :
                 cnt_115200hz == 7 ? data[6] :
                 cnt_115200hz == 8 ? data[7] :
                 1'b1; // stop bit + 115190*idle

endmodule
