module check();
bit clk;
time clk_period = 20ns;   
  
  initial
    forever #10 clk=!clk;

  property c_checker;
   realtime current_time;
    @(posedge clk)
    (1,current_time=$realtime) |=>(clk_period==$realtime-current_time); //without jitter
  
    //((1,current_time=$realtime)) |=>(clk_period<=($realtime-current_time)>clk_period-0.5ns) || (($realtime-current_time)<(clk_period+0.5ns)); //if clock is with jitter 
  
    endproperty
   
  CLK_FREQ:assert property (c_checker)
    begin
      $display("%t TB_INFO : clock time period match",$time); 
      $display("%t current time ",$time);
    end
    
    else
      $fatal("%t TB_INFO : clock time period mismatch",$time);
  
    initial begin
      $dumpfile("dump.vcd");
      $dumpvars();
      #500 $finish;
    end 
  
endmodule
