global loader                   ; the entry symbol for ELF

global __go_register_gc_roots
global __go_runtime_error
global __unsafe_get_addr

MAGIC_NUMBER equ 0x1BADB002     ; define the magic number constant
FLAGS        equ 0x0            ; multiboot flags
CHECKSUM     equ -MAGIC_NUMBER  ; calculate the checksum
                                ; (magic number + checksum + flags should equal 0)
KERNEL_STACK_SIZE equ 4096                  ; size of stack in bytes

section .bss
  align 4                                     ; align at 4 bytes
  kernel_stack:                               ; label points to beginning of memory
    resb KERNEL_STACK_SIZE
    mov esp, kernel_stack + KERNEL_STACK_SIZE   ; point esp to the start of the

section .text:                  ; start of the text (code) section
align 4                         ; the code must be 4 byte aligned
  dd MAGIC_NUMBER             ; write the magic number to the machine code,
  dd FLAGS                    ; the flags,
  dd CHECKSUM                 ; and the checksum

loader:
  ;mov eax, 0xCAFEBABE
  __go_runtime_error:
  __go_register_gc_roots:
    ret

  extern go.kernel.Kmain
  push dword 3            ; arg3
  push dword 2            ; arg2
  push dword 1            ; arg1
  call go.kernel.Kmain

.loop:
    jmp .loop
