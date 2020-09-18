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


