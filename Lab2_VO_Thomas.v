// ECE 5440
// Thomas Vo 9861
// Top Level module for Lab 2

module Lab2_VO_Thomas (
    p1_in, p2_in, clk, rst,
    p1_button, p2_button,  pass_LogOut_button,
    p1_out, p2_out, sum_out,
    sum_led_nonMatch, sum_led_Match,
    LogOut_LED, LogIn_LED
);

input [3:0] p1_in, p2_in;
input p1_button, p2_button,  pass_LogOut_button, clk, rst;
output [6:0] p1_out, p2_out, sum_out;
output sum_led_nonMatch, sum_led_Match,LogOut_LED, LogIn_LED;

//configure buttons first **NOT reset
wire p1_To_Access, p2_To_Access, pass_To_Access, LogOut_To_Access;
buttonShaper p1buttonShaper(p1_button, p1_To_Access, clk, rst);
buttonShaper p2buttonShaper(p2_button, p2_To_Access, clk, rst);
buttonShaper pass(pass_LogOut_button, pass_To_Access, clk, rst);
buttonShaper LogOut(pass_LogOut_button, LogOut_To_Access, clk, rst);
//configure player inputs to Load Registers 
wire [3:0] loadReg_p1_out, loadReg_p2_out;
wire Load_P1_out, Load_P2_out;
LoadRegister p1loadReg(p1_in, loadReg_p1_out, clk, rst, Load_P1_out);
LoadRegister p2loadReg(p2_in, loadReg_p2_out, clk, rst, Load_P2_out);
//connect loadRegs to Adder and Decoders
wire [3:0] AddertoIs15, AddertoDecoder;
Adder myAdder(loadReg_p1_out, loadReg_p2_out, AddertoDecoder, AddertoIs15);
sevenSegDecoder p1SSD(loadReg_p1_out, p1_out);
sevenSegDecoder p2SSD(loadReg_p2_out, p2_out);
sevenSegDecoder adder(AddertoDecoder, sum_out);
// Is15 module
Is15 verify(AddertoDecoder, sum_led_Match, sum_led_nonMatch);
//Access Controller
Access myAC(p2_in, pass_To_Access, p1_To_Access, p2_To_Access, 
LogIn_LED, LogOut_LED, Load_P1_out, Load_P2_out, rst, clk, pass_LogOut_button);

endmodule