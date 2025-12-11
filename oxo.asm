; tictactoe_win.asm - Windows 64-bit EXE (Standard NASM syntax)
bits 64
default rel

section .data
    ; Board positions
    a1 db '1', 0
    a2 db '2', 0
    a3 db '3', 0
    a4 db '4', 0
    a5 db '5', 0
    a6 db '6', 0
    a7 db '7', 0
    a8 db '8', 0
    a9 db '9', 0
    
    ; Display strings
    oxo db 'OXO', 13, 10, 0
    bar db '|', 0
    newline db 13, 10, 0
    dashes db '-----', 13, 10, 0
    
    ; Prompts
    prompt1 db 'Position (1-9): ', 0
    prompt2 db 'Symbol (x/o): ', 0
    
    ; Console handles
    hStdOut dq 0
    hStdIn  dq 0
    
    ; Input buffers
    pos times 16 db 0
    sym times 16 db 0
    bytesWritten dq 0
    bytesRead dq 0

section .text
    ; Import Windows API functions
    extern GetStdHandle
    extern WriteConsoleA
    extern ReadConsoleA
    extern ExitProcess
    
    global main

main:
    push rbp
    mov rbp, rsp
    
    ; Get console handles
    mov ecx, -11         ; STD_OUTPUT_HANDLE = -11
    call GetStdHandle
    mov [hStdOut], rax
    
    mov ecx, -10         ; STD_INPUT_HANDLE = -10
    call GetStdHandle
    mov [hStdIn], rax

game_loop:
    call display_board
    call get_input
    jmp game_loop
    
    ; Exit (never reached)
    xor ecx, ecx
    call ExitProcess

display_board:
    push rbp
    mov rbp, rsp
    
    ; Print OXO
    mov rcx, [hStdOut]
    lea rdx, [oxo]
    mov r8, 5            ; Length: 'O','X','O',13,10
    lea r9, [bytesWritten]
    call WriteConsoleA
    
    ; Row 1: a1 | a2 | a3
    mov rcx, [hStdOut]
    lea rdx, [a1]
    mov r8, 1
    lea r9, [bytesWritten]
    call WriteConsoleA
    
    mov rcx, [hStdOut]
    lea rdx, [bar]
    mov r8, 1
    lea r9, [bytesWritten]
    call WriteConsoleA
    
    mov rcx, [hStdOut]
    lea rdx, [a2]
    mov r8, 1
    lea r9, [bytesWritten]
    call WriteConsoleA
    
    mov rcx, [hStdOut]
    lea rdx, [bar]
    mov r8, 1
    lea r9, [bytesWritten]
    call WriteConsoleA
    
    mov rcx, [hStdOut]
    lea rdx, [a3]
    mov r8, 1
    lea r9, [bytesWritten]
    call WriteConsoleA
    
    ; Newline
    mov rcx, [hStdOut]
    lea rdx, [newline]
    mov r8, 2
    lea r9, [bytesWritten]
    call WriteConsoleA
    
    ; Dashes
    mov rcx, [hStdOut]
    lea rdx, [dashes]
    mov r8, 7            ; 5 dashes + CR + LF
    lea r9, [bytesWritten]
    call WriteConsoleA
    
    ; Row 2: a4 | a5 | a6
    mov rcx, [hStdOut]
    lea rdx, [a4]
    mov r8, 1
    lea r9, [bytesWritten]
    call WriteConsoleA
    
    mov rcx, [hStdOut]
    lea rdx, [bar]
    mov r8, 1
    lea r9, [bytesWritten]
    call WriteConsoleA
    
    mov rcx, [hStdOut]
    lea rdx, [a5]
    mov r8, 1
    lea r9, [bytesWritten]
    call WriteConsoleA
    
    mov rcx, [hStdOut]
    lea rdx, [bar]
    mov r8, 1
    lea r9, [bytesWritten]
    call WriteConsoleA
    
    mov rcx, [hStdOut]
    lea rdx, [a6]
    mov r8, 1
    lea r9, [bytesWritten]
    call WriteConsoleA
    
    ; Newline
    mov rcx, [hStdOut]
    lea rdx, [newline]
    mov r8, 2
    lea r9, [bytesWritten]
    call WriteConsoleA
    
    ; Dashes
    mov rcx, [hStdOut]
    lea rdx, [dashes]
    mov r8, 7
    lea r9, [bytesWritten]
    call WriteConsoleA
    
    ; Row 3: a7 | a8 | a9
    mov rcx, [hStdOut]
    lea rdx, [a7]
    mov r8, 1
    lea r9, [bytesWritten]
    call WriteConsoleA
    
    mov rcx, [hStdOut]
    lea rdx, [bar]
    mov r8, 1
    lea r9, [bytesWritten]
    call WriteConsoleA
    
    mov rcx, [hStdOut]
    lea rdx, [a8]
    mov r8, 1
    lea r9, [bytesWritten]
    call WriteConsoleA
    
    mov rcx, [hStdOut]
    lea rdx, [bar]
    mov r8, 1
    lea r9, [bytesWritten]
    call WriteConsoleA
    
    mov rcx, [hStdOut]
    lea rdx, [a9]
    mov r8, 1
    lea r9, [bytesWritten]
    call WriteConsoleA
    
    ; Newline
    mov rcx, [hStdOut]
    lea rdx, [newline]
    mov r8, 2
    lea r9, [bytesWritten]
    call WriteConsoleA
    
    ; Extra newline for spacing
    mov rcx, [hStdOut]
    lea rdx, [newline]
    mov r8, 2
    lea r9, [bytesWritten]
    call WriteConsoleA
    
    pop rbp
    ret

get_input:
    push rbp
    mov rbp, rsp
    
    ; Ask for position
    mov rcx, [hStdOut]
    lea rdx, [prompt1]
    mov r8, 16        ; Length of "Position (1-9): "
    lea r9, [bytesWritten]
    call WriteConsoleA
    
    ; Read position
    mov rcx, [hStdIn]
    lea rdx, [pos]
    mov r8, 16
    lea r9, [bytesRead]
    call ReadConsoleA
    
    ; Ask for symbol
    mov rcx, [hStdOut]
    lea rdx, [prompt2]
    mov r8, 14        ; Length of "Symbol (x/o): "
    lea r9, [bytesWritten]
    call WriteConsoleA
    
    ; Read symbol
    mov rcx, [hStdIn]
    lea rdx, [sym]
    mov r8, 16
    lea r9, [bytesRead]
    call ReadConsoleA
    
    ; Convert position from ASCII to number
    mov al, [pos]       ; Get first character
    sub al, '0'         ; Convert '1'-'9' to 1-9
    
    ; Get symbol (x or o)
    mov bl, [sym]       ; Get first character
    
    ; Update board based on position
    cmp al, 1
    je update_a1
    cmp al, 2
    je update_a2
    cmp al, 3
    je update_a3
    cmp al, 4
    je update_a4
    cmp al, 5
    je update_a5
    cmp al, 6
    je update_a6
    cmp al, 7
    je update_a7
    cmp al, 8
    je update_a8
    cmp al, 9
    je update_a9
    jmp input_done      ; Invalid position

update_a1:
    mov [a1], bl
    jmp input_done
update_a2:
    mov [a2], bl
    jmp input_done
update_a3:
    mov [a3], bl
    jmp input_done
update_a4:
    mov [a4], bl
    jmp input_done
update_a5:
    mov [a5], bl
    jmp input_done
update_a6:
    mov [a6], bl
    jmp input_done
update_a7:
    mov [a7], bl
    jmp input_done
update_a8:
    mov [a8], bl
    jmp input_done
update_a9:
    mov [a9], bl

input_done:
    pop rbp
    ret