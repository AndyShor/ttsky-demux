![](../../workflows/gds/badge.svg) ![](../../workflows/docs/badge.svg) ![](../../workflows/test/badge.svg) ![](../../workflows/fpga/badge.svg)

# This is an ASIC project created as a part of Zero to ASIC course for submission to SKY130 fab

[Zero to ASIC](https://www.zerotoasiccourse.com/) is a fantastic course that lets everyone to create their own little Aplication Specific Integrated Circuit 
(ASIC) chip all the way through, from HDL code up to an actual chip manufactured and packaged on a PCB.

## ASIC details

This ASIC is designed to control [ADG732](https://www.analog.com/en/products/adg732.html) demultiplexer chip from Analog Devices. ASIC takes internal clock signal of 10 MHz.
Divides it to 1 Hz. At this divided frequency the ASIC increments address value on a 5-bit bus ( using only 25 channels)
and then activates chip select signal (cs) for ADG732 that when on the next clock cycle it receives write (wr) signal
and updates the output channel connected to the input based on the value of the 5-bit address bus.
This task came from the practical need of testing 25 channel cable assemblies with origignal idea to visualize active channels
by LEDs on both sides of the cable assembly, hence frequency division to a human-friendly visual control range.
It's nice on the chip, but makes *.vcd files the size of movies in my teens.

## Related projects

Before submission to the fab shuttle the project was benchmarked on an FPGA dev board using PMOD LED to visualize 5-bit bus.
It was also tested on actual ADG732 chip on a breakout board. Look at the [fpga_demux repo](https://github.com/AndyShor/fpga_demux)

## Preview
This design does not yet physically exist. But rendered view of this tiny chip looks like this

![render](/docs/img/ASIC_7_cropped.png)

