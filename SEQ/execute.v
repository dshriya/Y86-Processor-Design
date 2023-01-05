`include "ALU64.v" 
`timescale 1ns/1ps
module execute(input clk,input [3:0]icode,ifun,input signed [63:0]valA,valB,valC,output reg Cnd,output reg zf,of,sf ,output reg signed[63:0]valE);
 
reg [1:0]control;
reg signed[63:0]A,B ;
wire error,carry; //error : overflow 
wire signed[63:0]Y;

reg xin1,xin2 ; //xor gate
reg ain1,ain2 ; //and gate
reg oin1,oin2 ; //or gate
reg nin ; //notgate

wire xout,aout,oout,nout;
	    
xor G1(xout,xin1,xin2);
and G2(aout,ain1,ain2);
or G3(oout,oin1,on2);
not G4(nout,nin);


ALU64 alu1(.s(control) ,
	    .a(A) ,
	    .b(B) ,
	    .y(Y) ,
	    .error(error) ,
	    .carry(carry));


 // zf,of,sf are set by OPq or otherwise are assumed to be zero.
 
 
 always @(*) begin
 if(icode == 4'd6)
 begin 
	 if (Y == 0)
	 begin 
	 zf = 1 ;
	 end 
	 else begin 
	 zf = 0 ;
	 end 
	 of = error ;
	 sf = Y[63] ;
	 
 end
 else begin 
 zf = 0 ; sf = 0; of = 0;
 end
 end
  
always @(*)begin
	Cnd  = 0 ;
case(icode) 
4'd3 : begin  //irmovq
	valE = 64'd0 + valC ;
	end
4'd4 : begin  //rmmovq
	valE = valB + valC;
	end
4'd5 : begin  //mrmovq
	valE = valB + valC;
	end
4'd8 : begin  //call
	valE = valB + 64'b1111111111111111111111111111111111111111111111111111111111111000 ;
	end 
4'd9 : begin  //ret
 	valE = valB + 64'd8;
	end
4'hA : begin  //pushq
	valE = valB + 64'b1111111111111111111111111111111111111111111111111111111111111000 ;
	end 
4'hB : begin  //popq
 	valE = valB + 64'd8;
	end
4'd6 : begin   // OPq
	case(ifun)
	4'd0 : begin  //add
		control = 2'b00 ;
		A = valA ;
		B = valB ;
		end
	4'd1 : begin  //sub
		control = 2'b01 ;
		A = valA ;
		B = valB ;
		end
	4'd2 : begin  //and
		control = 2'b10 ;
		A = valA ;
		B = valB ;
		end
	4'd3 : begin  //xor
		control = 2'b11 ;
		A = valA ;
		B = valB ;
		end
	endcase 
	valE = Y ;
	end
4'd2 : begin  //cmovxx
	case(ifun) 
	4'd0 : begin  //rrmovq
		Cnd = 1 ;
		end
	4'd1 : begin //cmovle
		xin1 = sf;
		xin2 = of ;
		oin1 = xout;
		oin2 = zf ;
		if(oout)
		begin
		Cnd = 1;
		end
		end
	4'd2 : begin //cmovl
		xin1 = sf ;
		xin2 = of ;
		if(xout)
		begin 
		Cnd = 1 ;
		end
		end
	4'd3 : begin  //cmove
		if(zf)
		begin
		Cnd = 1;
		end
		end
	4'd4 : begin  //cmovne
		nin  = zf ;
		if(nout)
		begin 
		Cnd  =1;
		end 
		end
	4'd5 : begin //cmovge
		xin1 = sf ;
		xin2 = of ;
		nin = xout;
		if(nout)
		begin
		Cnd = 1; 
		end
		end
	4'd6 : begin //cmovg
		xin1 = sf ;
		xin2 = of ;
		nin = xout ; 
		ain1 = nout;
		nin = zf ;
		ain2 = nout ;
		if(aout)
		begin 
		Cnd = 1 ;
		end
		end
	endcase 
	valE = 64'd0+valA;
	end
	
4'd7 :  begin  //jxx
	Cnd  = 0 ;
	case(ifun) 
	4'd0 : begin  //jmp
		Cnd = 1 ;
		end
	4'd1 : begin //jle
		xin1 = sf;
		xin2 = of ;
		oin1 = xout;
		oin2 = zf ;
		if(oout)
		begin
		Cnd = 1;
		end
		end
	4'd2 : begin //jl
		xin1 = sf ;
		xin2 = of ;
		if(xout)
		begin 
		Cnd = 1 ;
		end
		end
	4'd3 : begin  //je
		if(zf)
		begin
		Cnd = 1;
		end
		end
	4'd4 : begin  //jne
		nin  = zf ;
		if(nout)
		begin 
		Cnd  =1;
		end 
		end
	4'd5 : begin //jge
		xin1 = sf ;
		xin2 = of ;
		nin = xout;
		if(nout)
		begin
		Cnd = 1; 
		end
		end
	4'd6 : begin //jg
		xin1 = sf ;
		xin2 = of ;
		nin = xout ; 
		ain1 = nout;
		nin = zf ;
		ain2 = nout ;
		if(aout)
		begin 
		Cnd = 1 ;
		end
		end
	endcase 
	end
endcase


end 

endmodule 

