`timescale 1ns/1ps
module wb_tb ;
reg Cnd,clk;
reg [3:0]icode,rA,rB;
reg [63:0]valM,valE;
reg [63:0]R0,R1,R2,R3,R4,R5,R6,R7,R8,R9,R10,R11,R12,R13,R14;
output [63:0]Ro0,Ro1,Ro2,Ro3,Ro4,Ro5,Ro6,Ro7,Ro8,Ro9,Ro10,Ro11,Ro12,Ro13,Ro14;
reg [63:0]Rin,Rout[0:14];
writeback W1(clk,icode,Cnd,valM,valE,rA,rB,R0,R1,R2,R3,R4,R5,R6,R7,R8,R9,R10,R11,R12,R13,R14,Ro0,Ro1,Ro2,Ro3,Ro4,Ro5,Ro6,Ro7,Ro8,Ro9,Ro10,Ro11,Ro12,Ro13,Ro14);
always #10 clk = ~clk ;
initial begin
R0 = 64'd0;
R1 = 64'd1;
R2 = 64'd2;
R3 = 64'd3;
R4 = 64'd4;
R5 = 64'd5;
R6 = 64'd6;
R7 = 64'd7;
R8 = 64'd8;
R9 = 64'd9;
R10 = 64'd10;
R11 = 64'd11;
R12 = 64'd12;
R13 = 64'd13;
R14 = 64'd14;

Rout[0] = Ro0 ;
Rout[1] = Ro1 ;
Rout[2] = Ro2 ;
Rout[3] = Ro3 ;
Rout[4] = Ro4 ;
Rout[5] = Ro5 ;
Rout[6] = Ro6 ;
Rout[7] = Ro7 ;
Rout[8] = Ro8 ;
Rout[9] = Ro9 ;
Rout[10] = Ro10 ;
Rout[11] = Ro11 ;
Rout[12] = Ro12 ;
Rout[13] = Ro13 ;
Rout[14] = Ro14 ;

Rin[0] = R0 ;
Rin[1] = R1 ;
Rin[2] = R2 ;
Rin[3] = R3 ;
Rin[4] = R4 ;
Rin[5] = R5 ;
Rin[6] = R6 ;
Rin[7] = R7 ;
Rin[8] = R8 ;
Rin[9] = R9 ;
Rin[10] = R10 ;
Rin[11] = R11 ;
Rin[12] = R12 ;
Rin[13] = R13 ;
Rin[14] = R14 ;


//$monitor ($time , "icode = %d, valM=%d , valE = %d , rA = %d , rB = %d,\n Rin[rA]= %d ,Rin[rB] = %d, Rout[rA] = %d , Rout[rB] = %d ,Rout[4] = %d",icode,valM,valE,Rin[rA],Rin[rB],Rout[rA],Rout[rB],Rout[4]);
//$monitor ($time , "icode = %d, valM=%d , valE = %d , rA = %d , rB = %d",icode,valM,valE,rA,rB);
$monitor ($time , " icode = %d, Cnd = %d\nvalM=%d \nvalE =%d\n rA = %d , rB = %d,\nR0= %d\nR1 = %d\nR7 = %d\nRo0 = %d \nRo1 = %d\nRo4 = %d \nRo5 = %d \n",icode,Cnd,valM,valE,rA,rB,R0,R1,R7,Ro0,Ro1,Ro4,Ro5);
icode = 4'd6 ; rA = 0; rB = 1 ; valM = 0 ;valE = 19 ;clk  =1 ;
#10 icode = 4'd8 ;
#10 icode = 4'hB; valM= 13 ; 
#10 icode = 4'd1 ;
#10 icode = 4'd2 ; Cnd = 0 ;rB = 5 ; valE = 7 ;
#10 Cnd = 1;

#60 $finish;

end 
endmodule
