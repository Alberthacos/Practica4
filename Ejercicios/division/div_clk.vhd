----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:07:20 03/30/2022 
-- Design Name: 
-- Module Name:    div_clk - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
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

entity div_clk is
Port (

CLK: in STD_LOGIC; -- reloj de 50MHz para la nexys 2 y 100MHz para nexys 3
SAL_400Hz: inout STD_LOGIC); --salida 2.5ms,

end div_clk;

architecture Behavioral of div_clk is
-- Declaración de señales de los divisores
signal conta_1250us: integer range 1 to 62_500:=1; -- pulso1 de 1250us@400Hz (0.25ms)
BEGIN
-----------------DIVISOR 2.5ms=400Hz----------------
-------------------DIVISOR ÁNODOS-------------------
process (CLK) begin

if rising_edge(CLK) then
if (conta_1250us = 62_500) then --cuenta 1250us (50MHz=62500)
-- if (conta_1250us = 125000) then --cuenta 1250us (100MHz=125000)
SAL_400Hz <= NOT(SAL_400Hz); --genera un barrido de 2.5ms
conta_1250us <= 1;
else
conta_1250us <= conta_1250us + 1;
end if;
end if;
end process; -- fin del proceso Divisor Ánodos



end Behavioral;

