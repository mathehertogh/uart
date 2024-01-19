`timescale 1ns / 1ps

module top (
    input sysclk_300mhz_p,
    input sysclk_300mhz_n,
    input button_c,
    input uart_rx,
    output uart_tx,
    input uart_cts,
    output led[7:0]
);

// ============================ System Clock `clk` =============================
// Convert the 300 MHz differential system clock to a 30 MHz single-ended clock.
wire clk;
wire locked;
clk_wiz_0 clk_converter (
    .clk_30mhz(clk),
    .reset(0),
    .locked(locked),
    .clk_in1_p(sysclk_300mhz_p),
    .clk_in1_n(sysclk_300mhz_n)
 );

// Note that: 30M / 115200 == 260.4166667.
reg [8:0] cnt; // count 0-259 @30MHz
always @(posedge clk)
    cnt <= cnt == 9'd259 ? 0 : cnt + 1;
wire en_115200hz;
assign en_115200hz = cnt == 0;

reg [16:0] uart_tx_cnt;
always @(posedge clk)
    if (en_115200hz)
        uart_tx_cnt <= uart_tx_cnt == 17'd115199 ? 0 : uart_tx_cnt + 1;

localparam PAYLOAD = 8'h43;
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
assign led[6] = button_c;
assign led[7] = uart_tx_cnt < 4800; // clk_count[24];

endmodule
