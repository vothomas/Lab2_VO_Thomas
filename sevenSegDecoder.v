//ECE5440 10409 ADD
// Thomas Vo 9861
//Seven Segment Decoder Module


module sevenSegDecoder (
    decode_in, decode_out
);
    input [3:0] decode_in;
    output [6:0] decode_out;
    reg [6:0] decode_out;
    always @(decode_in) begin
        case (decode_in)
            4'b0000: begin decode_out = 7'b1000000; end //0
            4'b0001: begin decode_out = 7'b1111001; end //1
            4'b0010: begin decode_out = 7'b0100100; end //2*
            4'b0011: begin decode_out = 7'b0110000; end //3
            4'b0100: begin decode_out = 7'b0011001; end //4
            4'b0101: begin decode_out = 7'b0010010; end //5
            4'b0110: begin decode_out = 7'b0000010; end //6
            4'b0111: begin decode_out = 7'b1111000; end //7*
            4'b1000: begin decode_out = 7'b0000000; end //8
            4'b1001: begin decode_out = 7'b0011000; end //9
            4'b1010: begin decode_out = 7'b0001000; end //A
            4'b1011: begin decode_out = 7'b0000011; end //B
            4'b1100: begin decode_out = 7'b1000110; end //C
            4'b1101: begin decode_out = 7'b0100001; end //D
            4'b1110: begin decode_out = 7'b0000110; end //E
            4'b1111: begin decode_out = 7'b0001110; end //F
            default: begin decode_out = 7'b1111111; end //default empty
        endcase
    end


endmodule
