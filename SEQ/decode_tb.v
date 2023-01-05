`timescale 1ns/1ps
module decode_tb;
reg clk;
output [63:0] valA,valB;
reg [3:0]icode,rA,rB;
reg [63:0] R0,R1,R2,R3,R4,R5,R6,R7,R8,R9,R10,R11,R12,R13,R14;
decode Dec1(clk,icode,rA,rB,valA,valB,R0,R1,R2,R3,R4,R5,R6,R7,R8,R9,R10,R11,R12,R13,R14);

initial begin
R0 = 64'd1;
R1 = 64'd2;
R2 = 64'd3;
R3 = 64'd4;
R4 = 64'd5;
R5 = 64'd6;
R6 = 64'd7;
R7 = 64'd8;
R8 = 64'd9;
R9 = 64'd10;
R10 = 64'd11;
R11 = 64'd12;
R12 = 64'd13;
R13 = 64'd14;
R14 = 64'd15;
end

always #10 clk = ~clk ;
initial 
begin 

$monitor($time,"icode = %d, rA = %d , rB = %d , valA = %d , valB = %d",icode,rA,rB,valA,valB);
icode  = 4'd6 ; rA = 4'd0 ; rB = 4'd2 ; clk  = 1;
#10 icode = 4'd8 ; 
#10 icode = 4'b1011 ; 
#10 icode = 4'd5 ; rA = 4'd1; rB = 4'd7;

#10 icode = 4'd9 ; 
#50 $finish;
end

endmodule 
