`timescale 1ns/1ps
module fetch(input clk,input [63:0] PC,output reg[0:79] instr ,output reg [3:0] rA, output reg [3:0] rB, output reg [3:0] icode, output reg [3:0] ifun, output reg [63:0] valP, output reg [63:0] valC, output reg hlt, output reg valid, output reg error);

integer i;
reg [7:0] mem[0:1023];

// Inputs  - PC, mem
// Outputs - icode, ifun, rA, rB, valC, valP, halt, valid, error


always@(posedge clk)
begin

//OPq
mem[0]=8'b01100000;
mem[1]=8'b01000010;
mem[2]=8'b11001101;
mem[3]=8'b10101011;
mem[4]=8'b10001001;
mem[5]=8'b01100111;
mem[6]=8'b01000000;
mem[7]=8'b01000101;
mem[8]=8'b00100011;
mem[9]=8'b00000001;
// initialising values of error and valid
error =0;
valid = 1'b1;


// checking the value of PC
if (PC>1023 || PC<0)
	begin
	error=1;
	end
	
instr={mem[PC],mem[PC+1],mem[PC+2],mem[PC+3],mem[PC+4],mem[PC+5],
mem[PC+6],mem[PC+7],mem[PC+8], mem[PC+9]};


//computing the values of icode and ifun
icode=instr[0:3];
ifun=instr[4:7];

case(icode)
//halt
4'd0:
	begin
	hlt=1;
	valP=PC+64'd1*64'd8;
	end
//nop
4'd1:
	begin
	valP=PC+64'd1*64'd8;
	end
	
//cmovxx
4'd2:
	begin
	rA=instr[8:11];
	rB=instr[12:15];
	valP=PC+64'd2*64'd8;
	end

//irmovq
4'd3:
	begin
	rA=instr[8:11];
	rB=instr[12:15];
	valP=PC+64'd10*64'd8;
	valC=instr[16:79];
	end
	
//rmmovq
4'd4:
	begin
	rA=instr[8:11];
	rB=instr[12:15];
	valP=PC+64'd10*64'd8;
	valC=instr[16:79];
	end

//mrmovq
4'd5:
	begin
	rA=instr[8:11];
	rB=instr[12:15];
	valP=PC+64'd10*64'd8;
	valC=instr[16:79];
	end

//OPq
4'd6:
	begin
	rA=instr[8:11];
	rB=instr[12:15];
	valP=PC+64'd2*64'd8;
	end

//jxx
4'd7:
	begin
	valP=PC+64'd9*64'd8;
	valC=instr[8:71];
	end
/*
//call
4'd8:
	begin
	valP=PC+64'd9;
	valC=instr[8:71];
	end

//return
4'd9:
	begin
	valP=PC+64'd1;
	end
*/

//pushq
4'd10:
	begin
	rA=instr[8:11];
	rB=instr[12:15];
	valP=PC+64'd2*64'd8;
	end
	
//popq
4'd11:
	begin
	rA=instr[8:11];
	rB=instr[12:15];
	valP=PC+64'd2*64'd8;
	end

default:
	begin
	valid=1'b0;
	end
endcase
end
endmodule
	
	
	
	




