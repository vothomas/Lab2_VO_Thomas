// ECE 5440
// Thomas Vo 9861
// Button Shaper
// Takes button input into predictable digital signal

module buttonShaper (
    b_in, b_out, clk, rst
);
input b_in;
output b_out;
input clk, rst;
reg b_out;
parameter init = 0, pulse = 1, wait_s = 2;
reg[2:0] state, stateNext;
always @(state, b_in) begin
    case (state)
        init:begin
            b_out = 1'b0;
        if(b_in == 1'b1)
            stateNext = init;
        else
            stateNext = pulse;
        end 
        pulse: begin
            b_out = 1'b1;
            stateNext = wait_s;
        end
        wait_s: begin
            b_out = 1'b0;
            if(b_in == 1'b1)
                stateNext = init;
            else
                stateNext = wait_s;
        end
        default:begin
            b_out = 1'b0;
            stateNext = init;
        end 
    endcase
end
always @(posedge clk) begin
    if(rst == 1'b0)
        state  <= init;
    else
        state <= stateNext;
end 
endmodule
