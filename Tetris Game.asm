; this game is created by  Fawwaz-rz  		
		
		
		[org 0x0100]
		 jmp start
	checktouch_roof:dw 1
		 check_for_ch_by_ch_block:dw 1	 
music_index: dw 0
	music_delay:dw 0
		 count: dd 0
		 music_length: dw 7076
music_data incbin "pow.imf"
		 check_Pkey:dw 1
		 flagfortimer:dw 1
		 clock_timer_nanosec:db 10
		 ypos_mov_index:dw 1
		 delay_timer_size:dw 12
		 lastscorestr:db 'Your score is : '
		 lastscorestrlen:dw 16
		 mov_widht:dw 10
		 mov_height:dw 2
		 timestr:db 0x30,' : ',0x30,0x30
		 timestr_length:dw 6
		 second:db 0
		 minutes:db 0
		 nanoseconds:db 0
		 side_walls_Var:dw 20
		 tickcount: dw 0 
		  message4:db 0xDB,0xDB,0xDB,0xDB,0xDB,0xDB
	len4:dw 6
	message5:db 0xDB
	len5:dw 1
	 lastp_block_count:dw 160
	 slider_component_len:dw 2
	 attribute_last_dots:db 0x0F
	 ypos_last:db 2
	 xpos_last:dw 2
	 ypos_mov:dw 2
	 xpos_mov:dw 2
	 ypos_blockline:db 23
	 xpos_blockline:dw 6
	 check_next_att:dw 2
	 shape_num:dw 0
		 Gameover_Str:db 'Game Over!!'
	Gameover_Str_len:dw 11
		Scorestr: db 'Score',0x00 
		Sc_str_len: dw 5
		Linesstr: db 'Lines',0x00 
		Linesstr_len: dw 5
		Next_Shape: db 'Next Shape',0x00 
		Next_Shape_len: dw 10
		  Score_cal:db 0x30,0x30,0x2F,0x30	
    Score_cal_len:dw 4,0x00	
	square_shape: db '++++A$$$$'
	square_shape_len:dw 8
	t_shape: db '+++++++A$'
	 t_shape_len:dw 10
	 ot_shape: db '++$$$A$'
	ot_shape_len:dw 8
	l_shape: db ' +++++A$'
	l_shape_len:dw 8
	z_shape: db '+++++++++'
z_shape_len	:dw 10
	U_shape:db 0xDB,0xDB,0xDB,0xDB,0xDB,0xDB,0xDB,0xDB
	U_shape_len:dw 8
	slider_component: db 0xDB,0xDB 
	Ishape_home: db 0xDB,0xDB,0xDB,0xDB,0xDB,0xDB,0xDB,0xDB,0xDB,0xDB,0xDB,0xDB,0xDB,0xDB,0xDB,0xDB,0xDB,0xDB,0xDB,0xDB
	temp_cx:dw 16
	att_home_cal:dw 0x00
	row_col_home_cal:dw 0x01
	square_start:db 0x03
	start_str:db 'Let',0x27,
			   db's start the game!!'
			   start_str_size:dw 22
		



;///////////////////////////////////////////////////////////////////////
;///////////////////////////////////////////////////////////////////////
;///////////////////////////////////////////////////////////////////////
;///////////////////////////////////////////////////////////////////////
;///////////////////////////////////////////////////////////////////////
;///////////////////////////////////////////////////////////////////////
;///////////////////////////////////////////////////////////////////////
;///////////////////////////////////////////////////////////////////////
;///////////////////////////////////////////////////////////////////////
;///////////////////////////////////////////////////////////////////////
 delay_timer:
 mov cx, 8  ; You can adjust this value to control the delay length
loopcxt:
    mov dx, 0xFFFF
loop_agt:
    sub dx, 1
    jnz loop_agt
    loop loopcxt
    ret
;///////////////////////////////////////////////////////////////////////
printnumtt: push bp 
 mov bp, sp 
 push es 
 push ax 
 push bx 
 push cx 
 push dx 
 push di 
 mov ax, 0xb800 
 mov es, ax ; point es to video base 
 mov ax, [bp+4] ; load number in ax 
 mov bx, 10 ; use base 10 for division 
 mov cx, 0 ; initialize count of digits 
nextdigittt: mov dx, 0 ; zero upper half of dividend 
 div bx ; divide by 10 
 add dl, 0x30 ; convert digit into ascii value 
 push dx ; save ascii value on stack 
 inc cx ; increment count of values 
 cmp ax, 0 ; is the quotient zero 
 jnz nextdigittt ; if no divide it again 
 mov di, 140 ; point di to 70th column 
nextpostt: pop dx ; remove a digit from the stack 
 mov dh, 0x07 ; use normal attribute 
 mov [es:di], dx ; print char on screen 
 add di, 2 ; move to next screen location 
 loop nextpostt ; repeat for all digits on stack 
 pop di 
 pop dx 
 pop cx 
 pop bx 
 pop ax
 pop es 
 pop bp 
 ret 2 
; timer interrupt service routine 
; timertt: push ax 
 ; inc word [cs:tickcount]; increment tick count 
  ; cmp word[cs:tickcount],60
 ; jne timerttjmp
; mov word[cs:tickcount],0
; timerttjmp: push word [cs:tickcount] 
 ; call printnumtt ; print tick count 
 ; call delay_timer
 ; mov al, 0x20 
 ; out 0x20, al ; end of interrupt 
 ; pop ax 
 ; iret

;///////////////////////////////////////////////////////////////////////
;///////////////////////////////////////////////////////////////////////
;///////////////////////////////////////////////////////////////////////
;///////////////////////////////////////////////////////////////////////
;///////////////////////////////////////////////////////////////////////
;///////////////////////////////////////////////////////////////////////
;///////////////////////////////////////////////////////////////////////
;///////////////////////////////////////////////////////////////////////
;///////////////////////////////////////////////////////////////////////
;///////////////////////////////////////////////////////////////////////

printstr1:     push bp 
              mov  bp, sp 
              push es 
              push ax 
              push cx 
              push si 
              push di 
 
              mov  ax, 0xb800 
              mov  es, ax             ; point es to video base 
              mov  di, bx              ; point di to top left column 
              mov  si, [bp+6]         ; point si to string 
              mov  cx, [bp+4]         ; load length of string in cx 
              mov  ah, 0x44          ; normal attribute fixed in al 
 
nextchar1:     mov  al, [si]           ; load next char of string 
              mov  [es:di], ax        ; show this char on screen 
              add  di, 2              ; move to next screen location 
              add  si, 1              ; move to next char in string 
              loop nextchar1          ; repeat the operation cx times 
 
              pop  di 
              pop  si 
              pop  cx 
              pop  ax 
              pop  es 
              pop  bp 
              ret  4
;///////////////////////////////////////////////////////////////////////
;///////////////////////////////////////////////////////////////////////

printlastscore:
	push es
		push ax
		push di
	 mov bl,14	
	print_start_square_loop1: mov ax, 0xb800
		 mov es, ax 		
		 mov al, 80 
		 mul bl	
		 add ax,50	
		 shl ax, 1 			
		 mov di,ax			
		 mov al, 0x03	
		 mov cx, 30 	
		 mov ah,0x9F
		sqs_again1:  	          ; load next char of string
		 mov [es:di], ax 			; show this char on screen
		 sub di, 2  				; move to next char in string
		 loop sqs_again1
		dec bl	 
		 cmp bl,6
		 jne print_start_square_loop1 
		 mov bl,12	
		 
	print_start_square_loop21: mov ax, 0xb800
		 mov es, ax 		
		 mov al, 80 
		 mul bl	
		 add ax,50	
		 shl ax, 1 			
		 mov di,ax			
		 mov al, 0xB0	
		 mov cx, 30 	
		 mov ah,0x11
		sqs_again21:  	; load next char of string
		 mov [es:di], ax 			; show this char on screen
		 sub di, 2  				; move to next char in string
		 loop sqs_again21
		dec bl	 
		 cmp bl,8
		 jne print_start_square_loop21
	 mov ah, 0x13 ; service 13 - print string 
	 mov al, 1 ; subservice 01 – update cursor 
	 mov bh, 0 ; output on page 0 
	 mov bl,0x1F; normal attrib 
	 mov dx, 0x0A18 ; row 10 column 3 
	 mov cx, [lastscorestrlen] ; length of string 
	 push cs 
	 pop es ; segment of string 
	 mov bp, lastscorestr ; offset of string 
	 int 0x10 ; call BIOS video service 
	 
	  mov ah, 0x13 ; service 13 - print string 
	 mov al, 1 ; subservice 01 – update cursor 
	 mov bh, 0 ; output on page 0 
	 mov bl,0x1F; normal attrib 
	 mov dx, 0x0A29 ; row 10 column 3 
	 mov cx, [Score_cal_len] ; length of string 
	 push cs 
	 pop es ; segment of string 
	 mov bp, Score_cal ; offset of string 
	 int 0x10 ; call BIOS video service 
	 
		  pop di
		pop ax
		pop es
		ret
;///////////////////////////////////////////////////////////////////////
;///////////////////////////////////////////////////////////////////////
;///////////////////////////////////////////////////////////////////////
transition11: push es
push ax
push di
mov ax, 0xb800
mov es, ax ; point es to video base
mov di, 0 ; point di to top left column
nextloc11: mov word [es:di], 0x01B0; clear next char on screen
call last_transitionition_delay11
add di, 2 ; move to next screen location
cmp di, 4000 ; has the whole screen cleared
jne nextloc11 ; if no clear next position
pop di
pop ax
pop es
ret

end_game:

call transition11
call printlastscore
ret


;///////////////////////////////////////////////////////////////////////
last_transitionition_delay11:
push cx
mov cx, 0x0FFF
last_transitionition_delay_loop111:
loop last_transitionition_delay_loop111
pop cx
ret


;///////////////////////////////////////////////////////////////////////
	
last_print:
 push es 
 push ax 
 push cx 
 push si 
 push di 
 call generate_random_location
 mov ax, 0xb800 
 mov es, ax ; point es to video base 
 mov al, 80 ; load al with columns per row 
 mul byte [ypos_last] ; multiply with y position 
 add ax, [xpos_last] ; add x position 
 shl ax, 1 ; turn into byte offset 
 mov di,ax ; point di to required location 
 mov si, slider_component ; point si to string 
 mov cx, [slider_component_len] ; load length of string in cx 
 mov ah, byte[attribute_last_dots] ; load attribute in ah 
nextchar: mov al, [si] ; load next char of string 
 mov [es:di], ax ; show this char on screen 
 add di, 2 
 add si, 1 ; move to next char in string 
 loop nextchar ; repeat the operation cx times 
 pop di 
 pop si 
 pop cx 
 pop ax 
 pop es
 ret 
 
 generate_random_location:
	add al,2
	add dl,30
	mov word[ypos_last],0;y pos
	mov byte[ypos_last],al
	mov word[xpos_last],0;x pos
	mov byte[xpos_last],dl
    ret 
	
	
last_print_blocks_loop:
last_print_blocks_loop2:
add word[lastp_block_count],20
 
last_print_l_again:
call last_print 
 mov ax,[lastp_block_count]
 sub ax,1
 mov word[lastp_block_count],ax
 cmp ax, 1
 jne last_print_l_again
 sub byte[attribute_last_dots],0x01
 jnz last_print_blocks_loop2
  ret





	
;/////////////////////////////////////////////////////////////////////////////	

;/////////////////////////////////////////////////////////////////////////////	

delay_slider:
    mov cx, 3  
loopcx:
    mov dx, 0xFFFF
loop_ag:
    sub dx, 1
    jnz loop_ag
    loop loopcx
    ret

 clrscr_homepage_slider_Screen1: push es 
 push ax 
 push cx 
 push di 
 mov ax, 0xb800 
 mov es, ax ; point es to video base 
 xor di, di ; point di to top left column 
 mov ax, 0x4420 ; space char in normal attribute 
 mov cx, 960 ; number of screen locations 
 cld ; auto increment mode 
 rep stosw ; clear the whole screen 
 mov ax, 0x7720 ; space char in normal attribute 
 mov cx, 1100 ; number of screen locations 
 cld ; auto increment mode 
 rep stosw ; clear the whole screen 
 pop di 
pop cx 
 pop ax 
 pop es 
 ret 

callforslide_home:
call clrscr_homepage_slider_Screen1
  push es
push ax
push di
mov ax, 0xb800
mov es, ax ; point es to video base
mov di, 0 ; point di to top left column
nextloc111: mov word [es:di], 0x00B0; clear next char on screen
call last_transitionition_delay11
add di, 2 ; move to next screen location
cmp di, 4000 ; has the whole screen cleared
jne nextloc111 ; if no clear next position
pop di
pop ax
pop es
ret

 



delay_homepage:
  mov cx, 1  ; You can adjust this value to control the delay length
loopcxd:
    mov dx, 0x5FFF
loop_agd:
    sub dx, 1
    jnz loop_agd
    loop loopcxd
    ret

clrscr_homepage: push es 
	 push ax 
	 push cx 
	 push di 
	 mov ax, 0xb800 
	 mov es, ax ; point es to video base 
	 xor di, di ; point di to top left column 
	 mov ax, 0x00DB ; space char in normal attribute 
	 mov cx, 2000 ; number of screen locations 
	 cld ; auto increment mode 
	 rep stosw ; clear the whole screen 
	 pop di
	  pop cx 
	 pop ax 
	 pop es 
	 ret 

 
 
 homepage_blocks_display:
 call clrscr_homepage
 oddjmp_home: sub word[temp_cx],1
  add word[att_home_cal],0x01
  add word[row_col_home_cal],0x0026
 call clrscr_homepage
 jmp tempjmphom
 evenjmp_home:sub word[temp_cx],1
  add word[att_home_cal],0x01
  sub word[row_col_home_cal],0x0010
 
tempjmphom:
 mov ah, 0x13 ; service 13 - print string 
 mov al, 1 ; subservice 01 – update cursor 
 mov bh, 0 ; output on page 0 
 mov bl, byte[att_home_cal]; normal attrib 
 mov dx, word[row_col_home_cal] ; row 10 column 3 
 mov cx, 20 ; length of string 
 push cs 
 pop es ; segment of string 
 mov bp, Ishape_home ; offset of string 
 int 0x10 ; call BIOS video service 
 call delay_homepage
	mov si,25
loopprid1:	
call delay_homepage
	dec si
    mov ah, 0x07       ; service 6 - scroll up
    mov al,1       ; number of lines to scroll
    mov bh, 0       ; attribute for the new lines
    mov ch, 0       ; starting row
    mov cl, 0       ; starting column
    mov dh, 24      ; ending row (24 is the last row on a 25-line screen)
    mov dl, 79      ; ending column (79 is the last column on an 80-column screen)
    int 0x10        ; call BIOS video service
	cmp si,0
	jne loopprid1
	cmp word[att_home_cal],0x0A
	je exit_homepage_blocks_display
	mov ax, [temp_cx]  ; Load the number into ax
	test ax, 1  ; Test the least significant bit
	jz evenjmp_home
	jne oddjmp_home
	; cmp word[temp_cx],0
	; jne homepage_blocks_display
 exit_homepage_blocks_display:
	ret
	
print_start_square:
	push es
		push ax
		push di
	 mov bl,14	
	print_start_square_loop: mov ax, 0xb800
		 mov es, ax 		
		 mov al, 80 
		 mul bl	
		 add ax,50	
		 shl ax, 1 			
		 mov di,ax			
		 mov al, 0x03	
		 mov cx, 30 	
		 mov ah,0x84
		sqs_again:  	; load next char of string
		 mov [es:di], ax 			; show this char on screen
		 sub di, 2  				; move to next char in string
		 loop sqs_again
		dec bl	 
		 cmp bl,6
		 jne print_start_square_loop 
		 mov bl,12	
	print_start_square_loop2: mov ax, 0xb800
		 mov es, ax 		
		 mov al, 80 
		 mul bl	
		 add ax,50	
		 shl ax, 1 			
		 mov di,ax			
		 mov al, 0xDB	
		 mov cx, 30 	
		 mov ah,0x00
		sqs_again2:  	; load next char of string
		 mov [es:di], ax 			; show this char on screen
		 sub di, 2  				; move to next char in string
		 loop sqs_again2
		dec bl	 
		 cmp bl,8
		 jne print_start_square_loop2
	 mov ah, 0x13 ; service 13 - print string 
	 mov al, 1 ; subservice 01 – update cursor 
	 mov bh, 0 ; output on page 0 
	 mov bl,0x0F; normal attrib 
	 mov dx, 0x0A18 ; row 10 column 3 
	 mov cx, [start_str_size] ; length of string 
	 push cs 
	 pop es ; segment of string 
	 mov bp, start_str ; offset of string 
	 int 0x10 ; call BIOS video service 
		  pop di
		pop ax
		pop es
		ret
		
	

;/////////////////////////////////////////////////////////////////////////////	
;/////////////////////////////////////////////////////////////////////////////	
;/////////////////////////////////////////////////////////////////////////////	
	delay:
	mov cx,0xFFFF
	mov bx,0
	delay_loop:
	add bx,1
	loop delay_loop
	mov cx,0xFFFF
	mov bx,0
	delay_loop2:
	add bx,1
	loop delay_loop2
	delay_loop3:
	add bx,1
	loop delay_loop3
	ret
;/////////////////////////////////////////////////////////////////////////////
	clrscr_right:
	push es
		push ax
		push di
	 mov bl,22	
	clear_loop_right_below: mov ax, 0xb800
		 mov es, ax 		
		 mov al, 80 
		 mul bl	
		 add ax,68	
		 shl ax, 1 			
		 mov di,ax			
		 mov al, 0xDB	
		 mov cx, 15 	
		 mov ah,0x10
		upl_again:  	; load next char of string
		 mov [es:di], ax 			; show this char on screen
		 sub di, 2  				; move to next char in string
		 loop upl_again
		dec bl	 
		 cmp bl,16
		 jne clear_loop_right_below
		  pop di
		pop ax
		pop es
		ret
		
	
	

;/////////////////////////////////////////////////////////////////////////////	
clrscr_right_above:
push es
    push ax
    push di
 mov bl,7	
clear_loop_right_above: mov ax, 0xb800
	 mov es, ax 		
	 mov al, 80 
	 mul bl	
	 add ax,69 	
	 shl ax, 1 			
	 mov di,ax			
	 mov al, 0xDB	
	 mov cx, 16 	
	 mov ah,0x00
	upr_again:  	; load next char of string
	 mov [es:di], ax 			; show this char on screen
	 sub di, 2  				; move to next char in string
	 loop upr_again
	dec bl	 
	 cmp bl,2
	 jne clear_loop_right_above
	  pop di
    pop ax
    pop es
    ret

;/////////////////////////////////////////////////////////////////////////////
clrscr: push es 
 push ax 
 push cx 
 push di 
 mov ax, 0xb800 
 mov es, ax ; point es to video base 
 xor di, di ; point di to top left column 
 mov ax, 0x04B2 ; space char in normal attribute 
 mov cx, 2000 ; number of screen locations 
 cld ; auto increment mode 
 rep stosw ; clear the whole screen 
 pop di
  pop cx 
 pop ax 
 pop es 
 ret 
;/////////////////////////////////////////////////////////////////////////////
	
	score_cal_print:
		cmp byte[Score_cal+2],0x39
		jne score_cal_print1
		mov byte[Score_cal+2],0x30
		
		add byte[Score_cal+1],1
		cmp byte[Score_cal+1],0x39
		jne score_cal_print2

		mov byte[Score_cal+1],0x30
		add byte[Score_cal],1
		cmp byte[Score_cal],0x39
		jne score_cal_print3
		score_cal_print1:add byte[Score_cal+2],1
		score_cal_print2:
		score_cal_print3:
		mov ax, 0xb800
		 mov es, ax
		 push es
		push ax
		push di
		mov bl,6
		 mov al, 80 
		 mul bl	
		 add ax,61 	
		 shl ax, 1
		 mov di,ax
		 mov si,Score_cal
		 mov cx,word[Score_cal_len]
		 mov ah,0x07
		 cld
		 next_score:
		 lodsb
		 stosw
		 loop next_score
		 pop di
		pop ax
		pop es
		ret	
		
		
	
	
	
	
	
;///////////////////////////////////////////////////////////////////////////// 
	Blockscreen:
		push es
		push ax
		push di
	 mov bl,23	
	clear_loop_left: 
		mov ax, 0xb800
		 mov es, ax 		
		 mov al, 80 
		 mul bl	
		 add ax,39 	
		 shl ax, 1 			
		 mov di,ax			
		 mov al, 0xDB	
		 mov cx, 34 	
		 mov ah,0x00
		leftsc_again:  	; load next char of string
		 mov [es:di], ax 			; show this char on screen
		 sub di, 2  				; move to next char in string
		 loop leftsc_again
		dec bl	 
		 cmp bl,1
		 jne clear_loop_left
		  pop di
		pop ax
		pop es
		ret
;/////////////////////////////////////////////////////////////////////	
score_print:
    push es
    push ax
    push di
    mov bl,4	
score_print_above: mov ax, 0xb800
	 mov es, ax 		
	 mov al, 80 
	 mul bl	
	 add ax,69 	
	 shl ax, 1 			
	 mov di,ax			
	 mov al, 0xDB	
	 mov cx, 16 	
	 mov ah,0x07
	Score_again:  	; load next char of string
	 mov [es:di], ax 			; show this char on screen
	 sub di, 2  				; move to next char in string
	 loop Score_again
	dec bl	 
	 cmp bl,2
	 jne score_print_above
	 mov bl,4
	 mov al, 80 
	 mul bl	
	 add ax,59 	
	 shl ax, 1
	 mov di,ax
	 mov si,Scorestr
	 mov cx,word[Sc_str_len]
	 mov ah,0x70
	 cld
	 next_score_ch:
	 lodsb
	 stosw
	 loop next_score_ch
	  pop di
    pop ax
    pop es
    ret
	
	
;/////////////////////////////////////////////////////////////////////////////	
			print_Block: 
		push bp 
	 mov bp, sp 
	 push es 
	 push ax 
	 push cx 
	 push si 
	 push di 
	 cmp dx,1
	 je check_square_shape1
	 cmp dx,2
	 je check_t_shape1
	 cmp dx,3
	 je check_ot_shape1
	 cmp dx,4
	 je check_l_shape1
	 cmp dx,5
	 je check_z_shape1
	 cmp dx,6
	 je check_U_shape1
	 jmp Block_exit
	 check_U_shape1:call check_U_shape
	 jmp Block_exit
	 check_z_shape1:call check_z_shape
	 jmp Block_exit
	 check_l_shape1:call check_l_shape
	 jmp Block_exit
	 check_ot_shape1:call check_ot_shape
	 jmp Block_exit
	 check_t_shape1: call check_t_shape
	 jmp Block_exit
	 check_square_shape1:
	call check_square_shape
	jmp Block_exit
	 Block_exit:pop di 
	 pop si 
	 pop cx 
	 pop ax 
	 pop es 
	 pop bp 
	 ret 
	 
	 
	;//////////////////////////////////////////////////////////////////////// 

	 check_U_shape:mov ax, 0xb800 
	 mov es, ax ; point es to video base 
	 mov al, 80 ; load al with columns per row 
	 mul byte [ypos_mov] ; multiply with y position 
	 add ax, [xpos_mov] ; add x position 
	 shl ax, 1 ; turn into byte offset 
	 mov di,ax ; point di to required location 
	 mov si, U_shape ; point si to string 
	 mov cx, [U_shape_len] ; load length of string in cx 
	 mov ah, 0x0E 
	nextchar_h: 
	cmp byte[si],0x41
	jne check6
	mov bx,160+4
	sub bx,[U_shape_len]
	add di,bx
	add si,1
	check6:mov al, [si] 
	 mov [es:di], ax  
	 add di, 2 
	 add si, 1 
	 loop nextchar_h 
	 ret
	 
	;//////////////////////////////////////////////////////////////////////// 

	  check_z_shape:mov ax, 0xb800 
	 mov es, ax ; point es to video base 
	 mov al, 80 ; load al with columns per row 
	 mul byte [ypos_mov] ; multiply with y position 
	 add ax,  [xpos_mov] ; add x position 
	 shl ax, 1 ; turn into byte offset 
	 mov di,ax ; point di to required location 
	 mov si, z_shape ; point si to string 
	 mov cx, [z_shape_len] ; load length of string in cx 
	 mov ah, 0x55 
	nextchar_s: 
	cmp byte[si],0x41
	jne check5
	mov bx,160+4
	sub bx,[z_shape_len]
	add di,bx
	add si,1
	check5:mov al, [si] 
	 mov [es:di], ax  
	 add di, 2 
	 add si, 1 
	 loop nextchar_s ; repeat for the whole string
	 ret
	 
	;//////////////////////////////////////////////////////////////////////// 
	delay_last:

	mov cx, 1  ; You can adjust this value to control the delay length
	loopcxd2:
		mov dx, 0x0FFF
	loop_agd2:
		sub dx, 1
		jnz loop_agd2
		loop loopcxd2
		ret

	 ;//////////////////////////////////////////////////////////////////////// 

	 
	 
	 check_l_shape:mov ax, 0xb800 
	 mov es, ax ; point es to video base 
	 mov al, 80 ; load al with columns per row 
	 mul byte [ypos_mov] ; multiply with y position 
	 add ax, [xpos_mov]; add x position 
	 shl ax, 1 ; turn into byte offset 
	 mov di,ax ; point di to required location 
	 mov si, l_shape ; point si to string 
	 mov cx, [l_shape_len] ; load length of string in cx 
	 mov ah, 0x22 
	nextchar_j: 
	cmp byte[si],0x41
	jne check4
	mov bx,160+12
	;mov bx,160+4
	sub bx,[l_shape_len]
	sub di,bx
	;add di,bx
	add si,1
	check4:mov al, [si] 
	 mov [es:di], ax  
	 add di, 2 
	 add si, 1 
	 loop nextchar_j ; repeat for the whole string
	 ret
	 
	 
	;//////////////////////////////////////////////////////////////////////// 

	 
	 
	check_ot_shape:mov ax, 0xb800 
	 mov es, ax ; point es to video base 
	 mov al, 80 ; load al with columns per row 
	 mul byte [ypos_mov] ; multiply with y position 
	 add ax, [xpos_mov]; add x position 
	 shl ax, 1 ; turn into byte offset 
	 mov di,ax ; point di to required location 
	 mov si, ot_shape ; point si to string 
	 mov cx, [ot_shape_len] ; load length of string in cx 
	 mov ah, 0x33 
	nextchar_l: 
	cmp byte[si],0x41
	jne check3
	mov bx,160+18
	sub bx,[ot_shape_len]
	sub di,bx
	add si,1
	check3:mov al, [si] 
	 mov [es:di], ax  
	 add di, 2 
	 add si, 1 
	 loop nextchar_l ; repeat for the whole string
	 ret
	 
	 
	;//////////////////////////////////////////////////////////////////////// 

	 
	 check_t_shape:mov ax, 0xb800 
	 mov es, ax ; point es to video base 
	 mov al, 80 ; load al with columns per row 
	 mul byte [ypos_mov] ; multiply with y position 
	 add ax, [xpos_mov]; add x position 
	 shl ax, 1 ; turn into byte offset 
	 mov di,ax ; point di to required location 
	 mov si, t_shape ; point si to string 
	 mov cx, [t_shape_len] ; load length of string in cx 
	 mov ah, 0x66 
	nextchar_t: 
	cmp byte[si],0x41
	jne check2
	mov bx,160+20
	sub bx,[t_shape_len]
	sub di,bx
	add si,1
	check2:mov al, [si] 
	 mov [es:di], ax  
	 add di, 2 
	 add si, 1 
	 loop nextchar_t ; repeat for the whole string
	 ret
	;//////////////////////////////////////////////////////////////////////// 

	 
	  check_square_shape:mov ax, 0xb800 
	 mov es, ax ; point es to video base 
	 mov al, 80 ; load al with columns per row 
	 mul byte [ypos_mov] ; multiply with y position 
	 add ax, [xpos_mov]; add x position 
	 shl ax, 1 ; turn into byte offset 
	 mov di,ax ; point di to required location 
	 mov si, square_shape ; point si to string 
	 mov cx, [square_shape_len] ; load length of string in cx 
	 mov ah, 0x11 
	nextchar_square: 
	cmp byte[si],0x41
	jne check1
	mov bx,160+16
	sub bx,[square_shape_len]
	sub di,bx
	add si,1
	check1:mov al, [si] 
	 mov [es:di], ax  
	 add di, 2 
	 add si, 1 
	 loop nextchar_square ; repeat for the whole string 
	 ret
	 
;////////////////////////////////////////////////////////////////
Next_Shape_print:
    push es
    push ax
    push di
 mov bl,16	
Next_Shape_print1: mov ax, 0xb800
	 mov es, ax 		
	 mov al, 80 
	 mul bl	
	 add ax,68 	
	 shl ax, 1 			
	 mov di,ax			
	 mov al, 0xDB	
	 mov cx, 15 	
	 mov ah,0x77
	Shape_Again:  	; load next char of string
	 mov [es:di], ax 			; show this char on screen
	 sub di, 2  				; move to next char in string
	 loop Shape_Again
	dec bl	 
	 cmp bl,14
	 jne Next_Shape_print1
	 mov bl,16
	 mov al, 80 
	 mul bl	
	 add ax,58	
	 shl ax, 1
	 mov di,ax
	 mov si,Next_Shape
	 mov cx,word[Next_Shape_len]
	 mov ah,0x70
	 cld
	 next_Shape_ch:
	 lodsb
	 stosw
	 loop next_Shape_ch
	  pop di
    pop ax
    pop es
    ret 
;///////////////////////////////////////////////////////////////////
	gameover_print:
push es
    push ax
    push di
 mov bl,14	
print_over_square_loop: mov ax, 0xb800
	 mov es, ax 		
	 mov al, 80 
	 mul bl	
	 add ax,37	
	 shl ax, 1 			
	 mov di,ax			
	 mov al, 0x03	
	 mov cx, 30 	
	 mov ah,0x84
	sqo_again:  	; load next char of string
	 mov [es:di], ax 			; show this char on screen
	 sub di, 2  				; move to next char in string
	 loop sqo_again
	dec bl	 
	 cmp bl,6
	 jne print_over_square_loop 
	 mov bl,12	
print_over_square_loop2: mov ax, 0xb800
	 mov es, ax 		
	 mov al, 80 
	 mul bl	
	 add ax,37	
	 shl ax, 1 			
	 mov di,ax			
	 mov al, 0xDB	
	 mov cx, 30 	
	 mov ah,0x00
	sqo_again2:  	; load next char of string
	 mov [es:di], ax 			; show this char on screen
	 sub di, 2  				; move to next char in string
	 loop sqo_again2
	dec bl	 
	 cmp bl,8
	 jne print_over_square_loop2
 mov ah, 0x13 ; service 13 - print string 
 mov al, 1 ; subservice 01 – update cursor 
 mov bh, 0 ; output on page 0 
 mov bl,0x0F; normal attrib 
 mov dx, 0x0A10 ; row 10 column 3 
 mov cx, [Gameover_Str_len] ; length of string 
 push cs 
 pop es ; segment of string 
 mov bp, Gameover_Str ; offset of string 
 int 0x10 ; call BIOS video service 
	  pop di
    pop ax
    pop es
    ret
		
;///////////////////////////////////////////////////////////////////	

;///////////////////////////////////////////////////////////////////	
	delay_clearline:
	push cx
	  mov cx, 1  ; You can adjust this value to control the delay length
	loopcxd11:
		mov dx, 0xFFFF
	loop_agd11:
		sub dx, 1
		jnz loop_agd11
		loop loopcxd11
		pop cx
		ret
;///////////////////////////////////////////////////////////////////	
;///////////////////////////////////////////////////////////////////	
;///////////////////////////////////////////////////////////////////	
;///////////////////////////////////////////////////////////////////	
delay_movement:
  mov cx, [delay_timer_size]  ; You can adjust this value to control the delay length
loopcxd1:
    mov dx, 0xFFFF
loop_agd1:
    sub dx, 1
    jnz loop_agd1
    loop loopcxd1
    ret
;///////////////////////////////////////////////////////////////////	
;///////////////////////////////////////////////////////////////////	
block_remove:
	
	push bp 
	 mov bp, sp 
	 push es 
	 push ax 
	 push cx 
	 push si 
	 push di 
	 cmp dx,1
	 je check_square_shape22
	 cmp dx,2
	 je check_t_shape22
	 cmp dx,3
	 je check_ot_shape22
	 cmp dx,4
	 je check_l_shape22
	 cmp dx,5
	 je check_z_shape22
	 cmp dx,6
	 je check_U_shape22
	 jmp Block_exit2
	 check_U_shape22:call check_U_shape2
	 jmp Block_exit2
	 check_z_shape22:call check_z_shape2
	 jmp Block_exit2
	 check_l_shape22:call check_l_shape2
	 jmp Block_exit2
	 check_ot_shape22:call check_ot_shape2
	 jmp Block_exit2
	 check_t_shape22: call check_t_shape2
	 jmp Block_exit2
	 check_square_shape22:
	call check_square_shape2
	
	jmp Block_exit2
	 Block_exit2:pop di 
	 pop si 
	 pop cx 
	 pop ax 
	 pop es 
	 pop bp 
	 ret 
	 
	 
	;//////////////////////////////////////////////////////////////////////// 

	 check_U_shape2:mov ax, 0xb800 
	 mov es, ax ; point es to video base 
	 mov al, 80 ; load al with columns per row 
	 mul byte [ypos_mov] ; multiply with y position 
	 add ax, [xpos_mov] ; add x position 
	 shl ax, 1 ; turn into byte offset 
	 mov di,ax ; point di to required location 
	 mov si, U_shape ; point si to string 
	 mov cx, [U_shape_len] ; load length of string in cx 
	 mov ah, 0x00 
	nextchar_h2: 
	cmp byte[si],0x41
	jne check62
	mov bx,160+4
	sub bx,[U_shape_len]
	add di,bx
	add si,1
	check62:mov al,0xDB
	 mov [es:di], ax  
	 add di, 2 
	 add si, 1 
	 loop nextchar_h2 ; repeat for the whole string
	 ret
	 
	;//////////////////////////////////////////////////////////////////////// 

	  check_z_shape2:mov ax, 0xb800 
	 mov es, ax ; point es to video base 
	 mov al, 80 ; load al with columns per row 
	 mul byte [ypos_mov] ; multiply with y position 
	 add ax,  [xpos_mov] ; add x position 
	 shl ax, 1 ; turn into byte offset 
	 mov di,ax ; point di to required location 
	 mov si, z_shape ; point si to string 
	 mov cx, [z_shape_len] ; load length of string in cx 
	 mov ah, 0x00
	nextchar_s2: 
	cmp byte[si],0x41
	jne check52
	mov bx,160+4
	sub bx,[z_shape_len]
	add di,bx
	add si,1
	check52:mov al, 0xDB 
	 mov [es:di], ax  
	 add di, 2 
	 add si, 1 
	 loop nextchar_s2 ; repeat for the whole string
	 ret
	 
	
	 ;//////////////////////////////////////////////////////////////////////// 

	 
	 
	 check_l_shape2:
	 mov ax, 0xb800 
	 mov es, ax ; point es to video base 
	 mov al, 80 ; load al with columns per row 
	 mul byte [ypos_mov] ; multiply with y position 
	 add ax, [xpos_mov]; add x position 
	 shl ax, 1 ; turn into byte offset 
	 mov di,ax ; point di to required location 
	 mov si, l_shape ; point si to string 
	 mov cx, [l_shape_len] ; load length of string in cx 
	 mov ah, 0x00
	nextchar_j2: 
	cmp byte[si],0x41
	jne check42
	;mov bx,160+4
	mov bx,160+12
	sub bx,[l_shape_len]
	sub di,bx
	;add di,bx
	add si,1
	check42:mov al, 0xDB
	 mov [es:di], ax  
	 add di, 2 
	 add si, 1 
	 loop nextchar_j2 ; repeat for the whole string
	 ret
	 
	 
	;//////////////////////////////////////////////////////////////////////// 

	 
	 
	check_ot_shape2:mov ax, 0xb800 
	 mov es, ax ; point es to video base 
	 mov al, 80 ; load al with columns per row 
	 mul byte [ypos_mov] ; multiply with y position 
	 add ax, [xpos_mov]; add x position 
	 shl ax, 1 ; turn into byte offset 
	 mov di,ax ; point di to required location 
	 mov si, ot_shape ; point si to string 
	 mov cx, [ot_shape_len] ; load length of string in cx 
	 mov ah, 0x00
	nextchar_l2: 
	cmp byte[si],0x41
	jne check32
	mov bx,160+18
	sub bx,[ot_shape_len]
	sub di,bx
	add si,1
	check32:mov al, 0xDB
	 mov [es:di], ax  
	 add di, 2 
	 add si, 1 
	 loop nextchar_l2 ; repeat for the whole string
	 ret
	 
	 
	;//////////////////////////////////////////////////////////////////////// 

	 
	 check_t_shape2:mov ax, 0xb800 
	 mov es, ax ; point es to video base 
	 mov al, 80 ; load al with columns per row 
	 mul byte [ypos_mov] ; multiply with y position 
	 add ax, [xpos_mov]; add x position 
	 shl ax, 1 ; turn into byte offset 
	 mov di,ax ; point di to required location 
	 mov si, t_shape ; point si to string 
	 mov cx, [t_shape_len] ; load length of string in cx 
	 mov ah, 0x00 
	nextchar_t2: 
	cmp byte[si],0x41
	jne check22
	mov bx,160+20
	sub bx,[t_shape_len]
	sub di,bx
	add si,1
	check22:mov al, 0xDB 
	 mov [es:di], ax  
	 add di, 2 
	 add si, 1 
	 loop nextchar_t2 ; repeat for the whole string
	 ret
	;//////////////////////////////////////////////////////////////////////// 

	 
	  check_square_shape2:mov ax, 0xb800 
	 mov es, ax ; point es to video base 
	 mov al, 80 ; load al with columns per row 
	 mul byte [ypos_mov] ; multiply with y position 
	 add ax, [xpos_mov]; add x position 
	 shl ax, 1 ; turn into byte offset 
	 mov di,ax ; point di to required location 
	 mov si, square_shape ; point si to string 
	 mov cx, [square_shape_len] ; load length of string in cx 
	 mov ah, 0x00 
	nextchar_square2: 
	cmp byte[si],0x41
	jne check12
	mov bx,160+16
	sub bx,[square_shape_len]
	sub di,bx
	add si,1
	check12:mov al, 0xDB
	 mov [es:di], ax  
	 add di, 2 
	 add si, 1 
	 loop nextchar_square2 ; repeat for the whole string 
	 ret
	 
;///////////////////////////////////////////////////////////////////	
;///////////////////////////////////////////////////////////////////	
	touch_roof:
	mov ax, 0xb800 
	 mov es, ax ; point es to video base 
	 mov al, 80 ; load al with columns per row 
	 mov bl,2
	 mul bl  ; multiply with y position 
	 add ax, 6 ; add x position 
	 shl ax, 1 ; turn into byte offset 
	 mov di,ax ; point di to required location
	 mov ah,0x00
	 xor si,si
	 loop_touch_roof_next:
	 mov al,0xDB
	 cmp word[es:di],0x00DB
	 je l_nextindex_touch_roof
	   call gameover_print
	   call delay_movement
	   call delay_movement
	   call delay_movement
	   call delay_movement
	   call delay_movement
	   call last_print_blocks_loop
	    call end_game
	  call endl
	 l_nextindex_touch_roof:
	 add di,2
	 add si,1
	 cmp si,34
	 jne loop_touch_roof_next
	 ret
	
	
	;/////////////////////////////////////////////////////////////////////////////	
	;/////////////////////////////////////////////////////////////////////////////	
	checkwhatshapewidht:
	cmp word[shape_num],1
	je checkwhatshapewidht1
	cmp word[shape_num],2
	je checkwhatshapewidht2
	cmp word[shape_num],3
	je checkwhatshapewidht3
	cmp word[shape_num],4
	je checkwhatshapewidht4
	checkwhatshapewidht1:
	mov word[mov_widht],0
	sub word[mov_widht],1
	jmp exitcheckwhatshapewidht
	checkwhatshapewidht2:
	mov word[mov_widht],2
		jmp exitcheckwhatshapewidht
	checkwhatshapewidht3:
	mov word[mov_widht],0
	jmp exitcheckwhatshapewidht
	checkwhatshapewidht4:
	mov word[mov_widht],1
	exitcheckwhatshapewidht:
	ret
	;/////////////////////////////////////////////////////////////////////////////	
	;/////////////////////////////////////////////////////////////////////////////	
	;/////////////////////////////////////////////////////////////////////////////	
	keystrokeformovement: 
	push bx
			push ax 
		 push es 
		 mov ax, 0xb800 
		 mov es, ax ; point es to video memory 
		 in al, 0x60 ; read a char from keyboard port 
		 cmp al, 0x4B ; is the key left arrow 
		 jne nextcmpR ; no, try next comparison 
		mov dx,[shape_num]
		call block_remove
		
		cmp word[xpos_mov],6
		je loopkey1
		sub word[xpos_mov],1 
		mov ax,0xb800
		mov es,ax
	 mov al, 80 
	 mul byte[ypos_mov] 
	 add ax, [xpos_mov] 
	 shl ax, 1 
	 mov di,ax 
	 cmp word[es:di],0x00DB
	 je loopkey
	 add word[xpos_mov],1 
		jmp loopkey
		loopkey1:mov word[xpos_mov],6
		loopkey:jmp nomatchch ; leave interrupt routine 
	nextcmpR: cmp al, 0x4D ; is the key right arrow 
		 jne nextcmpU ; no, leave interrupt routine 
		 mov dx,[shape_num]
		call block_remove
		call checkwhatshapewidht
		mov bx,35
		sub bx,word[mov_widht]
		cmp word[xpos_mov],bx
		je loopkey2
		add word[xpos_mov],1
		mov ax,0xb800
		mov es,ax
	 mov al, 80 
	 mul byte[ypos_mov] 
	 add ax, [xpos_mov] 
	 shl ax, 1 
	 mov di,ax 
	 cmp word[es:di],0x00DB
	 jne ctempcheck
		jmp nomatchch
	ctempcheck:
	 sub word[xpos_mov],1
jmp nomatchch	 
loopkey2:mov word[xpos_mov],bx
jmp nomatchch 		
nextcmpU: cmp al,0x48
jne nextcmpD
call changeshapesU
nextcmpD:
cmp al,0x50;down arrow
jne nextcmpPLUS
mov word[flagfortimer],0
mov word[delay_timer_size],1
jmp nomatchch	
nextcmpPLUS:
cmp al,0x4E; numpad plus
jne nextcmpS
add byte[minutes],1
add byte[timestr],0x01
cmp byte[minutes],6
je stopgame
nextcmpS:
cmp al,0x12 ; E key
je stopgame
nextcmpAddscore:
cmp al,0x1F ;S key
jne nextcmpPkey
cmp byte[Score_cal+2],0x39
		jne score_cal_print11
		mov byte[Score_cal+2],0x30
		add byte[Score_cal+1],1
		cmp byte[Score_cal+1],0x39
		jne nomatchch
		mov byte[Score_cal+1],0x30
		add byte[Score_cal],1
		cmp byte[Score_cal],0x39
		jne nomatchch
		score_cal_print11:add byte[Score_cal+2],1
		jmp nomatchch
nextcmpPkey:
cmp al,0x19; P key
jne nextcmpRkey
mov word[check_Pkey],0
jmp nomatchch
nextcmpRkey:
cmp al,0x13; R key
jne nomatchch
mov word[check_Pkey],1
jmp nomatchch
nomatchch:		
mov al,0x20
 out 0x20, al 
		 pop es 
		 pop ax 
		 pop bx
		 iret
	
	;/////////////////////////////////////////////////////////////////////////////	
	;/////////////////////////////////////////////////////////////////////////////	
	;/////////////////////////////////////////////////////////////////////////////	
	clock:
	push dx
	push di
	push ax
	push es
	 mov ax, 0xb800 
	 mov es, ax ; point es to video base 
	 mov al, 80 ; load al with columns per row 
	 mov bl,1
	 mul  bl ; multiply with y position 
	 add ax, 68 ; add x position 
	 shl ax, 1 ; turn into byte offset 
	 mov di,ax ; point di to required location
	 mov si,timestr ; point si to string 
 mov cx, [timestr_length] ; load length of string in cx 
 mov ah, 0x07 
 cld 
nextchartimestr: lodsb 
 stosw 
 loop nextchartimestr 
 cmp word[flagfortimer],1
 jne exitclock
	cmp byte[nanoseconds],1
	je changesec
	add byte[nanoseconds],1
	jmp exitclock
	changesec:
	mov byte[nanoseconds],0
	cmp byte[second],60
	je changemin
	add byte[second],1
	cmp byte[timestr+5],0x39
	jae change_sec_L
	add byte[timestr+5],0x01
	jmp exitclock
	
	change_sec_L:
	mov byte[timestr+5],0x30
	add byte[timestr+4],0x01
	jmp exitclock
	changemin:
	mov byte[second],0
	mov byte[timestr+5],0x30
	mov byte[timestr+4],0x30
	add byte[minutes],1
	cmp byte[minutes],5
	je stopgame
	add byte[minutes],0x30
	mov ax,[minutes]
	mov [timestr],ax
	sub byte[minutes],0x30
	jmp exitclock
	stopgame: 
	add byte[minutes],1
	add byte[minutes],0x30
	mov al,[minutes]
	mov byte[timestr],al
	sub byte[minutes],0x30
	mov byte[timestr+5],0x30
	mov byte[timestr+4],0x30
	 call gameover_print
	
	   call delay_movement
	   call delay_movement
	   call delay_movement
	   call last_print_blocks_loop
	   call end_game
	  call endl
	exitclock:
	pop es
	pop ax
	pop di
	pop dx
	ret
	;/////////////////////////////////////////////////////////////////////////////	
	;/////////////////////////////////////////////////////////////////////////////	
	changeshapesU:
	mov dx,[shape_num]
	call block_remove
	cmp word[shape_num],4
	jae checkUequal1
	add word[shape_num],1
	mov dx,[shape_num]
	call print_Block
	call block_remove
	jmp exitchangeshape
	checkUequal1:
	mov dx,[shape_num]
	call block_remove
	mov word[shape_num],1
	mov dx,[shape_num]
	call print_Block
	call block_remove
	call print_Block
	exitchangeshape:
	
	ret
	;/////////////////////////////////////////////////////////////////////////////
	
	
	;/////////////////////////////////////////////////////////////////////////////	
		check_block_line:
	
	mov ax, 0xb800 
	 mov es, ax ; point es to video base 
	 mov al, 80 ; load al with columns per row 
	 mul byte[ypos_blockline]  ; multiply with y position 
	 add ax, [xpos_blockline] ; add x position 
	 shl ax, 1 ; turn into byte offset 
	 mov di,ax ; point di to required location
	xor si,si
	 ;call delay_clearline
	 loop_block_line_next:
	; call delay_clearline
	
	 sub di,2
	 l_nextindex_blockline:
	 add di,2
	 cmp word[es:di],0x00DB
	 je endblocklinecheck
	 add si,1
	 cmp si,34
	 jne l_nextindex_blockline
	 mov ax, 0xb800 
	 mov es, ax ; point es to video base 
	 mov al, 80 ; load al with columns per row 
	 mul byte[ypos_blockline]  ; multiply with y position 
	 add ax, [xpos_blockline] ; add x position 
	 shl ax, 1 ; turn into byte offset 
	 mov di,ax ; point di to required location
	 
	 mov cx,34
	 loop_to_clear_line:
	  
	 mov word[es:di],0x00DB
	 add di,2
	 call delay_clearline
	 loop loop_to_clear_line
	 ; call scrolldown
	 call delay_movement
	 call delay_movement
	 call delay_movement
	 call delay_movement
	push si
	push di
	 push ax
	 push bx
	 push cx
	 push dx
	   mov ah, 7h         ; Scroll text downward function
    mov al, 1h         ; Number of window lines to scroll downward by 1
    mov bh, 0x00           ; Color attribute (0 for default)
    mov ch, 3           ; Upper left corner of the window (row)
    mov cl, 6           ; Upper left corner of the window (column)
    mov dh,[ypos_blockline]          ; Lower right corner of the window (row)
    mov dl, 37          ; Lower right corner of the window (column)
    int 0x10             ; BIOS video services interrupt
	call score_cal_print
	pop dx
    pop cx
    pop bx
    pop ax
    pop di
    pop si
	sub byte[ypos_blockline],1	
	endblocklinecheck:

	ret
	
	
	;/////////////////////////////////////////////////////////////////////////////	
	;/////////////////////////////////////////////////////////////////////////////	
	check_side_walls:
	sub byte[ypos_blockline],1
	
	
check_side_walls1:	
	mov ax, 0xb800 
	 mov es, ax ; point es to video base 
	 mov al, 80 ; load al with columns per row 
	 mul byte[ypos_blockline]  ; multiply with y position 
	 add ax, [xpos_blockline] ; add x position 
	 shl ax, 1 ; turn into byte offset 
	 mov di,ax ; point di to required location
	 
	 loop_side_walls_next:
	 cmp word[es:di],0x00DB
	 jne l_nextindex_side_walls
	 mov word[xpos_blockline],6
	 cmp byte[ypos_blockline],2
	 jne check_side_walls
	 jmp endside_wallscheck
 l_nextindex_side_walls:
 
		; mov bx,[es:di]
		; push bx
		 call check_block_line
		 ;call delay_clearline
		; pop bx
		; mov word[es:di],bx
		
		 cmp byte[ypos_blockline],2
		 jne check_side_walls
		endside_wallscheck: 
		mov byte[ypos_blockline],23
		 mov word[xpos_blockline],6
		ret
	;/////////////////////////////////////////////////////////////////////////////	
	;/////////////////////////////////////////////////////////////////////////////	
	;/////////////////////////////////////////////////////////////////////////////	
	
	;/////////////////////////////////////////////////////////////////////////////	
	;/////////////////////////////////////////////////////////////////////////////	
	;/////////////////////////////////////////////////////////////////////////////	
checkblockmovxpos:
push bx
mov bx,[xpos_mov]
push bx
cmp word[shape_num],1
	je checkwhatshapewidht11
	cmp word[shape_num],2
	je checkwhatshapewidht21
	cmp word[shape_num],3
	je checkwhatshapewidht31
	cmp word[shape_num],4
	je checkwhatshapewidht41
	checkwhatshapewidht11:
	add word[xpos_mov],3
	jmp exitcheckwhatshapewidht1
	checkwhatshapewidht21:
		add word[xpos_mov],6
		jmp exitcheckwhatshapewidht1
	checkwhatshapewidht31:
		add word[xpos_mov],4
	jmp exitcheckwhatshapewidht1
	checkwhatshapewidht41:
		add word[xpos_mov],5
exitcheckwhatshapewidht1:
		mov ax, 0xb800 
	 mov es, ax 
	 mov al, 80 
	 mul byte[ypos_mov]
	 add ax, [xpos_mov] 
	 shl ax, 1 
	 sub word[xpos_mov],4
	 mov di,ax	
	 pop bx
	 mov word[xpos_mov],bx
	 pop bx
	 ret
;///////////////////////////////////////////////////////////////////	
;///////////////////////////////////////////////////////////////////	
delay11: 
    mov dword[count], 60000
looping_delay11:
	dec dword[count]
	cmp dword[count], 0
	jne looping_delay11
    ret
;///////////////////////////////////////////////////////////////////	
;///////////////////////////////////////////////////////////////////	
;///////////////////////////////////////////////////////////////////	
;///////////////////////////////////////////////////////////////////	

 music:push si
    push dx
    push ax
    push cx
    push bx

    mov si, 0

    next_note:
        mov dx, 0x388
        mov al, [si + music_data]
        out dx, al

        mov dx, 0x389
        mov al, [si + music_data + 1]
        out dx, al

        mov bx, [si + music_data + 2]

        add si, 4

        mov ah, 2Ch ; Get system time
        int 21h     ; CH = hour, CL = minute, DH = second, DL = hundredth second

        add dl, bl ; Add delay to current time

        delay111:
            mov ah, 2Ch
            int 21h
            cmp dl, bl ; Compare current time with target time
            jb delay111

        cmp si, [music_length]
        jb next_note

    pop bx
    pop cx
    pop ax
    pop dx
    pop si

    ret
	;/////////////////////////////////////////////////////////////////////////////
	;/////////////////////////////////////////////////////////////////////////////
	;/////////////////////////////////////////////////////////////////////////////	
	;/////////////////////////////////////////////////////////////////////////////	
	;/////////////////////////////////////////////////////////////////////////////	
	;/////////////////////////////////////////////////////////////////////////////	
	;/////////////////////////////////////////////////////////////////////////////	
	;/////////////////////////////////////////////////////////////////////////////	
	;/////////////////////////////////////////////////////////////////////////////	
	;/////////////////////////////////////////////////////////////////////////////	
	 beep_setup:
  push es
  push ax

  xor ax, ax
  mov es, ax

  ;Save the original ISR
  mov ax, WORD [es: TIMER_INT * 4]
  mov WORD [cs:original_timer_isr], ax
  mov ax, WORD [es: TIMER_INT * 4 + 2]
  mov WORD [cs:original_timer_isr + 2], ax

  ;Setup the new ISR

  cli
  mov ax, beep_isr
  mov WORD [es: TIMER_INT * 4], ax
  mov ax, cs
  mov WORD [es: TIMER_INT * 4 + 2], ax
  sti

  pop ax
  pop es
  ret 


;--------------> TEAR DOWN THE BEEP ISR
 beep_teardown:
  push es
  push ax

  call beep_stop

  xor ax, ax
  mov es, ax

  ;Restore the old ISR

  cli
  mov ax, WORD [cs:original_timer_isr]
  mov WORD [es: TIMER_INT * 4], ax
  mov ax, WORD [cs:original_timer_isr + 2]
  mov WORD [es: TIMER_INT * 4 + 2], ax
  sti

  pop ax
  pop es
  ret 


;--------------> BEEP ISR
 beep_isr:
  cmp BYTE [cs:sound_playing], 0
  je _bi_end

  cmp WORD [cs:sound_counter], 0
  je _bi_stop

  dec WORD [cs:sound_counter]

 jmp _bi_end

_bi_stop:
  call beep_stop

_bi_end:
  ;Chain
  jmp FAR [cs:original_timer_isr]
 ;Stop beep
 ;
 beep_stop:
  push ax

  ;Stop the sound

  in al, 61h
  and al, 0fch    ;Clear bit 0 (PIT to speaker) and bit 1 (Speaker enable)
  out 61h, al

  ;Disable countdown

  mov BYTE [cs:sound_playing], 0

  pop ax
  ret


 ;Beep
 ;AX = 1193180 / frequency
 ;BX = duration in 18.2th of sec
 beep_play:
  push ax
  push dx

  mov dx, ax

  mov al, 0b6h
  out 43h, al

  mov ax, dx
  out 42h, al
  mov al, ah
  out 42h, al


  ;Set the countdown
  mov WORD [cs:sound_counter], bx

  ;Start the sound

  in al, 61h
  or al, 3h    ;Set bit 0 (PIT to speaker) and bit 1 (Speaker enable)
  out 61h, al


  ;Start the countdown

  mov BYTE [cs:sound_playing], 1

  pop dx
  pop ax
  ret

 ;Keep these in the code segment
 sound_playing      db  0
 sound_counter      dw  0
 original_timer_isr     dd  0

 TIMER_INT      EQU     1ch
	;/////////////////////////////////////////////////////////////////////////////	
	;/////////////////////////////////////////////////////////////////////////////	
	;/////////////////////////////////////////////////////////////////////////////	
	;/////////////////////////////////////////////////////////////////////////////	
	;/////////////////////////////////////////////////////////////////////////////	
	;/////////////////////////////////////////////////////////////////////////////	
	
		
	

check_ch_by_ch_block:
push bx
mov bx,[xpos_mov]
push bx
cmp word[shape_num],1
	je checkwhatshapewidht111
	cmp word[shape_num],2
	je checkwhatshapewidht211
	cmp word[shape_num],3
	je checkwhatshapewidht311
	cmp word[shape_num],4
	je checkwhatshapewidht411
	checkwhatshapewidht111:
	add word[xpos_mov],2
	jmp exitcheckwhatshapewidht11
	checkwhatshapewidht211:
		add word[xpos_mov],5
		jmp exitcheckwhatshapewidht11
	checkwhatshapewidht311:
		add word[xpos_mov],3
	jmp exitcheckwhatshapewidht11
	checkwhatshapewidht411:
		add word[xpos_mov],4
exitcheckwhatshapewidht11:
		mov ax, 0xb800 
	 mov es, ax 
	 mov al, 80 
	 mul byte[ypos_mov]
	 add ax, [xpos_mov] 
	 shl ax, 1 
	 mov di,ax	
	 pop bx
	 mov word[xpos_mov],bx
	 pop bx
	 ret
	

check_ch_by_ch_block2:
push bx
mov bx,[xpos_mov]
push bx
cmp word[shape_num],1
	je checkwhatshapewidht1112
	cmp word[shape_num],2
	je checkwhatshapewidht2112
	cmp word[shape_num],3
	je checkwhatshapewidht3112
	cmp word[shape_num],4
	je checkwhatshapewidht4112
	checkwhatshapewidht1112:
	add word[xpos_mov],1
	jmp exitcheckwhatshapewidht112
	checkwhatshapewidht2112:
		add word[xpos_mov],4
		jmp exitcheckwhatshapewidht112
	checkwhatshapewidht3112:
		add word[xpos_mov],2
	jmp exitcheckwhatshapewidht112
	checkwhatshapewidht4112:
		add word[xpos_mov],2
exitcheckwhatshapewidht112:
		mov ax, 0xb800 
	 mov es, ax 
	 mov al, 80 
	 mul byte[ypos_mov]
	 add ax, [xpos_mov] 
	 shl ax, 1 
	 mov di,ax	
	 pop bx
	 mov word[xpos_mov],bx
	 pop bx
	 ret


;///////////////////////////////////////////////////////////////////	
;///////////////////////////////////////////////////////////////////	
;///////////////////////////////////////////////////////////////////	
block_movment:
	push ax 
push bx 
	call beep_setup ;Setup
;produces beep when eat food
mov ax, 4000	; beep frequency
mov bx, 4	;time for beep
call beep_play
call delay11
call beep_teardown  ;Tear down
pop bx
pop ax
mov word[delay_timer_size],12
mov word[flagfortimer],1

	block_movment1:
 pauseup:
cmp word[check_Pkey],0
je pauselast
	 call clock
		xor ax, ax 
 mov es, ax ; point es to IVT base 
 cli ; disable interrupts 
 mov word [es:9*4], keystrokeformovement ; store offset at n*4 
 mov [es:9*4+2], cs ; store segment at n*4+2 
 sti
	call delay_movement
	call print_Block
	    mov dx,[shape_num]
		call block_remove
		mov ax,[ypos_mov_index]
	 add word[ypos_mov],ax
	 mov ax, 0xb800 
	 mov es, ax 
	 mov al, 80 
	 mul byte[ypos_mov] 
	 add ax, [xpos_mov] 
	 shl ax, 1 
	 mov di,ax 
	 cmp word[es:di],0x00DB
	 jne exitmov 
	 call checkblockmovxpos
     add di,1	 
     sub di,1	 
	 cmp word[es:di],0x00DB
	 jne exitmov 
	 call check_ch_by_ch_block
	  add di,1	 
     sub di,1	 
	 cmp word[es:di],0x00DB
	 jne exitmov 
	 call check_ch_by_ch_block2
	  add di,1	 
     sub di,1	 
	 cmp word[es:di],0x00DB
	 jne exitmov 
	  mov dx,[shape_num]
	  call print_Block
	  jmp block_movment1

	
exitmov:
 sub word[ypos_mov],1	   
mov dx,[shape_num]
	  call print_Block
	  call check_side_walls1
	  call touch_roof
	  pauselast:
	  cmp word[check_Pkey],0
	je pauseup 
	 ret

	
	;/////////////////////////////////////////////////////////////////////////////
	;/////////////////////////////////////////////////////////////////////////////
	
	      
RANDSTART:

   MOV AH, 00h  ; interrupts to get system time        
   INT 1AH      ; CX:DX now hold number of clock ticks since midnight      

   mov  ax, dx
   xor  dx, dx
   mov  cx, 4    
   div  cx       ; here dx contains the remainder of the division - from 0 to 3

   add  dl, '1'  ; to adjust the range from 1 to 4
sub dx,0x30
		 mov word[shape_num],dx
	 call clrscr_right
	 push ax
	 mov word[ypos_mov],20
	  mov word[xpos_mov],58
	  pop ax
	 
	  call print_Block
 MOV AH, 00h  ; interrupts to get system time        
   INT 1AH      ; CX:DX now hold number of clock ticks since midnight
   mov  ax, dx
   xor  dx, dx
   mov  cx, 23   
   div  cx       
   add  dx, 6    
		mov word[xpos_mov], dx
	 mov word[ypos_mov], 3 
	call block_movment
   jmp RANDSTART
RET
;/////////////////////////////////////////////////////////////////////////////////////////////////////
;/////////////////////////////////////////////////////////////////////////////////////////////////////
;/////////////////////////////////////////////////////////////////////////////////////////////////////
;//////////////////////////////////////////////////////////////////////////////////////////////////

	
	
	start:
	
	
	
	 ; mov si, 0

    ; ; Create background process for music playback
    ; mov bx, music_data
; call music
call clrscr 
  call homepage_blocks_display
  
     call callforslide_home
	call print_start_square
	
	 mov ah,0
	 int 0x16
     call callforslide_home	
	 call clrscr 
	call clrscr_right
	call clrscr_right_above
	call Blockscreen
	call score_print
	call score_cal_print
	call Next_Shape_print
	;call RANDSTART
	; xor ax, ax 
 ; mov es, ax ; point es to IVT base 
 ; cli ; disable interrupts 
 ; mov word [es:8*4], timertt; store offset at n*4 
 ; mov [es:8*4+2], cs ; store segment at n*4+2 
 ; sti ; enable interrupts 
 ; mov dx, start ; end of resident portion 
 ; add dx, 15 ; round up to next para 
 ; mov cl, 4 
 ; shr dx, cl 
 
	mov word[delay_timer_size],1
	
		mov dx,1
		 mov word[shape_num],dx
		mov word[xpos_mov], 18
	 mov word[ypos_mov], 14
	 call block_movment
		mov dx,1
		 mov word[shape_num],dx
		mov word[xpos_mov], 22
	 mov word[ypos_mov], 14 
	 call block_movment
		mov dx,1
		 mov word[shape_num],dx
		mov word[xpos_mov], 26
	 mov word[ypos_mov], 14
	 call block_movment
	 mov dx,1
		 mov word[shape_num],dx
		mov word[xpos_mov], 10
	 mov word[ypos_mov], 14 
	 call block_movment
	 mov dx,1
		 mov word[shape_num],dx
		mov word[xpos_mov], 6
	 mov word[ypos_mov], 14 
	 call block_movment
		
		mov dx,1
		 mov word[shape_num],dx
		mov word[xpos_mov], 14
	 mov word[ypos_mov], 14
	 call block_movment
		mov dx,3
		 mov word[shape_num],dx
		mov word[xpos_mov], 30
	 mov word[ypos_mov], 14
	 call block_movment
		mov dx,3
		 mov word[shape_num],dx
		mov word[xpos_mov], 35
	 mov word[ypos_mov], 14
	 call block_movment
	 ;mov word[ypos_mov_index],3
			mov dx,1
		 mov word[shape_num],dx
		mov word[xpos_mov], 6
	 mov word[ypos_mov], 14 
	 call block_movment
	 		mov dx,1
		 mov word[shape_num],dx
		mov word[xpos_mov], 14
	 mov word[ypos_mov], 14
	 call block_movment

		mov dx,1
		 mov word[shape_num],dx
		mov word[xpos_mov], 10
	 mov word[ypos_mov], 14 
	 call block_movment
	 
		mov dx,3
		 mov word[shape_num],dx
		mov word[xpos_mov], 30
	 mov word[ypos_mov], 14
	 call block_movment
		mov dx,3
		 mov word[shape_num],dx
		mov word[xpos_mov], 35
	 mov word[ypos_mov], 14
	 call block_movment
		mov dx,1
		 mov word[shape_num],dx
		mov word[xpos_mov], 18
	 mov word[ypos_mov], 14
	 call block_movment
		mov dx,1
		 mov word[shape_num],dx
		mov word[xpos_mov], 22
	 mov word[ypos_mov], 14 
	 call block_movment
		mov dx,1
		 mov word[shape_num],dx
		mov word[xpos_mov], 26
	 mov word[ypos_mov], 14
	 call block_movment
	 mov word[ypos_mov_index],4
	mov dx,1
		 mov word[shape_num],dx
		mov word[xpos_mov], 6
	 mov word[ypos_mov], 14 
	 call block_movment
		mov dx,1
		 mov word[shape_num],dx
		mov word[xpos_mov], 10
	 mov word[ypos_mov], 14 
	 call block_movment
		mov dx,1
		 mov word[shape_num],dx
		mov word[xpos_mov], 14
	 mov word[ypos_mov], 14
	 call block_movment
		mov dx,1
		 mov word[shape_num],dx
		mov word[xpos_mov], 18
	 mov word[ypos_mov], 14
	 call block_movment
		mov dx,1
		 mov word[shape_num],dx
		mov word[xpos_mov], 22
	 mov word[ypos_mov], 14 
	 call block_movment
		mov dx,1
		 mov word[shape_num],dx
		mov word[xpos_mov], 26
	 mov word[ypos_mov], 14
	 call block_movment
		mov dx,1
		 mov word[shape_num],dx
		mov word[xpos_mov], 30
	 mov word[ypos_mov], 14
	 call block_movment
		mov dx,4
		 mov word[shape_num],dx
		mov word[xpos_mov], 34
	 mov word[ypos_mov], 14
	 call block_movment
	call gameover_print
	 call block_movment
	   call end_game
	  call endl
		
endl:		 mov ax, 0x4c00
		 int 0x21


