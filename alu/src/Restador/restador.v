`timescale 1ns / 1ps

module restador(init, xi, yi,sal);

  input init;
  input [3 :0] xi;
  input [3 :0] yi;
  output [3 :0] sal;
  
  
  wire [3:0] st;
  wire [3:0] ci;
  
  assign ci = ~yi;
  assign sal= st[3:0];
  
  assign st  = 	xi+ci+1;

endmodule
