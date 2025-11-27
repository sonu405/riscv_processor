THIS IS THE IMPLEMENTATION OF RISC V PROCESSOR.

# Objectives
1. Implement forwarding unit
	- load followed by store. or vice versa(Elaboaration on pg 302, H&P)
	- an instruction with rs same as rd in the previous instruction when the previous instruction is load store.
	This is unlike the previous case because in the previous case, in such a case, the subsequent instruction 
	would take it's value from the EX_MEM register but in the case of load, the value can only be taken 
	from load

Test Code:

addi x1, x0, 5        # x1 = 5  -- 93 00 50 00
addi x2, x0, 10       # x2 = 10 -- 13 01 A0 00
addi x19, x0, 100     # x19 = memory address base -- 93 09 40 06
addi x5, x1, 2                    -- 93 82 20 00
sw   x5, 0(x19)       # store x5  -- 23 A0 59 00
addi x21, x0, 0       # spacing  -- 93 0A 00 00
addi x21, x0, 0       # spacing  -- 93 0A 00 00
lw   x22, 0(x19)      # load back into x22 -- 03 AB 09 00

MAJOR PROBLEM IS DOUBLE DEPENDENCY OF SW ON BOTH forwarding from addi of x5 and x19 of addi before it.

# Instructions Tested
1. lw
2. sw
3. addi
4. add








