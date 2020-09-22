# lab01 : Unidad de suma, resta, multiplicación, división y visualización BCD
## Introducción


Inicialmente para la realizacion del laboratorio se procede a realizar el diseño del restados tal como se muestra a continuacion: 

<h4> RESTADOR </h4>

Para realizar la implementacion del restador se hizo uso del sumador, pero dado que para este es necesario tener en cuenta el signo, se agrego como salida la variable neg la cual nos indicara si el resultado es negativo o positivo.

Ademas de esto, con el fin de obtener un resultado correcto fue necesario añadir un if, donde en el caso que el sustraendo sea mayor se invertira el orden de la operacion y se le asignara un valor de 1 a la varible neg. Ahora para el caso contrario, donde la resta sea positiva, se mantiene el orden de la operacion y se asigna un valor de 0 a la variable neg; el codigo utilizado para esta labor es el que se muestra a continuacion: 

``` verilog
always @(*) begin 
  if (xi<yi) begin 
    st=yi-xi;
    st[4]=1;
  end 
  else begin 
     st=xi-yi;
     st[4]=0;
  end
end
```

<h4> ALU </h4>

Ahora para la implementacion correcta de la ALU con las tres operaciones que se presentan que son la suma, la resta y la multiplicacion se procedio primeramente a crear cada una de las variables que eran necesarias. Iniciando asi por las dos entradas ```portA``` y ```portB```; luego, una vez se tienen los valores de entrada se procede a definir cual es la operacion que se va a elegir, para ello se crea la variable ```opcode``` de 2 bits, la cual nos permitira escoger entre cada una de las 4 opciones que se presentan; cada una de estas 3 variables mostradas con anterioridad son las de mayor importancia para el funcionamiento de la ALU. Posteriormente, se tienen ademas las variables ```sseg```  y  ```an``` que nos permitiran mostrar nuestras respuestas mediante el display 7 segmentos, el cual a su vez sera controlado por la señal de reloj ```clk```, siendo estas las variables que se definieron para el funcionamiento de la ALU.

``` verilog
module alu(
    input [2:0] portA,
    input [2:0] portB,
    input [1:0] opcode,
    output [0:6] sseg,
    output [4:0] an,
    input clk,
    input rst
 );

``` 

Ya que se han definido las variables procedemos luego a declarar las salidas de cada bloque y sus respectivas señales de incio, esto se hace para posteriormente programar el decodificador, que como observamos con anterioridad es el que nos dira que operacion es la que se va a llevar a cabo en la ALU, para esta labor y dado que se tienen 4 diferentes opciones se hace uso de una case() donde dependiendo de la seleccion que se haga se activara la señal init respectiva. El codigo que se utiliza es el siguiente: 

``` verilog
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

```

Ahora que se ha definido el decodificador y se ha realizado la operacion deseada en el respectivo bloque se pasa a la etapa del multiplexor, donde dependiendo del valor de ```opcode``` elegido con anterioridad se procedera a elegir la respectiva señal de salida la cual ira al display. El codigo para esta seccion es el siguiente: 

``` verilog
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

```
Hasta este punto hemos visto como se definen las variables de entrada y salida, asi mismo como la seleccion de la operacion y la señal para el display; sin embargo hasta este punto no se ha llamado ninguno de los bloques de operaciones que se requerira, por lo que se hace necesario por ultimo instanciar cada uno de los bloques de cada operacion, asociando asi las entradas que tiene cada bloque con las del multiplexor, a continuacion observamos como se realizo la instanciacion de cada una de las operaciones: 


``` verilog
sum4b sum( .init(init_suma),.xi({1'b0,portA}), .yi({1'b0,portB}),.sal(sal_suma));
restador res( .init(init_resta), .xi(portA), .yi(portB), .neg(sal_resta[4]), .sal(sal_resta[3:0]));
multiplicador mul ( .MR(portA), .MD(portB), .init(init_mult),.clk(clk), .pp(sal_mult));
BCDtoSSeg dp( .BCD(int_bcd), .SSeg(sseg));

```

