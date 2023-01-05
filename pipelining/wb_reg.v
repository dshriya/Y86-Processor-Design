`timescale 1ns / 1ps

module wb_reg( input clk,M_Cnd, input [2:0] M_status, input [3:0] M_icode,M_rA,M_rB, input [63:0] M_valC,M_valP,M_valA,M_valB,M_valE,M_valM, output reg [2:0] w_status,output reg [3:0] w_icode,w_rA,w_rB,output reg [63:0]w_valC,w_valP,w_valA,w_valB,output reg w_Cnd,output reg [63:0]w_valE,w_valM );  
 
  always@(posedge clk)
  begin
    w_status    =   M_status;
    w_icode   =   M_icode;
    w_rA      =   M_rA;
    w_rB      =   M_rB;
    w_valA    =   M_valA;
    w_valB    =   M_valB;
    w_valC    =   M_valC;
    w_valE    =   M_valE;
    w_valM    =   M_valM;
    w_valP    =   M_valP;
    w_Cnd     =   M_Cnd;
    
  end
endmodule
