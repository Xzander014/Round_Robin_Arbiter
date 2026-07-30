module tb();
    reg clk, reset;
    reg [3:0]request;
    reg [3:0]done;
    wire [3:0]grant;


    arbiter #(4) dut(.*);

    always #5 clk = ~clk;

    initial begin
        reset = 1;
        clk = 0;
        request = 0;
        @(negedge clk) reset = 0;
        @(negedge clk) request = 4'b1011;
                       done = 4'b0000;
                       repeat(3)@(negedge clk);
                       done = 4'b0010;
        #40; done = 4'b0010;
        #10$finish;
    end

    initial begin
        $monitor("clk = %b, reset = %b, request = %b, out = %b", clk, reset, request, grant);
        $dumpfile("tb.vcd");
        $dumpvars(0, tb);
    end

endmodule