library IEEE;

use IEEE.STD_LOGIC_1164.ALL;

use IEEE.STD_LOGIC_ARITH.ALL;

use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity Teclado is port(
clk : in std_logic;
col : in std_logic_vector(3 downto 0);
row : out std_logic_vector(3 downto 0);
numero 	: out std_logic_vector(3 downto 0)
);
end Teclado;


architecture Behavioral of Teclado is 
signal rst : std_logic:='0';
signal temp : std_logic_vector(29 downto 0);
signal salida: std_logic_vector(3 downto 0);

begin data_in: process(clk,rst,salida) is begin 

if rst = '1' then numero <= "0000"; 

elsif rising_edge(clk) then temp <= temp + 1;

  case temp(10 downto 8) is when "000" => row <= "0111";

	when "001" => 
		if col = "1110" then numero <= x"A"; -- First Row A BIEN
		
		 elsif col = "0111" then numero <= x"1";	-- 1 BIEN
		 
		 elsif col = "1011" then numero <= x"2";	-- 2 BIEN

		 elsif col = "1101" then numero <= X"3";	-- 3 BIEN
							
		end if; 
	when "010" => row <= "1011";		

	when "011" => 
		if col = "1110" then numero<= x"B"; --second row --B BIEN

		 elsif col = "0111" then numero <= x"4";	-- 4 BIEN
		 
		 elsif col = "1011" then numero <= x"5";	-- 5 BIEN
		 
		 elsif col = "1101" then numero <= x"6";	-- 6 BIEN

		end if; 
	when "100" => row <= "1101";	

	when "101" => 
		if col = "1110" then numero <= x"C"; --Third row C BIEN 

		 elsif col = "0111" then numero <= x"7";	-- 7 BIEN
		 
		 elsif col = "1011" then numero <= x"8";	-- 8 BIEN
		 
		 elsif col= "1101" then numero <= x"9";	-- 9 BIEN

		end if; 
	when "110" => row <= "1110";			
	 
	when "111" =>
		if col = "1110" then numero <= x"D";	--fourth row -- D BIEN

		 elsif col = "1101" then numero <= x"F";	-- # BIEN asterisco

		 elsif col = "1011" then numero <= x"0";	-- 0 BIEN
		 
		 elsif col = "0111" then numero <= x"E"; salida<=x"E";-- * BIEN X"E"
		end if; 
	when others => numero <= x"0";	
  end case;
end if;

if salida = x"E" then rst <= '1'; numero <=x"0"; 
else salida <=x"0"; rst<='0';
end if;

end process;

end Behavioral;