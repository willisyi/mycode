
ROOTDIR = ../..
#include $(ROOTDIR)/dvr_rdk/Rules.make
FC_PATH = $(ROOTDIR)/ti_tools/framework_components/framework_components_3_22_02_08
APP_LIB_DIR = ../lib
PUBLIC_INCLUDE_DIR = ../inc

CMEM_INCLUDE_DIR = $(FC_PATH)/fctools/packages/ti/sdo/linuxutils/cmem/include

INCLUDES += -I./ -I$(PUBLIC_INCLUDE_DIR)  -I$(ROOTDIR)/ti_tools/linux_lsp/linux-psp-dvr-04.04.00.01/src/linux-04.04.00.01/include\
  -I$(FC_PATH)/fctools/packages/ti/sdo/linuxutils/cmem/src/interface

C_FLAGS += -Wall -g -O3
AR_FLAGS += -r

CC = arm-none-linux-gnueabi-gcc $(INCLUDES) $(C_FLAGS) -c
AR = arm-none-linux-gnueabi-ar

REL_LIB1 = file_msg_drv.a
REL_LIB2 = alarm_msg_drv.a
REL_LIB3 = share_mem.a
REL_LIB4 = sys_msg_drv.a
REL_LIB5 = msg_util.a
REL_LIB6 = Appro_interface.a
REL_LIB7 = dm355_gio_util.a
REL_LIB8 = sem_util.a
REL_LIB9 = sysctrl.a



REL_OBJ1 = file_msg_drv.o share_mem.o msg_util.o
REL_OBJ2 = alarm_msg_drv.o msg_util.o
REL_OBJ3 = share_mem.o
REL_OBJ4 = sys_msg_drv.o share_mem.o msg_util.o
REL_OBJ5 = msg_util.o
REL_OBJ6 = ApproDrvMsg.o Appro_interface.o sem_util.o msg_util.o
REL_OBJ7 = dm355_gio_util.o
REL_OBJ8 = sem_util.o
REL_OBJ9 = sysctrl.o sys_msg_drv.o share_mem.o msg_util.o sem_util.o
all:
	make clean
	make exe
exe: $(REL_LIB8) $(REL_LIB3) $(REL_LIB1) $(REL_LIB2) $(REL_LIB4) $(REL_LIB5) $(REL_LIB6) $(REL_LIB7) $(REL_LIB9) install

$(REL_LIB1): $(REL_OBJ1)
	$(AR) $(AR_FLAGS) $(REL_LIB1) $(REL_OBJ1)

$(REL_LIB2): $(REL_OBJ2)
	$(AR) $(AR_FLAGS) $(REL_LIB2) $(REL_OBJ2)

$(REL_LIB3): $(REL_OBJ3)
	$(AR) $(AR_FLAGS) $(REL_LIB3) $(REL_OBJ3)

$(REL_LIB4): $(REL_OBJ4)
	$(AR) $(AR_FLAGS) $(REL_LIB4) $(REL_OBJ4)

$(REL_LIB5): $(REL_OBJ5)
	$(AR) $(AR_FLAGS) $(REL_LIB5) $(REL_OBJ5)

$(REL_LIB6): $(REL_OBJ6)
	$(AR) $(AR_FLAGS) $(REL_LIB6) $(REL_OBJ6)

$(REL_LIB7): $(REL_OBJ7)
	$(AR) $(AR_FLAGS) $(REL_LIB7) $(REL_OBJ7)

$(REL_LIB8): $(REL_OBJ8)
	$(AR) $(AR_FLAGS) $(REL_LIB8) $(REL_OBJ8)

$(REL_LIB9): $(REL_OBJ9)
	$(AR) $(AR_FLAGS) $(REL_LIB9) $(REL_OBJ9)

file_msg_drv.o: file_msg_drv.c $(PUBLIC_INCLUDE_DIR)/file_msg_drv.h $(PUBLIC_INCLUDE_DIR)/Msg_Def.h\
		$(PUBLIC_INCLUDE_DIR)/sys_env_type.h
	$(CC) $(C_FLAGS) -o $@ $<

alarm_msg_drv.o: alarm_msg_drv.c $(PUBLIC_INCLUDE_DIR)/alarm_msg_drv.h\
		$(PUBLIC_INCLUDE_DIR)/Msg_Def.h $(PUBLIC_INCLUDE_DIR)/sys_env_type.h
	$(CC) $(C_FLAGS) -o $@ $<

share_mem.o: share_mem.c $(PUBLIC_INCLUDE_DIR)/share_mem.h 
	$(CC) $(C_FLAGS) -o $@ $<

sys_msg_drv.o: sys_msg_drv.c $(PUBLIC_INCLUDE_DIR)/sys_msg_drv.h $(PUBLIC_INCLUDE_DIR)/Msg_Def.h\
		$(PUBLIC_INCLUDE_DIR)/sys_env_type.h $(PUBLIC_INCLUDE_DIR)/share_mem.h
	$(CC) $(C_FLAGS) -o $@ $<

msg_util.o: msg_util.c $(PUBLIC_INCLUDE_DIR)/Msg_Def.h
	$(CC) $(C_FLAGS) -o $@ $<

ApproDrvMsg.o: ApproDrvMsg.c $(PUBLIC_INCLUDE_DIR)/ApproDrvMsg.h
	$(CC) $(C_FLAGS) -o $@ $<

Appro_interface.o: Appro_interface.c $(PUBLIC_INCLUDE_DIR)/Appro_interface.h  $(CMEM_INCLUDE_DIR)/cmem.h
	$(CC) $(C_FLAGS) -o $@ $<

sem_util.o: sem_util.c $(PUBLIC_INCLUDE_DIR)/sem_util.h
	$(CC) $(C_FLAGS) -o $@ $<

sysctrl.o: sysctrl.c $(PUBLIC_INCLUDE_DIR)/sysctrl.h $(PUBLIC_INCLUDE_DIR)/sys_env_type.h
	$(CC) $(C_FLAGS) -o $@ $<

clean:
	-$(RM) -f *.o
	-$(RM) -f *.a
	-$(RM) -Rf $(APP_LIB_DIR)


install: $(REL_LIB3) $(REL_LIB1) $(REL_LIB2) $(REL_LIB4) $(REL_LIB5) $(REL_LIB6)
	install -d $(APP_LIB_DIR)
	install $(REL_LIB1) $(APP_LIB_DIR)
	install $(REL_LIB2) $(APP_LIB_DIR)  
	install $(REL_LIB3) $(APP_LIB_DIR)
	install $(REL_LIB4) $(APP_LIB_DIR)
	install $(REL_LIB5) $(APP_LIB_DIR)
	install $(REL_LIB6) $(APP_LIB_DIR)
	install $(REL_LIB7) $(APP_LIB_DIR)
	install $(REL_LIB8) $(APP_LIB_DIR)
	install $(REL_LIB9) $(APP_LIB_DIR)

