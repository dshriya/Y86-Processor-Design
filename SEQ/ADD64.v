module ADD64(y,error,carryout, a, b);
parameter size = 64;
input signed [size-1:0] a,b;
output signed [size-1:0] y;
output error,carryout;
wire [size:0] carry;
genvar i;
assign carry[0] = 1'b0;
for (i=0;i<size;i=i+1) 
begin
wire [size-1:0] temp1,temp2,temp3;

xor g1 (temp1[i], a[i], b[i]);
xor g2 (y[i], temp1[i], carry[i]);
and g3 (temp2[i], temp1[i], carry[i]);
and g4 (temp3[i], a[i], b[i]);
or  g5 (carry[i+1], temp2[i], temp3[i]);
end
xor(carryout, carry[0], carry[size]);
xor g6 (error,carry[size],carry[size-1]);

endmodule
