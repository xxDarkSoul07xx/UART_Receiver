# UART_Receiver

This is a simple UART receiver that I built in Verilog on EDA Playground. 

The module implements a UART Receiver tailored for a 1MHz system clock and 9600 baud serial communication. It detects the start bit, samples incoming bits with a 1.5 bit delay (to ensure stability), and finally assembles the received bit using a shift register. This design also includes a data_valid flag to indicate that a full 8-bit message has been received.

I made this to get more experience with digital design. This is my first project using an HDL language, and I learned about bit alignment, simulation, and timing.

# Features

1. Starts bit detection logic

2. Precise bit sampling using clock count synchronization

3. Shift register for bit accumulation

4. Byte output with validity signaling

5. Configurable baud rate timing using the BAUD_TICKS parameter

6. Synchronous reset

The files include the UART design and the testbench, which sends the UART ASCII '1' - decimal 49. You can see the corresponding waveform in uart_waveform.png.

# Testbench

The testbench module (uart_tb) simulates the transmission of ASCII 1 (0x31). The testbench will use controlled timing and validate the receiver output through messages:

if (data_out == 8'd49)
  $display("PASS: Received ASCII '1' (0x31)");
else
  $display("FAIL: Got %0d instead of 49", data_out);

# July 26 Update:

I have learned some SystemVerilog, so I decided to turn the code from Verilog to SystemVerilog. All functionalities work and are still the same - waveforms are still applicable.


# License

MIT License - feel free to use or modify this; just give credit

Tools used: Icarus Verilog, EDA Playground, EPWave

Possible future improvements include using this to make an LED light blink or a simple game.
