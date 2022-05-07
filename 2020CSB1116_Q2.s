#Raj
#2020CSB1116
# Notes and assumption
# 1.Just paste the first array space saparated in arr1 and its size in n1, same goes for arr2 and n2.
# 2.Since final arr is of int (4Bytes) so when you look into the memory look as 0x10001000,0x10001004 ...
.data
arr1: .word 3 5
n1: .word 2
arr2: .word 1 3 4
n2: .word 3


.text
# Algorithm -> Two pointer. (GFG Link - https://www.geeksforgeeks.org/merge-two-sorted-arrays/)
la x11,arr1
la x12,arr2
lw x3,n1  # i=0
lw x4,n2  # j=0
li x5,0x10001000 # stores the initial address of the final merged array ie, 0x10001000
addi x8,x0,0
addi x9,x0,0


loop1:
beq x8,x3,exit1
beq x9,x4,exit1

lw x13,0(x11)
lw x14,0(x12)

bgt x13,x14,else1
sw x13,0(x5)
addi x5,x5,4
addi x11,x11,4
addi x8,x8,1
beq x0,x0,loop1

else1:
sw x14,0(x5)
addi x5,x5,4
addi x12,x12,4
addi x9,x9,1
beq x0,x0,loop1
exit1:

loop2:
beq x8,x3,exit2
lw x13,0(x11)
sw x13,0(x5)
addi x5,x5,4
addi x11,x11,4
addi x8,x8,1
beq x0,x0,loop2


exit2:

loop3:
beq x9,x4,exit3
lw x14,0(x12)
sw x14,0(x5)
addi x5,x5,4
addi x12,x12,4
addi x9,x9,1
beq x0,x0,loop3
exit3:

li x5,0x10001000 # giving x5 its initial value
