`timescale 1ns/1ps
module memory(input clk,input [3:0] icode, input [63:0] valE, input [63:0] valA, input [63:0] valB, input [63:0] valP,  output reg [63:0] valM,output reg [63:0] value);


reg [63:0] mem[0:1023];
integer i;

always@(*)
begin

//rmmovq
if (icode==4'd4)
	begin
	mem[valE]=valA;
	end

//mrmovq
if (icode==4'd5)
	begin
	valM=mem[valE];
	end

//pushq
if (icode==4'd10)
	begin
	mem[valE]=valA;
	end

//popq
if (icode==4'd11)
	begin
	valM=mem[valE];
	end
	
	
//call
if (icode==4'd8)
	begin
	mem[valE]=valP;
	end

//return
if (icode==4'd9)
	begin
	valM=mem[valA];
	end
	
value=mem[valE];

end
endmodule


