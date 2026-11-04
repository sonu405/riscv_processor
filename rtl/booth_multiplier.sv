`timescale 1ns / 1ps

module booth_multiplier #(
    parameter int n = 32
)(
    input logic clk, rst, start, sign,
    input logic signed [n-1:0] Q, M, 
    output logic finish, 
    output logic [2*n-1:0] out);

// total 2n + 3 bits as 2n + 2 bits for extended operands and one bit for Q_(-1)
logic signed [2*n+2:0] AQ_reg,  CAQ_reg; // AQ for signed, CAQ for unsigned
logic signed [n:0] Q_us, M_us, M_us_bar, Q_s, M_s, M_s_bar; // N+1 bits because we extend by 1 bit
logic [n-1:0] counter; // TODO: set correctly




logic busy;

always_ff@(posedge clk or posedge rst) begin

if (rst) begin
    AQ_reg  <= 0;
    CAQ_reg <= 0;
    busy    <= 0;
    finish  <= 0;
end

if (start && !busy) begin
    // latching values of Q and M got at the start
    // using these temps are necessary due to the nature of non-blocking assignments.
    
    logic signed [n:0] Q_us_temp, M_us_temp, Q_s_temp, M_s_temp;
    Q_us_temp = {1'b0, Q};
    M_us_temp = {1'b0, M};
    
    Q_s_temp  = {Q[n-1], Q};
    M_s_temp  = {M[n-1], M};
    
    // For unsigned
    Q_us <= Q_us_temp;
    M_us <= M_us_temp;
    M_us_bar <= ~M_us_temp + 1;
    
      
    // For signed
    M_s <= M_s_temp; // Extending for signed using MSB
    M_s_bar <= ~M_s_temp + 1;
    Q_s <= Q_s_temp;


    AQ_reg  <= {{n{1'b0}}, Q_s_temp,  1'b0};
    CAQ_reg <= {{n{1'b0}}, Q_us_temp, 1'b0};
    busy    <= 1;
    finish  <= 0;
end
else if (busy && !finish) begin
    case (sign)
    // UNSIGNED
    1'b0: begin
        if (CAQ_reg[1] == 1'b0 && CAQ_reg[0] == 1'b1)  begin 
        // n + 2 shift because we want to add M_us to the Accumalator bits.
        // Visualize using 4 bits for it to make sense.
            CAQ_reg <= (CAQ_reg +  (M_us << n+2)) >>> 1; 
        end
        else if (CAQ_reg[1] == 1'b1 && CAQ_reg[0] == 1'b0) begin 
            CAQ_reg <= (CAQ_reg +  (M_us_bar << n+2)) >>> 1;
        end
        else CAQ_reg <= CAQ_reg >>> 1 ; // we always do this.            
    end
    // SIGNED
    1'b1: begin
        if (AQ_reg[1] == 1'b0 && AQ_reg[0] == 1'b1) begin
            AQ_reg <= (AQ_reg +  (M_s << n+2)) >>> 1;
        end
        else if (AQ_reg[1] == 1'b1 && AQ_reg[0] == 1'b0) begin
            AQ_reg <= (AQ_reg +  (M_s_bar << n+2)) >>> 1;
        end
        else AQ_reg <= AQ_reg >>> 1 ; // we always do this.
    end
    endcase
end
end


always_ff@(posedge clk or posedge rst) begin
if ((start && !busy) || rst) counter = 0;

if (busy && !finish) begin
   if (counter == n+1) begin
       if (sign) begin
           out <=  AQ_reg[2*n:1]; 
           finish <= 1;
           busy   <= 0;
       end
       else begin
           out <= CAQ_reg[2*n:1];
           finish <= 1;
           busy   <= 0;
       end
   end 
   else counter <= (counter + 1); // this is else of counter == 5
end

if (~start && ~busy) begin
    finish <= 0;
end
end
endmodule


