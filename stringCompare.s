#Raj
#2020CSB1116
#Two strings are stored at location 0x10001000 and 0x10002000 respectively. A function that compares these strings and places the total number of characters that are different at register x7
# Notes and Assumptions ----->
# 1. for checking your own test cases juts paste both the string in line 7 and 8 along with their size
# 2. Make sure both have same size (as given in question)
# 3. Make sure to enter size of string carefully (just enter the value of n in place of 12 for your own strings)

.data
str1: .string "heyhowareYou"
str2: .string "helloIareyou"
n: .word 12
.text
la x1,str1
la x2,str2
lw x3,n
li x11,0x10001000  # storing str1 at required address
li x12,0x10002000  # storing str2 at required address
li x4,0
li x7,0  # it will store the final answer


loop:
beq x4,x3,exit
lb x5,0(x1)
lb x6,0(x2)
sb x5,0(x11)
sb x6,0(x12)
addi x11,x11,1 # since char is of one byte
addi x12,x12,1 # ,,
addi x1,x1,1   # ,,
addi x2,x2,1   # ,,
addi x4,x4,1
li x9,32
li x10,97
li x13,122

blt x5,x6,next
# x5>=x6
beq x5,x6,loop # x5==x6
# x5>x6
sub x14,x5,x6
bne x14,x9,inc
blt x5,x10,inc
bgt x5,x13,inc
beq x0,x0,loop

inc:
addi x7,x7,1
beq x0,x0,loop

next:
#x6>x5
sub x14,x6,x5
bne x14,x9,inc
blt x6,x10,inc
bgt x6,x13,inc
beq x0,x0,loop

exit:
