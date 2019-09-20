typedef enum logic [3:0] {
  idle,
  getX,
  zero,

  sumD_loadR1,
  sumD_loadR2,
  sumD_drive,

  sumS_loadR1,
  sumS_loadR2_1,
  sumS_driveR1,
  sumS_loadR2_2,
  sumS_drive,

  compara,
  finaliza
} State;

module sqrt(
  input  logic         clk_i,
  input  logic         rstn_i,

  input  logic         enb_i,
  input  logic [7:0]   dt_i,

  output logic         busy_o,
  output logic [7:0]   dt_o
);

  State state;

  logic [8:0]   d;
  logic [8:0]   s;
  logic [7:0]   x;


  sqrt_proc data_path (
    .clk_i(clk_i),
    .rstn_i(rstn_i),

    .enb_i(enb_i),
    .dt_i(dt_i),

    .state(state),

    .d(d),
    .s(s),
    .x(x),

    .busy_o(busy_o),
    .dt_o(dt_o)
  );

  sqrt_ctrl FSM (
    .clk_i(clk_i),
    .rstn_i(rstn_i),

    .enb_i(enb_i),

    .d(d),
    .s(s),
    .x(x),

    .state(state)
  );

endmodule
