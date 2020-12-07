--circuito antirrebote 
library ieee;
use ieee.std_logic_1164.all;
entity debounce4 is
port(
entrada: in std_logic;--optointerruptor
salida: out std_logic;--salid para el proceso
clk: in std_logic); --reloj
end debounce4;
architecture debounce4 of debounce4 is
signal delay1, delay2, delay3, delay4, delay5: std_logic;--delays utilizados;
signal clr: std_logic:='0';
begin
process (entrada, clk, clr)
begin
if clr='1' then
delay1 <= '0';
--delay2 <= '0';
--delay3 <= '0';
--delay4 <= '0';
--delay5 <= '0';
elsif clk'event and clk='1' then
delay1 <= entrada;
--delay2 <= delay1;
--delay3 <= delay2;
--delay4 <= delay3;
--delay5 <= delay4;
end if;
end process; --fin del proceso
--salida sin rebotes
salida <= delay1;-- and delay2 and delay3 and delay4 and delay5;
end debounce4; --fin de la arquitectura