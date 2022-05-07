#Raj
#2020CSB1116
#Notes and assumptions --->
#1 . E,S,D are capital and case sensetive please make sure the string must have only caps
#2. I have made sure that whenever Queue is empty ISA just skip that
#3** . Since I am assuming only the valid input string, please make sure that first character of string has to be one the {E,S,D}.
#4 for each new value that is to be queued I took 4 bytes since int requires 4 Bytes, So in case you want to check for queue in memory see like 0x10001000 ,0x10001004 and so on.
#5 if you want to check for your input string make sure it follows 1,2,3 and paste it in line 8.
.data
str1: .string "E1E2E-1E4DDSE5"


.text
la x11,str1
li x3,68 # D
li x4,69 # E
li x31,83 #S
li x5,0 #size
li x6,45 # '-' ASCII value
li x7,10
li x12,0x10001000 # queue address
li x20, 0x10005000 # stores size of queue whenever S comes
mv x13,x12

li x10,0 # final value
# li x25, 0 # sign
# li x18,10
# li x19,0
# li x23,0
lb x2,0(x11)
addi x11,x11,1

mainLoop:
beq x2,x0,mainLoopTerminate
bne x2,x4,checkForD
jal x1,readValue
sw x10,0(x12)
addi x12,x12,4 # since int is of 4 Bytes
addi x5,x5,1 #size++
beq x0 x0 mainLoop

checkForD:
beq x2,x31,size
beq x5,x0,doNothing # if Queue is empty
mv x14,x13
mv x18,x13
mv x15,x13
addi x14,x14,4
li x16,0
loopToShuffle: # to free the memory
beq x16,x5,breakLoop
lw x17,0(x14)
sw x17,0(x15)
addi x14,x14,4
addi x15,x15,4
addi x16,x16,1
beq x0 ,x0,loopToShuffle
breakLoop:
sw x0,0(x14)
mv x13,x18
addi x12,x12,-4 # making new rear address correct
addi x5,x5,-1 # size--

doNothing:
lb x2,0(x11)
addi x11,x11,1
beq x0,x0,mainLoop

size:
sw x5,0(x20)
lb x2,0(x11)
addi x11,x11,1
beq x0,x0,mainLoop

mainLoopTerminate:
beq x0,x0,exit


readValue: # helps to find value to be enqueued since we have to get int from string in which each digit is kinda taking a complete byte so this procedure call helps
li x8,0
li x9,0 #sign
lb x2,0(x11)
addi x11,x11,1
bne x2,x6,pos
li x9,1
loop2:
lb x2,0(x11)
addi x11,x11,1
beq x2,x0,exitLoop1
beq x2,x3,exitLoop1
beq x2,x4,exitLoop1
mul x8,x8,x7
add x8,x8,x2
addi x8,x8,-48
beq x0,x0,loop2

pos:
loop1:
beq x2,x0,exitLoop1 # checks has string ended?
beq x2,x3,exitLoop1 # next char of string is D
beq x2,x4,exitLoop1 # next char of string is E
mul x8,x8,x7
add x8,x8,x2
addi x8,x8,-48
lb x2,0(x11)
addi x11,x11,1
beq x0,x0,loop1

exitLoop1:
mv x10,x8
beq x9,x0,skipNeg
sub x10,x0,x10 #for neg number
skipNeg:
jalr x0,x1,0

exit:


