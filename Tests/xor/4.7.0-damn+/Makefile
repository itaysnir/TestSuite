obj-m := xor_nocopy.o
xor_test-y := xor_nocopy.o

all:
	make -C /lib/modules/`uname -r`/build M=$(PWD) modules
clean:
	make -C /lib/modules/`uname -r`/build M=$(PWD) clean
