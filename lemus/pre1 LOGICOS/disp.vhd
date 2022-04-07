--------------------------------------------------------------------------------------
-- Controlador del display de 4 digitos para las letras
--------------------------------------------------------------------------------------
Library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
----------------------------------------------------------------
-- Declaración de la entidad

entity DISPLAYS is
Port (
selOp: in std_logic_vector (3 DOWNTO 0); -- selector de operación lógica
SAL_400Hz: in STD_LOGIC; -- reloj de 400Hz
DISPLAY: out STD_LOGIC_VECTOR(7 DOWNTO 0); -- seg dsply "abcdefgP"
AN: out STD_LOGIC_VECTOR(3 DOWNTO 0)); -- ánodos del display
end DISPLAYS;
----------------------------------------------------------------
-- Declaración de la arquitectura
architecture Behavioral of DISPLAYS is
-- Declaración de señales de la multiplexación y asignación de letras al disp
signal SEL: std_logic_vector (1 downto 0):="00"; -- selector de barrido
-- Declaración de constantes para las letras (AND, OR, XOR, NOT) al disp
constant A: std_logic_vector (7 downto 0):= "00010001"; -- A
constant N: std_logic_vector (7 downto 0):= "11010101"; -- n
constant D: std_logic_vector (7 downto 0):= "10000101"; -- d
constant V: std_logic_vector (7 downto 0):= "11111111"; -- V sin dato
constant O: std_logic_vector (7 downto 0):= "00000011"; -- O
constant R: std_logic_vector (7 downto 0):= "11110101"; -- r
constant X: std_logic_vector (7 downto 0):= "00111011"; -- ^
constant T: std_logic_vector (7 downto 0):= "11100001"; -- t
BEGIN
--------------------MULTIPLEXOR---------------------
PROCESS(SAL_400Hz, sel, selOp)
BEGIN
IF SAL_400Hz'EVENT and SAL_400Hz='1' THEN SEL <= SEL + '1';
CASE(SEL) IS
when "00" => AN <="1110"; --
if selOp = x"1" then DISPLAY <= V; -- andV
elsif selOp = x"2" then DISPLAY <= V; -- orvV
elsif selOp = x"4" then DISPLAY <= V; -- ^orV
elsif selOp = x"8" then DISPLAY <= V; -- notV
else DISPLAY <= V; -- sin dato
end if;

when "01" => AN <="1101"; --
if selOp = x"1" then DISPLAY <= D; -- anDv
elsif selOp = x"2" then DISPLAY <= V; -- orVv
elsif selOp = x"4" then DISPLAY <= R; -- ^oRv
elsif selOp = x"8" then DISPLAY <= T; -- noTv
else DISPLAY <= V; -- sin dato
end if;
when "10" => AN <="1011"; --
if selOp = x"1" then DISPLAY <= N; -- aNdv
elsif selOp = x"2" then DISPLAY <= R; -- oRvv
elsif selOp = x"4" then DISPLAY <= O; -- ^Orv
elsif selOp = x"8" then DISPLAY <= O; -- nOtv
else DISPLAY <= V; -- sin dato
end if;
when "11" => AN <="0111"; --
if selOp = x"1" then DISPLAY <= A; -- Andv
elsif selOp = x"2" then DISPLAY <= O; -- Orvv
elsif selOp = x"4" then DISPLAY <= X; -- ^orv
elsif selOp = x"8" then DISPLAY <= N; -- Not
else DISPLAY <= V; -- sin dato
end if;
when OTHERS=>AN <="1111"; --
if selOp = x"1" then DISPLAY <= V; -- and
elsif selOp = x"2" then DISPLAY <= V; -- or
elsif selOp = x"4" then DISPLAY <= V; -- xor
elsif selOp = x"8" then DISPLAY <= V; -- not
else DISPLAY <= V; -- sin dato
end if;
END CASE;
end if;
END PROCESS; -- fin del proceso Multiplexor
------------------------------------------------
end Behavioral; -- fin de la arquitectura