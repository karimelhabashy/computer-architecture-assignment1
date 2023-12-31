// Install the file: iverilog-10.0-x86_setup.exe from: bleyer.org/icarus/
// Add the path C:\iverilog\bin to the PATH environment variable
// Go the folder containing full_adder.vl, then execute the following commands from the command prompt:
// iverilog -o full_adder full_adder.vl
// vvp full_adder
///////////////////////////////////////////////////////////////////////////////////////////////////
module half_adder (output sum, output carry, input a, input b);
    xor sum_gate (sum, a, b);
    and carry_gate (carry, a, b);
endmodule

module full_adder (output sum, output carry, input x, input y, input z);
    wire result_1, carry_1, carry_2; 
    half_adder first(result_1, carry_1, x, y);
    half_adder second(sum, carry_2, result_1, z);
    or carry_gate (carry, carry_1, carry_2);
endmodule

module mux_4x1 (output out, input in0, input in1, input in2, input in3, input s0, input s1);
    wire s0n, s1n;
    wire w1, w2, w3, w4;
    not not_gate0(s0n, s0);
    not not_gate1(s1n, s1);

    and and_gate1(w1, in0, s0n, s1n);
    and and_gate2(w2, in1, s0, s1n);
    and and_gate3(w3, in2, s0n, s1);
    and and_gate4(w4, in3, s0, s1);

    or or_gate1(out, w1, w2, w3, w4);
endmodule

module mux_2x1 (output out, input in0, input in1, input s0);
    wire s0n;
    wire w1, w2;
    not not_gate(s0n, s0);
    and and_gate1(w1, in0, s0n);
    and and_gate2(w2, in1, s0);
    or or_gate(out, w1, w2);
endmodule


module main (output g0, output g1, output g2, output c2, input [2:0] a, input [2:0] b, input [1:0]s);
    wire out_mux4x1_0, out_mux4x1_1, out_mux4x1_2;
    wire out_mux2x1_0, out_mux2x1_1, out_mux2x1_2;
    wire out_xor0, out_xor1, out_xor2;
    wire c0, c1;

    mux_4x1 mux_4x1_0(out_mux4x1_0, 1'b1, a[0], b[0], 1'b1, s[0], s[1]);
    mux_4x1 mux_4x1_1(out_mux4x1_1, 1'b0, a[1], b[1], 1'b0, s[0], s[1]);
    mux_4x1 mux_4x1_2(out_mux4x1_2, 1'b0, a[2], b[2], 1'b0, s[0], s[1]);

    mux_2x1 mux_2x1_0(out_mux2x1_0, a[0], b[0], s[0]);
    mux_2x1 mux_2x1_1(out_mux2x1_1, a[1], b[1], s[0]);
    mux_2x1 mux_2x1_2(out_mux2x1_2, a[2], b[2], s[0]);

    xor xor_gate0(out_xor0, s[1], out_mux2x1_0);
    xor xor_gate1(out_xor1, s[1], out_mux2x1_1);
    xor xor_gate2(out_xor2, s[1], out_mux2x1_2);

    full_adder fa0(g0, c0, out_mux4x1_0, out_xor0, s[1]);
    full_adder fa1(g1, c1, out_mux4x1_1, out_xor1, c0);
    full_adder fa2(g2, c2, out_mux4x1_2, out_xor2, c1);
endmodule

module test_bench ();
 reg [2:0] A;
  reg [2:0] B;
  reg [1:0] selector;
  wire [2:0] G;
  wire carry;
    main dut (
    .g0(G[0]),
    .g1(G[1]),
    .g2(G[2]),
    .c2(carry),
    .a(A),
    .b(B),
    .s(selector)
  );

initial begin
    for (integer A_val = -2; A_val < 4; A_val = A_val + 1) begin
        for (integer B_val = -2; B_val < 4; B_val = B_val + 1) begin
            for (integer sel_val = 0; sel_val < 4; sel_val = sel_val + 1) begin
                    A = A_val;
                    B = B_val;
                    selector = sel_val;
                    #10;
                    $display("Test Case: A=%b, B=%b, Selector=%b", A, B, selector);
                    #10;
                    $display("Output: CARRY G2 G1 G0 :%b%b",carry ,G);
                    $display("----------------------------------------");
                end
            end
         end   
   end
endmodule