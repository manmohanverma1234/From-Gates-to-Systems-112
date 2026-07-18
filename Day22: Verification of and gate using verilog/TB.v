module and_tb;
  reg a,b;
  wire y;
  
  and_gate a1(.a(a),.b(b),.y(y));
  
    integer pass_count = 0;
    integer fail_count = 0;
    integer test_no = 0;

  
    initial begin
      $dumpfile("and.vcd");
      $dumpvars(0, and_tb);
    end

    // Monitor Signals
    initial begin
        $monitor("Time=%0t | a=%b b=%b y=%b",$time, a, b, y);
    end

 
  
  task check_output;
    input expected;
    
    if(y==expected) begin 
      pass_count=pass_count+1;
      $display("test_case_no=%0d : PASS,expected=%d,Actual=%d",test_no,expected,y); 
    end
    else begin
      fail_count=fail_count+1;
      $display("test_case_no=%0d : FAIL ,expected=%d,Actual=%d",test_no,expected,y);
    end
  endtask
  
  task apply_test;
    input a_test;
    input b_test;
    reg expected;
    begin
      test_no = test_no + 1;
      
      expected=a_test & b_test;
      
         $display("---------------------------------------");
         $display("Running Test Case %0d", test_no);
      
      a=a_test;
      b=b_test;
      
      #10 check_output(expected);
    end
  endtask
  initial begin
    
        $display("========================================");
        $display("      AND Gate Verification Started");
        $display("========================================");
    
    apply_test(0,0);
    #10
    apply_test(0,1);
    #10
    apply_test(1,0);
    #10
    apply_test(1,1);
    
    // Random Testing
        $display("\n--- Random Testing ---");

        repeat(10) begin
            apply_test($random, $random);
        end
    
     // Simulation Summary
        $display("\n======================================");
        $display("Simulation Completed");
        $display("Total Test Cases = %0d", test_no);
        $display("PASS = %0d", pass_count);
        $display("FAIL = %0d", fail_count);
        $display("======================================");
    
    #10 $finish;
  end
endmodule
