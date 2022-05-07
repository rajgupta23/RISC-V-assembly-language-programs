#Raj
#2020CSB1116
#Reading machine code and storing its various parts such as its opcode, source registers, destination register and immediate field etc for various types of instructions.
# values will be stored at 0x10001000 in memory.
#Notes and Assumption --->
#1. I also appended the 0 of imm[0] in case of beq instructions.
#2. You can check for any one of the given five type of instructions just paste the machine code in line 8 in place of 0x005180b3 (make sure to write 0x too)
#3. In case of there is no imm or rs2 etc, I assigned them as 0.
#3. Values will be stored as follow 
	# opcode at -> 0x10001000
    # rd -> 0x10001004
    # rs1 -> 0x10001008
    # rs2 -> 0x1000100C
    # imm -> 0x10001010
    # fun3 -> 0x10001014
    # fun7 -> 0x10001018
 
li x10,0x10001000 # address where final value to be stored
li x1,0x00F32083 #instruction
#x2->0-6
slli x2,x1,25
srli x2,x2,25
#x3 -> 7-11
srli x3,x1,7
slli x3,x3,27
srli x3,x3,27
#x4 -> 12-14
srli x4,x1,12
slli x4,x4,29
srli x4,x4,29
#x5 -> 15-19
srli x5,x1,15
slli x5,x5,27
srli x5,x5,27
#x6  20-24
srli x6,x1,20
slli x6,x6,27
srli x6,x6,27
#x7 25-31
srli x7,x1,25
slli x7,x7,24
srli x7,x7,24
#x8 20-31
srli x8,x1,20
slli x8,x8,20
srli x8,x8,20

sw x2,0(x10) # opcode
addi x10,x10,4
li x4,51
beq x2,x4,case1

li x4,19
beq x2,x4,case2

li x4,3
beq x2,x4,case3

li x4,35
beq x2,x4,case4

li x4,99
beq x2,x4,case5


case1: #add
#rd
sw x3,0(x10)
addi x10,x10,4
#rs1
sw x5,0(x10)
addi x10,x10,4
#rs2
sw x6,0(x10)
addi x10,x10,4
#imm
sw x0,0(x10)
addi x10,x10,4
#fun3
sw x4,0(x10)
addi x10,x10,4
#fun7
sw x7,0(x10)
addi x10,x10,4

beq x0,x0,exit
case2: #slti
#rd
sw x3,0(x10)
addi x10,x10,4
#rs1
sw x5,0(x10)
addi x10,x10,4
#rs2
sw x0,0(x10)
addi x10,x10,4
#imm
sw x8,0(x10)
addi x10,x10,4
#fun3
sw x4,0(x10)
addi x10,x10,4
#fun7
sw x0,0(x10)
addi x10,x10,4

beq x0,x0,exit
case3: #lw type
#rd
sw x3,0(x10)
addi x10,x10,4
#rs1
sw x5,0(x10)
addi x10,x10,4
#rs2
sw x0,0(x10)
addi x10,x10,4
#imm
sw x8,0(x10)
addi x10,x10,4
#fun3
sw x4,0(x10)
addi x10,x10,4
#fun7
sw x0,0(x10)
addi x10,x10,4

beq x0,x0,exit

case4: #sw 
#rd
sw x0,0(x10)
addi x10,x10,4
#rs1
sw x5,0(x10)
addi x10,x10,4
#rs2
sw x6,0(x10)
addi x10,x10,4
#imm
mv x9,x7
slli x9,x9,5 #for shift
add x9,x9,x3
sw x9,0(x10)
addi x10,x10,4

#fun3
sw x4,0(x10)
addi x10,x10,4
#fun7
sw x0,0(x10)
addi x10,x10,4

beq x0,x0,exit

case5:
#rd 
sw x0,0(x10)
addi x10,x10,4
#rs1 
sw x5,0(x10)
addi x10,x10,4
#rs2
sw x6,0(x10)
addi x10,x10,4
#imm
#imm[0:4]
srli x11,x1,8
slli x11,x11,28
srli x11,x11,28
slli x11,x11,1  #for imm[0]
#imm[5:10] 25-30
srli x12,x1,25
slli x12,x12,26
srli x12,x12,26
slli x12,x12,5 #for final value
#imm[11] 7
srli x13,x1,7
slli x13,x13,31
srli x13,x13,31
slli x13,x13,11
#imm[12]
srli x14,x1,31
slli x14,x14,31
srli x13,x14,31
slli x14,x14,12

li x15,0 #final imm value
add x15,x15,x11
add x15,x15,x12
add x15,x15,x13
add x15,x15,x14

#fun3
sw x4,0(x10)
addi x10,x10,4
#fun7
sw x0,0(x10)
addi x10,x10,4

exit:
