# UART_Receiver

This is a simple UART receiver that I built in Verilog on EDA Playground. It runs at 9600 baud, with a 1 MHz clock. The module will read data from the 'rx' line, sample each bit it receives, and then output it to 'data_out' with a one-cycle pulse on 'data_valid'.

I made this to get more experience with digital design. This is my first Verilog project, and I learned about bit alignment, simulation, and timing.

Here is a step by step overview of what it does:
1. Waits for a start bit on 'rx'
2. Samples 8 data bits (least significant bit first) one by one at the right intervals
3. Once 8 bits are sampled, outputs the full byte on 'data_out'
4. Pulses 'data_valid' for one cycle to signal that the byte is ready

The files include the UART design and the testbench, which sends the UART ASCII '1' - decimal 49. You can see the corresponding waveform in uart_waveform.png.

Tools used: Icarus Verilog, EDA Playground, EPWave

Possible future improvements include using this to make an LED light blink or a simple game.
**
July 26 Update:**

I have learned some SystemVerilog, so I decided to turn the code from Verilog to SystemVerilog. All functionalities work and are still the same - waveforms are still applicable.

MIT License - feel free to use or modify this; just give credit
