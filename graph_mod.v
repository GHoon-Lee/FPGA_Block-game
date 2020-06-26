module graph_mod (clk, rst, x, y, key, key_pulse, rgb);

input clk, rst;
input [9:0] x, y;
input [4:0] key, key_pulse; 
output [2:0] rgb; 

// 화면 크기 설정
parameter MAX_X = 640; 
parameter MAX_Y = 480;  


//bar의 x 좌표
parameter BAR_Y_T = 430; 
parameter BAR_Y_B = 433;

//bar 속도, bar size
parameter BAR_X_SIZE = 72;
parameter BAR_V = 8; 

//ball 속도, ball size 
parameter BALL_SIZE = 8; 
parameter BALL_V = 4;

//block setting
parameter BLOCK_X_SIZE=55;
parameter BLOCK_Y_SIZE=20;
parameter BLOCK_X_START=27;
parameter BLOCK_Y_START=40;

wire refr_tick; 

reg game_stop, game_over,game_clear;  

//refrernce tick 
assign refr_tick = (y==MAX_Y-1 && x==MAX_X-1)? 1 : 0; // 매 프레임마다 한 clk 동안만 1이 됨. 


/*---------------------------------------------------------*/
// bar의 위치 결정
/*---------------------------------------------------------*/
wire bar_on, ball_on; 
wire [9:0] bar_x_l, bar_x_r; 
reg [9:0] bar_x_reg; 

assign bar_x_l = bar_x_reg; //bar의 top
assign bar_x_r = bar_x_l + BAR_X_SIZE - 1; //bar의 bottom

assign bar_on = (x>=bar_x_l && x<=bar_x_r && y>=BAR_Y_T && y<=BAR_Y_B)? 1 : 0; //bar가 있는 영역

always @ (posedge clk or posedge rst) begin
    if (rst |game_over|game_clear) bar_x_reg <= (MAX_X-BAR_X_SIZE)/2; //game이 멈추면 중간에서 시작
    else if (refr_tick) 
        if (key==5'h11 && bar_x_r<=MAX_X-BAR_V+3) bar_x_reg <= bar_x_reg + BAR_V; //move lefrr
        else if (key==5'h13 && bar_x_l>=BAR_V-3) bar_x_reg <= bar_x_reg - BAR_V;  //move right
end

/*---------------------------------------------------------*/
// black 설정
/*---------------------------------------------------------*/
wire[9:0] block_x_l[1:31], block_x_r[1:31], block_y_t[1:31], block_y_b[1:31];
wire block_col_on[1:31];

//각 block의 위치 설정
assign block_x_l[1]=BLOCK_X_START;
assign block_x_r[1]=block_x_l[1]+BLOCK_X_SIZE;
assign block_y_t[1]=BLOCK_Y_START;
assign block_y_b[1]=block_y_t[1]+BLOCK_Y_SIZE;

assign block_x_l[2]=block_x_r[1]+4;
assign block_x_r[2]=block_x_l[2]+BLOCK_X_SIZE;
assign block_y_t[2]=BLOCK_Y_START;
assign block_y_b[2]=block_y_t[2]+BLOCK_Y_SIZE;

assign block_x_l[3]=block_x_r[2]+4;
assign block_x_r[3]=block_x_l[3]+BLOCK_X_SIZE;
assign block_y_t[3]=BLOCK_Y_START;
assign block_y_b[3]=block_y_t[3]+BLOCK_Y_SIZE;

assign block_x_l[4]=block_x_r[3]+4;
assign block_x_r[4]=block_x_l[4]+BLOCK_X_SIZE;
assign block_y_t[4]=BLOCK_Y_START;
assign block_y_b[4]=block_y_t[3]+BLOCK_Y_SIZE;

assign block_x_l[5]=block_x_r[4]+4;
assign block_x_r[5]=block_x_l[5]+BLOCK_X_SIZE;
assign block_y_t[5]=BLOCK_Y_START;
assign block_y_b[5]=block_y_t[5]+BLOCK_Y_SIZE;

assign block_x_l[6]=block_x_r[5]+4;
assign block_x_r[6]=block_x_l[6]+BLOCK_X_SIZE;
assign block_y_t[6]=BLOCK_Y_START;
assign block_y_b[6]=block_y_t[6]+BLOCK_Y_SIZE;

assign block_x_l[7]=block_x_r[6]+4;
assign block_x_r[7]=block_x_l[7]+BLOCK_X_SIZE;
assign block_y_t[7]=BLOCK_Y_START;
assign block_y_b[7]=block_y_t[7]+BLOCK_Y_SIZE;

assign block_x_l[8]=block_x_r[7]+4;
assign block_x_r[8]=block_x_l[8]+BLOCK_X_SIZE;
assign block_y_t[8]=BLOCK_Y_START;
assign block_y_b[8]=block_y_t[8]+BLOCK_Y_SIZE;

assign block_x_l[9]=block_x_r[8]+4;
assign block_x_r[9]=block_x_l[9]+BLOCK_X_SIZE;
assign block_y_t[9]=BLOCK_Y_START;
assign block_y_b[9]=block_y_t[9]+BLOCK_Y_SIZE;

assign block_x_l[10]=block_x_r[9]+4;
assign block_x_r[10]=block_x_l[10]+BLOCK_X_SIZE;
assign block_y_t[10]=BLOCK_Y_START;
assign block_y_b[10]=block_y_t[10]+BLOCK_Y_SIZE;

assign block_x_l[11]=BLOCK_X_START;
assign block_x_r[11]=block_x_l[11]+BLOCK_X_SIZE;
assign block_y_t[11]=BLOCK_Y_START+30;
assign block_y_b[11]=block_y_t[11]+BLOCK_Y_SIZE;

assign block_x_l[12]=block_x_r[11]+4;
assign block_x_r[12]=block_x_l[12]+BLOCK_X_SIZE;
assign block_y_t[12]=BLOCK_Y_START+30;
assign block_y_b[12]=block_y_t[12]+BLOCK_Y_SIZE;

assign block_x_l[13]=block_x_r[12]+4;
assign block_x_r[13]=block_x_l[13]+BLOCK_X_SIZE;
assign block_y_t[13]=BLOCK_Y_START+30;
assign block_y_b[13]=block_y_t[13]+BLOCK_Y_SIZE;

assign block_x_l[14]=block_x_r[13]+4;
assign block_x_r[14]=block_x_l[14]+BLOCK_X_SIZE;
assign block_y_t[14]=BLOCK_Y_START+30;
assign block_y_b[14]=block_y_t[13]+BLOCK_Y_SIZE;

assign block_x_l[15]=block_x_r[14]+4;
assign block_x_r[15]=block_x_l[15]+BLOCK_X_SIZE;
assign block_y_t[15]=BLOCK_Y_START+30;
assign block_y_b[15]=block_y_t[15]+BLOCK_Y_SIZE;

assign block_x_l[16]=block_x_r[15]+4;
assign block_x_r[16]=block_x_l[16]+BLOCK_X_SIZE;
assign block_y_t[16]=BLOCK_Y_START+30;
assign block_y_b[16]=block_y_t[16]+BLOCK_Y_SIZE;

assign block_x_l[17]=block_x_r[16]+4;
assign block_x_r[17]=block_x_l[17]+BLOCK_X_SIZE;
assign block_y_t[17]=BLOCK_Y_START+30;
assign block_y_b[17]=block_y_t[17]+BLOCK_Y_SIZE;

assign block_x_l[18]=block_x_r[17]+4;
assign block_x_r[18]=block_x_l[18]+BLOCK_X_SIZE;
assign block_y_t[18]=BLOCK_Y_START+30;
assign block_y_b[18]=block_y_t[18]+BLOCK_Y_SIZE;

assign block_x_l[19]=block_x_r[18]+4;
assign block_x_r[19]=block_x_l[19]+BLOCK_X_SIZE;
assign block_y_t[19]=BLOCK_Y_START+30;
assign block_y_b[19]=block_y_t[19]+BLOCK_Y_SIZE;

assign block_x_l[20]=block_x_r[19]+4;
assign block_x_r[20]=block_x_l[20]+BLOCK_X_SIZE;
assign block_y_t[20]=BLOCK_Y_START+30;
assign block_y_b[20]=block_y_t[20]+BLOCK_Y_SIZE;

assign block_x_l[21]=BLOCK_X_START;
assign block_x_r[21]=block_x_l[21]+BLOCK_X_SIZE;
assign block_y_t[21]=BLOCK_Y_START+60;
assign block_y_b[21]=block_y_t[21]+BLOCK_Y_SIZE;

assign block_x_l[22]=block_x_r[21]+4;
assign block_x_r[22]=block_x_l[22]+BLOCK_X_SIZE;
assign block_y_t[22]=BLOCK_Y_START+60;
assign block_y_b[22]=block_y_t[22]+BLOCK_Y_SIZE;

assign block_x_l[23]=block_x_r[22]+4;
assign block_x_r[23]=block_x_l[23]+BLOCK_X_SIZE;
assign block_y_t[23]=BLOCK_Y_START+60;
assign block_y_b[23]=block_y_t[23]+BLOCK_Y_SIZE;

assign block_x_l[24]=block_x_r[23]+4;
assign block_x_r[24]=block_x_l[24]+BLOCK_X_SIZE;
assign block_y_t[24]=BLOCK_Y_START+60;
assign block_y_b[24]=block_y_t[23]+BLOCK_Y_SIZE;

assign block_x_l[25]=block_x_r[24]+4;
assign block_x_r[25]=block_x_l[25]+BLOCK_X_SIZE;
assign block_y_t[25]=BLOCK_Y_START+60;
assign block_y_b[25]=block_y_t[25]+BLOCK_Y_SIZE;

assign block_x_l[26]=block_x_r[25]+4;
assign block_x_r[26]=block_x_l[26]+BLOCK_X_SIZE;
assign block_y_t[26]=BLOCK_Y_START+60;
assign block_y_b[26]=block_y_t[26]+BLOCK_Y_SIZE;

assign block_x_l[27]=block_x_r[26]+4;
assign block_x_r[27]=block_x_l[27]+BLOCK_X_SIZE;
assign block_y_t[27]=BLOCK_Y_START+60;
assign block_y_b[27]=block_y_t[27]+BLOCK_Y_SIZE;

assign block_x_l[28]=block_x_r[27]+4;
assign block_x_r[28]=block_x_l[28]+BLOCK_X_SIZE;
assign block_y_t[28]=BLOCK_Y_START+60;
assign block_y_b[28]=block_y_t[28]+BLOCK_Y_SIZE;

assign block_x_l[29]=block_x_r[28]+4;
assign block_x_r[29]=block_x_l[29]+BLOCK_X_SIZE;
assign block_y_t[29]=BLOCK_Y_START+60;
assign block_y_b[29]=block_y_t[29]+BLOCK_Y_SIZE;

assign block_x_l[30]=block_x_r[29]+4;
assign block_x_r[30]=block_x_l[30]+BLOCK_X_SIZE;
assign block_y_t[30]=BLOCK_Y_START+60;
assign block_y_b[30]=block_y_t[30]+BLOCK_Y_SIZE;

genvar i;
for(i=1; i<31; i=i+1)begin
    assign block_col_on[i] = (x>=block_x_l[i] && x<=block_x_r[i] && y>=block_y_t[i] && y<=block_y_b[i])? 1: 0;
end

wire all_break;
assign all_break= (block_on==0)? 1: 0; //모든 block이 사라졌을 때
/*---------------------------------------------------------*/
// ball의 위치 결정
/*---------------------------------------------------------*/
reg [9:0] ball_x_reg, ball_y_reg;
reg [9:0]  ball_vx_reg, ball_vy_reg; 
reg [30:1] block_on;
reg [4:0] reach;
wire [9:0] ball_x_l, ball_x_r, ball_y_t, ball_y_b;
wire miss;

assign ball_x_l = ball_x_reg; //ball의 left
assign ball_x_r = ball_x_reg + BALL_SIZE - 1; //ball의 right
assign ball_y_t = ball_y_reg; //ball의 top
assign ball_y_b = ball_y_reg + BALL_SIZE - 1; //ball의 bottom

assign ball_on = (x>=ball_x_l && x<=ball_x_r && y>=ball_y_t && y<=ball_y_b)? 1 : 0; //ball이 있는 영역

always @ (posedge clk or posedge rst) begin
    if(rst | game_stop) begin
        ball_x_reg <= bar_x_reg+32; // game이 멈추면 bar의 중간에서 시작                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 <= bar_x_reg+32; // game이 멈추면 중간에서 시작
        ball_y_reg <= BAR_Y_T-10; // game이 멈추면 bar의 위에서 시작
    end else if (refr_tick) begin
        ball_x_reg <= ball_x_reg + ball_vx_reg; //매 프레임마다 ball_vx_reg만큼 움직임
        ball_y_reg <= ball_y_reg + ball_vy_reg; //매 프레임마다 ball_vy_reg만큼 움직임
    end
end

always @(posedge clk or posedge rst) begin
    if(rst|game_over|game_clear)begin
        reach<=0;
        block_on[1]<=1;
        block_on[2]<=1;
        block_on[3]<=1;
        block_on[4]<=1;
        block_on[5]<=1;
        block_on[6]<=1;
        block_on[7]<=1;
        block_on[8]<=1;
        block_on[9]<=1;
        block_on[10]<=1;
        block_on[11]<=1;
        block_on[12]<=1;
        block_on[13]<=1;
        block_on[14]<=1;
        block_on[15]<=1;
        block_on[16]<=1;
        block_on[17]<=1;
        block_on[18]<=1;
        block_on[19]<=1;
        block_on[20]<=1;
        block_on[21]<=1;
        block_on[22]<=1;
        block_on[23]<=1;
        block_on[24]<=1;
        block_on[25]<=1;
        block_on[26]<=1;
        block_on[27]<=1;
        block_on[28]<=1;
        block_on[29]<=1;
        block_on[30]<=1;
    end
    
    else if (ball_y_t<=block_y_b[1] && ball_y_t>=block_y_b[1]-3 && ball_x_r>=block_x_l[1] && ball_x_l<=block_x_r[1] && block_on[1]==1) begin reach<=5'b00001; block_on[1]<=0; end//top
    else if (ball_x_l<=block_x_r[1] && ball_x_l>=block_x_r[1]-3 && ball_y_t<=block_y_b[1] && ball_y_b>=block_y_t[1] && block_on[1]==1) begin reach<=5'b00010; block_on[1]<=0; end//left
    else if (ball_y_b>=block_y_t[1] && ball_y_b<=block_y_t[1]+3 && ball_x_r>=block_x_l[1] && ball_x_l<=block_x_r[1] && block_on[1]==1) begin reach<=5'b00100; block_on[1]<=0; end//bottom    
    else if (ball_x_r>=block_x_l[1] && ball_x_r<=block_x_l[1]+3 && ball_y_t<=block_y_b[1] && ball_y_b>=block_y_t[1] && block_on[1]==1) begin reach<=5'b01000; block_on[1]<=0; end//right
                                                              
    else if (ball_y_t<=block_y_b[2] && ball_y_t>=block_y_b[2]-3 && ball_x_r>=block_x_l[2] && ball_x_l<=block_x_r[2] && block_on[2]==1) begin reach<=5'b00001; block_on[2]<=0; end//top
    else if (ball_x_l<=block_x_r[2] && ball_x_l>=block_x_r[2]-3 && ball_y_t<=block_y_b[2] && ball_y_b>=block_y_t[2] && block_on[2]==1) begin reach<=5'b00010; block_on[2]<=0; end//left
    else if (ball_y_b>=block_y_t[2] && ball_y_b<=block_y_t[2]+3 && ball_x_r>=block_x_l[2] && ball_x_l<=block_x_r[2] && block_on[2]==1) begin reach<=5'b00100; block_on[2]<=0; end//bottom    
    else if (ball_x_r>=block_x_l[2] && ball_x_r<=block_x_l[2]+3 && ball_y_t<=block_y_b[2] && ball_y_b>=block_y_t[2] && block_on[2]==1) begin reach<=5'b01000; block_on[2]<=0; end//right
                                                              
    else if (ball_y_t<=block_y_b[3] && ball_y_t>=block_y_b[3]-3 && ball_x_r>=block_x_l[3] && ball_x_l<=block_x_r[3] && block_on[3]==1) begin reach<=5'b00001; block_on[3]<=0; end//top
    else if (ball_x_l<=block_x_r[3] && ball_x_l>=block_x_r[3]-3 && ball_y_t<=block_y_b[3] && ball_y_b>=block_y_t[3] && block_on[3]==1) begin reach<=5'b00010; block_on[3]<=0; end//left
    else if (ball_y_b>=block_y_t[3] && ball_y_b<=block_y_t[3]+3 && ball_x_r>=block_x_l[3] && ball_x_l<=block_x_r[3] && block_on[3]==1) begin reach<=5'b00100; block_on[3]<=0; end//bottom    
    else if (ball_x_r>=block_x_l[3] && ball_x_r<=block_x_l[3]+3 && ball_y_t<=block_y_b[3] && ball_y_b>=block_y_t[3] && block_on[3]==1) begin reach<=5'b01000; block_on[3]<=0; end//right
                                                              
    else if (ball_y_t<=block_y_b[4] && ball_y_t>=block_y_b[4]-3 && ball_x_r>=block_x_l[4] && ball_x_l<=block_x_r[4] && block_on[4]==1) begin reach<=5'b00001; block_on[4]<=0; end//top
    else if (ball_x_l<=block_x_r[4] && ball_x_l>=block_x_r[4]-3 && ball_y_t<=block_y_b[4] && ball_y_b>=block_y_t[4] && block_on[4]==1) begin reach<=5'b00010; block_on[4]<=0; end//left
    else if (ball_y_b>=block_y_t[4] && ball_y_b<=block_y_t[4]+3 && ball_x_r>=block_x_l[4] && ball_x_l<=block_x_r[4] && block_on[4]==1) begin reach<=5'b00100; block_on[4]<=0; end//bottom    
    else if (ball_x_r>=block_x_l[4] && ball_x_r<=block_x_l[4]+3 && ball_y_t<=block_y_b[4] && ball_y_b>=block_y_t[4] && block_on[4]==1) begin reach<=5'b01000; block_on[4]<=0; end//right
                                                              
    else if (ball_y_t<=block_y_b[5] && ball_y_t>=block_y_b[5]-3 && ball_x_r>=block_x_l[5] && ball_x_l<=block_x_r[5] && block_on[5]==1) begin reach<=5'b00001; block_on[5]<=0; end//top
    else if (ball_x_l<=block_x_r[5] && ball_x_l>=block_x_r[5]-3 && ball_y_t<=block_y_b[5] && ball_y_b>=block_y_t[5] && block_on[5]==1) begin reach<=5'b00010; block_on[5]<=0; end//left
    else if (ball_y_b>=block_y_t[5] && ball_y_b<=block_y_t[5]+3 && ball_x_r>=block_x_l[5] && ball_x_l<=block_x_r[5] && block_on[5]==1) begin reach<=5'b00100; block_on[5]<=0; end//bottom    
    else if (ball_x_r>=block_x_l[5] && ball_x_r<=block_x_l[5]+3 && ball_y_t<=block_y_b[5] && ball_y_b>=block_y_t[5] && block_on[5]==1) begin reach<=5'b01000; block_on[5]<=0; end//right
                                                              
    else if (ball_y_t<=block_y_b[6] && ball_y_t>=block_y_b[6]-3 && ball_x_r>=block_x_l[6] && ball_x_l<=block_x_r[6] && block_on[6]==1) begin reach<=5'b00001; block_on[6]<=0; end//top
    else if (ball_x_l<=block_x_r[6] && ball_x_l>=block_x_r[6]-3 && ball_y_t<=block_y_b[6] && ball_y_b>=block_y_t[6] && block_on[6]==1) begin reach<=5'b00010; block_on[6]<=0; end//left
    else if (ball_y_b>=block_y_t[6] && ball_y_b<=block_y_t[6]+3 && ball_x_r>=block_x_l[6] && ball_x_l<=block_x_r[6] && block_on[6]==1) begin reach<=5'b00100; block_on[6]<=0; end//bottom    
    else if (ball_x_r>=block_x_l[6] && ball_x_r<=block_x_l[6]+3 && ball_y_t<=block_y_b[6] && ball_y_b>=block_y_t[6] && block_on[6]==1) begin reach<=5'b01000; block_on[6]<=0; end//right
                                                              
    else if (ball_y_t<=block_y_b[7] && ball_y_t>=block_y_b[7]-3 && ball_x_r>=block_x_l[7] && ball_x_l<=block_x_r[7] && block_on[7]==1) begin reach<=5'b00001; block_on[7]<=0; end//top
    else if (ball_x_l<=block_x_r[7] && ball_x_l>=block_x_r[7]-3 && ball_y_t<=block_y_b[7] && ball_y_b>=block_y_t[7] && block_on[7]==1) begin reach<=5'b00010; block_on[7]<=0; end//left
    else if (ball_y_b>=block_y_t[7] && ball_y_b<=block_y_t[7]+3 && ball_x_r>=block_x_l[7] && ball_x_l<=block_x_r[7] && block_on[7]==1) begin reach<=5'b00100; block_on[7]<=0; end//bottom    
    else if (ball_x_r>=block_x_l[7] && ball_x_r<=block_x_l[7]+3 && ball_y_t<=block_y_b[7] && ball_y_b>=block_y_t[7] && block_on[7]==1) begin reach<=5'b01000; block_on[7]<=0; end//right
                                                              
    else if (ball_y_t<=block_y_b[8] && ball_y_t>=block_y_b[8]-3 && ball_x_r>=block_x_l[8] && ball_x_l<=block_x_r[8] && block_on[8]==1) begin reach<=5'b00001; block_on[8]<=0; end//top
    else if (ball_x_l<=block_x_r[8] && ball_x_l>=block_x_r[8]-3 && ball_y_t<=block_y_b[8] && ball_y_b>=block_y_t[8] && block_on[8]==1) begin reach<=5'b00010; block_on[8]<=0; end//left
    else if (ball_y_b>=block_y_t[8] && ball_y_b<=block_y_t[8]+3 && ball_x_r>=block_x_l[8] && ball_x_l<=block_x_r[8] && block_on[8]==1) begin reach<=5'b00100; block_on[8]<=0; end//bottom    
    else if (ball_x_r>=block_x_l[8] && ball_x_r<=block_x_l[8]+3 && ball_y_t<=block_y_b[8] && ball_y_b>=block_y_t[8] && block_on[8]==1) begin reach<=5'b01000; block_on[8]<=0; end//right
                                                              
    else if (ball_y_t<=block_y_b[9] && ball_y_t>=block_y_b[9]-3 && ball_x_r>=block_x_l[9] && ball_x_l<=block_x_r[9] && block_on[9]==1) begin reach<=5'b00001; block_on[9]<=0; end//top
    else if (ball_x_l<=block_x_r[9] && ball_x_l>=block_x_r[9]-3 && ball_y_t<=block_y_b[9] && ball_y_b>=block_y_t[9] && block_on[9]==1) begin reach<=5'b00010; block_on[9]<=0; end//left
    else if (ball_y_b>=block_y_t[9] && ball_y_b<=block_y_t[9]+3 && ball_x_r>=block_x_l[9] && ball_x_l<=block_x_r[9] && block_on[9]==1) begin reach<=5'b00100; block_on[9]<=0; end//bottom    
    else if (ball_x_r>=block_x_l[9] && ball_x_r<=block_x_l[9]+3 && ball_y_t<=block_y_b[9] && ball_y_b>=block_y_t[9] && block_on[9]==1) begin reach<=5'b01000; block_on[9]<=0; end//right
    
    else if (ball_y_t<=block_y_b[10] && ball_y_t>=block_y_b[10]-3 && ball_x_r>=block_x_l[10] && ball_x_l<=block_x_r[10] && block_on[10]==1) begin reach<=5'b00001; block_on[10]<=0; end//top
    else if (ball_x_l<=block_x_r[10] && ball_x_l>=block_x_r[10]-3 && ball_y_t<=block_y_b[10] && ball_y_b>=block_y_t[10] && block_on[10]==1) begin reach<=5'b00010; block_on[10]<=0; end//left
    else if (ball_y_b>=block_y_t[10] && ball_y_b<=block_y_t[10]+3 && ball_x_r>=block_x_l[10] && ball_x_l<=block_x_r[10] && block_on[10]==1) begin reach<=5'b00100; block_on[10]<=0; end//bottom    
    else if (ball_x_r>=block_x_l[10] && ball_x_r<=block_x_l[10]+3 && ball_y_t<=block_y_b[10] && ball_y_b>=block_y_t[10] && block_on[10]==1) begin reach<=5'b01000; block_on[10]<=0; end//right
                                                                
    else if (ball_y_t<=block_y_b[11] && ball_y_t>=block_y_b[11]-3 && ball_x_r>=block_x_l[11] && ball_x_l<=block_x_r[11] && block_on[11]==1) begin reach<=5'b00001; block_on[11]<=0; end//top
    else if (ball_x_l<=block_x_r[11] && ball_x_l>=block_x_r[11]-3 && ball_y_t<=block_y_b[11] && ball_y_b>=block_y_t[11] && block_on[11]==1) begin reach<=5'b00010; block_on[11]<=0; end//left
    else if (ball_y_b>=block_y_t[11] && ball_y_b<=block_y_t[11]+3 && ball_x_r>=block_x_l[11] && ball_x_l<=block_x_r[11] && block_on[11]==1) begin reach<=5'b00100; block_on[11]<=0; end//bottom    
    else if (ball_x_r>=block_x_l[11] && ball_x_r<=block_x_l[11]+3 && ball_y_t<=block_y_b[11] && ball_y_b>=block_y_t[11] && block_on[11]==1) begin reach<=5'b01000; block_on[11]<=0; end//right
                                                                
    else if (ball_y_t<=block_y_b[12] && ball_y_t>=block_y_b[12]-3 && ball_x_r>=block_x_l[12] && ball_x_l<=block_x_r[12] && block_on[12]==1) begin reach<=5'b00001; block_on[12]<=0; end//top
    else if (ball_x_l<=block_x_r[12] && ball_x_l>=block_x_r[12]-3 && ball_y_t<=block_y_b[12] && ball_y_b>=block_y_t[12] && block_on[12]==1) begin reach<=5'b00010; block_on[12]<=0; end//left
    else if (ball_y_b>=block_y_t[12] && ball_y_b<=block_y_t[12]+3 && ball_x_r>=block_x_l[12] && ball_x_l<=block_x_r[12] && block_on[12]==1) begin reach<=5'b00100; block_on[12]<=0; end//bottom    
    else if (ball_x_r>=block_x_l[12] && ball_x_r<=block_x_l[12]+3 && ball_y_t<=block_y_b[12] && ball_y_b>=block_y_t[12] && block_on[12]==1) begin reach<=5'b01000; block_on[12]<=0; end//right
                                                                
    else if (ball_y_t<=block_y_b[13] && ball_y_t>=block_y_b[13]-3 && ball_x_r>=block_x_l[13] && ball_x_l<=block_x_r[13] && block_on[13]==1) begin reach<=5'b00001; block_on[13]<=0; end//top
    else if (ball_x_l<=block_x_r[13] && ball_x_l>=block_x_r[13]-3 && ball_y_t<=block_y_b[13] && ball_y_b>=block_y_t[13] && block_on[13]==1) begin reach<=5'b00010; block_on[13]<=0; end//left
    else if (ball_y_b>=block_y_t[13] && ball_y_b<=block_y_t[13]+3 && ball_x_r>=block_x_l[13] && ball_x_l<=block_x_r[13] && block_on[13]==1) begin reach<=5'b00100; block_on[13]<=0; end//bottom    
    else if (ball_x_r>=block_x_l[13] && ball_x_r<=block_x_l[13]+3 && ball_y_t<=block_y_b[13] && ball_y_b>=block_y_t[13] && block_on[13]==1) begin reach<=5'b01000; block_on[13]<=0; end//right
                                                                
    else if (ball_y_t<=block_y_b[14] && ball_y_t>=block_y_b[14]-3 && ball_x_r>=block_x_l[14] && ball_x_l<=block_x_r[14] && block_on[14]==1) begin reach<=5'b00001; block_on[14]<=0; end//top
    else if (ball_x_l<=block_x_r[14] && ball_x_l>=block_x_r[14]-3 && ball_y_t<=block_y_b[14] && ball_y_b>=block_y_t[14] && block_on[14]==1) begin reach<=5'b00010; block_on[14]<=0; end//left
    else if (ball_y_b>=block_y_t[14] && ball_y_b<=block_y_t[14]+3 && ball_x_r>=block_x_l[14] && ball_x_l<=block_x_r[14] && block_on[14]==1) begin reach<=5'b00100; block_on[14]<=0; end//bottom    
    else if (ball_x_r>=block_x_l[14] && ball_x_r<=block_x_l[14]+3 && ball_y_t<=block_y_b[14] && ball_y_b>=block_y_t[14] && block_on[14]==1) begin reach<=5'b01000; block_on[14]<=0; end//right
                                                                
    else if (ball_y_t<=block_y_b[15] && ball_y_t>=block_y_b[15]-3 && ball_x_r>=block_x_l[15] && ball_x_l<=block_x_r[15] && block_on[15]==1) begin reach<=5'b00001; block_on[15]<=0; end//top
    else if (ball_x_l<=block_x_r[15] && ball_x_l>=block_x_r[15]-3 && ball_y_t<=block_y_b[15] && ball_y_b>=block_y_t[15] && block_on[15]==1) begin reach<=5'b00010; block_on[15]<=0; end//left
    else if (ball_y_b>=block_y_t[15] && ball_y_b<=block_y_t[15]+3 && ball_x_r>=block_x_l[15] && ball_x_l<=block_x_r[15] && block_on[15]==1) begin reach<=5'b00100; block_on[15]<=0; end//bottom    
    else if (ball_x_r>=block_x_l[15] && ball_x_r<=block_x_l[15]+3 && ball_y_t<=block_y_b[15] && ball_y_b>=block_y_t[15] && block_on[15]==1) begin reach<=5'b01000; block_on[15]<=0; end//right
                                                                
    else if (ball_y_t<=block_y_b[16] && ball_y_t>=block_y_b[16]-3 && ball_x_r>=block_x_l[16] && ball_x_l<=block_x_r[16] && block_on[16]==1) begin reach<=5'b00001; block_on[16]<=0; end//top
    else if (ball_x_l<=block_x_r[16] && ball_x_l>=block_x_r[16]-3 && ball_y_t<=block_y_b[16] && ball_y_b>=block_y_t[16] && block_on[16]==1) begin reach<=5'b00010; block_on[16]<=0; end//left
    else if (ball_y_b>=block_y_t[16] && ball_y_b<=block_y_t[16]+3 && ball_x_r>=block_x_l[16] && ball_x_l<=block_x_r[16] && block_on[16]==1) begin reach<=5'b00100; block_on[16]<=0; end//bottom    
    else if (ball_x_r>=block_x_l[16] && ball_x_r<=block_x_l[16]+3 && ball_y_t<=block_y_b[16] && ball_y_b>=block_y_t[16] && block_on[16]==1) begin reach<=5'b01000; block_on[16]<=0; end//right
                                                                
    else if (ball_y_t<=block_y_b[17] && ball_y_t>=block_y_b[17]-3 && ball_x_r>=block_x_l[17] && ball_x_l<=block_x_r[17] && block_on[17]==1) begin reach<=5'b00001; block_on[17]<=0; end//top
    else if (ball_x_l<=block_x_r[17] && ball_x_l>=block_x_r[17]-3 && ball_y_t<=block_y_b[17] && ball_y_b>=block_y_t[17] && block_on[17]==1) begin reach<=5'b00010; block_on[17]<=0; end//left
    else if (ball_y_b>=block_y_t[17] && ball_y_b<=block_y_t[17]+3 && ball_x_r>=block_x_l[17] && ball_x_l<=block_x_r[17] && block_on[17]==1) begin reach<=5'b00100; block_on[17]<=0; end//bottom    
    else if (ball_x_r>=block_x_l[17] && ball_x_r<=block_x_l[17]+3 && ball_y_t<=block_y_b[17] && ball_y_b>=block_y_t[17] && block_on[17]==1) begin reach<=5'b01000; block_on[17]<=0; end//right
                                                                
    else if (ball_y_t<=block_y_b[18] && ball_y_t>=block_y_b[18]-3 && ball_x_r>=block_x_l[18] && ball_x_l<=block_x_r[18] && block_on[18]==1) begin reach<=5'b00001; block_on[18]<=0; end//top
    else if (ball_x_l<=block_x_r[18] && ball_x_l>=block_x_r[18]-3 && ball_y_t<=block_y_b[18] && ball_y_b>=block_y_t[18] && block_on[18]==1) begin reach<=5'b00010; block_on[18]<=0; end//left
    else if (ball_y_b>=block_y_t[18] && ball_y_b<=block_y_t[18]+3 && ball_x_r>=block_x_l[18] && ball_x_l<=block_x_r[18] && block_on[18]==1) begin reach<=5'b00100; block_on[18]<=0; end//bottom    
    else if (ball_x_r>=block_x_l[18] && ball_x_r<=block_x_l[18]+3 && ball_y_t<=block_y_b[18] && ball_y_b>=block_y_t[18] && block_on[18]==1) begin reach<=5'b01000; block_on[18]<=0; end//right
                                                                
    else if (ball_y_t<=block_y_b[19] && ball_y_t>=block_y_b[19]-3 && ball_x_r>=block_x_l[19] && ball_x_l<=block_x_r[19] && block_on[19]==1) begin reach<=5'b00001; block_on[19]<=0; end//top
    else if (ball_x_l<=block_x_r[19] && ball_x_l>=block_x_r[19]-3 && ball_y_t<=block_y_b[19] && ball_y_b>=block_y_t[19] && block_on[19]==1) begin reach<=5'b00010; block_on[19]<=0; end//left
    else if (ball_y_b>=block_y_t[19] && ball_y_b<=block_y_t[19]+3 && ball_x_r>=block_x_l[19] && ball_x_l<=block_x_r[19] && block_on[19]==1) begin reach<=5'b00100; block_on[19]<=0; end//bottom    
    else if (ball_x_r>=block_x_l[19] && ball_x_r<=block_x_l[19]+3 && ball_y_t<=block_y_b[19] && ball_y_b>=block_y_t[19] && block_on[19]==1) begin reach<=5'b01000; block_on[19]<=0; end//right
                                                                
    else if (ball_y_t<=block_y_b[20] && ball_y_t>=block_y_b[20]-3 && ball_x_r>=block_x_l[20] && ball_x_l<=block_x_r[20] && block_on[20]==1) begin reach<=5'b00001; block_on[20]<=0; end//top
    else if (ball_x_l<=block_x_r[20] && ball_x_l>=block_x_r[20]-3 && ball_y_t<=block_y_b[20] && ball_y_b>=block_y_t[20] && block_on[20]==1) begin reach<=5'b00010; block_on[20]<=0; end//left
    else if (ball_y_b>=block_y_t[20] && ball_y_b<=block_y_t[20]+3 && ball_x_r>=block_x_l[20] && ball_x_l<=block_x_r[20] && block_on[20]==1) begin reach<=5'b00100; block_on[20]<=0; end//bottom    
    else if (ball_x_r>=block_x_l[20] && ball_x_r<=block_x_l[20]+3 && ball_y_t<=block_y_b[20] && ball_y_b>=block_y_t[20] && block_on[20]==1) begin reach<=5'b01000; block_on[20]<=0; end//right
                                                                
    else if (ball_y_t<=block_y_b[21] && ball_y_t>=block_y_b[21]-3 && ball_x_r>=block_x_l[21] && ball_x_l<=block_x_r[21] && block_on[21]==1) begin reach<=5'b00001; block_on[21]<=0; end//top
    else if (ball_x_l<=block_x_r[21] && ball_x_l>=block_x_r[21]-3 && ball_y_t<=block_y_b[21] && ball_y_b>=block_y_t[21] && block_on[21]==1) begin reach<=5'b00010; block_on[21]<=0; end//left
    else if (ball_y_b>=block_y_t[21] && ball_y_b<=block_y_t[21]+3 && ball_x_r>=block_x_l[21] && ball_x_l<=block_x_r[21] && block_on[21]==1) begin reach<=5'b00100; block_on[21]<=0; end//bottom    
    else if (ball_x_r>=block_x_l[21] && ball_x_r<=block_x_l[21]+3 && ball_y_t<=block_y_b[21] && ball_y_b>=block_y_t[21] && block_on[21]==1) begin reach<=5'b01000; block_on[21]<=0; end//right
                                                                
    else if (ball_y_t<=block_y_b[22] && ball_y_t>=block_y_b[22]-3 && ball_x_r>=block_x_l[22] && ball_x_l<=block_x_r[22] && block_on[22]==1) begin reach<=5'b00001; block_on[22]<=0; end//top
    else if (ball_x_l<=block_x_r[22] && ball_x_l>=block_x_r[22]-3 && ball_y_t<=block_y_b[22] && ball_y_b>=block_y_t[22] && block_on[22]==1) begin reach<=5'b00010; block_on[22]<=0; end//left
    else if (ball_y_b>=block_y_t[22] && ball_y_b<=block_y_t[22]+3 && ball_x_r>=block_x_l[22] && ball_x_l<=block_x_r[22] && block_on[22]==1) begin reach<=5'b00100; block_on[22]<=0; end//bottom    
    else if (ball_x_r>=block_x_l[22] && ball_x_r<=block_x_l[22]+3 && ball_y_t<=block_y_b[22] && ball_y_b>=block_y_t[22] && block_on[22]==1) begin reach<=5'b01000; block_on[22]<=0; end//right
                                                                
    else if (ball_y_t<=block_y_b[23] && ball_y_t>=block_y_b[23]-3 && ball_x_r>=block_x_l[23] && ball_x_l<=block_x_r[23] && block_on[23]==1) begin reach<=5'b00001; block_on[23]<=0; end//top
    else if (ball_x_l<=block_x_r[23] && ball_x_l>=block_x_r[23]-3 && ball_y_t<=block_y_b[23] && ball_y_b>=block_y_t[23] && block_on[23]==1) begin reach<=5'b00010; block_on[23]<=0; end//left
    else if (ball_y_b>=block_y_t[23] && ball_y_b<=block_y_t[23]+3 && ball_x_r>=block_x_l[23] && ball_x_l<=block_x_r[23] && block_on[23]==1) begin reach<=5'b00100; block_on[23]<=0; end//bottom    
    else if (ball_x_r>=block_x_l[23] && ball_x_r<=block_x_l[23]+3 && ball_y_t<=block_y_b[23] && ball_y_b>=block_y_t[23] && block_on[23]==1) begin reach<=5'b01000; block_on[23]<=0; end//right
                                                                
    else if (ball_y_t<=block_y_b[24] && ball_y_t>=block_y_b[24]-3 && ball_x_r>=block_x_l[24] && ball_x_l<=block_x_r[24] && block_on[24]==1) begin reach<=5'b00001; block_on[24]<=0; end//top
    else if (ball_x_l<=block_x_r[24] && ball_x_l>=block_x_r[24]-3 && ball_y_t<=block_y_b[24] && ball_y_b>=block_y_t[24] && block_on[24]==1) begin reach<=5'b00010; block_on[24]<=0; end//left
    else if (ball_y_b>=block_y_t[24] && ball_y_b<=block_y_t[24]+3 && ball_x_r>=block_x_l[24] && ball_x_l<=block_x_r[24] && block_on[24]==1) begin reach<=5'b00100; block_on[24]<=0; end//bottom    
    else if (ball_x_r>=block_x_l[24] && ball_x_r<=block_x_l[24]+3 && ball_y_t<=block_y_b[24] && ball_y_b>=block_y_t[24] && block_on[24]==1) begin reach<=5'b01000; block_on[24]<=0; end//right
                                                                
    else if (ball_y_t<=block_y_b[25] && ball_y_t>=block_y_b[25]-3 && ball_x_r>=block_x_l[25] && ball_x_l<=block_x_r[25] && block_on[25]==1) begin reach<=5'b00001; block_on[25]<=0; end//top
    else if (ball_x_l<=block_x_r[25] && ball_x_l>=block_x_r[25]-3 && ball_y_t<=block_y_b[25] && ball_y_b>=block_y_t[25] && block_on[25]==1) begin reach<=5'b00010; block_on[25]<=0; end//left
    else if (ball_y_b>=block_y_t[25] && ball_y_b<=block_y_t[25]+3 && ball_x_r>=block_x_l[25] && ball_x_l<=block_x_r[25] && block_on[25]==1) begin reach<=5'b00100; block_on[25]<=0; end//bottom    
    else if (ball_x_r>=block_x_l[25] && ball_x_r<=block_x_l[25]+3 && ball_y_t<=block_y_b[25] && ball_y_b>=block_y_t[25] && block_on[25]==1) begin reach<=5'b01000; block_on[25]<=0; end//right
                                                                
    else if (ball_y_t<=block_y_b[26] && ball_y_t>=block_y_b[26]-3 && ball_x_r>=block_x_l[26] && ball_x_l<=block_x_r[26] && block_on[26]==1) begin reach<=5'b00001; block_on[26]<=0; end//top
    else if (ball_x_l<=block_x_r[26] && ball_x_l>=block_x_r[26]-3 && ball_y_t<=block_y_b[26] && ball_y_b>=block_y_t[26] && block_on[26]==1) begin reach<=5'b00010; block_on[26]<=0; end//left
    else if (ball_y_b>=block_y_t[26] && ball_y_b<=block_y_t[26]+3 && ball_x_r>=block_x_l[26] && ball_x_l<=block_x_r[26] && block_on[26]==1) begin reach<=5'b00100; block_on[26]<=0; end//bottom    
    else if (ball_x_r>=block_x_l[26] && ball_x_r<=block_x_l[26]+3 && ball_y_t<=block_y_b[26] && ball_y_b>=block_y_t[26] && block_on[26]==1) begin reach<=5'b01000; block_on[26]<=0; end//right
                                                                
    else if (ball_y_t<=block_y_b[27] && ball_y_t>=block_y_b[27]-3 && ball_x_r>=block_x_l[27] && ball_x_l<=block_x_r[27] && block_on[27]==1) begin reach<=5'b00001; block_on[27]<=0; end//top
    else if (ball_x_l<=block_x_r[27] && ball_x_l>=block_x_r[27]-3 && ball_y_t<=block_y_b[27] && ball_y_b>=block_y_t[27] && block_on[27]==1) begin reach<=5'b00010; block_on[27]<=0; end//left
    else if (ball_y_b>=block_y_t[27] && ball_y_b<=block_y_t[27]+3 && ball_x_r>=block_x_l[27] && ball_x_l<=block_x_r[27] && block_on[27]==1) begin reach<=5'b00100; block_on[27]<=0; end//bottom    
    else if (ball_x_r>=block_x_l[27] && ball_x_r<=block_x_l[27]+3 && ball_y_t<=block_y_b[27] && ball_y_b>=block_y_t[27] && block_on[27]==1) begin reach<=5'b01000; block_on[27]<=0; end//right

    else if (ball_y_t<=block_y_b[28] && ball_y_t>=block_y_b[28]-3 && ball_x_r>=block_x_l[28] && ball_x_l<=block_x_r[28] && block_on[28]==1) begin reach<=5'b00001; block_on[28]<=0; end//top
    else if (ball_x_l<=block_x_r[28] && ball_x_l>=block_x_r[28]-3 && ball_y_t<=block_y_b[28] && ball_y_b>=block_y_t[28] && block_on[28]==1) begin reach<=5'b00010; block_on[28]<=0; end//left
    else if (ball_y_b>=block_y_t[28] && ball_y_b<=block_y_t[28]+3 && ball_x_r>=block_x_l[28] && ball_x_l<=block_x_r[28] && block_on[28]==1) begin reach<=5'b00100; block_on[28]<=0; end//bottom    
    else if (ball_x_r>=block_x_l[28] && ball_x_r<=block_x_l[28]+3 && ball_y_t<=block_y_b[28] && ball_y_b>=block_y_t[28] && block_on[28]==1) begin reach<=5'b01000; block_on[28]<=0; end//right

    else if (ball_y_t<=block_y_b[29] && ball_y_t>=block_y_b[29]-3 && ball_x_r>=block_x_l[29] && ball_x_l<=block_x_r[29] && block_on[29]==1) begin reach<=5'b00001; block_on[29]<=0; end//top
    else if (ball_x_l<=block_x_r[29] && ball_x_l>=block_x_r[29]-3 && ball_y_t<=block_y_b[29] && ball_y_b>=block_y_t[29] && block_on[29]==1) begin reach<=5'b00010; block_on[29]<=0; end//left
    else if (ball_y_b>=block_y_t[29] && ball_y_b<=block_y_t[29]+3 && ball_x_r>=block_x_l[29] && ball_x_l<=block_x_r[29] && block_on[29]==1) begin reach<=5'b00100; block_on[29]<=0; end//bottom    
    else if (ball_x_r>=block_x_l[29] && ball_x_r<=block_x_l[29]+3 && ball_y_t<=block_y_b[29] && ball_y_b>=block_y_t[29] && block_on[29]==1) begin reach<=5'b01000; block_on[29]<=0; end//right

    else if (ball_y_t<=block_y_b[30] && ball_y_t>=block_y_b[30]-3 && ball_x_r>=block_x_l[30] && ball_x_l<=block_x_r[30] && block_on[30]==1) begin reach<=5'b00001; block_on[30]<=0; end//top
    else if (ball_x_l<=block_x_r[30] && ball_x_l>=block_x_r[30]-3 && ball_y_t<=block_y_b[30] && ball_y_b>=block_y_t[30] && block_on[30]==1) begin reach<=5'b00010; block_on[30]<=0; end//left
    else if (ball_y_b>=block_y_t[30] && ball_y_b<=block_y_t[30]+3 && ball_x_r>=block_x_l[30] && ball_x_l<=block_x_r[30] && block_on[30]==1) begin reach<=5'b00100; block_on[30]<=0; end//bottom    
    else if (ball_x_r>=block_x_l[30] && ball_x_r<=block_x_l[30]+3 && ball_y_t<=block_y_b[30] && ball_y_b>=block_y_t[30] && block_on[30]==1) begin reach<=5'b01000; block_on[30]<=0; end//right
        
    else if(ball_y_t<=3)reach<=5'b00001;//top

    else if (ball_y_b>MAX_Y-3)  reach<=5'b10000;//miss

    else if (ball_x_l<=3) reach<=5'b00010;//left

    else if (ball_x_r>=MAX_X-3) reach<=5'b01000;//right
    
    else if (ball_y_b>=BAR_Y_T && ball_y_b<=BAR_Y_B && ball_x_r>=bar_x_l && ball_x_l<=bar_x_r) reach<=5'b00100;//bar
    
    else reach<=0;
end

assign miss = (reach==5'b10000 && refr_tick==1)? 1 : 0; //bar가 ball을 놓침, miss를 1클럭 pulse로 만들기 위해 refr_tick과 AND 시킴


always @ (posedge clk or posedge rst) begin
    if(rst | game_stop) begin
        ball_vx_reg <= -1*BALL_V; //game이 멈추면 왼쪽으로 
        ball_vy_reg <= -1*BALL_V; //game이 멈추면 아래로
    end else begin
        if (reach==5'b00001) ball_vy_reg <= BALL_V; //위에 부딪히면 아래로.
        else if (reach==5'b00010) ball_vx_reg <= BALL_V; //왼쪽에 부딫혔을 때
        else if (reach==5'b01000) ball_vx_reg <= -1*BALL_V; // 오른쪽에 부딫혔을 때
        else if (reach==5'b00100) ball_vy_reg <= -1*BALL_V; //아래에 부딫혔을 때
    end  
end

/*---------------------------------------------------------*/
// finite state machine for game control
/*---------------------------------------------------------*/
parameter NEWGAME=3'b000, PLAY=3'b001, NEWBALL=3'b010, OVER=3'b011, CLEAR=3'b100; 
reg [2:0] state_reg, state_next;
reg [1:0] life_reg, life_next;

always @ (key, miss, state_reg, life_reg,all_break) begin
    game_stop = 1; 
    life_next = life_reg;
    game_over = 0;
    game_clear=0;
    
    case(state_reg) 
        NEWGAME: begin //새 게임
            if(key==5'h15) begin //버튼이 눌리면
                state_next = PLAY; //게임시작
                life_next = 2'b10; //남은 생명 2개로
            end else begin
                state_next = NEWGAME; //버튼이 안 눌리면 현재 상태 유지
                life_next = 2'b11; //남은 생명 3개 유지
            end
         end
         PLAY: begin
            game_stop = 0; //게임 Running
            if (miss) begin //ball을 놓치면
                if (life_reg==2'b00) //남은 생명이 없으면
                    state_next = OVER; //게임종료
                else begin//남은 생명이 있으면 
                    state_next = NEWBALL; 
                    life_next = life_reg-1'b1; //남은 생명 하나 줄임
                end
            end 
            else if (all_break) begin// 모든 블럭이 깨지면
                state_next=CLEAR;// game이 clear됨
            end
            else
                state_next = PLAY; //ball 놓치지 않으면 계속 진행
        end
        NEWBALL: //새 ball 준비
            if(key==5'h15) state_next = PLAY;
            else state_next = NEWBALL;
        CLEAR: begin
            if(key==5'h15|key==5'h11|key==5'h13) begin //게임이 끝났을 때 버튼을 누르면 새게임 시작
                state_next = NEWGAME;
            end else begin
                state_next = CLEAR;
            end
            game_clear = 1;
        end 
        OVER: begin
            if(key==5'h15|key==5'h11|key==5'h13) begin //게임이 끝났을 때 버튼을 누르면 새게임 시작
                state_next = NEWGAME;
            end else begin
                state_next = OVER;
            end
            game_over = 1;
        end 
        default: 
            state_next = NEWGAME;
    endcase
end

always @ (posedge clk or posedge rst) begin
    if(rst) begin
        state_reg <= NEWGAME; 
        life_reg <= 0;
    end else begin
        state_reg <= state_next; 
        life_reg <= life_next;
    end
end

/*---------------------------------------------------------*/
// text on screen 
/*---------------------------------------------------------*/
// score region
wire [6:0] char_addr;
reg [6:0]  char_addr_l, char_addr_o,char_addr_c;
wire [2:0] bit_addr;
reg [2:0]  bit_addr_c,bit_addr_l, bit_addr_o;
wire [3:0] row_addr,row_addr_c, row_addr_l, row_addr_o; 
wire life_on, over_on, clear_on;

wire font_bit;
wire [7:0] font_word;
wire [10:0] rom_addr;

font_rom_vhd font_rom_inst (clk, rom_addr, font_word);

assign rom_addr = {char_addr, row_addr};
assign font_bit = font_word[~bit_addr]; //화면 x좌표는 왼쪽이 작은데, rom의 bit는 오른쪽이 작으므로 reverse

assign char_addr = (life_on)? char_addr_l : (over_on)? char_addr_o : (clear_on)? char_addr_c :0;
assign row_addr =  (life_on)? row_addr_l : (over_on)? row_addr_o : (clear_on)? row_addr_c :0; 
assign bit_addr = (life_on)? bit_addr_l : (over_on)? bit_addr_o : (clear_on)? bit_addr_c :0; 

//remaining ball
wire [9:0] life_x_l, life_y_t; 
assign life_x_l = 200; 
assign life_y_t = 0; 
assign life_on = (y>=life_y_t && y<life_y_t+16 && x>=life_x_l && x<life_x_l+8*3)? 1 : 0;
assign row_addr_l = y-life_y_t;
always @(*) begin
    if (x>=life_x_l+8*0 && x<life_x_l+8*1) begin bit_addr_l = (x-life_x_l-8*0); char_addr_l = 7'b1000010; end // B x42  
    else if (x>=life_x_l+8*1 && x<life_x_l+8*2) begin bit_addr_l = (x-life_x_l-8*1); char_addr_l = 7'b0111010; end // :
    else if (x>=life_x_l+8*2 && x<life_x_l+8*3) begin bit_addr_l = (x-life_x_l-8*2); char_addr_l = {5'b01100, life_reg}; end
    else begin bit_addr_l = 0; char_addr_l = 0; end   
end

// game over
assign over_on = (game_over==1 && y[9:6]==4 && x[9:5]>=5 && x[9:5]<=13)? 1 : 0; 
assign row_addr_o = y[5:2];
always @(*) begin
    bit_addr_o = x[4:2];
    case (x[9:5]) 
        5: char_addr_o = 7'b1000111; // G x47
        6: char_addr_o = 7'b1100001; // a x61
        7: char_addr_o = 7'b1101101; // m x6d
        8: char_addr_o = 7'b1100101; // e x65
        9: char_addr_o = 7'b0000000; //                      
        10: char_addr_o = 7'b1001111; // O x4f
        11: char_addr_o = 7'b1110110; // v x76
        12: char_addr_o = 7'b1100101; // e x65
        13: char_addr_o = 7'b1110010; // r x72
        default: char_addr_o = 0; 
    endcase
end

// game clear
assign clear_on = (game_clear==1 && y[9:6]==4 && x[9:5]>=5 && x[9:5]<=14)? 1 : 0; 
assign row_addr_c = y[5:2];
always @(*) begin
    bit_addr_c = x[4:2];
    case (x[9:5]) 
        5: char_addr_c = 7'b1000111; // G x47
        6: char_addr_c = 7'b1100001; // a x61
        7: char_addr_c = 7'b1101101; // m x6d
        8: char_addr_c = 7'b1100101; // e x65
        9: char_addr_c = 7'b0000000; //                      
        10: char_addr_c = 7'b01000011; // C x43
        11: char_addr_c = 7'b01101100; // l x6c
        12: char_addr_c = 7'b1100101; // e x65
        13: char_addr_c = 7'b1100001; // a x61
        14: char_addr_c = 7'b1110010; // r x72
        default: char_addr_c = 0; 
    endcase
end

/*---------------------------------------------------------*/
// color setting
/*---------------------------------------------------------*/

    assign rgb = (font_bit&life_on)? 3'b100 : //blue text
                 (font_bit&over_on)? 3'b100 : //blue text(ball_on)? 3'b100 :
                 (font_bit&clear_on)? 3'b100 :
                 (bar_on)? 3'b011 : 
                 (ball_on)? 3'b100 : // red ball
                 (block_col_on[1] && block_on[1])? 3'b101:
                 (block_col_on[2] && block_on[2])? 3'b001:
                 (block_col_on[3] && block_on[3])? 3'b101:
                 (block_col_on[4] && block_on[4])? 3'b001:
                 (block_col_on[5] && block_on[5])? 3'b101:
                 (block_col_on[6] && block_on[6])? 3'b001:
                 (block_col_on[7] && block_on[7])? 3'b101:
                 (block_col_on[8] && block_on[8])? 3'b001:
                 (block_col_on[9] && block_on[9])? 3'b101:
                 (block_col_on[10] && block_on[10])? 3'b001:
                 (block_col_on[11] && block_on[11])? 3'b001:
                 (block_col_on[12] && block_on[12])? 3'b101:
                 (block_col_on[13] && block_on[13])? 3'b001:
                 (block_col_on[14] && block_on[14])? 3'b101:
                 (block_col_on[15] && block_on[15])? 3'b001:
                 (block_col_on[16] && block_on[16])? 3'b101:
                 (block_col_on[17] && block_on[17])? 3'b001:
                 (block_col_on[18] && block_on[18])? 3'b101:
                 (block_col_on[19] && block_on[19])? 3'b001:
                 (block_col_on[20] && block_on[20])? 3'b101: 
                 (block_col_on[21] && block_on[21])? 3'b101:
                 (block_col_on[22] && block_on[22])? 3'b001:
                 (block_col_on[23] && block_on[23])? 3'b101:
                 (block_col_on[24] && block_on[24])? 3'b001:
                 (block_col_on[25] && block_on[25])? 3'b101:
                 (block_col_on[26] && block_on[26])? 3'b001:
                 (block_col_on[27] && block_on[27])? 3'b101:
                 (block_col_on[28] && block_on[28])? 3'b001:
                 (block_col_on[29] && block_on[29])? 3'b101:
                 (block_col_on[30] && block_on[30])? 3'b001: 
                 3'b110; //yellow background

endmodule
