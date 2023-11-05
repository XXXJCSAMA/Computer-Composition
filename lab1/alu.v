module alu (a,b,aluc,s,z);
   input [31:0] a,b;
   input [3:0] aluc;
   output [31:0] s;
   output        z;
   wire z;
   wire [31:0] s;

   always @ (a or b or aluc) begin
      case (aluc)
         4'b0000: s = a + b;             // 0000 ADD
         4'b1000: s = a - b;             // 1000 SUB
         4'b0111: s = a & b;             // 0111 AND
         4'b0110: s = a | b;             // 0110 OR
         4'b0100: s = a ^ b;             // 0100 XOR
         4'b0010: s = {b[19:0], 12'b0};  // 0010 LUI:{lui_imm ,12'b0}
         4'b0001: s = a << b;            // 0001 SLL: rd <- (rs1 << rs2)
         4'b0101: s = a >> b;            // 0101 SRL: rd <- (rs1 >>rs2) (logical)
         4'b1101: s = $signed(a) >>> b;  // 1101 SRA: rd <- (rs1 >> rs2) (arithmetic)
         default: s = 0;
      endcase

      if (s == 0) z = 1;
      else z = 0;
   end
endmodule

