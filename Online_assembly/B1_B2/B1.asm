; Suppose, you have a string consisting of only lowercase vowels and lowercase consonants as its characters.
; Your task is to count the total number of vowels and consonants in the string. You do not need to take the
; string as the user input, you may declare a string in the data segment of your program. You must use loops to
; iterate the characters in the string.

.MODEL SMALL  
.STACK 100H
.DATA
    CR          EQU 0DH
    LF          EQU 0AH
    str_        DB  'aefof$' ; Added '$' to mark the end of the string
    vow_prompt  DB  'Vowel Count: $'
    cons_prompt DB  CR, LF, 'Consonant Count: $'
    n           DW  6 ; Increased to account for the end-of-string marker
    cons        DW  0H
    vow         DW  0H
.CODE
MAIN PROC
                   MOV  AX, @DATA
                   MOV  DS, AX
                   LEA  SI, str_
                   MOV  CX, n
    count_vow_cons:
                   CMP  CX, 0H
                   JG   print_ans
                   MOV  AL, [SI]
                   CMP  AL, '$'
                   JE   print_ans
                   CMP  AL, 'a'
                   JE   vow_inc
                   CMP  AL, 'e'
                   JE   vow_inc
                   CMP  AL, 'i'
                   JE   vow_inc
                   CMP  AL, 'o'
                   JE   vow_inc
                   CMP  AL, 'u'
                   JE   vow_inc
                   JMP  cons_inc
    vow_inc:       
                   MOV  AX, vow
                   ADD  AX, 01H
                   MOV  vow, AX
                   DEC  CX
                   ADD  SI, 01H
                   JMP  count_vow_cons
    cons_inc:      
                   MOV  AX, cons
                   ADD  AX, 01H
                   MOV  cons, AX
                   DEC  CX
                   ADD  SI, 01H
                   JMP  count_vow_cons
    print_ans:     
                   LEA  DX, vow_prompt
                   MOV  AH, 09H
                   INT  21H
                   MOV  AX, vow
                   CALL PRINT
                   LEA  DX, cons_prompt
                   MOV  AH, 09H
                   INT  21H
                   MOV  AX, cons
                   CALL PRINT
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
