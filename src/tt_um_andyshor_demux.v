/*
 * Copyright (c) 2024 Your Name
 * SPDX-License-Identifier: Apache-2.0
 */

`default_nettype none

module tt_um_andyshor_demux (
    input  wire [7:0] ui_in,    // Dedicated inputs
    output wire [7:0] uo_out,   // Dedicated outputs
    input  wire [7:0] uio_in,   // IOs: Input path
    output wire [7:0] uio_out,  // IOs: Output path
    output wire [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // always 1 when the design is powered, so you can ignore it
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
);

wire rst= !rst_n;
wire demux_ena = uo_out[0];
wire wr = uo_out[1];
wire cs = uo_out[2];
wire [4:0] set_ch = uo_out[7:3];
assign uio_oe = 8'b00000000;
assign uio_in = 8'b00000000;
assign ui_in = 8'b00000000;



demux #(.CLK_DIVIDER(24'd10000000)) demux  (
	.clk(clk), // clock signal from the board
	.rst(rst), // reset signal from the board
    	.ena(demux_ena),         // enable signal to ADG732
    	.wr(wr),           // write signal to ADG732
    	.cs(cs),           // chip select output for ADG732
    	.set_ch(set_ch)  // set output channel

);

endmodule
