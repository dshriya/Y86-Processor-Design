`timescale 1ns / 1ps
module PC_update(input clk,input [3:0] icode,input Cnd,input [63:0] valP,valC,valM,output reg [63:0] PC);

// inputs - Cnd, icode, valP, valC, valM , clk
// output - PC
	
always @(*)begin 
	
// the value of PC gets updated based on the value of icode.
	
case(icode)
4'd7 :  begin  // jXX
	if(Cnd)
	begin 
	PC = valC ;
	end
	else
	begin 
	PC = valP;
	end
        end
4'd8 : begin  // call
	PC = valC;
	end
4'd9 : begin  //ret
	PC = valM;
	end
default : begin 
PC = valP ;
end
endcase

end

endmodule
