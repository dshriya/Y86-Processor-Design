`include "complement.v"
module SUB64(Y,error,carryout,A,B);
parameter size = 64;
genvar i;
input signed[size-1:0]A,B;
output signed[size-1:0]Y,Bcomp;
output carryout,error ;
wire signed[size:0]carry;
// Bcomp = 2's comp of B
complement comp1(Bcomp,B);
// add Bcomp to A
assign carry[0]= 0; 

for (i=0;i<size;i=i+1) 
begin
wire [size-1:0] temp1;
wire [size-1:0] temp2;
wire [size-1:0] temp3;
xor g1 (temp1[i], A[i],Bcomp[i] );
xor g2 (Y[i], temp1[i], carry[i]);
and g3 (temp2[i], temp1[i], carry[i]);
and g4 (temp3[i], A[i], Bcomp[i]);
or  g5 (carry[i+1], temp2[i], temp3[i]);
end
assign carryout = carry[size];
xor g6 (error, carry[size],carry[size-1]); 

endmodule
