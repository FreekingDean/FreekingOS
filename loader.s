global loader

  KERNEL_STACK_SIZE equ 4096
	MAGIC_NUMBER      equ 0x1BADB002      ; define the magic number constant
	FLAGS             equ 0x0             ; multiboot flags
	CHECKSUM          equ -MAGIC_NUMBER   ; calculate the checksum
                                        ; (magic number + checksum + flags should equal 0)

	section .text:                  ; start of the text (code) section
		align 4                       ; the code must be 4 byte aligned
	  dd MAGIC_NUMBER               ; write the magic number to the machine code,
	  dd FLAGS                      ; the flags,
	  dd CHECKSUM                   ; and the checksum

  section .bss:
    align 4
    kernel_stack:
      resb KERNEL_STACK_SIZE
      mov esp, kernel_stack + KERNEL_STACK_SIZE   ; point esp to the start of the
                                                  ; stack (end of memory area)


	loader:                         ; the loader label (defined as entry point in linker script)
    extern sum_of_three
    push dword 1
    push dword 2
    push dword 3
    call sum_of_three
    ;mov byte [0x000B8000], 0x4128


	.loop:
    jmp .loop                   ; loop forever
