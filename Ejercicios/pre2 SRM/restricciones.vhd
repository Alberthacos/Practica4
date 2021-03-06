// Archivo de restricciones de usuario (UCF) //
#######################################
##Asignación de terminales de la AMIBA 2
//DISPLAYS
NET "DISPLAY(7)" LOC = "P16"; // a
NET "DISPLAY(6)" LOC = "P15"; // b
NET "DISPLAY(5)" LOC = "T15"; // c
NET "DISPLAY(4)" LOC = "T14"; // d
NET "DISPLAY(3)" LOC = "T13"; // e
NET "DISPLAY(2)" LOC = "R16"; // f
NET "DISPLAY(1)" LOC = "R15"; // g
NET "DISPLAY(0)" LOC = "R14"; // P
//ANODOS
NET "AN(3)" LOC = "E11"; // AN0
NET "AN(2)" LOC = "D11"; // AN1
NET "AN(1)" LOC = "C15"; // AN2
NET "AN(0)" LOC = "E15"; // AN3

//selOp,RESET--PUSH BUTTON
//NET "selOp(0)" LOC = "L1"; // btn0 suma
//NET "selOp(1)" LOC = "J1"; // btn1 resta
//NET "selOp(2)" LOC = "J3"; // btn2 mult
//NET "RESET" LOC = "H13"; // btn3 RST

//Botones selectores de operacion

//CLK reloj 50MHz
NET "CLK" LOC = "E7";

// entrada A y B a SW
//NET "SW(0)" LOC = "N9"; // SW0 B(0)
//NET "SW(1)" LOC = "R7"; // SW1 B(1)
//NET "SW(2)" LOC = "P4"; // SW2 B(2)
//NET "SW(3)" LOC = "R9"; // SW3 B(3)

//NET "SW(4)" LOC = "T7"; // SW4 A(0)
//NET "SW(5)" LOC = "N5"; // SW5 A(1)
//NET "SW(6)" LOC = "P2"; // SW6 A(2)
//NET "SW(7)" LOC = "M1"; // SW7 A(3)

//numeros del teclado 
NET"filas(3)" LOC="D3";
NET"filas(2)" LOC="D5";
NET"filas(1)" LOC="C6";
NET"filas(0)" LOC="F9";
NET"columnas(3)" LOC="F10";
NET"columnas(2)" LOC="E10";
NET"columnas(1)" LOC="F3";
NET"columnas(0)" LOC="D1";



// salida a led testigos del resultado C
NET "led(0)" LOC = "N1"; // LD0
NET "led(1)" LOC = "R2"; // LD1
NET "led(2)" LOC = "R5"; // LD2
NET "led(3)" LOC = "N8"; // LD3
NET "led(4)" LOC = "P11"; // LD4
NET "led(5)" LOC = "P6"; // LD5
NET "led(6)" LOC = "P8" ; // LD6
NET "led(7)" LOC = "P12" ; // LD7
NET"ledprueba" LOC ="P1";