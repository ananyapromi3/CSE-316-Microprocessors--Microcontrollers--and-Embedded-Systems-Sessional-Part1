; Suppose, you have an array of words. 
; Your task is to determine whether the elements in the array are sorted in the descending order, 
; in ascending order or are not sorted. 
; You should print an appropriate message in all the cases. 
; You need not take the array as user input. 
; You may declare an array of any length in the data segment and work with it. 
; Note that you must iterate the array elements in a loop.

.MODEL SMALL  
.STACK 100H
.DATA
    CR             EQU 0DH
    LF             EQU 0AH
    prompt         DB  'Enter the sequence of numbers: $'
    asc_msg        DB  'Ascending$'
    dec_msg        DB  'Descending$'
    not_sorted_msg DB  'Not sorted$'
    digit          DW  ?
    n              DW  0H
    prev           DW  0H
    flag           DW  0
.CODE
MAIN PROC
              MOV AX, @DATA
              MOV DS, AX
              LEA DX, prompt
              MOV AH, 9
              INT 21H
    input_1:  
              MOV AH, 01H
              INT 21H
              CMP AL, '2'
              JG  process
              SUB AL, '0'
              MOV AH, 0H
              MOV digit, AX
              MOV AX, n
              MOV BX, 0AH
              MUL BX
              ADD AX, digit
              MOV n, AX
              JMP input_1
    process_1:
              MOV BX, n
              MOV prev, BX
              MOV BX, 0H
              MOV n, 0H
    input:    
              MOV AH, 01H
              INT 21H
              CMP AL, ' '
              JE  process
              CMP AL, CR
              JE  output
              SUB AL, '0'
              MOV AH, 0H
              MOV digit, AX
              MOV AX, n
              MOV BX, 0AH
              MUL BX
              ADD AX, digit
              MOV n, AX
              JMP input
    process:  
              MOV BX, n
              CMP BX, prev
              JA  check_asc
              JE  not_sure
              JB  check_des
              MOV BX, 0H
              MOV n, BX
    chech_asc:
    MOV AX, 01H
    CMP AX, flag
    JB set_flag
    output:   
              LEA DX, msg
              MOV AH, 9
              INT 21H
              MOV AH, 2
              MOV DL, ans
              INT 21H
              MOV AH, 4CH
              INT 21H
MAIN ENDP
END MAIN 