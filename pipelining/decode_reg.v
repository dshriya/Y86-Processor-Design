`timescale 1ns / 1ps
module decode_reg( input CLK, input [2:0] F_status, input [3:0] F_icode, input [3:0] F_ifun, input [3:0] F_rA, input [3:0] F_rB, input [63:0] F_valC, input [63:0] F_valP, output reg [2:0] d_status, output reg [3:0] d_icode, output reg [3:0] d_ifun, output reg [3:0] d_rA, output reg [3:0] d_rB, output reg [63:0] d_valC, output reg [63:0] d_valP);

always@(posedge CLK)
begin

d_status<=F_status;
d_rA<=F_rA;
d_rB<=F_rB;
d_valC<=F_valC;
d_icode<=F_icode;
d_ifun<=F_ifun;
d_valP<=F_valP;
end
endmodule
