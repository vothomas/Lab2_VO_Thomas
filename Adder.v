//ECE5440 10409 ADD
// Thomas Vo 9861
//Adder Module

module Adder (
    num1,num2,out,verify
);

input[3:0] num1,num2;
output [3:0] out;
output verify;
reg [3:0] out;
reg verify;

always @(num1,num2) begin
    out = num1 + num2;
    verify = num1 + num2;
end
    
endmodule
