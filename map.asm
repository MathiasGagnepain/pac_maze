WALL_COLOR: equ 20h
BASE_MAZE: equ 0x0014
MAZE_SIZE_X: equ 0280h  ;0280h = 640 in hexa TODO substract the size of the right panel
MAZE_SIZE_Y: equ 01E0h  ;01E0h = 480 in hexa
TILE_SIZE: equ 000Fh    ;Size of a tile

section .data
    maze:
        dw 0b0000_0000_0000_0000
        dw 0b0111_1111_1111_1110
        dw 0b0100_0010_0000_0010
        dw 0b0100_0010_0000_0010
        dw 0b0111_1111_1111_1111
        dw 0b0100_0010_0100_0000
        dw 0b0111_1110_0111_1110
        dw 0b0000_0010_0000_0010
        dw 0b0000_0010_0111_1111
        dw 0b0000_0011_1100_0000
        dw 0b0000_0010_0100_0000
        dw 0b0000_0010_0111_1111
        dw 0b0000_0010_0100_0000
        dw 0b0111_1111_1111_1110
        dw 0b0100_0010_0000_0010
        dw 0b0111_1011_1111_1111
        dw 0b0000_1010_0100_0000
        dw 0b0111_1110_0111_1110
        dw 0b0100_0000_0000_0010
        dw 0b0111_1111_1111_1111
        dw 0b0000_0000_0000_0000

drawMaze:
    ;mov di,BASE_MAZE

    mov ah, 0Ch                 ;set the configuration to write a pixel
    mov al, WALL_COLOR          ;Choose color to write
    xor bx, bx
    mov cx, 0000h                 ;set the column (X)
    mov dx, 0000h                 ;set the line (Y)

    call drawTile

    .exitloop:
        jmp _start.awaitKey

drawTile:
    .drawline:
        int 10h
        inc cx
        cmp cx, MAZE_SIZE_X
        JNE .drawline
        cmp dx, MAZE_SIZE_Y
        JNE .drawcol
        JMP .tiledone
    .drawcol:
        int 10h
        inc dx
        cmp dx, MAZE_SIZE_Y
        JNE .drawline
    .tiledone:
        jmp drawMaze.exitloop
