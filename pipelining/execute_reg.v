`timescale 1ns / 1ps
module execute_reg( input CLK, input [2:0] D_status, input [3:0] D_icode, input [3:0] D_ifun, input [3:0] D_rA, input [3:0] D_rB, input [63:0] D_valC, input [63:0] D_valP, input [63:0] D_valA, input [63:0] D_valB, output reg [2:0]  e_status, output reg [3:0]  e_icode, output reg [3:0]  e_ifun, output reg [3:0]  e_rA, output reg [3:0]  e_rB, output reg [63:0] e_valC, output reg [63:0] e_valP, output reg [63:0] e_valA, output reg [63:0] e_valB);

always@(posedge CLK)
begin
e_icode <= D_icode;
e_rB <= D_rB;
e_valA <= D_valA;
e_ifun <= D_ifun;
e_valB <= D_valB;
e_valC <= D_valC;
e_status <= D_status;
e_valP <= D_valP;
e_rA <= D_rA;

end
endmodule
