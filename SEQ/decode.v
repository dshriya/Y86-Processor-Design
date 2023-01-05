`timescale 1ns/1ps
module decode(input clk,input [3:0] icode,rA,rB,output reg [63:0]valA,valB,input [63:0]R0,R1,R2,R3,R4,R5,R6,R7,R8,R9,R10,R11,R12,R13,R14);

reg [63:0] R[0:14] ;

always @(*)begin 
R[0] = R0;
R[1] = R1;
R[2] = R2;
R[3] = R3;
R[4] = R4;
R[5] = R5;
R[6] = R6;
R[7] = R7;
R[8] = R8;
R[9] = R9;
R[10] = R10;
R[11] = R11;
R[12] = R12;
R[13] = R13;
R[14] = R14;
end
always@(*)begin

case(icode) 
4'b0010 : begin   // cmovxx
           valA = R[rA] ;
          end
4'b0100 : begin   // rmmovq
 	  valA = R[rA] ;
 	  valB = R[rB] ;
 	  end
4'b0101 : begin   //mrmovq
           valB = R[rB] ; 
           end 
4'b0110 : begin   // OPq
 	  valA = R[rA] ;
 	  valB = R[rB];
 	  end	
4'b1000 : begin //call
	  valB = R[4];
	  end
4'b1001 : begin   //ret
 	  valA = R[4] ;
 	  valB = R[4] ;
 	  end    	  
4'b1010 : begin   //pushq
 	  valA = R[rA] ;
 	  valB = R[4] ;
 	  end    	 
4'b1011 : begin   //popq
 	  valA = R[4] ;
 	  valB = R[4] ;
 	  end          
endcase
end
endmodule
