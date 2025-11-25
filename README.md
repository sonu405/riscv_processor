THIS IS THE IMPLEMENTATION OF RISC V PROCESSOR.
Test Code:

addi x1, x0, 5        # x1 = 5  -- 93 00 50 00
addi x2, x0, 10       # x2 = 10 -- 13 01 A0 00
addi x19, x0, 100     # x19 = memory address base -- 93 09 40 06
addi x20, x0, 0       # spacing   -- 13 0A 00 00
addi x5, x1, 2                 -- 93 82 20 00
addi x4, x0, 0        # dummy spacing  -- 13 02 00 00
addi x3, x0, 0        # dummy spacing  -- 93 01 00 00
addi x21, x0, 0       # spacing  -- 93 0A 00 00
sw   x5, 0(x19)       # store x5  -- 23 A0 59 00
addi x21, x0, 0       # spacing  -- 93 0A 00 00
lw   x22, 0(x19)      # load back into x22 -- 03 AB 09 00
addi x23, x0, 0       # spacing   -- 93 0B 00 00
add  x23, x5, x5      #           -- B3 8B 52 00

# Instructions Tested
1. lw
2. sw
3. addi
4. add







