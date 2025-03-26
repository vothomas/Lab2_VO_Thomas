// ECE 5440
// Thomas Vo 9861
// Access Controller
// controls several inputs and outputs of system design

module Access (
    PassDigit, PassEnter, Load_P1_In,
    Load_P2_In, LogIn, LogOut,
    Load_P1_Out, Load_P2_Out,
    rst, clk, LogOut_Input
);

input [3:0] PassDigit;
input PassEnter, Load_P1_In, Load_P2_In, clk, rst, LogOut_Input;
output LogIn, LogOut, Load_P1_Out, Load_P2_Out;
reg LogIn, LogOut, Load_P1_Out, Load_P2_Out, Flag;

parameter digit1 = 0, digit2 = 1, digit3 = 2, digit4 = 3, verify = 4, passed_pedning = 5,passed =6,  logged_out = 7;
reg [2:0] state;

always @(posedge clk) begin
    if(rst == 1'b0)begin
        state <= digit1;
        Flag <= 1'b1;
        LogIn <= 1'b0;
        LogOut <= 1'b1;
        Load_P1_Out <= 1'b0;
        Load_P2_Out <= 1'b0;
    end

    else begin
        
    case (state)
        digit1:begin
            Flag <= 1'b1;
            LogIn <= 1'b0;
            LogOut <= 1'b1;
            Load_P1_Out <= 1'b0;
            Load_P2_Out <= 1'b0;

            if(PassEnter == 1'b1)begin
                if(PassDigit != 4'b1001) //incorrect - 9
                    Flag <= 1'b0; 
                state <= digit2;
            end
            else
                state <= digit1;
        end 

        digit2:begin
            LogIn <= 1'b0;
            LogOut <= 1'b1;
            Load_P1_Out <= 1'b0;
            Load_P2_Out <= 1'b0;
            if(PassEnter == 1'b1)begin
                if(PassDigit != 4'b1000) //incorrect - 8
                    Flag <= 1'b0; 
                state <= digit3;
            end
            else
                state <= digit2;
        end

        digit3:begin
            LogIn <= 1'b0;
            LogOut <= 1'b1;
            Load_P1_Out <= 1'b0;
            Load_P2_Out <= 1'b0;
            if(PassEnter == 1'b1)begin
                if(PassDigit != 4'b0110) //incorrect - 6
                    Flag <= 1'b0; 
                state <= digit4;
            end
            else
                state <= digit3;
        end

        digit4:begin
            LogIn <= 1'b0;
            LogOut <= 1'b1;
            Load_P1_Out <= 1'b0;
            Load_P2_Out <= 1'b0;
            if(PassEnter == 1'b1)begin
                if(PassDigit != 4'b0001) //incorrect - 1
                    Flag <= 1'b0; 
                state <= verify;
            end
            else
                state <= digit4;
        end

        verify:begin
            if(Flag == 1'b1)
                state <= passed_pedning;
            else
                state <= digit1;
        end
        passed_pedning:begin
            LogIn <= 1'b1;
            LogOut <= 1'b0;
            if(Load_P1_In == 1'b1)begin
                Load_P1_Out <= 1'b1;
                state <= passed;
            end
            else 
                Load_P1_Out <= 1'b0;
            if(Load_P2_In == 1'b1)begin
                Load_P2_Out <= 1'b1;
                state <= passed;
            end
            else
                Load_P2_Out <= 1'b0;
        

        end

        passed:begin
            LogIn <= 1'b1;
            LogOut <= 1'b0;
            if(Load_P1_In == 1'b1)
                Load_P1_Out <= 1'b1;
            else 
                Load_P1_Out <= 1'b0;
            if(Load_P2_In == 1'b1)
                Load_P2_Out <= 1'b1;
            else
                Load_P2_Out <= 1'b0;
            //if loggedout is pressed, transition to logged outt state
             if(PassEnter == 1'b1 )
                 state <= logged_out;
        end

        logged_out: begin
            LogIn <= 1'b0;
            LogOut <= 1'b1;
            Load_P1_Out <= 1'b0;
            Load_P2_Out <= 1'b0;

            // User must re-enter the password to log back in
            if(PassEnter == 1'b1)
                state <= digit1;
        end

        default: begin
            state <= digit1;
            Flag <= 1'b1;
            LogIn <= 1'b0;
            LogOut <= 1'b1;
            Load_P1_Out <= 1'b0;
            Load_P2_Out <= 1'b0;
        end
    endcase
end
end
    
endmodule