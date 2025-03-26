//ECE5440 10409 ADD
// Thomas Vo 9861
//Verification module


module Is15(is15_in, led_match_on, led_match_off);
input [3:0] is15_in;
output led_match_on, led_match_off;
reg led_match_on, led_match_off;

always @(*) begin
    if(is15_in == 4'b1111) begin
        led_match_on = 1'b1;
        led_match_off = 1'b0;
    end

    else begin
        led_match_on = 1'b0;
        led_match_off = 1'b1;
    end


end
endmodule