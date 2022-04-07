----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    07:42:07 03/30/2022 
-- Design Name: 
-- Module Name:    SHIFT_ADD - Behavioral 
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
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity SHIFT_ADD is
port(
--		condicion: in std_logic;
		C: in std_logic_vector(7 downto 0):= (others=>'0'); --8bits
		UNI,DEC,CEN: out std_logic_vector(3 downto 0)	--digitos unidades
		); 															--decenas y centenas
end SHIFT_ADD;
--Declaración de la arquitectura
architecture Behavioral of SHIFT_ADD is
--Declaración de señales de asignación U-D-C
signal P: std_logic_vector (11 downto 0);
begin
-- convertir de bin a bcd
-- este proceso contiene un algoritmo recorre y suma 3 para 
--convertir un número binario abcde, que se manda a los displays.
-- El algortimo consiste en desplazar (shift) el vector inicial (en binario)
-- le níumero de veces según sea el número de bits
-- y cuando alguno de los bloques de 5 bits (U-D-C-UM, que es el número de bits 
--para que cuente de 0 a 9 por cifra) sea igual o mayor a 5 se le debe sumar 3 a 
-- ese bloque, después se continua desplazando hasta que otro (o el mismo) bloque cumpla con esa condicionn
-- y se le sumen 3. Inicialmente se rota 3 veces porque es el numero mínimo de bits
-- que debe yener para que sea igual o mayor a 5.
-- Finalmente se asigna a otro vector, el vectir ya convertido que cuenta con 3 bloques 
-- para las 3 cifras de 5 bits cada una. 
Process(C)	
--20 bits para separar las centenas-decenas-unidades
	variable C_D_U:std_logic_vector(19 downto 0);
	
	BEGIN
	--ciclo de inicialización 
		for I in 0 to 19 LOOP --manda ceros a los 18 bits + 2
			C_D_U(I):='0';		--se inicializa con cero
		END LOOP;
	C_D_U (7 downto 0):=C(7 downto 0); --c del divisor de 10 bits
	--ciclo de asignación C-D_U
	for I in 0 to 7 loop -- hace 10 veces el ciclo shift-add3
		if C_D_U(11 downto 8)>4 then --u--
		C_D_U (11 downto 8):= C_D_U(11 downto 8)+3;
		END IF;
	
		if C_D_U(15 downto 12)> 4 then --c--
		C_D_U (15 downto 12):= C_D_U(15 downto 12)+3;
		END IF;
	
		if C_D_U (19 downto 16) > 4 then --u--
		C_D_U (19 downto 16):= C_D_U(19 downto 16)+3;
		END IF;
	--shift--realiza el corrimiento--
	C_D_U(19 downto 1):=C_D_U(18 downto 0);
	END LOOP;

	P <= C_D_U(19 downto 8); --guarda en P y en seguida se separan C-D-U
	
	end Process; -- fin del proceso display
	
--process(condicion,P)
--	begin
--	if condicion = '0' then 
	--separa C_D_U
		UNI<=P(3 downto 0);	--unidades
		DEC<=P(7 downto 4);  --decenas
		CEN<=P(11 downto 8);	--centenas
		
--	else --cambiar orden de unidades y decenas
--		UNI<=P(7 downto 4);	--unidades
--	
--		DEC<=P(3 downto 0); --decenas
--	--	7 downto 4
--		CEN<=P(11 downto 8); --centenas
--	end if;
--end process;
	
	end Behavioral;--fin de la arquitectura



