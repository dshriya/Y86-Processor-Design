`timescale 1ns / 1ps
module dec_wb(input clk,output reg[63:0]Ro0,output reg[63:0]Ro1,output reg[63:0]Ro2,output reg[63:0]Ro3,output reg[63:0]Ro4,output reg[63:0]Ro5,output reg[63:0]Ro6,output reg[63:0]Ro7,output reg[63:0]Ro8,output reg[63:0]Ro9,output reg[63:0]Ro10,output reg[63:0]Ro11,output reg[63:0]Ro12,output reg[63:0]Ro13,output reg[63:0]Ro14,input [3:0]D_icode,input [3:0]D_rA,input [3:0]D_rB,output reg [63:0]d_valA,output reg [63:0]d_valB, input [3:0]W_icode,input [3:0]W_rA,input [3:0]W_rB,input W_Cnd,input [63:0]W_valE,input [63:0]W_valM);

reg [63:0] R[0:14] ;

initial begin 
R[0] = 0;
R[1] = 1;
R[2] = 2;
R[3] = 3;
R[4] = 4;
R[5] = 5;
R[6] = 6;
R[7] = 7;
R[8] = 8;
R[9] = 9;
R[10] =10;
R[11] =11;
R[12] =12;
R[13] =13;
R[14] =14;
end
always@(*)begin

case(D_icode) 
4'b0110 : begin   // OPq
 	  d_valA = R[D_rA] ;
 	  d_valB = R[D_rB];
 	  end	
	  
4'b0100 : begin   // rmmovq
 	  d_valA = R[D_rA] ;
 	  d_valB = R[D_rB] ;
 	  end
4'b0101 : begin   //mrmovq
           d_valB = R[D_rB] ; 
           end 
4'b0010 : begin   // cmovxx
           d_valA = R[D_rA] ;
          end

4'b1010 : begin   //pushq
 	  d_valA = R[D_rA] ;
 	  d_valB = R[4] ;
 	  end    	 
4'b1011 : begin   //popq
 	  d_valA = R[4] ;
 	  d_valB = R[4] ;
 	  end      
 	 
4'b1000 : begin //call
	  d_valB = R[4];
	  end
4'b1001 : begin   //ret
 	  d_valA = R[4] ;
 	  d_valB = R[4] ;
 	  end        
endcase

    Ro0=R[0];
    Ro1=R[1];
    Ro2=R[2];
    Ro3=R[3];
    Ro4=R[4];
    Ro5=R[5];
    Ro6=R[6];
    Ro7=R[7];
    Ro8=R[8];
    Ro9=R[9];
    Ro10=R[10];
    Ro11=R[11];
    Ro12=R[12];
    Ro13=R[13];
    Ro14=R[14];
end

always @(*)
begin 
case(W_icode)
4'd6 : begin  //OPq
       R[W_rB] = W_valE ; 
       end
       
4'd3 : begin   // irmovq
       R[W_rB] = W_valE ; 
       end
4'd5 : begin   // mrmovq
       R[W_rA] = W_valM ; 
       end

4'd2 : begin  // cmovXX
		if(W_Cnd)
		begin
	       R[W_rB] = W_valE ; 
	       end
       end
4'hA : begin // pushq
       R[4] = W_valE ; 
       end
4'hB : begin  //popq
       R[4] = W_valE ; 
       R[W_rA] = W_valM;
       end

4'd8 : begin //call
	R[4] = W_valE ;
	end
4'd9 : begin  //ret
	R[4] = W_valE;
	end
	
endcase 
Ro0= R[0];
Ro1= R[1];
Ro2= R[2];
Ro3= R[3];
Ro4= R[4];
Ro5= R[5];
Ro6= R[6];
Ro7= R[7];
Ro8= R[8];
Ro9= R[9];
Ro10= R[10];
Ro11= R[11];
Ro12= R[12];
Ro13= R[13];
Ro14= R[14];
end

endmodule 


