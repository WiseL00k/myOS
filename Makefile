CXXFLAGS += -fno-use-cxa-atexit -fno-exceptions -fleading-underscore -fno-builtin -fno-rtti -nostdlib -fno-pie
GPPPARAMS = -m32 
ASPARAMS = --32
LDPARAMS = -melf_i386 -no-pie

objects = loader.o kernel.o

%.o: %.cpp
	g++ $(GPPPARAMS) $(CXXFLAGS) -o $@ -c $<

%.o: %.s
	as ${ASPARAMS} -o $@ $<

mykernel.bin: linker.ld $(objects)
	ld ${LDPARAMS} -T $< -o $@ $(objects)

install: mykernel.bin
	sudo cp $< /boot/mykernel.bin