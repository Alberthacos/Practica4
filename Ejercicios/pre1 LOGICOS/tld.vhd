-----------------------------------------------------------------------------------
-- Top Level Design
-- Lógico AND OR XOR NOT
-- con salida a display.
-----------------------------------------------------------------------------------
Library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
----------------------------------------------------------------
-- Declaración de la entidad
entity logico_top is
Port (
CLK: in STD_LOGIC; -- reloj de 50MHz para la nexys 2 y 100MHz para nexys 3
SW: in STD_LOGIC_VECTOR(7 DOWNTO 0); -- A SW[7:4], B SW[3:0]
selOp: in STD_LOGIC_VECTOR(3 DOWNTO 0); -- selector de operación lógica
LED: OUT STD_LOGIC_VECTOR(3 DOWNTO 0); -- salida a leds testigos
DISPLAY: out STD_LOGIC_VECTOR(7 DOWNTO 0); -- segmentos del display "abcdefgP"
AN: out STD_LOGIC_VECTOR(3 DOWNTO 0)); -- ánodos del display
end logico_top;
----------------------------------------------------------------
-- Declaración de la arquitectura
architecture Behavioral of logico_top is
-- Declaración de señales del divisor
signal SAL_400Hz: std_logic; --salidas 2.5ms
-- Declaración del selector
signal selOpint: std_logic_vector (3 DOWNTO 0); -- op lógica
BEGIN
selOpint <= selOp;
--------------------------------------------------------------------------------------------
-- Declaración del cto lógico -- U1
U1: ENTITY WORK.logico PORT MAP(
A => SW(7 DOWNTO 4), -- a SW
B => SW(3 DOWNTO 0), -- a SW
C => LED, -- a señal LD
selOp => selOpint -- a señal selOp (U3) y BTN
);
----------------------------------------------------------------
--------------------------------------------------------------------------------------------
-- Declaración del componente del divisor (2.5ms=400Hz) -- U2
U2: ENTITY WORK.DIV_CLK PORT MAP(
CLK => CLK, -- a reloj 50MHz p/nexys2
SAL_400Hz => SAL_400Hz -- a señal p/displays (U4)
);
----------------------------------------------------------------
--------------------------------------------------------------------------------------------
-- Declaración del controlador de display -- U3
U3: ENTITY WORK.DISPLAYS PORT MAP(
selOp => selOpint, -- a señal selOp (U1)
SAL_400Hz => SAL_400Hz, -- a señal p/div_clk (U4)
DISPLAY => DISPLAY, -- a segmentos del display
AN => AN -- a ánodos del display
);
----------------------------------------------------------------
end Behavioral; -- fin de la arquitectura TLD