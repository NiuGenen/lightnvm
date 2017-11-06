#
# Makefile for Open-Channel SSDs.
#

obj-$(CONFIG_NVM)		:= core.o
obj-$(CONFIG_NVM_RRPC)		+= rrpc.o
obj-$(CONFIG_NVM_PBLK)		+= pblk.o
pblk-y				:= pblk-init.o pblk-core.o pblk-rb.o \
				   pblk-write.o pblk-cache.o pblk-read.o \
				   pblk-gc.o pblk-recovery.o pblk-map.o \
				   pblk-rl.o pblk-sysfs.o

KERNELBUILD :=/lib/modules/$(shell uname -r)/build
default:
	make -j4  -C $(KERNELBUILD) M=$(shell pwd) modules
clean:
	rm -rf *.o *.ko *.mod.c .*.cmd *.markers *.order *.symvers .tmp_versions  
