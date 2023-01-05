`include "ADD64.v"
 `include "SUB64.v"
 `include "AND64.v"
 `include "XOR64.v"
 module ALU64(s,y,error,carry,a,b);
 parameter size= 64;
 input [1:0]s;
 input signed[size-1:0] a,b;
 output signed[size-1:0]y;
 output error,carry;
 
 wire signed [size-1:0] yadd,ysub,yand,yxor ;
 wire err_add,err_sub,car_add,car_sub ;
 reg signed[size-1:0] yx;
 reg errorx,carryx;
 
 ADD64 G1(yadd,err_add,car_add,a,b);
 SUB64 G2(ysub,err_sub,car_sub,a,b);
 AND64 G3(yand,a,b);
 XOR64 G4(yxor,a,b);
 
 always@(*) begin
 case(s)
  2'b00 : begin 
  	  yx = yadd;
  	  errorx = err_add;
  	  carryx = car_add;
  	  end
  2'b01 : begin 
  	  yx = ysub;
  	  errorx = err_sub;
  	  carryx = car_sub;
  	  end
  2'b10 : begin 
  	  yx = yand;
  	  errorx = 0;
  	  carryx = 0;
  	  end
 2'b11 : begin 
  	  yx = yxor;
  	  errorx = 0;
  	  carryx = 0;
  	  end
 endcase 
 end 
 assign y = yx;
 assign error =errorx;
 assign carry = carryx;
 
 endmodule
