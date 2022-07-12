include 'emu8086.inc'

clrscr macro                       	; to clear the screen
	mov ah, 00h
	mov al, 02h
	int 10h
endm

.data
    	cr equ 0dh
    	lf equ 0ah
   	    
    	
    	N db 0
    	proe db 0
    	sign db 0
    	opcode db ?
    	chose db ?
    	
    	rowcarry db 0
    	rescarry db 0
    	
    	a4 db 0
    	a3 db 0
    	a2 db 0
    	a1 db 0
    	
    	b4 db 0
    	b3 db 0
    	b2 db 0
    	b1 db 0
    	
    	a4b4 db 0
    	a3b4 db 0
    	a2b4 db 0
    	a1b4 db 0
    	out1 db 0
    	
    	a4b3 db 0
    	a3b3 db 0
    	a2b3 db 0
    	a1b3 db 0
    	out2 db 0
    	
    	a4b2 db 0
    	a3b2 db 0
    	a2b2 db 0
    	a1b2 db 0
    	out3 db 0
    	
    	a4b1 db 0
    	a3b1 db 0
    	a2b1 db 0
    	a1b1 db 0
    	out4 db 0
    	
    	
    	res1 db 0
    	res2 db 0
    	res3 db 0
    	res4 db 0
    	res5 db 0
    	res6 db 0
    	res7 db 0
    	res8 db 0 
    	
    	num1  dw ?
    	num2  dw ?
    	ex  dw ?
    	result  dw ?
    	rem  dw ?
	sum db 5 dup('$')
    	
    	
endm

.code 
assume ds: @data, cs: @code	; initialize ds and cs to segments

start:
   
   clrscr

   print "Enter The Mode of Operation : "
   
   mov ah,1
   int 21h
   
   mov opcode,al
   
   cmp opcode,'+'
   je doingAdd   
             
   cmp opcode,'-'
   je doingSub
   
   cmp opcode,'*'
   je doingMul
   
   cmp opcode,'/'
   je doingDiv 
   
   printn ""
   print "wrong choice !!" 
   jmp finishdoing
   


doingAdd:

printn ""    
    push ax
    push bx
    push cx
    push dx
    
    mov N,0
    
    print "Enter first number: "
    mov bl,10d
    mov cx,00
    mov dx,0
    mov bh,00
    read:
        
        mov ah,1
        int 21h
        cmp al,cr
        je readF
        
        sub al,'0'
        mov ah,00
        mov dx,ax
        mov ax,cx 
        
        
        cmp N,3
        jne h:
        mov ex,dx 
        mul bx
        add ax,ex
        jmp h1
        
    h:  mul bl
        add ax,dx
    h1: mov cx,ax        
     
        inc N
        cmp N,4
        jl read  
   
   
   readF:
    printn ""
    cmp N,1
    jne read2
        mov ax,cx
        div bl
        mov al,ah
        mov ah,00
    mov cx,ax
  
  
    
    
    read2:
        
        mov num1,cx
        
        print "Enter second number: "
        
        mov ax,0000h
        mov bx,0000h
        mov cx,0000h
        mov N,0d
        
        mov bl,10d
        
        reads:
        
        mov ah,1
        int 21h
        cmp al,cr
        je read2F
        
        sub al,'0'
        mov ah,00
        mov dx,ax
        mov ax,cx 
        
        
        cmp N,3
        jne h2:
        mov ex,dx 
        mul bx
        add ax,ex
        jmp h3
        
    h2:  mul bl
        add ax,dx
    h3: mov cx,ax        
     
        inc N
        cmp N,4
        jl reads  
   
   
   read2F:
    printn ""
    cmp N,1
    jne readOk
        mov ax,cx
        div bl
        mov al,ah
        mov ah,00
    mov cx,ax
    
   readOk:
        mov num2,cx
        mov ax,0000h
        mov bx,0000h
        mov cx,0000h
        mov N,0d
        
        mov ax,num1
        mov bx,num2
        
        add ax,bx
        
        mov result , ax
        
    printing:
    
    print "The result is : "        
    mov ax,result
    mov si, offset sum
    mov cx,si
    mov bl,10d
    mov bh,00
    
    cmp ax,1279d
    jle one
    jmp two
    one:
            h11:
                div bl
                mov [si],ah
                mov ah,00
                inc si
                inc N
                
                cmp al,10d
                jge h11
                mov [si],al
            p11:
                mov dl,[si]
                add dl,'0'
                mov ah,2
                int 21h
                
                dec si
                dec N
                cmp si,cx
                jge p11
                jmp finishxxx
    two:
            idiv bx
            mov [si],dl
            mov dx,00
            inc si
            inc N
            
            h22:
                div bl
                mov [si],ah
                mov ah,00
                inc si
                inc N
                
                cmp al,0h
                jne h22
                
            p22:
                mov dl,[si]
                add dl,'0'
                mov ah,2
                int 21h
                
                dec si
                dec N
                cmp N,0
                jge p22
finishxxx:                
        
        pop dx
        pop cx
        pop bx
        pop ax
         
jmp finishdoing


doingSub:
printn ""
    push ax
    push bx
    push cx
    push dx
    
    mov N,0
    mov sign,0
    mov proe,0
    
    print "Enter first number: "
    mov bl,10d
    mov cx,00
    mov dx,0
    mov bh,00
    subread:
        
        mov ah,1
        int 21h
        cmp al,cr
        je subreadF
        
        sub al,'0'
        mov ah,00
        mov dx,ax
        mov ax,cx 
        
        
        cmp N,3
        jne subh:
        mov ex,dx 
        mul bx
        add ax,ex
        jmp subh1
        
    subh:  mul bl
        add ax,dx
    subh1: mov cx,ax        
     
        inc N
        cmp N,4
        jl subread  
   
   
   subreadF:
    printn ""
    cmp N,1
    jne subread2
        mov ax,cx
        div bl
        mov al,ah
        mov ah,00
    mov cx,ax
  
  
    
    
    subread2:
        
        mov num1,cx
        
        print "Enter second number: "
        
        mov ax,0000h
        mov bx,0000h
        mov cx,0000h
        mov N,0d
        
        mov bl,10d
        
        subreads:
        
        mov ah,1
        int 21h
        cmp al,cr
        je subread2F
        
        sub al,'0'
        mov ah,00
        mov dx,ax
        mov ax,cx 
        
        
        cmp N,3
        jne subh2:
        mov ex,dx 
        mul bx
        add ax,ex
        jmp subh3
        
    subh2:  mul bl
        add ax,dx
    subh3: mov cx,ax        
     
        inc N
        cmp N,4
        jl subreads  
   
   
   subread2F:
    printn ""
    cmp N,1
    jne subreadOk
        mov ax,cx
        div bl
        mov al,ah
        mov ah,00
    mov cx,ax
    
   subreadOk:
        mov num2,cx
        mov ax,0000h
        mov bx,0000h
        mov cx,0000h
        mov N,0d
        
        mov ax,num1
        mov bx,num2
        
        cmp ax,bx
        jl subsmall
            
            sub ax,bx
            mov result,ax
            jmp subp1
            
        subsmall:
            xchg ax,bx
            sub ax,bx
            mov result,ax
            jmp subp2
             
        
    
    
    subprinting:
    
subp2: print "The result is : -"
    jmp subp3  
subp1: print "The result is : "        
subp3: mov ax,result
    mov si, offset sum
    mov cx,si
    mov bl,10d
    mov bh,00
    
    cmp ax,1279d
    jle subone
    jmp subtwo
    subone:
            subh11:
                div bl
                mov [si],ah
                mov ah,00
                inc si
                inc N
                
                cmp al,10d
                jge subh11
                mov [si],al
            subp11:
                mov dl,[si]
                add dl,'0'
                mov ah,2
                int 21h
                
                dec si
                dec N
                cmp si,cx
                jge subp11
                jmp finishxs
    subtwo:
            div bx
            mov [si],dl
            mov dx,00
            inc si
            inc N
            
            subh22:
                div bl
                mov [si],ah
                mov ah,00
                inc si
                inc N
                
                cmp al,0h
                jne subh22
                
            subp22:
                mov dl,[si]
                add dl,'0'
                mov ah,2
                int 21h
                
                dec si
                dec N
                cmp N,0
                jge subp22
finishxs:
                
       pop dx
        pop cx
        pop bx
        pop ax
         
jmp finishdoing

doingMul:
        mov rowcarry , 0
    	mov rescarry , 0
    	
    	mov a4 , 0
    	mov a3 , 0
    	mov a2 , 0
    	mov a1 , 0
    	
    	mov b4 , 0
    	mov b3 , 0
    	mov b2 , 0
    	mov b1 , 0
    	
    	mov a4b4 , 0
    	mov a3b4 , 0
    	mov a2b4 , 0
    	mov a1b4 , 0
    	mov out1 , 0
    	
    	mov a4b3 , 0
    	mov a3b3 , 0
    	mov a2b3 , 0
    	mov a1b3 , 0
    	mov out2 , 0
    	
    	mov a4b2 , 0
    	mov a3b2 , 0
    	mov a2b2 , 0
    	mov a1b2 , 0
    	mov out3 , 0
    	
    	mov a4b1 , 0
    	mov a3b1 , 0
    	mov a2b1 , 0
    	mov a1b1 , 0
    	mov out4 , 0
    	
    	
    	mov res1 , 0
    	mov res2 , 0
    	mov res3 , 0
    	mov res4 , 0
    	mov res5 , 0
    	mov res6 , 0
    	mov res7 , 0
    	mov res8 , 0 
printn ""
    push ax
    push bx
    push cx
    push dx
    
    mov N,0
    mov sign,0
    mov proe,0
    
    print "Enter first number : "
    
    mov ah,1
    int 21h
    cmp al,cr
    je reading2
    sub al,'0'
    mov a4,al
    
    
    mov ah,1
    int 21h
    cmp al,cr
    je reading2
    sub al,'0'
    mov a3,al
    
    mov bl,a4
    mov bh,a3
    xchg bl,bh
    mov a4,bl
    mov a3,bh
    
    
    mov ah,1
    int 21h
    cmp al,cr
    je reading2
    sub al,'0'
    mov a2,al
    
    mov bl,a2
    mov bh,a3
    xchg bl,bh
    mov a2,bl
    mov a3,bh
    
    mov bl,a4
    mov bh,a3
    xchg bl,bh
    mov a4,bl
    mov a3,bh
    
    
    
    mov ah,1
    int 21h
    cmp al,cr
    je reading2
    sub al,'0'
    mov a1,al
    
    mov bl,a1
    mov bh,a2
    xchg bl,bh
    mov a1,bl
    mov a2,bh
    
    mov bl,a2
    mov bh,a3
    xchg bl,bh
    mov a2,bl
    mov a3,bh
    
    mov bl,a4
    mov bh,a3
    xchg bl,bh
    mov a4,bl
    mov a3,bh
    
    

reading2:
    printn ""
    print "Enter second number : "
    
    mov ah,1
    int 21h
    cmp al,cr
    je reading2Finish
    sub al,'0'
    mov b4,al
    
    mov ah,1
    int 21h
    cmp al,cr
    je reading2Finish
    sub al,'0'
    mov b3,al
    
    mov bl,b4
    mov bh,b3
    xchg bl,bh
    mov b4,bl
    mov b3,bh
    
    
    mov ah,1
    int 21h
    cmp al,cr
    je reading2Finish
    sub al,'0'
    mov b2,al
    
    mov bl,b2
    mov bh,b3
    xchg bl,bh
    mov b2,bl
    mov b3,bh
    
    mov bl,b4
    mov bh,b3
    xchg bl,bh
    mov b4,bl
    mov b3,bh
    
    
    mov ah,1
    int 21h
    cmp al,cr
    je reading2Finish
    sub al,'0'
    mov b1,al
    
    mov bl,b1
    mov bh,b2
    xchg bl,bh
    mov b1,bl
    mov b2,bh
    
    mov bl,b2
    mov bh,b3
    xchg bl,bh
    mov b2,bl
    mov b3,bh
    
    mov bl,b4
    mov bh,b3
    xchg bl,bh
    mov b4,bl
    mov b3,bh
    
  
reading2Finish: 
    
    mov ax,0000h    
    mov al,a4
    mov bl,b4    
    mul bl
    mov cl,0Ah
    div cl   
    mov a4b4,ah
    mov rowcarry,al 
    
    mov ax,0000h    
    mov al,a3
    mov bl,b4    
    mul bl
    mov cl,0Ah
    div cl
    add ah,rowcarry   
    mov a3b4,ah
    mov rowcarry,al
    
    mov ax,0000h    
    mov al,a2
    mov bl,b4    
    mul bl
    mov cl,0Ah
    div cl
    add ah,rowcarry   
    mov a2b4,ah
    mov rowcarry,al
    
    mov ax,0000h    
    mov al,a1
    mov bl,b4    
    mul bl
    mov cl,0Ah
    div cl
    add ah,rowcarry   
    mov a1b4,ah
    mov out1,al
    mov rowcarry,0
    
    
    
    mov ax,0000h    
    mov al,a4
    mov bl,b3    
    mul bl
    mov cl,0Ah
    div cl   
    mov a4b3,ah
    mov rowcarry,al 
    
    mov ax,0000h    
    mov al,a3
    mov bl,b3    
    mul bl
    mov cl,0Ah
    div cl
    add ah,rowcarry   
    mov a3b3,ah
    mov rowcarry,al
    
    mov ax,0000h    
    mov al,a2
    mov bl,b3    
    mul bl
    mov cl,0Ah
    div cl
    add ah,rowcarry   
    mov a2b3,ah
    mov rowcarry,al
    
    mov ax,0000h    
    mov al,a1
    mov bl,b3    
    mul bl
    mov cl,0Ah
    div cl
    add ah,rowcarry   
    mov a1b3,ah
    mov out2,al
    mov rowcarry,0 
    
    
    mov ax,0000h    
    mov al,a4
    mov bl,b2    
    mul bl
    mov cl,0Ah
    div cl   
    mov a4b2,ah
    mov rowcarry,al 
    
    mov ax,0000h    
    mov al,a3
    mov bl,b2    
    mul bl
    mov cl,0Ah
    div cl
    add ah,rowcarry   
    mov a3b2,ah
    mov rowcarry,al
    
    mov ax,0000h    
    mov al,a2
    mov bl,b2    
    mul bl
    mov cl,0Ah
    div cl
    add ah,rowcarry   
    mov a2b2,ah
    mov rowcarry,al
    
    mov ax,0000h    
    mov al,a1
    mov bl,b2    
    mul bl
    mov cl,0Ah
    div cl
    add ah,rowcarry   
    mov a1b2,ah
    mov out3,al
    mov rowcarry,0
    
    
    
    mov ax,0000h    
    mov al,a4
    mov bl,b1    
    mul bl
    mov cl,0Ah
    div cl   
    mov a4b1,ah
    mov rowcarry,al 
    
    mov ax,0000h    
    mov al,a3
    mov bl,b1    
    mul bl
    mov cl,0Ah
    div cl
    add ah,rowcarry   
    mov a3b1,ah
    mov rowcarry,al
    
    mov ax,0000h    
    mov al,a2
    mov bl,b1    
    mul bl
    mov cl,0Ah
    div cl
    add ah,rowcarry   
    mov a2b1,ah
    mov rowcarry,al
    
    mov ax,0000h    
    mov al,a1
    mov bl,b1    
    mul bl
    mov cl,0Ah
    div cl
    add ah,rowcarry   
    mov a1b1,ah
    mov out4,al
    mov rowcarry,0
    
resultProduce:    
    
    mov ax,0000h
    mov bx,0000h
    
    mov al,a4b4
    mov bl,0ah
    div bl
    
    mov res1,ah
    mov rescarry,al
    
    
    mov ax,0000h
    mov bx,0000h
    
    
    mov al,a3b4
    mov ah,a4b3
    add al,ah
    add al,rescarry
    mov ah,00h
    mov bl,0ah
    div bl
    
    mov res2,ah
    mov rescarry,al
    
    
    mov ax,0000h
    mov bx,0000h
    mov cx,0000h
    mov dx,0000h
    
    mov al,a2b4
    mov ah,a3b3
    mov cl,a4b2
    add al,rescarry
    add al,ah
    add al,cl
    mov ah,00h
    mov cx,0000h
    mov bl,0ah
    div bl
    
    mov res3,ah
    mov rescarry,al 
    
    
    mov ax,0000h
    mov bx,0000h
    
    mov al,a1b4
    mov ah,a2b3
    mov cl,a3b2
    mov ch,a4b1
    add al,rescarry 
    add al,ah
    add al,cl
    add al,ch
    mov ah,00h
    mov cx,0000h
    
    mov bl,0ah
    div bl
    
    mov res4,ah
    mov rescarry,al
    
    
    mov ax,0000h
    mov bx,0000h
    
    mov al,out1
    mov ah,a1b3
    mov cl,a2b2
    mov ch,a3b1
    add al,rescarry 
    add al,ah
    add al,cl
    add al,ch
    mov ah,00h
    mov cx,0000h
    
    mov bl,0ah
    div bl
    
    mov res5,ah
    mov rescarry,al 
    
    
    
    mov ax,0000h
    mov bx,0000h
    
    mov al,out2
    mov ah,a1b2
    mov cl,a2b1
    add al,rescarry 
    add al,ah
    add al,cl
    mov ah,00h
    mov cx,0000h
    
    mov bl,0ah
    div bl
    
    mov res6,ah
    mov rescarry,al
    
    
    mov ax,0000h
    mov bx,0000h
    
    mov al,out3
    mov ah,a1b1
    add al,rescarry 
    add al,ah
    mov ah,00h
    
    mov bl,0ah
    div bl
    
    mov res7,ah
    mov rescarry,al
    
    
    mov ax,0000h
    mov bx,0000h
    
    mov al,out4
    add al,rescarry 
    mov ah,00h
    add al,ah
    
    mov bl,0ah
    div bl
    
    mov res8,ah
    mov rescarry,al
    
    
printingMul:
        
       printn ""
       print "The result is : "
         mov ah,2
         
         mov dl,res8
         add dl,'0'
         int 21h
                  
         mov dl,res7
         add dl,'0'
         int 21h
         
         mov dl,res6
         add dl,'0'
         int 21h
         
         mov dl,res5
         add dl,'0'
         int 21h
         
         mov dl,res4
         add dl,'0'
         int 21h
         
         mov dl,res3
         add dl,'0'
         int 21h
         
         mov dl,res2
         add dl,'0'
         int 21h
         
         mov dl,res1
         add dl,'0'
         int 21h

        pop dx
        pop cx
        pop bx
        pop ax
         
jmp finishdoing

doingDiv:
printn ""
    push ax
    push bx
    push cx
    push dx
    
    mov N,0
    mov sign,0
    mov proe,0

    print "Enter first number: "
    mov bl,10d
    mov cx,00
    mov dx,0
    mov bh,00
    divread:
        
        mov ah,1
        int 21h
        cmp al,cr
        je divreadF
        
        sub al,'0'
        mov ah,00
        mov dx,ax
        mov ax,cx 
        
        
        cmp N,3
        jne divh
        mov ex,dx 
        mul bx
        add ax,ex
        jmp divh1
        
    divh:  mul bl
        add ax,dx
    divh1: mov cx,ax        
     
        inc N
        cmp N,4
        jl divread  
   
   
   divreadF:
    printn ""
    cmp N,1
    jne divread2
        mov ax,cx
        div bl
        mov al,ah
        mov ah,00
    mov cx,ax
  
  
    
    
    divread2:
        
        mov num1,cx
        
        print "Enter second number: "
        
        mov ax,0000h
        mov bx,0000h
        mov cx,0000h
        mov N,0d
        
        mov bl,10d
        
        divreads:
        
        mov ah,1
        int 21h
        cmp al,cr
        je divread2F
        
        sub al,'0'
        mov ah,00
        mov dx,ax
        mov ax,cx 
        
        
        cmp N,3
        jne divh2:
        mov ex,dx 
        mul bx
        add ax,ex
        jmp divh3
        
    divh2:  mul bl
        add ax,dx
    divh3: mov cx,ax        
     
        inc N
        cmp N,4
        jl divreads  
   
   
   divread2F:
    printn ""
    cmp N,1
    jne divreadOk
        mov ax,cx
        div bl
        mov al,ah
        mov ah,00
    mov cx,ax
    
   divreadOk:
        mov num2,cx
        mov ax,0000h
        mov bx,0000h
        mov cx,0000h
        mov N,0d
        
        MOV AX,NUM1 
        MOV DX,NUM1+2
        CWD
        IDIV NUM2
        mov result,ax
        mov rem,dx
       
        
    divprinting:
    
    print "The result is : "        
    mov ax,result
    jmp divpro
divrema:
    printn ""
    print "The Remainder is : "        
    mov ax,rem
divpro:mov si, offset sum
    mov cx,si
    mov bl,10d
    mov bh,00
    
    cmp ax,1279d
    jle divone
    jmp divtwo
    divone:
            divh11:
                idiv bl
                mov [si],ah
                mov ah,00
                inc si
                inc N
                
                cmp al,10d
                jge divh11
                mov [si],al
            divp11:
                mov dl,[si]
                add dl,'0'
                mov ah,2
                int 21h
                
                dec si
                dec N
                cmp si,cx
                jge divp11
                jmp divexit
    divtwo:
            div bx
            mov [si],dl
            mov dx,00
            inc si
            inc N
            
            divh22:
                div bl
                mov [si],ah
                mov ah,00
                inc si
                inc N
                
                cmp al,0h
                jne divh22
                
            divp22:
                mov dl,[si]
                add dl,'0'
                mov ah,2
                int 21h
                
                dec si
                dec N
                cmp N,0
                jge divp22 
                
         
             
divexit:
         inc proe
         cmp proe,1
         je divrema 
       
       pop dx  
       pop cx
        pop bx
        pop ax
         
jmp finishdoing 



finishdoing:
     printn ""
     print "press any key "
     mov ah,1
     int 21h
     jmp start

endm
end start