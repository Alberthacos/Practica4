-----------------------------------------------------------------------------------
-- programa de un sumador, restador y multiplicador de
-- 4 bits con salida a display, con BCD shift and add3
-- estructura de top level design
-----------------------------------------------------------------------------------
Library ieee;
use ieee.std_logic_1164.all;
--use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
USE IEEE.NUMERIC_STD.ALL;
----------------------------------------------------------------
-- Declaración de la entidad
entity SRM is
Port (
error,division: out std_Logic:='0';
numero: in std_logic_vector(3 downto 0);
ledprueba: out std_logic_vector(3 downto 0);
C: OUT STD_LOGIC_VECTOR(7 DOWNTO 0); -- salida a leds testigos
signo: out STD_LOGIC_VECTOR(3 DOWNTO 0)); -- salida para el signo

end SRM;
----------------------------------------------------------------
-- Declaración de la arquitectura
architecture Behavioral of SRM is
type ram_type is array(2 downto 0) of std_logic_vector (3 downto 0);
signal myRam: ram_type;

	signal rst: std_logic;
	signal A,B: std_logic_vector(3 downto 0):="1111";
	signal decimal: std_logic_vector(3 downto 0);
	signal selector_general: std_logic_vector(3 downto 0);
	signal selOp: std_logic_vector(3 downto 0):="1111";

BEGIN
---------------------OPERACIONES------------------------------------
-- en este proceso realiza las operaciones según el selector selOp

PROCESS(A,B,selOp,decimal,selector_general,rst,numero,myRam)
begin

if numero /= x"E" or numero /= x"F" then 
case (numero) is
		when x"0" => decimal <= x"0"; -- 0 decimal  en teclado convertido a binario 
		when x"1" => decimal <= x"1"; -- 1 decimal 
		when x"2" => decimal <= x"2"; -- 2 decimal 
		when x"3" => decimal <= x"3"; -- 3 decimal
		when x"4" => decimal <= x"4"; -- 4 decimal
		when x"5" => decimal <= x"5"; -- 5 decimal
		when x"6" => decimal <= x"6"; -- 6 decimal
		when x"7" => decimal <= x"7"; -- 7 decimal
		when x"8" => decimal <= x"8"; -- 8 decimal
		when x"9" => decimal <= x"9"; -- 9 decimal
		
		when x"A" => selector_general <= "0001"; decimal <= "1111";	-- suma
		when x"B" => selector_general <= "0010"; decimal <= "1111";	-- resta
		when x"C" => selector_general <= "0100"; decimal <= "1111";	-- multiplicacion
		when x"D" => selector_general <= "1000"; decimal <= "1111";	-- Division
		when x"E" => rst <='1';
		when others => decimal <= "1111"; selector_general <= "1111"; rst <='0';
	end case;
end if;

if rst='1' then 
	selOp <="0000"; 
	A<="1111"; B<="1111"; selOp <= "1111";
	myRam(0)<="1111"; myRam(1)<="1111"; myRam(2)<="1111";
	c <="00000000"; signo <= x"E"; decimal<="0000";
	selector_general<="1111"; rst <='0'; division<='0'; error <='0';
else

		if ((numero /= x"A" and numero/=x"B" and numero/=x"C" and numero /=x"D" and numero /=x"E" ) and myRam(0)="1111" and myRam(2)="1111" and myRam(1)="1111" and A="1111" and B="1111" and selOp="1111") then 
		myRam(0)<=decimal; 
		elsif (myRam(0)/="1111" and myRam(1)="1111" and myRam(2)="1111" and (numero = x"A" or numero =x"B" or numero =x"C" or numero =x"D") and numero/=x"E")then 
		myRam(1)<=selector_general; 
		if selector_general = x"D" then division <='1';
		else division <='0'; end if;
		elsif ((numero/= x"A" or numero/=x"B" or numero/=x"C" or numero /=x"D") and myRam(0)/="1111" and myRam(1)/="1111" and myRam(2)="1111" )	then
		myRam(2)<= decimal; 
		end if;

	A 		<= myRam(0);
	selOp	<= myRam(1);
	B		<= myRam(2);
	
case selOp is
	when "0001" => c <= ("0000" & A) + ("0000" & B); signo <= x"E";  error <='0'; division <='0';-- suma
			
	when "0010" => 		error <='0';	division <='0';													-- resta
		if A >= B then c <= ("0000" & A) - ("0000" & B); signo <= x"E"; 
		else c <= ("0000" & B) - ("0000" & A); signo <= x"F"; 
		end if;

	when "0100" => c <= A * B; signo <= x"E"; error <='0'; division <='0';			-- multiplicación

	when "1000" => 	division <='1';
		
		if B ="00000" and A /= "00000" then error <='1'; c <= "00000000"; signo<=x"E";-- x/0
		elsif (A = "00000" and B = "0000") then c<="00000000"; signo<=x"E";  error <='0';-- 0/0 
		else c <= std_logic_vector(to_unsigned((to_integer(unsigned(A))*10)/to_integer(unsigned(B)),8)); signo<=x"E";  
		error <='0';
		end if;

	when others => c <= (others => '0'); signo <= x"E";
end case;


if A="1111" or B="1111" then c <="00000000"; signo <= x"E"; end if;
end if;

end process; --termina el proceso de operaciones
end Behavioral; -- fin de la arquitectura