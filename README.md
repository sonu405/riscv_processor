

THIS IS THE IMPLEMENTATION OF RISC V PROCESSOR.



# Test Code (GPT)
```asm
        # x1 = -1 (0xFFFFFFFF), x2 = 1, x3 = 0
        addi x1, x0, -1
        addi x2, x0, 1
        addi x3, x0, 0
        # --- 1. BEQ: (-1 == -1) should TAKE ---
        beq  x1, x1, BEQ_T
        addi x10, x0, 1          # FAIL_BEQ
BEQ_T:
        # --- 2. BNE: (-1 != 1) should TAKE ---
        bne  x1, x2, BNE_T
        addi x10, x0, 2          # FAIL_BNE
BNE_T:
        # --- 3. BLT (signed): -1 < 1 should TAKE ---
        blt  x1, x2, BLT_T
        addi x10, x0, 3          # FAIL_BLT
BLT_T:
        # --- 4. BGE (signed): -1 >= 0 should NOT take ---
        bge  x1, x3, BGE_T
        addi x10, x0, 0          # correct path (not taken)
        j AFTER_BGE
BGE_T:
        addi x10, x0, 4          # FAIL_BGE
AFTER_BGE:
        # --- 5. BLTU (unsigned): 0xFFFFFFFF < 1 should NOT take ---
        bltu x1, x2, BLTU_T
        addi x10, x0, 0          # correct path (not taken)
        j AFTER_BLTU
BLTU_T:
        addi x10, x0, 5          # FAIL_BLTU
AFTER_BLTU:

        # --- 6. BGEU (unsigned): 0xFFFFFFFF >= 1 should TAKE ---
        bgeu x1, x2, BGEU_T
        addi x10, x0, 6          # FAIL_BGEU
BGEU_T:
        # ALL PASSED
        addi x10, x0, 0

```
