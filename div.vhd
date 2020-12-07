--divisor de tensión
Library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
----------------------------------------------------------------
-- Declaración de la entidad
entity DIV_CLK is
Port (
CLK: in STD_LOGIC; -- reloj de 8MHz para la coolrunner
SAL_1000Hz: inout STD_LOGIC); --salida 1ms,
end DIV_CLK;
----------------------------------------------------------------
-- Declaración de la arquitectura
architecture Behavioral of DIV_CLK is
-- Declaración de señales de los divisores
signal conta_500us: integer range 1 to 8_000:=1;--señal para el divisor de frecuencia
BEGIN
-----------------DIVISOR 2.5ms=400Hz----------------
-------------------DIVISOR ÁNODOS-------------------
process (CLK) begin--proceso Divisor ffrecuencia
if rising_edge(CLK) then
	if (conta_500us = 8_000) then --cuenta 1250us (50MHz=62500)
	SAL_1000Hz <= NOT(SAL_1000Hz); --genera un barrido de 2.5ms
	conta_500us <= 1;
	else
	conta_500us <= conta_500us + 1;
	end if;
end if;
end process;

------------------------------------------------
end Behavioral; -- fin de la arquitectura