module uart (
  input  logic        clk,        // 1 MHz
  input  logic        rst,        
  input  logic        rx,         
  output logic [7:0]  data_out,   
  output logic        data_valid  // Goes high (1) when byte is ready
);

  logic [3:0]   bit_index;   // Tracks the bits that have been received
  logic [7:0]   shift_reg;   // Collects incoming bits
  logic [16:0]  clk_count;   // Counts 104 + 52 = 156
  logic         receiving;   

  localparam int BAUD_TICKS = 104;  // 9600 baud, 1 MHz = 104 µs/bit

  always_ff @(posedge clk or posedge rst) begin
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
        // Start bit detected -> going to start receiving bits
        receiving   <= 1;
        clk_count   <= BAUD_TICKS + (BAUD_TICKS >> 1);  // 1.5 bit periods
        bit_index   <= 0;
      end else if (receiving) begin
        if (clk_count == 0) begin
          shift_reg <= {rx, shift_reg[7:1]};  

          // All bits have been received now
          if (bit_index == 7) begin
            data_out    <= {rx, shift_reg[7:1]};
            data_valid  <= 1;
            receiving   <= 0;
          end else begin
            
            // Get ready for the next bit
            bit_index   <= bit_index + 1;
            clk_count   <= BAUD_TICKS;
          end
        end else begin
          clk_count <= clk_count - 1;
        end
      end
    end
  end

endmodule
