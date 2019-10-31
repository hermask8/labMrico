.model small
.DATA
    recCadena DB 0FFH DUP(?)                      ;Resultante
    contador DB ?
    mensaje db 'Ingrese la cadena a evaluar: $'
.STACK
.CODE

programa:
    MOV AX,@DATA
    MOV DS, AX
    
    MOV DX, OFFSET mensaje
    MOV AH, 09H
    INT 21H
    
   
    
    MOV SI, 0
    MOV contador, 0
    
    
LecCadena:

    XOR AX,AX
    MOV AH, 01H
    INT 21H
    CMP AL, 0DH
    JZ Imprimir
    MOV recCadena[SI], AL
    INC SI
    INC contador
    JMP LecCadena
    
Imprimir:
    MOV AX, 03H
    INT 10H
    MOV CL, contador
    MOV SI, 0
    
    
Recorrer:
    MOV AH, 02H
    MOV DL, recCadena[SI]
    SUB DL, 20H
    INT 21H
    INC SI
    LOOP Recorrer
    
    
    MOV AH,4CH
    INT 21H    

end programa