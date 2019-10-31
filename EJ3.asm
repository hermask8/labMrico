.model small
.DATA
    mensajeIngreso db 'Ingrese la cadena: $'
    mensajeResult1 db 'La cadena no es palindromo$'
    mensajeResult2 db 'La cadena es palindromo$'
     Resultado DB 0FFH DUP(?)                      
    contador DB ?
    
.STACK
.CODE

programa:
    MOV AX,@DATA
    MOV DS, AX
    
    MOV AX, 03H
    INT 10H
    
    MOV DX, OFFSET mensajeIngreso
    MOV AH, 09H
    INT 21H
    
    MOV SI, 0
    MOV contador, 0
    
LecturaCaracter1:

    XOR AX,AX
    MOV AH, 01H
    INT 21H
    CMP AL, 0DH
    JZ leerAlreves
    MOV Resultado[SI], AL
    PUSH AX
    INC SI
    INC contador
    JMP LecturaCaracter1
    
leerAlreves:
    
    MOV SI, 0
    MOV CL, contador
    
ValiDereAl:
    XOR AX,AX
    POP AX
    CMP Resultado[SI], AL
    JNE Palindromo
    INC SI
    LOOP ValiDereAl
    JMP NoPalindromo
    
Palindromo:
    MOV AX, 03H
    INT 10H
    
    MOV DX, OFFSET mensajeResult1
    MOV AH, 09H
    INT 21H
    JMP Fin
    
NoPalindromo:
    MOV AX, 03H
    INT 10H
    
    MOV DX, OFFSET mensajeResult2
    MOV AH, 09H
    INT 21H
Fin:
    
    MOV AH,4CH
    INT 21H             
end programa