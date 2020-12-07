Library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
----------------------------------------------------------------
-- Declaración de la entidad
entity SHIFT_ADD is
Port (
cont: in std_logic_vector (13 DOWNTO 0):=(others=>'0'); -- 8 bits
UNI,DEC,CEN,MIL: out std_logic_vector (3 DOWNTO 0) -- digitos unidades,
); -- decenas, centenas Y millares
end SHIFT_ADD;
----------------------------------------------------------------
-- Declaración de la arquitectura
architecture Behavioral of SHIFT_ADD is
-- Declaración de señales de la asignación de U-D-C
signal P: std_logic_vector (15 DOWNTO 0); -- asigna UNI, DEC, CEN y MIL
BEGIN
-----------CONVERTIR DE BIN A BCD------------------
--PROCESO PARA CONVERITR 9999 EN BINARIO (10011100001111) A VECTORES EN UNIDADES, DECENAS, 
--CENTENAS Y MILLARES
PROCESS(cont)
--30 bits para separar las Centenas-Decenas-Unidades
VARIABLE M_C_D_U:STD_LOGIC_VECTOR(29 DOWNTO 0);
BEGIN
--ciclo de inicialización-------------------------------
FOR I IN 0 TO 29 LOOP -- manda ceros a los 30 bits 
M_C_D_U(I):='0'; -- se inicializa con 0
END LOOP;
M_C_D_U(13 DOWNTO 0):=cont(13 downto 0); --14 bits para 9999
--ciclo de asignación M_C-D-U--------------------------
FOR I IN 0 TO 13 LOOP -- hace 14 veces el ciclo shift-add3
	IF M_C_D_U(17 DOWNTO 14) > 4 THEN -- U --
	M_C_D_U(17 DOWNTO 14):= M_C_D_U(17 DOWNTO 14)+3;
	END IF;
	IF M_C_D_U(21 DOWNTO 18) > 4 THEN -- D --
	M_C_D_U(21 DOWNTO 18):= M_C_D_U(21 DOWNTO 18)+3;
	END IF;
	IF M_C_D_U(25 DOWNTO 22) > 4 THEN -- C --
	M_C_D_U(25 DOWNTO 22):= M_C_D_U(25 DOWNTO 22)+3;
	END IF;
	IF M_C_D_U(29 DOWNTO 26) > 4 THEN -- M --
	M_C_D_U(29 DOWNTO 26):= M_C_D_U(29 DOWNTO 26)+3;
	END IF;
	-- shift -- realiza el corrimiento -----------
	M_C_D_U(29 DOWNTO 1):= M_C_D_U(28 DOWNTO 0);
END LOOP;
P<=M_C_D_U(29 DOWNTO 14); -- guarda en P y en seguida se separan M_C-D-U
END PROCESS; -- fin del proceso Display
-- separa M_C-D-U --
-- UNIDADES --
UNI<=P(3 DOWNTO 0);
-- DECENAS --
DEC<=P(7 DOWNTO 4);
-- CENTENAS --
CEN<=P(11 DOWNTO 8);
-- MILLARES --
MIL<=P(15 DOWNTO 12);
------------------------------------------------
end Behavioral; -- fin de la arquitectura