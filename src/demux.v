`default_nettype none
`timescale 1ns / 100ps
module demux #(parameter CLK_DIVIDER = 24'd10000000) (
	input  wire       clk, // clock signal from the board
	input  wire       rst, // reset signal from the board
    output reg ena,         // enable signal to ADG732
    output reg wr,           // write signal to ADG732
    output reg cs,           // chip select output for ADG732
    output reg [4:0] set_ch  // set output channel
);

localparam STATE_COUNTING = 2'd0 ; // counting - wr to low, count clock for division
localparam STATE_PREP = 2'd1 ; //states prep - set cs and new channel values 
localparam STATE_UPDATE= 2'd2 ; //update - load new values by wr l-> H
//localparam CLK_DIVIDER = 24'd10000000; // clock divider value, 10M by default

reg [23:0] clk_count; //24 bit counter for 10 million clock divider
reg div_clk;
reg [1:0] state; // register keeping the machine state

always @(posedge clk) begin
    if (rst) begin
        clk_count<=0;
        ena <= 0;
        div_clk <=0;
        state <= STATE_COUNTING;
        set_ch <=0;

    end else begin
	    if (clk_count>= CLK_DIVIDER) begin
		state <= STATE_PREP;        
		div_clk <= ~div_clk;
		clk_count <= 0;
		set_ch <= set_ch+1;
		wr <= 0;
		cs <=1;
		ena <= 0;
	    end else begin
		clk_count <=  clk_count+1;
		cs <=0;
	    end
	    
	    if (state==STATE_PREP) begin
	     wr <= 1;
	     cs <=1;
	     state<=STATE_COUNTING;

	    end

	    if (state==STATE_COUNTING) begin
	    wr <= 0;
	    
	    end
	    


	    if (set_ch>=25) begin
	     set_ch<= 0;
	    end
    end
    

end

endmodule
