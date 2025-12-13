THIS IS THE IMPLEMENTATION OF RISC V PROCESSOR.


# NOTICE THE BUG
If we are at execute stage and we want to stall. We can surely but if in this stage, our id_ex data1 and data2 are 
the old ones and we are basing all our work on the forwarded data then the forwarded data will be written into the register
file in the subsequent cycles but since they the forwarded data values were never being latched therefore, we'd get
garbade values because we were first depending ourselves on the forwarded values and then we based our selves on
the id_ex register which was stopped from writing so that, it can write pause the state of the decode stage which 
holds the next instruction. 

One solution I can think of is to pause the following stages, MEMOERY and WRITEBACK as well so that the values 
to be forwarded at all times but this would mean, stopping the previoius instruction from executing as well. 

What are the pitfalls of this approach? 
Is there any other way to latch the values of forwarded data1 and data2? (FU_data1, FU_data2)? 

Experience: This approach has a major fault. Can't remember what since i have been trying to fix the initial problem for hours now 
but when i did try the above, sab warr gya. 

The other solution that worked is simply latching the values of inputs inside the multiply unit when they are given. 


Now, other than this, there were other many bugs because controlling the start and finish signals of the multiply unit is a major 
pain in the a**. Anyway, now is all fine. Finallly. 

However, another issue is that the instruction `mulhsu` where we multiply signed with unsigned hasn't been yet implemented so 
that's what is needed to be done next. But hopefully, i'll karaying it miss. 

Also, their is much verification needed to make sure, everthing's fine. 









