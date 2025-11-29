THIS IS THE IMPLEMENTATION OF RISC V PROCESSOR.

# Objectives
1. Implement forwarding unit
	- load followed by store. or vice versa(Elaboaration on pg 302, H&P)
	- an instruction with rs same as rd in the previous instruction when the previous instruction is load store.
	This is unlike the previous case because in the previous case, in such a case, the subsequent instruction 
	would take it's value from the EX_MEM register but in the case of load, the value can only be taken 
	from load

2. One case where the forwarding can't save the day is when we have load instruction storing value in a register and then we use 
that register s in the next instruction. Forwarding can't help becaue data is availble in the mem stage, stored in 
the mem_wb regiseter and  the next instruction requries value in the execute stage thus 
forwarding isn't useful because the arrow goes back in time. In this case, we must stall. 

For stall, we setup a hazard detection unit in the decode stage. It checks if the prev instruction was 
load using MemRead of the EX_MEM register and 
It sets a new signal PCWrite to 0 so that pc isn't updated while we stall. The signal 
IF/ID signal to zero so that this register is no longer written. 

Next, We also set the control signals for our current instruction (which is the one following the load)
to zero so that the stall for the current instruction stall through all the stage by one cycle 
In the next cycle, How does the unstall of the PC happens?

3. One more thing changed in this code is that we set the forwarded value from the WRITEBACK Stage as ResultW
instead of MEM_WB.alu_out. 
This is because if some instruction wants lw instruction to forward it's value when the lw is in it's writeback
stage then the instruction expects the value that would be written instead of the alu_out stored in mem_wb.

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








