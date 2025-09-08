`default_nettype none
`timescale 1ns / 1ps


/* This testbench just instantiates the module and makes some convenient wires
   that can be driven / tested by the cocotb test.py.
*/
module tb ();

  // Dump the signals to a VCD file. You can view it with gtkwave or surfer.
  initial begin
    $dumpfile("tb.vcd");
    $dumpvars(0, tb);
    #1;
  end

  // Wire up the inputs and outputs:
  reg clk;
  reg rst_n;
  reg ena;
  reg [7:0] ui_in;
  reg [7:0] uio_in;
  wire [7:0] uio_out;
  wire [7:0] uio_oe;
`ifdef GL_TEST
  wire VPWR = 1'b1;
  wire VGND = 1'b0;
`endif

reg cs, wr, demux_ena;
reg [4:0] set_ch;
reg [7:0] uo_out_internal;
assign demux_ena=uo_out_internal[0];
assign wr = uo_out_internal[1];
assign cs = uo_out_internal[2];
assign set_ch = uo_out_internal[7:3];

  // Replace tt_um_example with your module name:
  tt_um_andyshor_demux tt_um_andyshor_demux (

      // Include power ports for the Gate Level test:
`ifdef GL_TEST
      .VPWR(VPWR),
      .VGND(VGND),
`endif

      .ui_in  (8'b00000000),    // Dedicated inputs
      .uo_out (uo_out_internal),   // Dedicated outputs
      .uio_in (uio_in),   // IOs: Input path
      .uio_out(uio_out),  // IOs: Output path
      .uio_oe (uio_oe),   // IOs: Enable path (active high: 0=input, 1=output)
      .ena    (ena),      // enable - goes high when design is selected
      .clk    (clk),      // clock
      .rst_n  (rst_n)     // not reset
  );

endmodule
