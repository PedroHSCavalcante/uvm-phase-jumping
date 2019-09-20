//Top
module top;
  import uvm_pkg::*;
  import pkg::*;
  logic clk;
  logic clk_rb;
  logic rst;

  initial begin
    clk = 1;
    clk_rb = 1;
    rst = 1;
    #20 rst = 0;
    #20 rst = 1;
  end

  always #1 clk = !clk;
  always #4 clk_rb = !clk_rb;

  interface_if dut_if(.clk(clk), .rst(rst));
  interface_rb rb_if(.clk(clk_rb), .rst(rst));
  
  datapath dp(.clk_ula(clk),
              .clk_reg(clk_rb),
              .rst(rst),
              .valid_reg(rb_if.valid_i),
              .addr(rb_if.addr),
              .data_in(rb_if.data_i),
              .reg_sel(dut_if.reg_sel),
              .valid_ula(dut_if.valid_i),
              .instru(dut_if.instru),
              .A(dut_if.data_i),
              .data_out(dut_if.data_o),
              .valid_out(dut_if.valid_o)
  );

  initial begin
    `ifdef XCELIUM
       $recordvars();
    `endif
    `ifdef VCS
       $vcdpluson;
    `endif
    `ifdef QUESTA
       $wlfdumpvars();
       set_config_int("*", "recording_detail", 1);
    `endif

    uvm_config_db#(interface_vif)::set(uvm_root::get(), "*.env_h.mst.*", "vif", dut_if);
    uvm_config_db#(rb_vif)::set(uvm_root::get(), "*.env_h.mst_rb.*", "vif", rb_if);

    run_test("simple_test");
  end
endmodule
