DSEG SEGMENT
  X DW 1234H
  Y DW 2345H
  Z DW -1234H
  MAX DW ?
DSEG ENDS

SSEG SEGMENT
  NUMS DW 12H DUP(?)
  STACK_TOP DW LENGTH NUMS
SSEG ENDS

CSEG SEGMENT
  ASSUME DS:DSEG, SS:SSEG, CS:CSEG
  BEGIN:
        MOV AX, DSEG      ; 初始化
        MOV DS, AX
        MOV AX, SSEG
        MOV SS, AX
        MOV AX, STACK_TOP
        MOV SP, AX

        MOV AX, Z         ; 倒序压栈
        PUSH AX
        MOV AX, Y
        PUSH AX
        MOV AX, X
        PUSH AX
        
        CALL FIND_MAX     ; 发生中断，改变栈顶
        MOV MAX, AX       ; AX 存入 DSEG:0008H
        
        MOV AH, 4CH       ; return
        INT 21H

  FIND_MAX PROC
        MOV BP, SP        ; 保护栈顶指针
        MOV AX, [BP + 2]  ; 栈顶被改变，偏移 2H
        CMP AX, [BP + 4]  ; 条件控制语句
        JGE BRANCH
        MOV AX, [BP + 4]
    BRANCH:
        CMP AX, [BP + 6]
        JGE DONE
        MOV AX, [BP + 6]
        PUSH AX
    DONE:                 ; 最大的数已经在 AX
        RET               ; return
  FIND_MAX ENDP
CSEG ENDS
END BEGIN