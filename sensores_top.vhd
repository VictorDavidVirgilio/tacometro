-- prueba de sensores
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity sensores_top is
port(
CLK: in std_logic;--reloj 8 MHz de coolrunner 
vel: in std_logic;--entradas de sensores
AN : out std_logic_vector(3 downto 0);--anodos
display: out std_logic_vector(7 downto 0));--display de coolruner
end sensores_top;
 
architecture behavioral of sensores_top is 
--señales usadas en TOP
signal sal_1000hz: std_logic;--reloj para  display y contador de cilcos por segundo
--signal sal_1hz: std_logic;--reloj para suma rpm
signal sal: std_logic;--salida del debouncer
signal cnt: std_logic_vector(13 downto 0);-- contador interno de ciclos por segundo
signal UNIint, DECint, CENint, MILint:std_logic_vector(3 downto 0);
begin
--------------------MULTIPLEXOR---------------------
--U1 debouncer para optointerruptor
anti: entity work.debounce4 port map(
entrada => vel, -- entrada de optointerruptor
salida => sal,  -- salida p/contador(U2)
clk=> sal_1000hz -- reloj de divisor (U4)
);

--U2 comprobación de sensores
contador: entity work.sen port map(
int => sal,    --entrada del sensor despues de l debouncer
cont => cnt, --contador de ciclos
reloj => sal_1000hz
);

--U3 shift add 3
shift_add_3: entity work.shift_add port map(
cont => cnt, -- 
UNI => UNIint, -- a señal p/displays (U3)
DEC => DECint, -- a señal p/displays (U3)
CEN => CENint, -- a señal p/displays (U3)
MIL => MILint -- a señal p/displays (U3));
--U4 display de coolrunner
disp: entity work.displays port map (
UNI => UNIint, -- a señal p/shift_add (U2)
DEC => DECint, -- a señal p/shift_add (U2)
CEN => CENint, -- a señal p/displays (U3)
MIL => MILint, -- a señal p/displays (U3)
SAL_1000Hz =>sal_1000hz, -- reloj de 1000Hz
DISPLAY=>display, -- seg dsply "abcdefgP"
AN=>AN --anodos
);
-- U5 Declaración del componente del divisor 
div: entity work.div_clk port map(
CLK => CLK, -- a reloj 8MHz coolrunner2
SAL_1000Hz => SAL_1000Hz -- a señal p/displays (U4)
--sal_m => sal_m
);
end behavioral;  
