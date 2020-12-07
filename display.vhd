Library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
----------------------------------------------------------------
-- Declaración de la entidad
entity DISPLAYS is
Port (
UNI,DEC,CEN,MIL: in std_logic_vector (3 DOWNTO 0); -- dígitos unidades, decenas,
-- centenas y signo
SAL_1000Hz: in STD_LOGIC; -- reloj de 1000Hz
DISPLAY: out STD_LOGIC_VECTOR(7 DOWNTO 0); -- seg dsply "abcdefgP"
AN: out STD_LOGIC_VECTOR(3 DOWNTO 0)); -- ánodos del display
end DISPLAYS;
----------------------------------------------------------------
-- Declaración de la arquitectura
architecture Behavioral of DISPLAYS is
-- Declaración de señales de la multiplexación y asignación de U-D-C al disp
signal SEL: std_logic_vector (1 downto 0):="00"; -- selector de barrido
signal D: std_logic_vector (3 downto 0); -- almacena los valores del disp
BEGIN
--------------------MULTIPLEXOR---------------------
PROCESS(SAL_1000Hz, SEL, UNI, DEC, CEN, MIL)
BEGIN
IF SAL_1000Hz'EVENT and SAL_1000Hz='1' THEN SEL <= SEL + '1';
	CASE(SEL) IS
	when "00" => AN <="0111"; D <= MIL; -- Millares
	when "01" => AN <="1011"; D <= CEN; -- Centenas
	when "10" => AN <="1101"; D <= DEC; -- Decenas
	when "11" => AN <="1110"; D <= UNI; -- Unidades
	when OTHERS=>AN <="1111"; D <= "0000"; -- NULL
	END CASE;
end if;
END PROCESS; -- fin del proceso Multiplexor
--------------------DISPLAY---------------------
PROCESS(D)
Begin
case(D) is -- abcdefgP
WHEN x"0" => DISPLAY <= "00000011"; --0
WHEN x"1" => DISPLAY <= "10011111"; --1
WHEN x"2" => DISPLAY <= "00100101"; --2
WHEN x"3" => DISPLAY <= "00001101"; --3
WHEN x"4" => DISPLAY <= "10011001"; --4
WHEN x"5" => DISPLAY <= "01001001"; --5
WHEN x"6" => DISPLAY <= "01000001"; --6
WHEN x"7" => DISPLAY <= "00011111"; --7
WHEN x"8" => DISPLAY <= "00000001"; --8
WHEN x"9" => DISPLAY <= "00001001"; --9
WHEN x"F" => DISPLAY <= "11111101"; --signo
WHEN OTHERS => DISPLAY <= "11111111"; --apagado
END CASE;
END PROCESS; -- fin del proceso Display
------------------------------------------------
end Behavioral; -- fin de la arquitectura