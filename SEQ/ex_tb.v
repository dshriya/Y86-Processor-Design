`timescale 1ns/1ps
module execute_tb;

reg [3:0]icode,ifun ;
reg clk ;
reg signed [63:0]valA,valB,valC;
output zf,sf,of;
output Cnd;
output signed [63:0]valE ;

execute ex1(clk,icode,ifun,valA,valB,valC,Cnd,zf,sf,of,valE);
always #10 clk = ~clk ;
initial begin
$monitor($time," icode = %d ifun = %d\nvalA = %d \nvalB = %d\nvalC = %d \nvalE = %d\n Cnd=%d\n zf = %d of  = %d sf = %d",icode,ifun,valA,valB,valC,valE,Cnd,zf,of,sf);
icode = 4'd3 ; valC = 64'd2 ; clk = 1;
#10 icode =4'd4 ;valB = 64'd9;
#10 icode = 4'd9; 
#10 icode = 4'd6 ; ifun = 4'd1; valA = 64'd1 ;valB = 64'd1 ;
#10 valA = -10 ; valB = 20 ;
#10 ifun = 4'd2 ; valA = 1; valB = 2;
#10 icode = 4'd2 ;valA = 7 ;ifun = 4 ;
#10 icode = 4'd7 ; ifun = 2 ; 
#10 ifun = 3 ;
#10 icode = 4'd6 ; ifun = 4'd0; valA = 9223372036854775807 ; valB = 2 ;
#120 $finish ;
end 

endmodule 
