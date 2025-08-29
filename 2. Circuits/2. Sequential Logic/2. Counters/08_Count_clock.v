module top_module(
    input clk,
    input reset,
    input ena,
    output pm,
    output [7:0] hh,
    output [7:0] mm,
    output [7:0] ss); 

    always @(posedge clk)begin
        if(reset==1)begin
            hh <= 8'h12;
            mm <= 8'h00;
            ss <= 8'h00;
            pm <= 0;
        end
        else if (ena) begin
            if (hh == 8'h11 && mm == 8'h59 && ss == 8'h59)begin
                hh <= 8'h12;
          	  	mm <= 8'h00;
            	ss <= 8'h00;
            	pm <= ~pm;
            end
            else if (hh == 8'h12 && mm == 8'h59 && ss == 8'h59)begin
                hh <= 8'h01;
          	  	mm <= 8'h00;
            	ss <= 8'h00;
            end
            else if (hh == 8'h09 && mm == 8'h59 && ss == 8'h59)begin
                hh <= 8'h10;
          	  	mm <= 8'h00;
            	ss <= 8'h00;
            end
            else if (mm == 8'h59 && ss == 8'h59)begin
                hh <= hh+8'h01;
                mm <= 8'h00;
            	ss <= 8'h00;
            end
            else if (mm[3:0] == 4'h9 && ss == 8'h59)begin
                mm[7:4] <= mm[7:4]+4'h1;
                mm[3:0] <= 4'h0;
            	ss <= 8'h00;
            end
            else if(ss == 8'h59)begin
                mm <= mm+8'h01;
            	ss <= 8'h00;
            end
            else if(ss[3:0] == 4'h9)begin
                ss[7:4] <= ss[7:4]+4'h1;
                ss[3:0] <= 4'h0;
            end
            else 
                ss <= ss+8'h01;
        end 
    end
            
endmodule
