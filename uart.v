module uart (
  input              clk,        // 1 MHz
  input              rst,        
  input              rx,         
  output reg [7:0]   data_out,   
  output reg         data_valid  // goes high (1) when byte is ready for one cycle
);

  reg [3:0]  bit_index;   // keeps track of how many bits have been received
  reg [7:0]  shift_reg;   // collects incoming bits
  reg [16:0] clk_count;   // has to count up to 104+52 = 156
  reg        receiving;   

  localparam BAUD_TICKS = 104;        // 9600 baud @ 1 MHz = 104 µs/bit

  always @(posedge clk or posedge rst) begin
    if (rst) begin
      bit_index   <= 0;
      shift_reg   <= 0;
      clk_count   <= 0;
      receiving   <= 0;
      data_out    <= 0;
      data_valid  <= 0;
    end else begin
      
      data_valid <= 0;

      if (!receiving && rx == 0) begin
        // start bit - now receiving
        receiving   <= 1;
        clk_count   <= BAUD_TICKS + (BAUD_TICKS>>1);  
        // 1.5 bit periods, sample the center of first data bit
        bit_index   <= 0;
      end
      
      else if (receiving) begin
        if (clk_count == 0) begin
          // sample and record the bit
          shift_reg <= {rx, shift_reg[7:1]};

          if (bit_index == 7) begin
            // last bit has been received and sampled
            data_out   <= {rx, shift_reg[7:1]};
            data_valid <= 1;
            receiving  <= 0;
          end else begin
            // get ready for the next bit
            bit_index <= bit_index + 1;
            clk_count <= BAUD_TICKS;
          end
        end else begin
          clk_count <= clk_count - 1;
        end
      end
    end
  end

endmodule
