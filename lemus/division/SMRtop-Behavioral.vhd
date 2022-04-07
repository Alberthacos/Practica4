
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
USE IEEE.NUMERIC_STD.ALL;


-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity DIV_top is
Port(
		clk:in std_logic; --reloj 
		sw: in std_logic_vector (7 downto 0); --asw[9:4],bsw[4:0]
		led:out std_logic_vector (7 downto 0);	--salida a leds testigos
		display: out std_logic_vector(7 downto 0); --segmentos del display "abcdefgP"
--		selOp: in std_logic;
		error: inout std_logic;
--		condicion:inout std_logic;
		an: out std_logic_vector (7 downto 0)); --ánodos del display 
end DIV_top;

--declaración de arquitectura

architecture Behavioral of DIV_top is

--Declaracion de señales del divisor
signal SAL_400Hz:std_logic; --salidas 2.5ms
--Declaracion de señales de resultados 
signal resultado: std_logic_vector(7 downto 0); --señal para leds, resultado
-- Declaración de señales de asignación 
signal UNIint, DECint,CENint,signoint:std_logic_vector(3 downto 0);-- U D C signo

BEGIN

led<=resultado;	

-- Declaracion del srm con signo
-- U1
	Div: entity work.Divisor port map(
	A		=>		sw(7 downto 4), 	-- a SW
	B		=>		sw(3 downto 0), 	-- a SW
	C		=>		resultado,			-- a señal p/LD
	error => 	error,
--	selOp =>		selOp,		
--	condicion => condicion,		-- indicador
	signo	=>		signoint				-- a señal p/displays (U3)
	);
--Declaracion del componente que convierte de binario a decimal
-- por la metodología de correr y sumar 3
-- U2
SHIFT_ADD_3 : entity work.shift_add port map(
--	condicion => condicion,
	C=>resultado,	--a señal p/LD y srm (U1)
	UNI=>UNIint,	--a señal p/displays (U3)
	DEC=>DECint,	--a señal p/displays (U3)
	CEN=>CENint		--a señal p/displays	(U3)
);
--Declaración del controlador de display 
--U3
	DISP: entity work.displays port map(
--	condicion => condicion,
	error   =>    error,
	UNI		=>		UNIint,		--a señal p/shift_add(U2)
	DEC		=>		DECint,		--a señal p/shift_add(U2)
	CEN		=>		CENint,		--a señal p/shift_add(U2)
	signo		=> 	signoint,	--a señal p/sm (U1)
	SAL_400Hz =>	SAL_400Hz,	--a señal p/div_clk(U4)
	DISPLAY	=>		DISPLAY, 	--a segmentos del display
	AN			=>		AN				--a ánodos del display
);

-- Declaración del componente de los divisores (1ms,2.5ms=400Hz)
--	U4
	DIV_reloj:entity work.div_clk port map(
	CLK		=>		CLK,		--a reloj 
	SAL_400Hz	=>	SAL_400Hz
);
end Behavioral; -- fin de la arquitectura
	
