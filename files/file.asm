
global _start

section .data
	path db "/home/ghost/test.c",0
	msg db "message from assembly!"
	lenmsg equ $-msg
	openerrmsg db "error whit opening the file",10,0
	lenopenerrmsg equ $-openerrmsg
	writeerrmsg db "error with writing to the file",10,0
	lenwriteerrmsg equ $-writeerrmsg

section .text
_start:
	;open syscall
	mov eax, 5
	mov ebx, path
	mov ecx, 1
	int 0x80
	cmp ebx,0
	jl open_error
	
	;write syscall
	mov ebx,eax
	mov eax,4
	mov ecx,msg
	mov edx,lenmsg
	int 0x80
	cmp eax,0
	jle write_error
	
	;file close syscall
	mov eax,6
	int 0x80

	;closing the program
	mov ebx,0
	jmp close

open_error:
	mov eax, 4
	mov ebx, 1
	mov ecx, openerrmsg
	mov edx, lenopenerrmsg
	int 0x80
	mov ebx,-1
	jmp close

write_error:
	mov eax, 4
	mov ebx, 1
	mov ecx, writeerrmsg
	mov edx, lenwriteerrmsg
	int 0x80	
	mov ebx,-1
	jmp close

close:
	mov eax,1
	int 0x80
