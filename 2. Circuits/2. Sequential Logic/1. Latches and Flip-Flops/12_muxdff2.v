module top_module (
    input clk,
    input w, R, E, L,
    output Q
);

    always @(posedge clk) begin
        if(L==1)
            Q <= R;
        else begin
            if (E==0)
                Q <= Q;
            if (E==1)
                Q <= w;
        end
    end
endmodule
