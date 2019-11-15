.386
.MODEL FLAT, STDCALL 
OPTION CASEMAP:NONE

INCLUDE \masm32\include\windows.inc 
INCLUDE \masm32\include\kernel32.inc
INCLUDE \masm32\include\masm32.inc
INCLUDE \masm32\include\masm32rt.inc 
include \masm32\include\user32.inc
include \masm32\include\gdi32.inc

includelib \masm32\lib\user32.lib
includelib \masm32\lib\gdi32.lib
INCLUDELIB \masm32\lib\kernel32.lib
INCLUDELIB \masm32\lib\masm32.lib
;Macros 

print1 MACRO msg                
        INVOKE StdOut, ADDR msg
ENDM

Operar MACRO numFactorial,respuestaFinal
	PUSHA
	;Solo limpia registros para volverlos a utilizar
	XOR EAX , EAX
	XOR ECX , ECX

	MOV EAX , 1
	MOV CL , numFactorial
	; multiplica n veces o la cantidad ingresada 
	;multiplica decrementando el numero de veces
	multip:	
		MUL ECX
	LOOP multip
	;mueve el resultado que esta en EAX
	MOV respuestaFinal , EAX
	POPA
ENDM

.DATA
	msg1 DB 'Ingrese un numero para rellenar 3 cifras utilice 0 : ' , 0
	msg2 DB 'Factorial= ' ,0
	
	comoD DB 10

	PC DB 3 dup(?)
	numero DB ?
	respuestaFinal DD ?
.CODE
program:
main PROC
	print1 msg1
	INVOKE StdIn, ADDR PC, 10 

	MOV numero , 0

	;Lee lo ingresado y lo va sumando a numero
	MOV AL , PC[2]
	SUB AL , 30h
	ADD numero , AL

	MOV AL , PC[1]
	SUB AL , 30h
	MUL comoD
	ADD numero , AL

	MOV AL , PC[0]
	SUB AL , 30h
	MUL comoD
	MUL comoD
	ADD numero , AL

	;Llama a macro
	Operar numero,respuestaFinal
	
	;Imprime la respuesta
	print1 msg2
	
	print str$(respuestaFinal),10,13

	INVOKE ExitProcess,0
main ENDP
END program