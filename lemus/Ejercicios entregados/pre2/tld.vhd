-----------------------------------------------------------------------------------
-- Top Level Design
-- Sumador, restador y multiplicador
-- con salida a display.
-----------------------------------------------------------------------------------
Library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
USE IEEE.NUMERIC_STD.ALL;
----------------------------------------------------------------
-- Declaración de la entidad
entity SRM_top is
Port (
COLUMNAS   : in  std_logic_vector(3 downto 0);
FILAS      : out std_logic_vector(3 downto 0);
--rst: in std_logic;
CLK: in STD_LOGIC; -- reloj de 50MHz para la nexys 2 y 100MHz para nexys 3
--SW: in STD_LOGIC_VECTOR(7 DOWNTO 0); -- A SW[7:4], B SW[3:0]
--selOp: in STD_LOGIC_VECTOR(2 DOWNTO 0); -- selector de operación S R M
LED: OUT STD_LOGIC_VECTOR(7 DOWNTO 0); -- salida a leds testigos
--ledprueba:out std_logic_vector(3 downto 0);
DISPLAY: out STD_LOGIC_VECTOR(7 DOWNTO 0); -- segmentos del display "abcdefgP"
AN: out STD_LOGIC_VECTOR(7 DOWNTO 0)); -- ánodos del display

end SRM_top;
---------------------------------------------------------------
-- Declaración de la arquitectura
architecture Behavioral of SRM_top is

-- Declaración de señales del divisor
signal error,division: std_logic;
signal SAL_400Hz: std_logic; --salidas 2.5ms
-- Declaración de señales del resultado
signal resultado: STD_LOGIC_VECTOR(7 DOWNTO 0); -- señal para leds y resultado
signal numero: std_logic_vector (3 downto 0);
-- Declaración de señales de la asignación de U-D-C-UM
signal UNIint,DECint,CENint, signoint: std_logic_vector (3 DOWNTO 0); -- U D C signo
BEGIN
--if division ='1' 
--LED <= resultado/"1010";
--else 
LED <= resultado;
--end if;
--------------------------------------------------------------------------
--Declaracion del receptor de datos con el teclado matricial
--UX
TecladoMatricial: ENTITY work.Teclado PORT MAP(
CLK 	=> clk,
col	=>	columnas,
row	=> filas,

numero => numero
);
--------------------------------------------------------------------------------------------
-- Declaración del srm con signo
-- U1
SumResMul: ENTITY WORK.SRM PORT MAP(
--numeros => numeros,
--reset => reset,
--ledprueba => ledprueba,
--rst	 => rst,
division=>division,
error => error,
numero => numero,
C 		 => resultado, -- a señal p/LD y shift_add3 (U2)
signo	 => signoint -- a señal p/displays (U3)
);
----------------------------------------------------------------
--------------------------------------------------------------------------------------------
-- Declaración del componente que convierte de binario a decimal
-- por la metodología de correr y sumar 3 (shift and add 3)
-- U2
SHIFT_ADD_3: ENTITY WORK.SHIFT_ADD PORT MAP(
C => resultado, -- a señal p/LD y srm (U1)
UNI => UNIint, -- a señal p/displays (U3)
DEC => DECint, -- a señal p/displays (U3)
CEN => CENint -- a señal p/displays (U3)
);
----------------------------------------------------------------
--------------------------------------------------------------------------------------------
-- Declaración del controlador de display
-- U3
DISP: ENTITY WORK.DISPLAYS PORT MAP(
error => error,
division=>division,
UNI => UNIint, -- a señal p/shift_add (U2)
DEC => DECint, -- a señal p/shift_add (U2)
CEN => CENint, -- a señal p/shift_add (U2)
signo => signoint, -- a señal p/srm (U1)
SAL_400Hz => SAL_400Hz, -- a señal p/div_clk (U4)
DISPLAY => DISPLAY, -- a segmentos del display
AN => AN -- a ánodos del display
);
----------------------------------------------------------------
--------------------------------------------------------------------------------------------
-- Declaración del componente de los divisores (1ms=1kHz, 2.5ms=400Hz)
-- U4
DIV: ENTITY WORK.DIV_CLK PORT MAP(
CLK => CLK, -- a reloj 50MHz p/nexys2
SAL_400Hz => SAL_400Hz -- a señal p/displays (U4)
);
----------------------------------------------------------------
end Behavioral; -- fin de la arquitectura TLD