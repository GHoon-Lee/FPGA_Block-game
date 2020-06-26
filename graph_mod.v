module graph_mod (clk, rst, x, y, key, key_pulse, rgb);

input clk, rst;
input [9:0] x, y;
input [4:0] key, key_pulse; 
output [2:0] rgb; 

wire [9:0] bar_y_t, bar_y_b; 
reg [9:0] bar_y_reg;
wire refr_tick;

assign refr_tick = (y==479 && x==639)? 1:0;
assign bar_y_t = bar_y_reg;
assign bar_y_b = bar_y_t + 71;

always @ (posedge clk or posedge rst) begin
    if (rst) bar_y_reg <= 204;
    else if (refr_tick==1) 
        if (key==5'h11 && bar_y_b<=475) bar_y_reg <= bar_y_reg + 4; //move down
        else if (key==5'h14 && bar_y_t>=4) bar_y_reg <= bar_y_reg - 4;  //move up
end 


assign rgb = (x>=600 && x<=603 && y>=bar_y_t && y<=bar_y_b)? 3'b010 : 3'b110;




endmodule
