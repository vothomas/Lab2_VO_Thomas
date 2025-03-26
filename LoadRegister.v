// ECE 5440
// Thomas Vo 9861
// Load Register
// Stores data for until button press

module LoadRegister (
    D_in,D_out, clk, rst, Load
);


input [3:0] D_in;
output [3:0] D_out;
input clk,rst;
input Load;
reg [3:0] D_out;

always @(posedge clk) 
    begin
    
    if(rst == 1'b0) 
    
    D_out <= 4'b0000 ;
    

    else 
    begin
    if(Load == 1'b1)
    D_out <= D_in;
    end
    

end


    
endmodule
