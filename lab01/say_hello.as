# This program writes "hello" to  
# the standard output stream.

.section .data

hello:
.ascii "hello, Alice.\n"

.section .text
.globl _start        # Tells assembler to generate information for the
                     # operating system to find the first instruction
                     # in the file.

_start:

movl $4, %eax        # Store 4 in register eax. This value is interpreted
                     # by Linux as the write bytes command, which is a
                     # command to copy bytes from main memory (RAM) into
                     # an output stream.

movl $1, %ebx        # Store 1 in register ebx. The write bytes command will
                     # look in register ebx to determine which output stream
                     # to copy the bytes into.  The number 1 means the 
                     # standard output stream.  The standard output stream is
                     # determined at runtime; it is the console window by
                     # default.

movl $hello,  %ecx    # When the operating system loads this program into main 
                     # to make it a running process, a numerical representation
                     # of the string "hello" will be placed into memory and the
                     # address of the first character will be placed in
                     # the first argument of this instruction
                     # (which is also stored in main memory).  This numerical
                     # representation includes 5 bytes, one for each character,
                     # followed by a sixth byte that contains zero.
                     #
                     # The write bytes command will look in register ecx to
                     # get the address of the first byte to copy into the
                     # output stream.

movl $16, %edx        # Store 6 in register edx. The write bytes command will
                     # look in edx to determine how many bytes to copy into 
                     # the output stream.

int $0x80            # Pass the hexadecimal number 80 to the operating system
                     # through a software interrupt.  Linux interprets 0x80
                     # as a command to run the command in register eax.

movl $1, %eax        # Store the exit command in register eax.

movl $0, %ebx        # Store the status code in register ebx; this is
                     # expected by the exit command.

int $0x80            # Tell Linux to execute the command in register eax.
