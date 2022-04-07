-----------------------------------------------------------------------------------
-- programa que realiza la operación lógica bit a bit entre 2entradas de
-- 4 bits con salida a display y leds
-----------------------------------------------------------------------------------
Library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
----------------------------------------------------------------
-- Declaración de la entidad
entity LOGICO is
Port (
A,B: in STD_LOGIC_VECTOR(3 DOWNTO 0); -- entradas con interruptores
C: OUT STD_LOGIC_VECTOR(3 DOWNTO 0); -- salida a leds testigos
selOp: in STD_LOGIC_VECTOR(2 DOWNTO 0)); -- a botones
end LOGICO;
----------------------------------------------------------------
-- Declaración de la arquitectura
architecture Behavioral of LOGICO is
BEGIN
---------------------OPERACIONES------------------------------------
-- en este proceso realiza las operaciones según el selector selOp

PROCESS(A,B,selOp)
begin
case selOp is -- función lógica
    when "000" => c <= A AND B; -- AND
    when "001" => c <= A OR B; -- OR
    when "010" => c <= A XOR B; -- XOR
    when "011" => c <= NOT A; -- NOT A
    when "100" => c <= B; -- BUFFER B
    when "101" => c <= A NAND B; -- A NAND B
    when "110" => c <= A NOR B; -- A NOR B
    when "111" => c <= A XNOR B; -- A XNOR B
    when others => c <= (others => '0');
end case;
end process; --termina el proceso de operaciones
end Behavioral; -- fin de la arquitectura
------------------------------------------------