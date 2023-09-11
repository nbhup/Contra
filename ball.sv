//-------------------------------------------------------------------------
//    Ball.sv                                                            --
//    Viral Mehta                                                        --
//    Spring 2005                                                        --
//                                                                       --
//    Modified by Stephen Kempf 03-01-2006                               --
//                              03-12-2007                               --
//    Translated by Joe Meng    07-07-2013                               --
//    Fall 2014 Distribution                                             --
//                                                                       --
//    For use with ECE 298 Lab 7                                         --
//    UIUC ECE Department                                                --
//-------------------------------------------------------------------------


module  ball ( input Reset, frame_clk,
					input [7:0] keycode, 
					input [9:0] playerX, playerY,
               output [9:0]  BallX, BallY,
					input f,
					input direction, 
					input scroll,
					output bfiring);
    
    logic [9:0] Ball_X_Pos, Ball_X_Motion, Ball_Y_Pos, Ball_Y_Motion, Ball_Size;
	 
	 logic firing;
	 
	 logic [9:0] subtract;
	 
	 assign subtract = -5;
	 
	 parameter [9:0] ball_step = 10'd10;
	 
	 logic [9:0] Ball_X_step;

    assign Ball_Size = 2;  
   
    always_ff @ (posedge Reset or posedge frame_clk )
    begin: Move_Ball
        if (Reset)  // Asynchronous Reset
        begin 
            Ball_Y_Motion <= 10'd0; 
				Ball_X_Motion <= 10'd0; 
				Ball_Y_Pos <= 10'd485;
				Ball_X_Pos <= playerX;
				firing <= 1'b0;
				Ball_X_step <= ball_step;
        end
           
        else 
        begin
				 if(direction == 1'b1)
					Ball_X_step <= ball_step;
			    else
					Ball_X_step <= (~ball_step)+1;

		
		
				 if ( (Ball_Y_Pos - Ball_Size) > 10'd479 ) begin  // Ball is outside the bottom edge
					  Ball_Y_Pos <= 10'd485;  //return
					  Ball_X_Pos <= playerX;
					  Ball_Y_Motion <= 10'd0; 
					  Ball_X_Motion <= 10'd0; 
					  firing <= 1'b0;
				 end
		
					  
				 else if ( (Ball_Y_Pos + Ball_Size) < 10'd0 ) begin // Ball is outside the top edge
					  Ball_Y_Pos <= 10'd485;//return
					  Ball_X_Pos <= playerX;
					  Ball_Y_Motion <= 10'd0; 
					  Ball_X_Motion <= 10'd0; 
					  firing <= 1'b0;
				 end
					  
				  else if ( (Ball_X_Pos - Ball_Size) > 10'd639 )  begin// Ball is outside the Right edge
					  Ball_Y_Pos <= 10'd485;  //return
					  Ball_X_Pos <= playerX;
					  Ball_Y_Motion <= 10'd0; 
					  Ball_X_Motion <= 10'd0; 
					  firing <= 1'b0;
				 end
					  
				 else if ( (Ball_X_Pos + Ball_Size) < 10'd0 )  begin// Ball is outside the Left edge
					  Ball_Y_Pos <= 10'd485; //return
					  Ball_X_Pos <= playerX;
					  Ball_Y_Motion <= 10'd0; 
					  Ball_X_Motion <= 10'd0; 
					  firing <= 1'b0;
				 end
					  
				 else if(firing == 1'b0) begin
					  Ball_Y_Pos <= 10'd485;//return
					  Ball_X_Pos <= playerX;
					  Ball_Y_Motion <= 10'd0; 
					  Ball_X_Motion <= 10'd0; 
					  firing <= 1'b0;
				 end
				 else begin
					 Ball_Y_Motion <= Ball_Y_Motion;  // Ball is somewhere in the middle just keep moving
					 Ball_X_Motion <= Ball_X_Motion;
					 firing <= firing;
				 end
					  
					  
				 
				 if(keycode == 8'd44 && firing == 1'b0 && f == 1'b1) begin //if space is hit
						Ball_X_Motion <= Ball_X_step;
						Ball_Y_Motion <= 0;
						Ball_X_Pos <= playerX;
						Ball_Y_Pos <= playerY;
						firing <= 1'b1;
				 end
				 else if(firing == 1'b1) begin
					Ball_Y_Pos <= (Ball_Y_Pos + Ball_Y_Motion);
					if(scroll == 1'b1) begin
						Ball_X_Pos <= (Ball_X_Pos + (Ball_X_Motion + subtract));	
					end
					else begin
						Ball_X_Pos <= (Ball_X_Pos + Ball_X_Motion);	
					end		 
				 end		
		end  
    end
       
    assign BallX = Ball_X_Pos;
   
    assign BallY = Ball_Y_Pos;
	 
	 assign bfiring = firing;
    

endmodule
