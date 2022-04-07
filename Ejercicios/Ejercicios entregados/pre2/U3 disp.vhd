--------------------------------------------------------------------------------------
-- Controlador del display de 4 digitos
--------------------------------------------------------------------------------------
Library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
----------------------------------------------------------------
-- Declaración de la entidad
entity DISPLAYS is
Port (
error,division: in std_logic;
UNI,DEC,CEN,signo: in std_logic_vector (3 DOWNTO 0); -- dígitos unidades, decenas,
-- centenas y signo
SAL_400Hz: in STD_LOGIC; -- reloj de 400Hz
DISPLAY: out STD_LOGIC_VECTOR(7 DOWNTO 0); -- seg dsply "abcdefgP"
AN: out STD_LOGIC_VECTOR(7 DOWNTO 0)); -- ánodos del display
end DISPLAYS;
----------------------------------------------------------------
-- Declaración de la arquitectura
architecture Behavioral of DISPLAYS is
-- Declaración de señales de la multiplexación y asignación de U-D-C al disp
signal SEL: std_logic_vector (1 downto 0):="00"; -- selector de barrido
signal punto:std_logic;
signal D,DD: std_logic_vector (3 downto 0); -- almacena los valores del disp
BEGIN
--------------------MULTIPLEXOR---------------------
PROCESS(SAL_400Hz, sel, UNI, DEC,CEN,division)
BEGIN
IF SAL_400Hz'EVENT and SAL_400Hz='1' THEN SEL <= SEL + '1';
	if division = '0' and error ='0' then 			--condiciones normales
		CASE(SEL) IS
		when "00" => AN <="11101111"; D <= UNI;  	punto <='0';-- UNIDADES
		when "01" => AN <="11011111"; D <= DEC; 	punto <='0'; -- DECENAS
		when "10" => AN <="10111111"; D <= CEN;   punto <='0';-- CENTENAS
		when "11" => AN <="01111111"; D <= SIGNO; punto <='0';-- signo
		when OTHERS=>AN <="11111111"; D <= SIGNO; punto <='0'; -- signo
		END CASE;
	elsif error ='1' then AN <="11101111"; 		-- error algo entre cero
		
	elsif division ='1' then 														--DIVISION
		CASE(SEL) IS
		when "00" => AN <="11101111"; D <= UNI; 	punto <='0';  -- UNIDADES
		when "01" => AN <="11011111"; D <= DEC; 	punto <='1'; -- DECENAS
		when "10" => AN <="10111111"; D <= CEN; 	punto <='0';-- CENTENAS
		when "11" => AN <="01111111"; D <= SIGNO; punto <='0';-- signo
		when OTHERS=>AN <="11111111"; D <= SIGNO; punto <='0';-- signo
		END CASE;

	end if;
end if;

END PROCESS; -- fin del proceso Multiplexor
--------------------DISPLAY---------------------
PROCESS(D,error,DD)
Begin

if division = '0' and error ='0' then --condiciones normales
	case(D) is 				-- abcdefgP
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
	
elsif error ='1' and division ='1' then  DISPLAY <= "01100001";-- AN <="11101111"; --error algo entre 0

elsif division ='1' and error ='0' then			--DIVISION
if punto ='0' then
case(D) is 				-- abcdefgP
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
else 
	case(D) is 				-- abcdefgP
	WHEN x"0" => DISPLAY <= "00000010"; --0
	WHEN x"1" => DISPLAY <= "10011110"; --1
	WHEN x"2" => DISPLAY <= "00100100"; --2
	WHEN x"3" => DISPLAY <= "00001100"; --3
	WHEN x"4" => DISPLAY <= "10011000"; --4
	WHEN x"5" => DISPLAY <= "01001000"; --5
	WHEN x"6" => DISPLAY <= "01000000"; --6
	WHEN x"7" => DISPLAY <= "00011110"; --7
	WHEN x"8" => DISPLAY <= "00000000"; --8
	WHEN x"9" => DISPLAY <= "00001000"; --9
	WHEN x"F" => DISPLAY <= "11111100"; --signo
	WHEN OTHERS => DISPLAY <= "11111111"; --apagado
	END CASE;
end if;
end if;

END PROCESS; -- fin del proceso Display
------------------------------------------------
end Behavioral; -- fin de la arquitectura