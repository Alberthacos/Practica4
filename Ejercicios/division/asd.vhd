---
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
--use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity Divisor is
Port(
	A,B: in std_logic_vector (3 downto 0); --entradas con interruptores
	C: out std_logic_vector (7 downto 0);	--salida a leds testigos
--	condicion: out std_logic;
--	selOp: in std_logic;
	error: out std_logic;
	signo: out std_logic_vector(3 downto 0));-- salida para el signo
	
end Divisor;

architecture Behavioral of Divisor is
--signal Error:std_logic;
BEGIN
-- Operaciones
-- En este proceso se realiza la division
Process(A,B)
begin
if selOp ="1000" then 
	if B ="00000" and A /= "00000" then error <='1'; c <= "00000000"; -- 0 entre algo
	elsif (A = "00000" and B = "0000") then c<="00000000"; 				--0 entre 0
	signo<=x"E"; error <= '0'; signo<=x"E"; --condicion <= '0'; 

	else c <= std_logic_vector(to_unsigned(to_integer(unsigned(A*(x"A")))/to_integer(unsigned(B)),8)); signo<=x"E";
	error <= '0';--condicion <= '1';		--condiciones normales, A mayor que B
	end if;
end if;
end process;
	
end Behavioral;
