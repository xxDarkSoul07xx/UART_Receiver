`timescale 1us/1ns

module uart_tb;

  logic        clk    = 0;
  logic        rst    = 1;
  logic        rx     = 1;
  logic [7:0]  data_out;
  logic        data_valid;

  uart uut (
    .clk(clk),
    .rst(rst),
    .rx(rx),
    .data_out(data_out),
    .data_valid(data_valid)
  );

  // 1 MHz clock (toggle every 0.5 us)
  always #0.5 clk = ~clk;

  initial begin
    $dumpfile("uart.vcd");
    $dumpvars(0, uart_tb);

    #10 rst = 0;

    // Transmit ASCII '1' = 0x31 = 0b0011_0001
    rx = 0;      #104;  // Start bit

    rx = 1;      #104;  // Bit 0 = 1
    rx = 0;      #104;  // Bit 1 = 0
    rx = 0;      #104;  // Bit 2 = 0
    rx = 0;      #104;  // Bit 3 = 0
    rx = 1;      #104;  // Bit 4 = 1
    rx = 1;      #104;  // Bit 5 = 1
    rx = 0;      #104;  // Bit 6 = 0
    rx = 0;      #104;  // Bit 7 = 0

    rx = 1;      #104;  // Stop bit

    #200;

    if (data_out == 8'd49)
      $display("PASS: Received ASCII '1' (0x31)");
    else
      $display("FAIL: Got %0d instead of 49", data_out);

    $finish;
  end

endmodule
