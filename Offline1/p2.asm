.MODEL SMALL  
.STACK 100H
.DATA
     CR         EQU 0DH
     LF         EQU 0AH
     prompt1    DB  'Letter 1: $'
     prompt2    DB  CR, LF, 'Letter 2: $'
     prompt3    DB  CR, LF, 'Letter 3: $'
     output_msg DB  CR, LF, 'Second-highest letter: $'
     equal_msg  DB  CR, LF, 'All letters are equal$'
     a          DB  ?
     b          DB  ?
     c          DB  ?
     ans        DB  ?
.CODE
MAIN PROC
     ; initialize DS
                 MOV  AX, @DATA
                 MOV  DS, AX
     ; take input 1
                 LEA  DX, prompt1
                 MOV  AH, 9
                 INT  21H
                 MOV  AH, 1
                 INT  21H
                 MOV  a, AL
     ; take input 2
                 LEA  DX, prompt2
                 MOV  AH, 9
                 INT  21H
                 MOV  AH, 1
                 INT  21H
                 MOV  b, AL
     ; take input 3
                 LEA  DX, prompt3
                 MOV  AH, 9
                 INT  21H
                 MOV  AH, 1
                 INT  21H
                 MOV  c, AL
     ; compare
                 MOV  AH, b
                 CMP  a, AH
                 JL   no_exchange        ; a < b
                 XCHG a, AH
                 MOV  b, AH
     ; ensures a <= b
     no_exchange:
                 MOV  AH, c
                 CMP  b, AH
                 JL   ans_b              ; a <= b < c
                 CMP  a, AH
                 JL   ans_c              ; a < c <= b
                 JMP  ans_a              ; c <= a <= b
     ans_a:      
                 MOV  AH, a
                 MOV  ans, AH
                 JMP  check_equal
     ans_b:      
                 MOV  AH, b
                 MOV  ans, AH
                 JMP  check_equal
     ans_c:      
                 MOV  AH, c
                 MOV  ans, AH
                 JMP  check_equal
     check_equal:
                 MOV  AH, b
                 CMP  a, AH
                 JNE  print_ans
                 CMP  AH, c
                 JNE  print_ans
     ; print equal
                 LEA  DX, equal_msg
                 MOV  AH, 9
                 INT  21H
                 JMP  end_case
     print_ans:  
                 LEA  DX, output_msg
                 MOV  AH, 9
                 INT  21H
                 MOV  AH, 2
                 MOV  DL, ans
                 INT  21H
     end_case:   
                 MOV  AH, 4CH
                 INT  21H
MAIN ENDP
END MAIN 