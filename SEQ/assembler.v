`include "fetch.v"
`include "wb.v"
`include "execute.v"
`include "decode.v"
`include "memory.v"
`include "pc.v"
`timescale 1ns/1ps 
module assembler;
  reg clk;
  reg [63:0] PC;

  reg status[0:2]; 
  reg [63:0] R0, R1, R2,R3, R4, R5, R6, R7, R8, R9, R10, R11, R12, R13, R14;

  wire [3:0] icode,ifun,rA,rB; 
  wire [63:0] valC,valP;
  wire valid,error;
  wire [63:0] valA,valB,valE,valM;
  wire zf, sf, of;
  
  wire Cnd,hlt;
  wire [63:0] PC_updated;

  wire [63:0] Ro0, Ro1, Ro2,Ro3, Ro4, Ro5, Ro6, Ro7, Ro8, Ro9, Ro10, Ro11, Ro12, Ro13, Ro14;
  
  wire [63:0] value;

  

  fetch fetch
  ( .clk(clk),
    .PC(PC),
    .icode(icode),
    .ifun(ifun),
    .rA(rA),
    .rB(rB),
    .valC(valC),
    .valP(valP),
    .valid(valid),
    .error(error),
    .hlt(hlt)
  );


  execute execute
  (.clk(clk),
    .icode(icode),
    .ifun(ifun),
    .valA(valA),
    .valB(valB),
    .valC(valC),
    .valE(valE),
    .sf(sf),
    .zf(zf),
    .of(of),
    .Cnd(Cnd)
  );

  decode decode
  (.clk(clk),
    .icode(icode),
    .rA(rA),
    .rB(rB),
    .valA(valA),
    .valB(valB),
    .R0(R0),
    .R1(R1),
    .R2(R2),
    .R3(R3),
    .R4(R4),
    .R5(R5),
    .R6(R6),
    .R7(R7),
    .R8(R8),
    .R9(R9),
    .R10(R10),
    .R11(R11),
    .R12(R12),
    .R13(R13),
    .R14(R14)
  );
  
  memory mem(
  .clk(clk),
    .icode(icode),
    .valA(valA),
    .valB(valB),
    .valE(valE),
    .valP(valP),
    .valM(valM),
    .value(value)
  );
  
  writeback writeback(
  .clk(clk),
    .icode(icode),
    .Cnd(Cnd),
    .valM(valM),
    .valE(valE),
    .rA(rA),
    .rB(rB),
    .R0(R0),
    .R1(R1),
    .R2(R2),
    .R3(R3),
    .R4(R4),
    .R5(R5),
    .R6(R6),
    .R7(R7),
    .R8(R8),
    .R9(R9),
    .R10(R10),
    .R11(R11),
    .R12(R12),
    .R13(R13),
    .R14(R14),
    .Ro0(Ro0),
    .Ro1(Ro1),
    .Ro2(Ro2),
    .Ro3(Ro3),
    .Ro4(Ro4),
    .Ro5(Ro5),
    .Ro6(Ro6),
    .Ro7(Ro7),
    .Ro8(Ro8),
    .Ro9(Ro9),
    .Ro10(Ro10),
    .Ro11(Ro11),
    .Ro12(Ro12),
    .Ro13(Ro13),
    .Ro14(Ro14)
    );

  PC_update PC_update(
    .clk(clk),
    .icode(icode),
    .Cnd(Cnd),
    .valC(valC),
    .valM(valM),
    .valP(valP),
    .PC(PC_updated)
  ); 

always #10 clk = ~clk ;

  initial begin
    $dumpfile("assembler.vcd");
    $dumpvars(0,assembler);
    status[0]=1;
    status[1]=0;
    status[2]=0;
    PC=64'd0;
    R0 = 0;
    R1 = 1;
    R2 = 2;
    R3 = 3;
    R4 = 4;
    R5 = 5;
    R6 = 6;
    R7 = 7;
    R8 = 8;
    R9 = 9;
    R10 = 10;
    R11 = 11;
    R12 = 12;
    R13  = 13;
    R14  = 14;
    clk  = 0;
  end 
 
  always@(*)
  begin
    PC=PC_updated;
  end

  always@(*)
  begin
    if(valid)
    begin
      status[0]=1'b0;
      status[1]=valid;
      status[2]=1'b0;
    end
    else if(hlt)
    begin
      status[0]=1'b0;
      status[1]=1'b0;
      status[2]=hlt;
    end
    
    else
    begin
      status[0]=1'b1;
      status[1]=1'b0;
      status[2]=1'b0;
    end
  end
  
  always@(*)
  begin
    if(status[2]==1'b1)
    begin
      $finish;
    end
  end
initial begin
  $monitor("PC=%b \nicode=%b ifun=%b\nrA=%b rB=%b \nvalA=%d valB=%d \nvalE=%d\nvalP=%d\nvalid=%d error=%d Cnd=%d halt=%d \nR0=%d |R1=%d | R2=%d | R3=%d | R4=%d | R5=%d | R6=%d | R7=%d | R8=%d | R9=%d | R10=%d | R11=%d | R12=%d | R13=%d | R14=%d \n ",PC,icode,ifun,rA,rB,valA,valB,valE,valP,valid,error,Cnd,status[2],Ro0,Ro1,Ro2,Ro3,Ro4,Ro5,Ro6,Ro7,Ro8,Ro9,Ro10,Ro11,Ro12,Ro13,Ro14);
	#20 $finish ;
end	
endmodule
