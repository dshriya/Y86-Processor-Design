`timescale 1ns/1ps
module writeback (clk,icode,Cnd,valM,valE,rA,rB,R0,R1,R2,R3,R4,R5,R6,R7,R8,R9,R10,R11,R12,R13,R14,Ro0,Ro1,Ro2,Ro3,Ro4,Ro5,Ro6,Ro7,Ro8,Ro9,Ro10,Ro11,Ro12,Ro13,Ro14);
input clk;
// instruction type and register type
input [3:0]icode,rA,rB;
// Condition code set in Execute stage
input Cnd ;
// Outputs from Memory and Execute stage
input [63:0]valM,valE;
// Input Register file
input [63:0]R0,R1,R2,R3,R4,R5,R6,R7,R8,R9,R10,R11,R12,R13,R14;
// Output register file - after writing back
output reg[63:0]Ro0,Ro1,Ro2,Ro3,Ro4,Ro5,Ro6,Ro7,Ro8,Ro9,Ro10,Ro11,Ro12,Ro13,Ro14;
// For easy modification 
reg [63:0]Rout[0:14];
always@(negedge clk)begin
Rout[0] = R0 ;
Rout[1] = R1 ;
Rout[2] = R2 ;
Rout[3] = R3 ;
Rout[4] = R4 ;
Rout[5] = R5 ;
Rout[6] = R6 ;
Rout[7] = R7 ;
Rout[8] = R8 ;
Rout[9] = R9 ;
Rout[10] = R10 ;
Rout[11] = R11 ;
Rout[12] = R12 ;
Rout[13] = R13 ;
Rout[14] = R14 ;
	
case(icode)
4'd2 : begin  // cmovXX
		if(Cnd)
		begin
	       Rout[rB] = valE ; 
	       end
       end
4'd3 : begin   // irmovq
       Rout[rB] = valE ; 
       end
4'd5 : begin   // mrmovq
       Rout[rA] = valM ; 
       end
4'd6 : begin  //OPq
       Rout[rB] = valE ; 
       end
4'd8 : begin //call
	Rout[4] = valE ;
	end
4'd9 : begin  //ret
	Rout[4] =valE;
	end
4'hA : begin // pushq
       Rout[4] = valE ; 
       end
4'hB : begin  //popq
       Rout[4] = valE ; 
       Rout[rA] = valM;
       end

endcase 
// Copying values into the output register file as 2D array cannot be passed between the modules
Ro0= Rout[0];
Ro1= Rout[1];
Ro2= Rout[2];
Ro3= Rout[3];
Ro4= Rout[4];
Ro5= Rout[5];
Ro6= Rout[6];
Ro7= Rout[7];
Ro8= Rout[8];
Ro9= Rout[9];
Ro10= Rout[10];
Ro11= Rout[11];
Ro12= Rout[12];
Ro13= Rout[13];
Ro14= Rout[14];
end

endmodule
