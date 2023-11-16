cpu 8086
org 100h

%include "map.asm"

section .data
    charValue db 'X$'

section .text
    global _start

_start:
    xor sp, sp        ; Reset Stack Pointer
    ; Initialize graphics mode
    mov ax, 4F02h      ; Set Video Mode 4F02h (VBE mode 101h) - 640x480, 256 colors
    mov bx, 101h    ; VBE mode 101h
    int 10h          ; Call BIOS interrupt

    ; Your code for drawing the maze goes here
    ;TODO Add drawMaze


    ; Return to text mode and exit
    mov ax, 0xA000
    int 0x10       ; Set destination index to 0 (start of video memory)

    call drawMaze

    .awaitKey:
        call keyHandler
        mov [charValue], al
        cmp al ,27  ; Escape ??
        je .exit
        cmp al ,'z'
        je .moveUp
        cmp al ,'s'
        je .moveDn
        cmp al ,'d'
        je .moveRg
        cmp al ,'q'
        je .moveLf
        jmp .awaitKey

    .moveUp:
        ;move up
        call moveup
    .moveDn:
        ;move down
        call movedown
    .moveRg:
        ;move right
        call moveright
    .moveLf:
        ;move left
        call moveleft
    .exit:
        mov ah, 4ch
        xor al, al
        int 21h

keyHandler:
    xor ax, ax
    int 16h
    ret


; TO ADD in sprite.asm
moveup:
    mov ah, 9
    mov dx, charValue
    int 21h
    jmp _start.awaitKey
movedown:
    mov ah, 9
    mov dx, charValue
    int 21h
    jmp _start.awaitKey
moveleft:
    mov ah, 9
    mov dx, charValue
    int 21h
    jmp _start.awaitKey
moveright:
    mov ah, 9
    mov dx, charValue
    int 21h
    jmp _start.awaitKey