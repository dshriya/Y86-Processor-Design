`timescale 1ns/1ps
module fetch_tb;
//inputs
output [0:79] instr;
reg [63:0] PC;
reg clk;

//outputs
output [3:0] icode;
wire [3:0] ifun;
wire [3:0] rA;
wire [3:0] rB;
wire [63:0] valP;
wire [63:0] valC;

fetch fetch (.clk(clk),.PC(PC), .instr(instr), .icode(icode), .ifun(ifun), .rA(rA), .rB(rB), .valP(valP), .valC(valC));
always #10 clk = ~clk ;
initial begin
$dumpfile ("fetch.vcd");
$dumpvars (0,fetch_tb);


end
initial begin
		$monitor("PC=%d \ninstr=%b \nicode= %b\nifun=%b \nrA=%b \nrB=%b \nvalC=%d \nvalP=%d\n",PC,instr,icode,ifun,rA,rB,valC,valP);
		PC=64'd0; clk = 1;
	#30 $finish ;
	end
endmodule
