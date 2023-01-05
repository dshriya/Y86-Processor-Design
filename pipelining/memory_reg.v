`timescale 1ns / 1ps
module memory_reg( input CLK, input [2:0] E_status, input [3:0] E_icode, input [3:0] E_rA, input [3:0] E_rB, input [63:0] E_valC, input [63:0] E_valP, input [63:0] E_valA, input [63:0] E_valB, input E_Cnd, input [63:0] E_valE, output reg [2:0] m_status, output reg [3:0] m_icode, output reg [3:0] m_rA, output reg [3:0] m_rB, output reg [63:0] m_valC, output reg [63:0] m_valP, output reg [63:0] m_valA, output reg [63:0] m_valB, output reg m_Cnd, output reg [63:0] m_valE);

always@(posedge CLK)
begin
m_status <= E_status;
m_icode <= E_icode;
m_rA <= E_rA;
m_rB <= E_rB;
m_valC <= E_valC;
m_valP <= E_valP;
m_valA <= E_valA;
m_valB <= E_valB;
m_Cnd <= E_Cnd;
m_valE <= E_valE;
end
endmodule
