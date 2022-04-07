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
    selOp: in std_logic_vector (2 DOWNTO 0); -- selector de operación lógica
    SAL_400Hz: in STD_LOGIC; -- reloj de 400Hz
    DISPLAY: out STD_LOGIC_VECTOR(7 DOWNTO 0); -- seg dsply "abcdefgP"
    AN: out STD_LOGIC_VECTOR(7 DOWNTO 0) -- ánodos del display
    ); 
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
constant B: std_logic_vector (7 downto 0):= "11000001"; -- B
constant U: std_logic_vector (7 downto 0):= "11000111"; -- u
constant F: std_logic_vector (7 downto 0):= "01110001"; -- f
BEGIN
--------------------MULTIPLEXOR---------------------
PROCESS(SAL_400Hz, sel, selOp)
BEGIN
IF SAL_400Hz'EVENT and SAL_400Hz='1' THEN SEL <= SEL + '1';

CASE(SEL) IS
when "00" => AN <="11111110"; --
		if selOp = "000" then DISPLAY <= V; -- andV
        elsif selOp = "001" then DISPLAY <= V; -- orvV
        elsif selOp = "010" then DISPLAY <= V; -- ^orV
        elsif selOp = "011" then DISPLAY <= A; -- notV
        elsif selOp = "100" then DISPLAY <= B; -- BufV
        elsif selOp = "101" then DISPLAY <= D; -- nand
        elsif selOp = "110" then DISPLAY <= V; -- norV
        elsif selOp = "111" then DISPLAY <= R; -- x^nor
        else DISPLAY <= V; -- sin Datos 
end if;

when "01" => AN <="11111101"; --
    if selOp = "000" then DISPLAY <= D; -- andV
        elsif selOp = "001" then DISPLAY <= V; -- orvV
        elsif selOp = "010" then DISPLAY <= R; -- ^orV
        elsif selOp = "011" then DISPLAY <= T; -- notV
        elsif selOp = "100" then DISPLAY <= F; -- BufV
        elsif selOp = "101" then DISPLAY <= N; -- nand
        elsif selOp = "110" then DISPLAY <= R; -- norV
        elsif selOp = "111" then DISPLAY <= O; -- ^nor
        else DISPLAY <= V; -- sin Datos 
end if;

when "10" => AN <="11111011"; --
    if selOp = "000" then DISPLAY <= N; -- andV
        elsif selOp = "001" then DISPLAY <= R; -- orvV
        elsif selOp = "010" then DISPLAY <= O; -- ^orV
        elsif selOp = "011" then DISPLAY <= O; -- notV
        elsif selOp = "100" then DISPLAY <= U; -- BufV
        elsif selOp = "101" then DISPLAY <= A; -- nand
        elsif selOp = "110" then DISPLAY <= O; -- norV
        elsif selOp = "111" then DISPLAY <= N; -- ^nor
        else DISPLAY <= V; -- sin Datos 
end if;

when "11" => AN <="11110111"; --
    if selOp = "000" then DISPLAY <= A; -- andV
        elsif selOp = "001" then DISPLAY <= O; -- orvV
        elsif selOp = "010" then DISPLAY <= X; -- ^orV
        elsif selOp = "011" then DISPLAY <= N; -- notV
        elsif selOp = "100" then DISPLAY <= B; -- BufV
        elsif selOp = "101" then DISPLAY <= N; -- nand
        elsif selOp = "110" then DISPLAY <= N; -- norV
        elsif selOp = "111" then DISPLAY <= X; -- ^nor
        else DISPLAY <= V; -- sin Datos 
end if;

----------------------------------------------------------------------------------------
when OTHERS=>AN <="11111111"; --
    if selOp = "000" then DISPLAY <= V; -- and
        elsif selOp = "001" then DISPLAY <= V; -- or
            elsif selOp = "010" then DISPLAY <= V; -- xor
                elsif selOp = "011" then DISPLAY <= V; -- not
                    elsif selOp = "100" then DISPLAY <= V; -- BufV
                        elsif selOp = "101" then DISPLAY <= V; -- nand
                            elsif selOp = "110" then DISPLAY <= V; -- norV
                                elsif selOp = "111" then DISPLAY <= V; -- ^nor
                
                else 
                   DISPLAY <= V; -- sin dato
    end if;
            END CASE;
        end if;
END PROCESS; -- fin del proceso Multiplexor
------------------------------------------------
end Behavioral; -- fin de la arquitectura
