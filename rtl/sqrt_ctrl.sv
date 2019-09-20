module sqrt_ctrl(
  input  logic         clk_i,
  input  logic         rstn_i,

  input  logic         enb_i,

  input  logic [8:0]   d,
  input  logic [8:0]   s,
  input  logic [7:0]   x,

  output State         state
);
  
  State state_nxt;

  always_comb begin
    state_nxt = idle;
    

    case(state)
      idle: begin
        state_nxt = getX;
      end
      getX: begin
        state_nxt = compara;
      end

      sumD_loadR1: begin
        state_nxt = sumD_loadR2;
      end
      sumD_loadR2: begin
        state_nxt = sumD_drive;
      end
      sumD_drive: begin
        state_nxt = sumS_loadR1;
      end

      sumS_loadR1: begin
        state_nxt = sumS_loadR2_1;
      end
      sumS_loadR2_1: begin
        state_nxt = sumS_driveR1;
      end
      sumS_driveR1: begin
        state_nxt = sumS_loadR2_2;
      end
      sumS_loadR2_2: begin
        state_nxt = sumS_drive;
      end
      sumS_drive: begin
        state_nxt = compara;
      end
	zero:  state_nxt = idle;

      compara: begin
	if(x==0)
	  state_nxt = zero;
        else begin 
          if(s<=x)
            state_nxt = sumD_loadR1;
          else
            state_nxt = finaliza;
        end
      end
      finaliza: begin
        state_nxt = idle;
      end
    endcase
  end

  always_ff @(posedge clk_i, negedge rstn_i) begin
    if(~rstn_i)
      state <= idle;
    else
      if(enb_i)
        state <= state_nxt;
  end


endmodule
