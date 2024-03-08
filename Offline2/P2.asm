.MODEL SMALL  
.STACK 100H
.DATA
    CR     EQU 0DH
    LF     EQU 0AH
    prompt DB  'Enter n: $'
    output DB  'Sum of the digits: $'
    digit  DW  ?
    n      DW  0H
    sum    DW  0H
    temp   DW  ?
.CODE
MAIN PROC
    ; initialize DS
                  MOV  AX, @DATA
                  MOV  DS, AX
    ; user prompt
                  LEA  DX, prompt
                  MOV  AH, 09H
                  INT  21H
    input_n:      
                  MOV  AH, 01H
                  INT  21H
                  CMP  AL, 0DH
                  JE   calculate_ans
                  SUB  AL, '0'
                  MOV  AH, 0H
                  MOV  digit, AX
                  MOV  AX, n
                  MOV  BX, 0AH
                  MUL  BX
                  ADD  AX, digit
                  MOV  n, AX
                  JMP  input_n
    calculate_ans:
                  MOV  AX, n
                  MOV  BX, 0AH
                  DIV  BX
                  PUSH DX
                  MOV  DX, 0H
                  CALL SUM_DIGITS
                  MOV  sum, AX
    ; output
                  LEA  DX, output
                  MOV  AH, 9
                  INT  21H
                  MOV  AX, sum
                  CALL PRINT
    end_code:     
                  MOV  AH, 4CH
                  INT  21H
MAIN ENDP
SUM_DIGITS PROC NEAR
                  
                  PUSH BP
                  MOV  BP, SP
                  CMP  AX, 0
                  JG   END_IF      
                  ADD  AX, WORD PTR[BP+4]
                  JMP return
    END_IF:       
                  MOV  BX, 0AH
                  DIV  BX
                  PUSH DX
                  MOV  DX, 0H
                  CALL SUM_DIGITS
                  ADD  AX, WORD PTR[BP+4]
    return:       
                  POP  BP
                  RET  2
SUM_DIGITS ENDP
PRINT PROC
                  MOV  CX, 0H
                  MOV  DX, 0H
    extract_digit:
                  CMP  AX, 0H
                  JE   print_digit
                  INC  CX
                  MOV  BX, 0AH
                  DIV  BX
                  PUSH DX
                  MOV  DX, 0H
                  JMP  extract_digit
    print_digit:  
                  CMP  CX, 0H
                  JE   exit_func
                  DEC  CX
                  POP  DX
                  ADD  DX, '0'
                  MOV  AH, 02H
                  INT  21H
                  JMP  print_digit
    exit_func:    
                  RET
PRINT ENDP
END MAIN 