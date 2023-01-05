module XOR64(Y,A,B);
parameter size = 64 ;
input signed[size-1:0]A,B;
output signed[size-1:0]Y;

genvar i; 
for(i = 0; i<size; i=i+1)
begin
xor Gate1(Y[i],A[i],B[i]);
end

endmodule
