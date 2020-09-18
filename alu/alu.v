`timescale 1ns / 1ps


module alu(
    input [2:0] portA,
    input [2:0] portB,
    input [1:0] opcode,
    output [0:6] sseg,
    output [4:0] an,
    input clk,
    input rst
 );

// Declaración de salidas de cada bloque 
wire [4:0] sal_suma;
wire [4:0] sal_resta;
wire [4:0] sal_div;
wire [4:0] sal_mult;


// Declaración de las entradas init de cada bloque 
reg [3:0] init; 
wire init_suma;
wire init_resta;
wire init_mult;
wire init_div;

// 

assign init_suma= init[0];
assign init_resta=init[1];
assign init_mult=init[2];
assign init_div=init[3];

reg [15:0]int_bcd;

wire [3:0] operacion;

// descripción del decodificacion de operaciones
always @(*) begin
	case(opcode) 
		2'b00: init<=1;
		2'b01: init<=2;
		2'b10: init<=4;
		2'b11: init<=8;
	default:
		init <= 0;
	endcase
	
end
// Descripcion del miltiplexor
always @(*) begin
	case(opcode) 
		2'b00: int_bcd <={8'b00,sal_suma};
		2'b01: int_bcd <={8'b00,sal_resta};
		2'b10: int_bcd <={8'b00,sal_mult};
		2'b11: int_bcd <={8'b00,sal_div};
	default:
		int_bcd <= 0;
	endcase
	
end

assign an = int_bcd;
//instanciación de los componnetes 

sum4b sum( .init(init_suma),.xi({1'b0,portA}), .yi({1'b0,portB}),.sal(sal_suma));
restador res( .init(init_resta), .xi(portA), .yi(portB), .neg(sal_resta[4]), .sal(sal_resta[3:0]));
multiplicador mul ( .MR(portA), .MD(portB), .init(init_mult),.clk(clk), .pp(sal_mult));
BCDtoSSeg dp( .BCD(int_bcd), .SSeg(sseg));

// adicone los dos bloques que hacen flata la resta y división





endmodule
