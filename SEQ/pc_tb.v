`timescale 1ns/1ps
module pc_tb ;
reg clk;
reg [3:0] icode ;
reg [63:0]valP,valC,valM;
output [63:0]PC ;
reg Cnd;

PC_update pc1(clk,icode,Cnd,valP,valC,valM,PC);
always #10 clk = ~clk;
initial begin 

$monitor("icode = %d , Cnd = %b, valP = %d, valC = %d, valM = %d, PC = %d ",icode,Cnd,valP,valC,valM,PC);
icode = 6 ; valP = 5 ; clk =1 ;
#10 icode = 7 ; Cnd = 1; valC = 13 ;
#10 Cnd = 0 ;
#10 icode = 9 ; valM = 4;
#10 icode = 3; valP = 0;
#60 $finish;
end

endmodule
