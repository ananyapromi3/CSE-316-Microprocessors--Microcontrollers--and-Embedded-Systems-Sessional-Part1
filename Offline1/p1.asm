.MODEL SMALL  
.STACK 100H
.DATA
    CR            EQU 0DH
    LF            EQU 0AH
    uppercase_msg DB  CR, LF, 'Uppercase Letter $'
    lowercase_msg DB  CR, LF, 'Lowercase Letter $'
    num_msg       DB  CR, LF, 'Number $'
    other_msg     DB  CR, LF, 'Not an alphanumeric value $'
    prompt        DB  'Enter a single printable ASCII character: $'
.CODE
MAIN PROC
    ; initialize DS
                    MOV AX, @DATA
                    MOV DS, AX
    ; user prompt
                    LEA DX, prompt
                    MOV AH, 9
                    INT 21H
    ; take input
                    MOV AH, 1
                    INT 21H
    check_lowercase:
                    CMP AL, 'a'
                    JB  check_uppercase
                    CMP AL, 'z'
                    JBE print_lowercase
    check_uppercase:
                    CMP AL, 'A'
                    JB  check_number
                    CMP AL, 'Z'
                    JBE print_uppercase
    check_number:   
                    CMP AL, '0'
                    JB  print_other
                    CMP AL, '9'
                    JBE print_number
    print_other:    
                    LEA DX, other_msg
                    MOV AH, 9
                    INT 21H
                    JMP end_case
    print_uppercase:
                    LEA DX, uppercase_msg
                    MOV AH, 9
                    INT 21H
                    JMP end_case
    print_lowercase:
                    LEA DX, lowercase_msg
                    MOV AH, 9
                    INT 21H
                    JMP end_case
    print_number:   
                    LEA DX, num_msg
                    MOV AH, 9
                    INT 21H
                    JMP end_case
    end_case:       
                    MOV AH, 4CH
                    INT 21H
MAIN ENDP
END MAIN 