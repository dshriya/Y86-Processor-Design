`timescale 1ns / 1ps
`include "decode_reg.v"
`include "execute_reg.v"
`include "fetch_reg.v"
`include "memory_reg.v"
`include "wb_reg.v"
`include "fetch.v"
`include "execute.v"
`include "dec_wb.v"
`include "memory.v"
`include "pc.v"

module assembler;
reg CLK;
reg [63:0] PC;
reg status[0:2]; // status[0]->AOK | status[1]->INS | status[2]->HLT

// Fetch Register
wire [63:0] updated_PC;
wire [2:0] f_status; 
wire [63:0] f_predPC;
wire [3:0] f_ifun, f_icode, f_rA, f_rB;

wire [63:0] f_valC;
wire [63:0] f_valP;
wire error, hlt, valid;

// Decode Register
wire [2:0] d_status; 
wire [3:0] d_icode, d_ifun, d_rA, d_rB;
wire [63:0] d_valC, d_valP, d_valA, d_valB;

// Execute Register
wire [2:0] e_status;
wire e_Cnd;
wire [3:0] e_icode, e_ifun, e_rA, e_rB; 
wire [63:0] e_valA, e_valB, e_valE, e_valC, e_valP;

// Memory Register
wire [2:0] m_status;
wire [3:0] m_icode, m_rA, m_rB;
wire m_Cnd;
wire [63:0] m_valC, m_valP, m_valA, m_valB, m_valE, m_valM,m_value;

// Writeback Register
wire [2:0] w_status;
wire w_Cnd;
wire [3:0] w_icode, w_rA, w_rB;
wire [63:0] w_valC, w_valP, w_valA, w_valB, w_valE, w_valM;




// Registers
wire [63:0] Ro0, Ro1, Ro2, Ro3, Ro4, Ro5, Ro6, Ro7, Ro8, Ro9, Ro10, Ro11, Ro12, Ro13, Ro14;

// Fetch Register
fetch_reg fetch_reg(
.CLK(CLK),
.predPC(f_valP),
.f_predPC(f_predPC)
);

// Decode Register
decode_reg decode_reg(
.CLK(CLK),
.F_status(f_status),
.F_icode(f_icode),
.F_ifun(f_ifun),
.F_rA(f_rA),
.F_rB(f_rB),
.F_valC(f_valC),
.F_valP(f_valP),
.d_status(d_status),
.d_icode(d_icode),
.d_ifun(d_ifun),
.d_rA(d_rA),
.d_rB(d_rB),
.d_valP(d_valP),
.d_valC(d_valC)
);

// Execute Register
execute_reg execute_reg(
.CLK(CLK),
.D_status(d_status),
.D_icode(d_icode),
.D_ifun(d_ifun),
.D_rA(d_rA),
.D_rB(d_rB),
.D_valC(d_valC),
.D_valA(d_valA),
.D_valB(d_valB),
.D_valP(d_valP),
.e_status(e_status),
.e_icode(e_icode),
.e_ifun(e_ifun),
.e_rA(e_rA),
.e_rB(e_rB),
.e_valC(e_valC),
.e_valA(e_valA),
.e_valB(e_valB),
.e_valP(e_valP)
);


// Memory Register
memory_reg memory_reg(
    .CLK(CLK),
    .E_status(e_status),
    .E_icode(e_icode),
    .E_rA(e_rA),
    .E_rB(e_rB),
    .E_valC(e_valC),
    .E_valP(e_valP),
    .E_valA(e_valA),
    .E_valB(e_valB),
    .E_Cnd(e_Cnd),
    .E_valE(e_valE),
    .m_status(m_status),
    .m_icode(m_icode),
    .m_rA(m_rA),
    .m_rB(m_rB),
    .m_valC(m_valC),
    .m_valP(m_valP),
    .m_valA(m_valA),
    .m_valB(m_valB),
    .m_Cnd(m_Cnd),
    .m_valE(m_valE)

);


// Writeback Register
 wb_reg wb_reg(

    .clk(CLK),
    .M_status(m_status),
    .M_icode(m_icode),
    .M_rA(m_rA),
    .M_rB(m_rB),
    .M_valC(m_valC),
    .M_valP(m_valP),
    .M_valA(m_valA),
    .M_valB(m_valB),
    .M_Cnd(m_Cnd),
    .M_valE(m_valE),
    .M_valM(m_valM),

    .w_status(w_status),
    .w_icode(w_icode),
    .w_rA(w_rA),
    .w_rB(w_rB),
    .w_valC(w_valC),
    .w_valP(w_valP),
    .w_valA(w_valA),
    .w_valB(w_valB),
    .w_Cnd(w_Cnd),
    .w_valE(w_valE),
    .w_valM(w_valM)
  );
  
  
// PC update
PC_update PC_update(
    .clk(CLK),
    .icode(w_icode),
    .Cnd(w_Cnd),
    .valP(f_predPC),
    .valC(w_valC),
    .valM(w_valM),
    .PC(updated_PC)
);

// Fetch
fetch fetch(
    .clk(CLK),
    .PC(PC),
    .icode(f_icode),
    .ifun(f_ifun),
    .rA(f_rA),
    .rB(f_rB),
    .valC(f_valC),
    .valP(f_valP),
    .instr_valid(valid),
//    .valid(valid),
    .imem_error(error),
//    .error(error),
    .hlt(hlt)
  );

// Execute
execute execute(
    .clk(CLK),
    .E_icode(e_icode),
    .E_ifun(e_ifun),
    .E_valA(e_valA),
    .E_valB(e_valB),
    .E_valC(e_valC),
    .e_valE(e_valE),
    .e_sf(sf),
    .e_zf(zf),
    .e_of(of),
    .e_Cnd(e_Cnd)
  );
  
  
// Decode & Write-back
dec_wb dec_wb(
    .clk(CLK),
    .D_icode(d_icode),
    .D_rA(d_rA),
    .D_rB(d_rB),
    .d_valA(d_valA),
    .d_valB(d_valB),
    .W_icode(w_icode),
    .W_rA(w_rA),
    .W_rB(w_rB),
    .W_Cnd(w_Cnd),
    .W_valE(w_valE),
    .W_valM(w_valM),
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


// Memory
memory memory(
    .clk(CLK),
    .M_icode(m_icode),
    .M_valA(m_valA),
    .M_valB(m_valB),
    .M_valE(m_valE),
    .M_valP(m_valP),
    .m_valM(m_valM),
    .m_value(m_value)
  );

always #10 CLK = ~CLK ;

  initial begin
    $dumpfile("assembler.vcd");
    $dumpvars(0,assembler);
    status[0]=1;
    status[1]=0;
    status[2]=0;
    PC=64'd0;
    CLK = 0 ;
  end 

  always@(*)
  begin
    PC=updated_PC;
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

 // $monitor("PC=%b \nf_icode=%b f_ifun=%b\nf_rA=%b f_rB=%b \nf_valC=%d f_valP=%d \nvalid=%d error=%d  halt=%d",PC,f_icode,f_ifun,f_rA,f_rB,f_valC,f_valP,valid,error,hlt);
 // decode
 // $monitor("clk=%d\nPC=%b \nf_icode=%b f_ifun=%b\nf_rA=%b f_rB=%b \nf_valC=%d f_valP=%d \nvalid=%d error=%d  halt=%d",CLK,PC,f_icode,f_ifun,f_rA,f_rB,f_valC,f_valP,valid,error,hlt);
 //$monitor("PC=%b , f_predPC = %b, f_valP=%b", PC, f_predPC, f_valP
 $monitor("clk=%d f=%d d=%d e=%d m=%d wb=%d",CLK,f_icode,d_icode,e_icode,m_icode,w_icode);

 
//  $monitor("PC=%b \nf_icode=%b f_ifun=%b\nd_rA=%b d_rB=%b \n e_valE=%d f_valP=%d \nvalid=%d error=%d  halt=%d",PC,f_icode,f_ifun,d_rA,d_rB,e_valE,f_valP,valid,error,hlt);
 #120 $finish;
end
endmodule


