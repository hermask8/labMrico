.model small
.DATA
   
    mensajeNG db 'Las cadenas ingresadas no son iguales$'
    mensajeG db 'Las cadenas ingresadas son iguales$'
    mensajeIn1 db 'Ingrese la primer cadena a evaluar: $'
    mensajeIn2 db 'Ingrese la segunda cadena a evaluar: $'
     Resultado1 DB 0FFH DUP(?)                      
    Resultado2 DB 0FFH DUP(?)                      
    con DB ?
    co DB ?

.STACK

.CODE

programa:
    MOV AX,@DATA
    MOV DS, AX
    
    MOV AX, 03H
    INT 10H
    
    MOV DX, OFFSET mensajeIn1
    MOV AH, 09H
    INT 21H
    
    MOV SI, 0
    MOV con, 0
    
LecturaCaracter1:

    XOR AX,AX
    MOV AH, 01H
    INT 21H
    CMP AL, 0DH
    JZ String2
    MOV Resultado1[SI], AL
    INC SI
    INC con
    JMP LecturaCaracter1
    
String2:
    MOV AX, 03H
    INT 10H
    
    MOV co, 0
    MOV SI, 0
    
    MOV DX, OFFSET mensajeIn2
    MOV AH, 09H
    INT 21H
    
LecturaCaracter2:

    XOR AX,AX
    MOV AH, 01H
    INT 21H
    CMP AL, 0DH
    JZ Terminar
    MOV Resultado2[SI], AL
    INC SI
    INC co
    JMP LecturaCaracter2
    
Terminar:
    MOV AL, con
    CMP co, AL
    JNE NoIguales
    MOV SI, 0
    MOV CL, con
    
ValidarCadenas:
    MOV AL, Resultado2[SI]
    CMP Resultado1[SI], AL
    JNE NoIguales
    LOOP ValidarCadenas
    JMP Iguales
    
    
NoIguales:
    MOV AX, 03H
    INT 10H
    
    MOV DX, OFFSET mensajeNG
    MOV AH, 09H
    INT 21H
    JMP Fin
    
Iguales:
    
    MOV AX, 03H
    INT 10H
    
    MOV DX, OFFSET mensajeG
    MOV AH, 09H
    INT 21H
Fin:
    
    MOV AH,4CH
    INT 21H 
    
end programa