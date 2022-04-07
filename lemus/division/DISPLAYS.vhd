
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity DISPLAYS is
Port(
		error: in std_logic;
--		condicion: in std_logic;
		UNI,DEC,CEN,signo:in std_logic_vector(3 downto 0); --dígitos unidades,decenas, centenas y signo
		SAL_400Hz:in std_logic;--reloj de 400Hz
		DISPLAY:out std_logic_vector(7 downto 0);--seg display "abcdefgP"
		AN: out std_logic_vector(3 downto 0));--ánodos del display
	
end DISPLAYS;
--Declaración de la arquitectura
architecture Behavioral of DISPLAYS is
--Declaración de señales de multiplexación y asignación de U-D-C al disp
signal SEL: std_logic_vector(1 downto 0):="00";--selector de barrido
signal D: std_logic_vector(3 downto 0); --almacena los valores del disp

BEGIN

Process(SAL_400Hz,SEL,UNI,DEC,CEN,error)
begin
--if condicion = '0' then 
	if rising_edge(SAL_400Hz) then SEL<=Sel+'1';
		CASE(SEL) IS
		when "00" => AN <="11101111"; D <= UNI; -- UNIDADES
		when "01" => AN <="11011111"; D <= DEC; -- DECENAS
		when "10" => AN <="10111111"; D <= CEN; -- CENTENAS
		when "11" => AN <="01111111"; D <= SIGNO; -- signo
		when OTHERS=>AN <="11111111"; D <= SIGNO; -- signo
		END CASE;
	end if;
--else 
--	if rising_edge(SAL_400Hz) then SEL<=Sel+'1';
--		CASE(SEL) IS
--		when "00" => AN <="11111110"; D <= UNI; -- UNIDADES
--		when "01" => AN <="11101111"; D <= DEC; -- DECENAS
--		when "10" => AN <="11011111"; D <= CEN; -- CENTENAS
--		when "11" => AN <="10111111"; D <= SIGNO; -- signo
--		when OTHERS=>AN <="11111111"; D <= SIGNO; -- signo
--		END CASE;
--	end if;
--end if;

END PROCESS; --fin del proceso Multiplexor
	
--Display
Process(D,error) 
Begin
if error = '0' then  
		case(D) is 				  --abcdefgP
		when x"0" => DISPLAY <= "00000011"; --0
		WHEN x"1" => DISPLAY <= "10011111"; --1
		WHEN x"2" => DISPLAY <= "00100101"; --2
		WHEN x"3" => DISPLAY <= "00001101"; --3
		WHEN x"4" => DISPLAY <= "10011001"; --4
		WHEN x"5" => DISPLAY <= "01001001"; --5
		WHEN x"6" => DISPLAY <= "01000001"; --6
		WHEN x"7" => DISPLAY <= "00011111"; --7
		WHEN x"8" => DISPLAY <= "00000001"; --8
		WHEN x"9" => DISPLAY <= "00001001"; --9
		WHEN x"A" => DISPLAY <= "01100001";	--E
		WHEN x"F" => DISPLAY <= "11111101"; --signo 
		WHEN OTHERS => DISPLAY <= "11111111"; --apagado
		END CASE;
else DISPLAY <= "01100001"; --AN <="11101111";
end if;
end process;

end Behavioral;

