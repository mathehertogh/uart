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

wire uart_ready;
localparam PAYLOAD = 8'h45;
uart_controller uart_controller (
    .clk(clk),
    .pin_cts(uart_cts),
    .pin_tx(uart_tx),
    .ready(uart_ready),
    .data(PAYLOAD)
);

///////////////////////////////////   LEDs   ///////////////////////////////////
assign led[7] = button_c;

endmodule
