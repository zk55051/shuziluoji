`timescale 1ns / 1ps

module alu_behavior(
    input  wire [7:0] A,
    input  wire [7:0] B,
    input  wire [2:0] ALU_OP,
    output reg  [7:0] F,
    output reg        ZF,
    output reg        OF
);

always @(*) begin
    F = 0;
    ZF = 0;
    OF = 0;

    case(ALU_OP)
        3'b000: F = A & B;          // AND
        3'b001: F = A | B;          // OR
        3'b010: F = A ^ B;          // XOR
        3'b011: F = ~(A | B);       // NOR
        3'b100: begin               // ADD
            F = A + B;
            OF = (A[7] == B[7]) && (F[7] != A[7]);
        end
        3'b101: begin               // SUB
            F = A - B;
            OF = (A[7] != B[7]) && (F[7] != A[7]);
        end
        3'b110: F = ($signed(A) < $signed(B)) ? 1 : 0; // SLT
        3'b111: F = B << A[2:0];    // ??¦Ë
    endcase

    ZF = (F == 0);
end

endmodule