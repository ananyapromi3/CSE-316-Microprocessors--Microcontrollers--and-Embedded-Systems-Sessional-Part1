.MODEL SMALL  
.STACK 100H
.DATA
    CR     EQU 0DH
    LF     EQU 0AH
    prompt DB  'Enter n and k: $'
    output DB  'Number of chocolates Shahil can have: $'
    digit  DW  ?
    n      DW  0H
    k      DW  0H
    ans    DW  0H
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
                  CMP  AL, 20H
                  JE   input_k
                  SUB  AL, '0'
                  MOV  AH, 0H
                  MOV  digit, AX
                  MOV  AX, n
                  MOV  BX, 0AH
                  MUL  BX
                  ADD  AX, digit
                  MOV  n, AX
                  JMP  input_n
    input_k:      
                  MOV  AH, 01H
                  INT  21H
                  CMP  AL, 0DH
                  JE   calculate_ans
                  SUB  AL, '0'
                  MOV  AH, 0H
                  MOV  digit, AX
                  MOV  AX, k
                  MOV  BX, 0AH
                  MUL  BX
                  ADD  AX, digit
                  MOV  k, AX
                  JMP  input_k
    calculate_ans:
                  XOR  DX, DX
                  MOV  AX, n
                  MOV  BX, 0H
                  MOV  CX, 0H
    eat_chocolate:
                  INC  BX
                  INC  CX
                  DEC  AX
                  CMP  BX, k
                  JB   no_exchange
                  INC  AX
                  SUB  BX, k
    no_exchange:  
                  CMP  AX, 0
                  JNE  eat_chocolate
    ; output
                  MOV  ans, CX
                  LEA  DX, output
                  MOV  AH, 9
                  INT  21H
                  MOV  AX, ans
                  CALL PRINT
    end_code:     
                  MOV  AH, 4CH
                  INT  21H
MAIN ENDP
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