`timescale 1ns / 1ps
module memory_;
reg clk;
reg [3:0] icode;
reg [63:0] valE;
reg [63:0] valA;
reg [63:0] valB;
reg [63:0] valP;

output [63:0] valM;
output [63:0] value;



memory memory(
    .icode(icode),
    .valE(valE),
    .valA(valA),
    .valB(valB),
    .valP(valP),
    .valM(valM),
    .value(value)
  );
  always #10 clk = ~clk ;
initial begin 

	icode=4'd3;
	valE=4;
    	valA=12;
	valB=14;
	valP=2;
clk = 1;
	#10 icode=4'd5;
        
end 
  
initial begin
	$monitor("icode=%b | valE=%b |\n valA=%b | valB=%b | valP=%b | valM=%b | value=%b \n",icode, valE, valA, valB, valP, valM, value);
	#10 $finish;
	end 
endmodule
