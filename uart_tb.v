`timescale 1us/1ns

module uart_tb;

  reg        clk    = 0;
  reg        rst    = 1;
  reg        rx     = 1;
  wire [7:0] data_out;
  wire       data_valid;

  uart_led uut (
    .clk(clk), 
    .rst(rst), 
    .rx(rx),
    .data_out(data_out), 
    .data_valid(data_valid)
  );

  // 1 MHz clock that will toggle every 0.5 µs
  always #0.5 clk = ~clk;

  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0, uart_led_tb);

    #10 rst = 0;

    // Send ASCII '1' = 0x31
    rx = 0;      #104;  // start bit

    rx = 1;      #104;  // bit0 = 1
    rx = 0;      #104;  // bit1 = 0
    rx = 0;      #104;  // bit2 = 0
    rx = 0;      #104;  // bit3 = 0
    rx = 1;      #104;  // bit4 = 1
    rx = 1;      #104;  // bit5 = 1
    rx = 0;      #104;  // bit6 = 0
    rx = 0;      #104;  // bit7 = 0

    rx = 1;      #104;  // stop bit

    // Time for the DUT to process
    #200;

    if (data_out == 8'd49)
      $display("Received ASCII '1' (%0d)", data_out);
    else
      $display("Received %0d instead of 49", data_out);

    $finish;
  end

endmodule
