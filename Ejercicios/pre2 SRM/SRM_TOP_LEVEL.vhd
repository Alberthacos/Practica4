-- Top Level Design
-- Sumador, restador y multiplicador
-- con salida a display.
-----------------------------------------------------------------------------------
Library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
----------------------------------------------------------------
-- Declaraci?n de la entidad
entity SRM_top is
Port (
		CLK: in STD_LOGIC; -- reloj de 50MHz para la nexys 2 y 100MHz para nexys 3
		SW: in STD_LOGIC_VECTOR(7 DOWNTO 0); -- A SW[7:4], B SW[3:0]
		selOp: in STD_LOGIC_VECTOR(2 DOWNTO 0); -- selector de operaci?n S R M
		LED: OUT STD_LOGIC_VECTOR(7 DOWNTO 0); -- salida a leds testigos
		DISPLAY: out STD_LOGIC_VECTOR(7 DOWNTO 0); -- segmentos del display
		leds:out std_logic_vector(2 downto 0);														 --"abcdefgP"
		AN: out STD_LOGIC_VECTOR(3 DOWNTO 0)); -- ?nodos del display
end SRM_top;

----------------------------------------------------------------
-- Declaraci?n de la arquitectura
architecture Behavioral of SRM_top is

-- Declaraci?n de se?ales del divisor
signal SAL_400Hz: std_logic; --salidas 2.5ms

-- Declaraci?n de se?ales del resultado
signal resultado: STD_LOGIC_VECTOR(7 DOWNTO 0); -- se?al para leds y resultado

-- Declaraci?n de se?ales de la asignaci?n de U-D-C-UM
signal UNIint,DECint,CENint, signoint: std_logic_vector (3 DOWNTO 0); -- U D C signo

BEGIN
LED <= resultado;

--------------------------------------------------------------------------------------------
-- Declaraci?n del srm con signo
-- U1
		SumResMul: ENTITY WORK.SRM PORT MAP(
				A => SW(7 DOWNTO 4), -- a SW
				B => SW(3 DOWNTO 0), -- a SW
				C => resultado, -- a se?al p/LD y shift_add3 (U2)
				selOp => selOp, -- a BTN
				leds=> leds,
				signo => signoint -- a se?al p/displays (U3)
);
----------------------------------------------------------------

--------------------------------------------------------------------------------------------
-- Declaraci?n del componente que convierte de binario a decimal
-- por la metodolog?a de correr y sumar 3 (shift and add 3)
-- U2
		SHIFT_ADD_3: ENTITY WORK.SHIFT_ADD PORT MAP(
				C => resultado, -- a se?al p/LD y srm (U1)
				UNI => UNIint, -- a se?al p/displays (U3)
				DEC => DECint, -- a se?al p/displays (U3)
				CEN => CENint -- a se?al p/displays (U3)
);
----------------------------------------------------------------

--------------------------------------------------------------------------------------------
-- Declaraci?n del controlador de display
-- U3
		DISP: ENTITY WORK.DISPLAYS PORT MAP(
				UNI => UNIint, -- a se?al p/shift_add (U2)
				DEC => DECint, -- a se?al p/shift_add (U2)
				CEN => CENint, -- a se?al p/shift_add (U2)
				signo => signoint, -- a se?al p/srm (U1)
				SAL_400Hz => SAL_400Hz, -- a se?al p/div_clk (U4)
				DISPLAY => DISPLAY, -- a segmentos del display
				AN => AN -- a ?nodos del display
		);
----------------------------------------------------------------

--------------------------------------------------------------------------------------------
-- Declaraci?n del componente de los divisores (1ms=1kHz, 2.5ms=400Hz)
-- U4
		DIV: ENTITY WORK.DIV_CLK PORT MAP(
				CLK => CLK, -- a reloj 50MHz p/nexys2
				SAL_400Hz => SAL_400Hz -- a se?al p/displays (U4)
		);
----------------------------------------------------------------
end Behavioral; -- fin de la arquitectura TLD

