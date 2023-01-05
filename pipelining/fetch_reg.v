`timescale 1ns / 1ps
module fetch_reg(input CLK,input [63:0] predPC, output reg [63:0] f_predPC
);  

always@(posedge CLK)
begin
f_predPC <= predPC;
end
endmodule


