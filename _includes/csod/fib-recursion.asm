# Recursive fibbonachi sequence generator in assembly.

main:       li      $t1, 10               # Load N
            sw      $t1, 0($sp)           # Call fib(N)
            jal     fib
            lw      $s1, 0($sp)           # Load result to $s1
            addi    $sp, $sp, 4

            add     $a0, $zero, $s1       # Print out the result
            li      $v0, 1
            syscall
            li      $v0, 10               # Exit
            syscall

fib:        lw      $t3, 0($sp)           # Pop input value from stack
            addi    $sp, $sp, 4
            addi    $t5, $zero, 1
            beq     $t3, $zero, fib_b1    # Base case where N=0
            beq     $t3, $t5, fib_b2      # Base case where N=1

fib_nb:     addi    $t3, $t3, -1
            addi    $sp, $sp, -4
            sw      $t3, 0($sp)           # Save $t3
            addi    $sp, $sp, -4
            sw      $ra, 0($sp)           # Save $ra

            addi    $sp, $sp, -4
            sw      $t3, 0($sp)
            jal     fib                   # Call fib

            lw      $t7, 0($sp)           # Load result to $t7
            addi    $sp, $sp, 4

            lw      $ra, 0($sp)           # Restore $ra
            addi    $sp, $sp, 4
            lw      $t3, 0($sp)           # Restore $t3
            addi    $sp, $sp, 4
            addi    $t3, $t3, -1          # Decrement N

            addi    $sp, $sp, -4
            sw      $ra, 0($sp)           # Save $ra
            addi    $sp, $sp, -4
            sw      $t7, 0($sp)           # Save $t7

            addi    $sp, $sp, -4
            sw      $t3, 0($sp)
            jal     fib                   # Call fib

            lw      $t8, 0($sp)           # Load result to $t8
            addi    $sp, $sp, 4

            lw      $t7, 0($sp)           # Restore $t7
            addi    $sp, $sp, 4
            lw      $ra, 0($sp)           # Restore $ra
            addi    $sp, $sp, 4

            add    $t9, $t7, $t8
            addi    $sp, $sp, -4
            sw      $t9, 0($sp)           # Store result

            jr  $ra

fib_b1:     addi    $sp, $sp, -4
            sw      $zero, 0($sp)         # Return 0
            jr $ra

fib_b2:     addi    $t4, $zero, 1
            addi    $sp, $sp, -4
            sw      $t4, 0($sp)           # Return 1
            jr $ra