#make_COM#
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt

org 100h

INCLUDE "EMU8086.INC" 

JMP START 
.data
    myNumber dw ?
    i db 0
    j db 0
    address dw 34Fh 
    string db 0
    NUM DW ?
    MAIN DB "FACTORIAL CALCULATOR. NUM: $"
    MSG DB 13,10, "THE RESULT IS: $", 0
    RESULT_MSG DB "Factorial is:", 0 
    buffer DB 7 DUP ('$') ; Buffer to store the string representation (assuming a maximum of 10 digits + null terminator)
    buffer2 DB 7 DUP (' ') ; Buffer to store the string representation (assuming a maximum of 10 digits + null terminator)
    FILE_NAME DB "emudosya.txt", 0   
                                              
    
.code 
PROGRAM proc
START:
MOV DX, OFFSET MAIN
MOV AH, 9
INT 21H
CALL SCAN_NUM
MOV NUM, CX

MOV BX, 1
MOV AX, 1
JMP LABEL1

LABEL1:
    MUL BX
    INC BX
    CMP BX, NUM
    JBE LABEL1

push AX
CALL function4
pop AX
call function5

lea DX, MSG
mov ah, 09h
int 21h
lea dx, buffer
int 21h



MOV DX, OFFSET FILE_NAME
MOV AH, 3Ch ; Create or open file
MOV CX, 0 ; Access mode (0 = read/write)
INT 21h ; Create the file


MOV BX, AX ; Save file handle

 MOV DX, OFFSET RESULT_MSG
MOV AH, 40h ; Write to file
MOV CX, 13 ; Number of bytes to write
INT 21h ; Write the message to the file
MOV DX, OFFSET buffer2
MOV AH, 40h ; Write to file
MOV CX, 7 ; Number of bytes to write
INT 21h ; Write the message to the file

MOV AX, BX ; Move file handle to AX
MOV AH, 3Eh ; Close file
INT 21h ; Close the file
hlt
PROGRAM endp


function4 proc
FUNC_START:
   
    MOV BX, OFFSET buffer ; Address of the buffer

    ; Convert the number to a string
    MOV CX, 10 ; Divisor for conversion (base 10)
    MOV DI, 0 ; Index for buffer
    MOV DX, 0 ; Initialize DX as zero for division

DIVISION_LOOP:
    XOR DX, DX ; Clear DX for division
    DIV CX ; Divide AX by CX (integer division)
    ADD DL, '0' ; Convert the remainder to ASCII character
    MOV [BX + DI], DL ; Store the character in the buffer
    INC DI ; Increment the buffer index

    ; Check if the quotient is zero
    CMP AX, 0
    JNE DIVISION_LOOP

    ; Reverse the string in the buffer
    DEC DI ; Move back to the last character
    MOV SI, 0 ; Start index for buffer

REVERSE_LOOP:
    CMP SI, DI ; Check if the indices have crossed each other
    JGE DISPLAY ; Jump to display if done

    MOV AL, [BX + SI] ; Load character from the buffer
    MOV AH, [BX + DI] ; Load character from the buffer
    MOV [BX + SI], AH ; Swap characters
    MOV [BX + DI], AL ; Swap characters
    INC SI ; Increment start index
    DEC DI ; Decrement end index
    JMP REVERSE_LOOP
    DISPLAY:
    ret
function4 endp


function5 proc
FUNC_START2:
   
    MOV BX, OFFSET buffer2 ; Address of the buffer

    ; Convert the number to a string
    MOV CX, 10 ; Divisor for conversion (base 10)
    MOV DI, 0 ; Index for buffer
    MOV DX, 0 ; Initialize DX as zero for division

DIVISION_LOOP2:
    XOR DX, DX ; Clear DX for division
    DIV CX ; Divide AX by CX (integer division)
    ADD DL, '0' ; Convert the remainder to ASCII character
    MOV [BX + DI], DL ; Store the character in the buffer
    INC DI ; Increment the buffer index

    ; Check if the quotient is zero
    CMP AX, 0
    JNE DIVISION_LOOP2

    ; Reverse the string in the buffer
    DEC DI ; Move back to the last character
    MOV SI, 0 ; Start index for buffer

REVERSE_LOOP2:
    CMP SI, DI ; Check if the indices have crossed each other
    JGE DISPLAY2 ; Jump to display if done

    MOV AL, [BX + SI] ; Load character from the buffer
    MOV AH, [BX + DI] ; Load character from the buffer
    MOV [BX + SI], AH ; Swap characters
    MOV [BX + DI], AL ; Swap characters
    INC SI ; Increment start index
    DEC DI ; Decrement end index
    JMP REVERSE_LOOP2
    DISPLAY2:
    ret
function5 endp

DEFINE_PRINT_NUM
DEFINE_SCAN_NUM
DEFINE_PRINT_NUM_UNS
DEFINE_PRINT_STRING
