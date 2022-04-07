-----------------------------------------------------------------------------------
-- programa que realiza la operaci�n l�gica bit a bit entre 2entradas de
-- 4 bits con salida a display y leds
-----------------------------------------------------------------------------------
Library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
----------------------------------------------------------------
-- Declaraci�n de la entidad
entity LOGICO is
Port (
A,B: in STD_LOGIC_VECTOR(3 DOWNTO 0); -- entradas con interruptores
C: OUT STD_LOGIC_VECTOR(3 DOWNTO 0); -- salida a leds testigos
selOp: in STD_LOGIC_VECTOR(3 DOWNTO 0)); -- a botones
end LOGICO;
----------------------------------------------------------------
-- Declaraci�n de la arquitectura
architecture Behavioral of LOGICO is
BEGIN
---------------------OPERACIONES------------------------------------
-- en este proceso realiza las operaciones seg�n el selector selOp

PROCESS(A,B,selOp)
begin
case selOp is -- funci�n l�gica
when "0001" => c <= A AND B; -- AND
when "0010" => c <= A OR B; -- OR
when "0100" => c <= A XOR B; -- XOR
when "1000" => c <= NOT A; -- NOT
when others => c <= (others => '0');
end case;
end process; --termina el proceso de operaciones
end Behavioral; -- fin de la arquitectura
------------------------------------------------