`timescale 1ns / 1ps

module fetch(
  input clk,input [63:0]PC, output reg [3:0] icode,ifun,rA,rB,output reg [63:0] valC,valP,output reg instr_valid,imem_error,hlt
);


  reg [0:79] instr;
  reg [7:0] instr_mem[0:1023];

  initial
  begin
  //Instruction memory

  //OPq
instr_mem[0]=8'b01100000;
instr_mem[1]=8'b01000010;
instr_mem[2]=8'b11001101;
instr_mem[3]=8'b10101011;
instr_mem[4]=8'b10001001;
instr_mem[5]=8'b01100111;
instr_mem[6]=8'b01000000;
instr_mem[7]=8'b01000101;
instr_mem[8]=8'b00100011;
instr_mem[9]=8'b00000001;
  end  

  always@(*) 
  begin 

    imem_error=0;
    if(PC>1023)
    begin
      imem_error=1;
    end

    instr={
      instr_mem[PC],
      instr_mem[PC+1],
      instr_mem[PC+2],
      instr_mem[PC+3],
      instr_mem[PC+4],
      instr_mem[PC+5],
      instr_mem[PC+6],
      instr_mem[PC+7],
      instr_mem[PC+8],
      instr_mem[PC+9]
    };

    instr_valid=1'b1;
    ifun= instr[4:7];
    icode= instr[0:3];


    if(icode==4'b0000) //halt
    begin
      hlt=1;
      valP=PC+64'd1;
    end
    else if(icode==4'b0001) //nop
      valP=PC+64'd1;

    else if(icode==4'b0011) //irmovq
    begin
      rA=instr[8:11];
      valC=instr[16:79];
      rB=instr[12:15];
      valP=PC+64'd10;
    end

    else if(icode==4'b0010) //cmovxx
    begin
      rB=instr[12:15];
      rA=instr[8:11];
      valP=PC+64'd2;
    end

    else if(icode==4'b0100) //rmmovq
    begin
      rA=instr[8:11];
      valC=instr[16:79];
      rB=instr[12:15];
      valP=PC+64'd10;
    end
    else if(icode==4'b0110) //OPq
    begin
      rB=instr[12:15];
      rA=instr[8:11];
      valP=PC+64'd2;
    end
    else if(icode==4'b0101) //mrmovq
    begin
      rA=instr[8:11];
      valC=instr[16:79];
      rB=instr[12:15];
      valP=PC+64'd10;
    end

    else if(icode==4'b0111) //jxx
    begin
      valP=PC+64'd9;
      valC=instr[8:71];
    end

    else if(icode==4'b1001) //ret
      valP=PC+64'd1;

    else if(icode==4'b1000) //call
    begin
      valP=PC+64'd9;
      valC=instr[8:71];
    end
    else if(icode==4'b1011) //popq
    begin
      rB=instr[12:15];
      valP=PC+64'd2;
      rA=instr[8:11];
    end
    else if(icode==4'b1010) //pushq
    begin
      rB=instr[12:15];
      valP=PC+64'd2;
      rA=instr[8:11];
    end

    else 
      instr_valid=1'b0;
  end

endmodule
