module ram(clk, data,read,address,cs,req,rdy);
parameter data_width=16;
parameter address_width=16;
parameter memory_depth=2**14;
inout  [data_width-1:0] data;
reg [data_width-1:0] data_1;
input[address_width-1:0] address;
input cs,read,req,clk ;

output reg rdy ;
integer state=0;
reg [data_width-1:0] RAM[memory_depth-1:0];


always @ (posedge clk)
    begin
       case(state)
            0: begin
                if(cs)
                    state=1;//end
                    else
                    state=0;
                end
            1:begin
                if(~read)
                state=2;
                     else
                    state=3;
                    end
            2,3: state=0;
        endcase
    end
always@(state)
case(state)
  0:begin
    rdy=1;
    data_1=16'bZ;
  end
  1:begin
    rdy=0;
  end
  2:begin
    RAM[address[13:0]]=data;
  end
  4:begin
  data_1=RAM[address[13:0]];
  end
endcase
    assign data=(cs&read)?data_1:16'bZ;
endmodule
