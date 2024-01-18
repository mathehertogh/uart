`timescale 1ns / 1ps

module led_blink(
    input sysclk_300mhz_p,
    input sysclk_300mhz_n,
    input button_c,
    input uart_rx,
    output uart_tx,
    input uart_cts,
    output led[7:0]
    );

//////////////////////////////////   CLOCK   ///////////////////////////////////
wire clk_30mhz;
wire locked;
clk_wiz_0 clk_converter
 (.clk_30mhz(clk_30mhz),
  .reset(0),
  .locked(locked),
  .clk_in1_p(sysclk_300mhz_p),
  .clk_in1_n(sysclk_300mhz_n)
 );

reg [32:0] clk_count;
always @(posedge clk_30mhz)
    clk_count <= clk_count + 1;

wire clk_en;
assign clk_en = clk_count[24:0] == 0;

// Note that: 30M / 115200 == 260.4166667.
reg [11:0] clk_115200hz_cnt;
always @(posedge clk_30mhz)
    clk_115200hz_cnt <= clk_115200hz_cnt == 12'd259 ? 0 : clk_115200hz_cnt + 1;
wire clk_115200hz_en;
assign clk_115200hz_en = clk_115200hz_cnt == 0;

///////////////////////////////////   UART   ///////////////////////////////////
reg uart_rx_hold;
always @(posedge clk_30mhz)
    if (clk_en)
        uart_rx_hold <= uart_rx;

reg [16:0] uart_tx_cnt;
always @(posedge clk_30mhz)
    if (clk_115200hz_en)
        uart_tx_cnt <= uart_tx_cnt == 17'd115199 ? 0 : uart_tx_cnt + 1;

localparam PAYLOAD = 8'h42;
assign uart_tx = uart_tx_cnt == 0 ? 1'b0 : // start bit
                 uart_tx_cnt == 1 ? PAYLOAD[0] :
                 uart_tx_cnt == 2 ? PAYLOAD[1] :
                 uart_tx_cnt == 3 ? PAYLOAD[2] :
                 uart_tx_cnt == 4 ? PAYLOAD[3] :
                 uart_tx_cnt == 5 ? PAYLOAD[4] :
                 uart_tx_cnt == 6 ? PAYLOAD[5] :
                 uart_tx_cnt == 7 ? PAYLOAD[6] :
                 uart_tx_cnt == 8 ? PAYLOAD[7] :
                 1'b1; // stop bit + 115190*idle

///////////////////////////////////   LEDs   ///////////////////////////////////
assign led[0] = uart_rx_hold;
assign led[1] = uart_cts;
assign led[6] = button_c;
assign led[7] = uart_tx_cnt < 4800; // clk_count[24];

endmodule
