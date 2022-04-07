-- programa de un sumador, restador y multiplicador de
-- 4 bits con salida a display, con BCD shift and add3
-- estructura de top level design
-----------------------------------------------------------------------------------
Library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
----------------------------------------------------------------
-- Declaración de la entidad
entity SRM is
Port (
		A,B: in STD_LOGIC_VECTOR(3 DOWNTO 0); -- entradas con interruptores
		C: OUT STD_LOGIC_VECTOR(7 DOWNTO 0); -- salida a leds testigos
		leds:out std_logic_vector (2 downto 0);
		signo: out STD_LOGIC_VECTOR(3 DOWNTO 0); -- salida para el signo
		selOp: in STD_LOGIC_VECTOR(2 DOWNTO 0)); -- a botones
end SRM;

----------------------------------------------------------------
-- Declaración de la arquitectura

architecture Behavioral of SRM is

BEGIN
---------------------OPERACIONES------------------------------------
-- en este proceso realiza las operaciones según el selector selOp

PROCESS(A,B,selOp)
begin
		case selOp is
		when "001" => c <= ("0000" & A) + ("0000" & B); signo <= x"E"; leds<="100"; -- suma
		
		when "010" => -- resta
		if A >= B then c <= ("0000" & A) - ("0000" & B); signo <= x"E"; leds<="010";
		else c <= ("0000" & B) - ("0000" & A); signo <= x"F"; leds<="010";
		end if;

		when "100" => c <= A * B; signo <= x"E"; leds<="001";-- multiplicación
		
		when others => c <= (others => '0'); signo <= x"E"; leds<="000";
		end case;
		
end process; --termina el proceso de operaciones

end Behavioral; -- fin de la arquitectura