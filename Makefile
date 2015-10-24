OBJECTS = loader.o kmain.o

#CC = gcc
#CFLAGS = -m32 -nostdlib -nostdinc -fno-stack-protector \
#				 -nostartfiles -nodefaultlibs -Wall -Wextra -Werror -c
CC = gccgo -m32
#CFLAGS = -static -Werror -nostdlib -nostartfiles -nodefaultlibs
CFLAGS = -Wall -Wextra -fno-split-stack -nostdlib -nodefaultlibs

LD=ld
LDFLAGS = -T link.ld -melf_i386 -Igccgo
#LD=gccgo
#LDFLAGS = -Wl,-u,pthread_create,-T,link.ld -n -fno-split-stack -nostartfiles -static -static-libgcc -static-libgo -m32

AS = nasm
ASFLAGS = -f elf32

all: kernel.elf

kernel.elf: $(OBJECTS)
	$(LD) $(LDFLAGS) $(OBJECTS) -o kernel.elf

os.iso: kernel.elf
	cp kernel.elf iso/boot/kernel.elf
	genisoimage -R                              \
							-b boot/grub/stage2_eltorito    \
							-no-emul-boot                   \
							-boot-load-size 4               \
							-A os                           \
							-input-charset utf8             \
							-quiet                          \
							-boot-info-table                \
							-o os.iso                       \
							iso

run: os.iso
	echo -ne 'c' | bochs -f bochsrc.txt -q

%.o: %.go
	GOARCH=386 $(CC) $(CFLAGS) -c $< -o $@

%.o: %.s
	$(AS) $(ASFLAGS) $< -o $@

clean:
	rm -rf *.o kernel.elf os.iso
