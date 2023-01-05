module complement (result, a);
parameter size = 64;
input signed [size-1:0] a,b;
output signed [size-1:0] result;
genvar i;
wire [size-1:0] temp_initial;
wire [size:0] carry;
wire [size-1:0] temp1;
wire [size-1:0] temp2;
wire [size-1:0] temp3;

assign b = 1 ;
assign carry[0] = 1'b0;

// finding 1's complement of input a and storing in temp_initial
for (i=0;i<size;i=i+1) 
begin
not g1 (temp_initial[i],a[i]);
end
// adding temp_initial with b (1's complement+1)
for (i=0;i<size;i=i+1) 
begin
xor g1 (temp1[i], b[i],temp_initial[i] );
xor g2 (result[i], temp1[i], carry[i]);
and g3 (temp2[i], temp1[i], carry[i]);
and g4 (temp3[i], temp_initial[i], b[i]);
or  g5 (carry[i+1], temp2[i], temp3[i]);
end

endmodule
