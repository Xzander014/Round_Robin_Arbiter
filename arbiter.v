module arbiter #(parameter N = 4)(
    input clk, reset,
    input [N-1:0]request, done,
    output reg [N-1:0]grant
);

    reg [N-1:0]last_grant;
    reg [1:0]counter; 

    wire [N-1:0]upper_mask = {N{1'b0}}|(~((last_grant)|(last_grant-1'b1)));

    wire [N-1:0]higher_request = upper_mask & request;  
    wire [N-1:0]lower_request = ~upper_mask & request;

    function [N-1:0]granter;
        
        input [N-1:0]request;
        integer i;begin
        granter = {N{1'b0}};
        for(i = N-1; i >=0; i = i-1)
            if(request[i])
                granter = ({{(N-1){1'b0}}, 1'b1} << i);
        end
    endfunction
    
    wire [N-1:0]next_grant = |higher_request ? granter(higher_request) : granter(lower_request);

    always@(posedge clk or posedge reset) begin
        if(reset) begin
            grant <= {N{1'b0}};
            last_grant <= {{(N-1){1'b0}}, 1'b1};
            counter <= 2'b0;
        end
        else if(|request) begin
            if(counter == 3 || |(grant & done)) begin
                grant <= next_grant;
                last_grant <= next_grant;
                counter <= 2'b0;
            end
            else if(!(|( grant & request ))) begin
                grant <= next_grant;
                last_grant <= next_grant;
                counter <= 2'b0;
            end
            else 
                counter <= counter + 1;
        end
        else begin
            grant <= {N{1'b0}};
            counter <= 2'b0;
        end
    end
endmodule