DSEG SEGMENT
  MSG DB "complete.", 0DH, 0AH, 24H
  X DW 2012H
  Y DW ?
DSEG ENDS

SSEG SEGMENT
SSEG ENDS

CSEG SEGMENT
  ASSUME DS:DSEG, SS:SSEG, CS:CSEG

  BEGIN:
    MOV AX, DSEG
    MOV DS, AX

    MOV AX, X
    ADD AX, 2311H
    MOV Y, AX

    MOV DX, OFFSET MSG
    MOV AH, 9
    INT 21H

    MOV AH, 4CH
    INT 21H
CSEG ENDS
END BEGIN
