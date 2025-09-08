/*
 * Copyright (c) 2024 Your Name
 * SPDX-License-Identifier: Apache-2.0
 */

`default_nettype none
`timescale 1ns / 100ps

module tt_um_andyshor_demux (
    input  wire [7:0] ui_in,    // Dedicated inputs
    output reg [7:0] uo_out,   // Dedicated outputs
    input  wire [7:0] uio_in,   // IOs: Input path
    output wire [7:0] uio_out,  // IOs: Output path
    output wire [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // always 1 when the design is powered, so you can ignore it
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
);

wire rst= !rst_n;
reg demux_ena ;
reg wr ;
reg cs ;
reg [4:0] set_ch;
assign uio_oe = 8'b00000000;
assign uio_out = 8'b00000000;




demux #(.CLK_DIVIDER(24'd10000000)) demux  (
	.clk(clk), // clock signal from the board
	.rst(rst), // reset signal from the board
    	.ena(demux_ena),         // enable signal to ADG732
    	.wr(wr),           // write signal to ADG732
    	.cs(cs),           // chip select output for ADG732
    	.set_ch(set_ch)  // set output channel

);



assign uo_out = {set_ch,cs, wr, demux_ena};

endmodule
