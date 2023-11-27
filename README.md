# Finding-the-factorial-of-the-entered-number-and-printing-it-to-the-file-in-Assembly
This program is for factorial calculation. Its function is to prompt the user to enter a number, calculate its factorial, print the result to the screen and to a file.

Descriptions of the functions are as follows:
myNumber dw ? : A 2-byte variable myNumber is defined. This variable represents the factorial result.
i db 0 and j db 0 : 1 byte variables i and j are defined. These variables are used in loops and initial values are assigned to 0.
address dw 34Fh: A 2-byte variable address is defined and initialized with the value 34Fh. This represents an address in memory.
string db 0: A 1-byte string variable is defined and its initial value is assigned to 0.
NUM DW ? : NUM, a 2-byte variable, is defined. This variable was used to represent a number to be received from the user.
MAIN DB "FACTORIAL CALCULATOR. NUM: $": MAIN, which is a string, is defined and contains the expression "FACTORIAL CALCULATOR. NUM: ". $ indicates that it ends with the null character.
MSG DB 13.10, "THE RESULT IS: $", 0 : MSG, which is a string, is defined and contains "THE RESULT IS: ". The expression 13,10 is a line skip signal and is used to move to a new line. $ indicates that it ends with the null character.
RESULT_MSG DB "Factorial is:", 0 : RESULT_MSG, which is a string, is defined and contains the expression "Factorial is:". $ indicates that it ends with the null character.
buffer DB 7 DUP ('$): A 7-byte buffer is defined. This buffer is used to store the string representation of the factorial result. Initial values are assigned as '$' with the expression '$, '$, '$, '$, '$, '$, ''.
buffer2 DB 7 DUP (' '): A 7-byte buffer (buffer2) is defined. This buffer is used to store the inverted string representation of the factorial result. The initial values are assigned as space characters with the expressions ' ', ' ', ' ', ' ', ' ', ' ', ' '.
The number is received from the user and stored in the NUM variable. Then, initial values are assigned to BX and AX registers for factorial calculation.
The section starting with the LABEL1 label performs the factorial calculation. With the MUL instruction, register AX is multiplied by BX, BX is incremented by 1, and BX and NUM are compared. If BX is less than or equal to NUM, it jumps back to LABEL1 to continue the calculation.
In the rest of the code, the function4 and function5 procedures are used to convert the number as a string into buffers buffer and buffer2. These procedures calculate each digit of the number separately, convert it to an ASCII character, and save it in buffer or buffer2. A loop is then used to invert these strings. MSG and buffer addresses are loaded into the DX register with the lea DX, MSG and lea dx, buffer commands, and printing is performed to the screen with int 21h interrupt calls. The rest of the code uses interrupt calls (int 21h) to create, write to, and close the file. While the FILE_NAME string represents the file name, the RESULT_MSG and buffer2 strings are used to print the factorial result to the file.
Finally, the program is terminated using the hlt command.
