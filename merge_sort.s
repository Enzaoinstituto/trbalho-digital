main:
    ori $a0,$zero,endereco
    
    add $a1,$zero,$zero
    ori $a3,$zero,tamanho - 1

    jal merge-sort 

merge-sort:
    # b0 
    sw $fp,-4($sp)
    addi $fp,$sp,-4
    addi $sp,$sp,-20
    sw $ra,0($fp)
    sw $a0,-4($fp)
    sw $a1,-8($fp)
    sw $a2,-12($fp)
    sw $s0,-16($fp)

    #b1
    bge $a1,$a2,retorno

    #b2
    add $s0,$a1,$a2
    srl $s0,$s0,1

    #b3
    or $a2,$s0,$zero
    jal merge-sort

    #b4
    lw $a2,-12($fp)
    addi $a1,$s0,1
    jal merge-sort

    #b5
    add $a3,$a2,$zero
    add $a2,$s0,$zero
    jal merge

    #b6
    retorno:
    lw $ra,0($fp)
    lw $a0,-4($fp)
    lw $a1,-8($fp)
    lw $a2,-12($fp)
    lw $s0,-16($fp)
    addi $sp,$fp,4
    lw $fp,-4($sp)

#a0 = vetor,a1=esquerda,a2 = meio,a3 = direita
merge:
    #t0 = esquerda(i)
    add $t0,$a1,$zero
    #t1 = meio + 1(j)
    addi $t1,$a2,1

    loop:
        bgt $a2,$t0,fim
        bgt $a3,$t1,fim
            sll $t0,$t0,2
            sll $t1,$t1,2
            #t2 = v[i]
            add $t2,$a0,$t0
            #t3 = v[j]
            add $t3,$a0,$t1
            

            lw $t2,0($t2)
            lw $t3,0($t3)

            srl $t0,$t0,2
            srl $t1,$t1,2

            bgt $t2,$t3,else
            addi $t0,$t0,1
            j loop
        else:
            add $t4,$t1,$zero
            
            loop2:
                beq $t4,$t0,fimloop2
                sll $t4,$t4,2
                add $t5,$a0,$t4
                lw $t6,0($t5)
                lw $t7,-4($t5)
                sw $t6,-4($t5)
                sw $t7, 0($t5)
                srl $t4,$t4,2
                addi $t4,$t4,-1
            fimloop2:
                addi $t0,$t0,1
                addi $t1,$t1,1
                addi $a2,$a2,1
                j loop


fim:
    jr ra