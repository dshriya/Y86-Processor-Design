`timescale 1ns / 1ps
`include "ALU64.v" 
module execute(input clk,input [3:0] E_icode,E_ifun,input signed [63:0] E_valA,E_valB,E_valC,output reg e_Cnd,e_zf,e_sf,e_of,output reg signed [63:0] e_valE);

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

 
 always @(*) begin
 if(E_icode == 4'd6)
 begin 
	 if (Y == 0)
	 begin 
	 e_zf = 1 ;
	 end 
	 else begin 
	 e_zf = 0 ;
	 end 
	 e_of = error ;
	 e_sf = Y[63] ;
	 
 end
 else begin 
 e_zf = 0 ; e_sf = 0; e_of = 0;
 end
 end
  
always @(*)begin
	e_Cnd  = 0 ;
case(E_icode) 
4'd3 : begin  //irmovq
	e_valE = 64'd0 + E_valC ;
	end
4'd4 : begin  //rmmovq
	e_valE = E_valB + E_valC;
	end
4'd5 : begin  //mrmovq
	e_valE = E_valB + E_valC;
	end
4'd6 : begin   // OPq
	case(E_ifun)
	4'd0 : begin  //add
		control = 2'b00 ;
		A = E_valA ;
		B = E_valB ;
		end
	4'd1 : begin  //sub
		control = 2'b01 ;
		A = E_valA ;
		B = E_valB ;
		end
	4'd2 : begin  //and
		control = 2'b10 ;
		A = E_valA ;
		B = E_valB ;
		end
	4'd3 : begin  //xor
		control = 2'b11 ;
		A = E_valA ;
		B = E_valB ;
		end
	endcase 
	e_valE = Y ;
	end
4'd8 : begin  //call
	e_valE = E_valB + 64'b1111111111111111111111111111111111111111111111111111111111111000 ;
	end 
4'd9 : begin  //ret
 	e_valE = E_valB + 64'd8;
	end
4'hA : begin  //pushq
	e_valE = E_valB + 64'b1111111111111111111111111111111111111111111111111111111111111000 ;
	end 
4'hB : begin  //popq
 	e_valE = E_valB + 64'd8;
	end

4'd2 : begin  //cmovxx
	case(E_ifun) 
	4'd0 : begin  //rrmovq
		e_Cnd = 1 ;
		end
	4'd1 : begin //cmovle
		xin1 = e_sf;
		xin2 = e_of ;
		oin1 = xout;
		oin2 = e_zf ;
		if(oout)
		begin
		e_Cnd = 1;
		end
		end
	4'd2 : begin //cmovl
		xin1 = e_sf ;
		xin2 = e_of ;
		if(xout)
		begin 
		e_Cnd = 1 ;
		end
		end
	4'd3 : begin  //cmove
		if(e_zf)
		begin
		e_Cnd = 1;
		end
		end
	4'd4 : begin  //cmovne
		nin  = e_zf ;
		if(nout)
		begin 
		e_Cnd  =1;
		end 
		end
	4'd5 : begin //cmovge
		xin1 = e_sf ;
		xin2 = e_of ;
		nin = xout;
		if(nout)
		begin
		e_Cnd = 1; 
		end
		end
	4'd6 : begin //cmovg
		xin1 = e_sf ;
		xin2 = e_of ;
		nin = xout ; 
		ain1 = nout;
		nin = e_zf ;
		ain2 = nout ;
		if(aout)
		begin 
		e_Cnd = 1 ;
		end
		end
	endcase 
	e_valE = 64'd0+E_valA;
	end
	
4'd7 :  begin  //jxx
	e_Cnd  = 0 ;
	case(E_ifun) 
	4'd0 : begin  //jmp
		e_Cnd = 1 ;
		end
	4'd1 : begin //jle
		xin1 = e_sf;
		xin2 = e_of ;
		oin1 = xout;
		oin2 = e_zf ;
		if(oout)
		begin
		e_Cnd = 1;
		end
		end
	4'd2 : begin //jl
		xin1 = e_sf ;
		xin2 = e_of ;
		if(xout)
		begin 
		e_Cnd = 1 ;
		end
		end
	4'd3 : begin  //je
		if(e_zf)
		begin
		e_Cnd = 1;
		end
		end
	4'd4 : begin  //jne
		nin  = e_zf ;
		if(nout)
		begin 
		e_Cnd  =1;
		end 
		end
	4'd5 : begin //jge
		xin1 = e_sf ;
		xin2 = e_of ;
		nin = xout;
		if(nout)
		begin
		e_Cnd = 1; 
		end
		end
	4'd6 : begin //jg
		xin1 = e_sf ;
		xin2 = e_of ;
		nin = xout ; 
		ain1 = nout;
		nin = e_zf ;
		ain2 = nout ;
		if(aout)
		begin 
		e_Cnd = 1 ;
		end
		end
	endcase 
	end
endcase


end 

endmodule
