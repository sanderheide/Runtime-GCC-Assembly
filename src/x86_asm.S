.text # Code segment
.global mat_mul_asm # Make this label available in the global symbol table
.type mat_mul_asm, @function # Declare this label type: function

##############################
# name: mat_mul_asm
# 
# input: 
#       First arg: int : rdi
#       Second arg: int : rsi
#       ...
# output:
#
# return:
#       int: rax
# modifies: 
#     
# notes:
#
##############################
mat_mul_asm:

    
    # Do something here... 

#   Example code:
#   example:
#       pushq   %rbp
#       movq    %rsp, %rbp              #####
#       movl    %edi, -20(%rbp)         # int example(int num, int num2){
#       movl    %esi, -24(%rbp)         # int a = 0;
#       movl    $0, -4(%rbp)            # while(num<num2){
#       jmp     .L2                     #   a++;
#   .L3:                                # }
#       addl    $1, -4(%rbp)            # return a;
#   .L2:                                # }
#       movl    -20(%rbp), %eax         #####
#       cmpl    -24(%rbp), %eax         
#       jl      .L3
#       movl    -4(%rbp), %eax
#       popq    %rbp
#       ret


