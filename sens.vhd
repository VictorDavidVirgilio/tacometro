--contador de ciclpspor segundo
Library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
----------------------------------------------------------------
-- Declaración de la entidad
entity sen is
Port (
int: in std_logic;--entradas de sensor despues de debouncer
reloj: in std_logic;
cont: out std_logic_vector(13 downto 0)); --salida del contador
end sen;

architecture Behavioral of sen is
signal cnt_tmp: STD_LOGIC_VECTOR(13 DOWNTO 0) := "00000000000000";--señal temporal para realizar la operación del contador
signal cnt_s:std_logic_vector(9 downto 0) := "0000000000"; --señal para el contador de un segundo
signal cnt_final: STD_LOGIC_VECTOR(13 DOWNTO 0) := "00000000000000";--señal para el contador que va a ser presentado en el display
--signal seg: STD_LOGIC_VECTOR(6 DOWNTO 0) := "0000000";--señal para display.
--signal s: std_logic_vector(1 downto 0);--vectore de sensores
begin
process(int)
begin
-- sensor de velocidad	
	if rising_edge(int) then
	cnt_tmp <= cnt_tmp + 1;
		if cnt_tmp ="10011100001111" then cnt_tmp<="00000000000000";--cuando llega a 10 vuelve a 0
		end if;
	else
	cnt_tmp <= cnt_tmp;
	end if;
	if rising_edge(reloj) then
	cnt_s <= cnt_s + 1;
		if cnt_s = "1111100111" then --""
		cnt_s <= "0000000000";--cuando llega a 10 vuelve a 0
		cnt_final <= cnt_tmp;
		end if;
	else
	cnt_s <= cnt_s;
   cnt_final <= cnt_final;
	end if;
	if cnt_s ="0000000000" then cnt_tmp<="00000000000000";
	end if;
end process;
cont<=cnt_final;
end Behavioral;