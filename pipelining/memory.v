`timescale 1ns / 1ps
module memory(input clk, input [3:0] M_icode,input [63:0] M_valE , M_valA,M_valB,M_valP,output reg [63:0] m_valM,m_value);

reg [63:0] mem[0:1023];

always@(*)
begin

//rmmovq
if (M_icode==4'd4)
	begin
	mem[M_valE]=M_valA;
	end

//mrmovq
if (M_icode==4'd5)
	begin
	m_valM=mem[M_valE];
	end

//pushq
if (M_icode==4'd10)
	begin
	mem[M_valE]=M_valA;
	end

//popq
if (M_icode==4'd11)
	begin
	m_valM=mem[M_valE];
	end
	
	
//call
if (M_icode==4'd8)
	begin
	mem[M_valE]=M_valP;
	end

//return
if (M_icode==4'd9)
	begin
	m_valM=mem[M_valA];
	end
	
m_value=mem[M_valE];

end
endmodule
