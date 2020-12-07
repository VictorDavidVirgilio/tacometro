# tacometro
tacometro casero utilizando un sensor de velocidad y un CoolRunner-II programado en VHDL

Se ocupa Top-level Design para facilitar la interacción entre las funciones del programa

El archivo top muestra las distintas entidades y la configuración general de salidas y entradas
antirebote es el archivo que genera un delay para evitar que el sensor tome datos inecesarios
sens contiene el contador principal para medir los cilslos por segundo
shiftadd3 contiene el convertidor del número binario en BCD para unidades, decenas centenas y millares.
display se utiliza para configurar el display de cuatro dígitos de siete segmentos
div es el divisor de frecuencia para generar el pulso de reloj de 1kHz que se utiliza en antirrebote , sens y display
El archivo mastercr2 indica entradas y salidas utilizadas en la CPLD
