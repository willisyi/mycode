#include <stdio.h>
#include <string.h>
#include <sys/types.h>
#include <sys/ipc.h>
#include <sys/shm.h>
#include "share_mem.h"

int ShareMemInit(int shmid,int key)
{
	shmid = shmget(key, sizeof(struct shared_use), IPC_CREAT | 0660);
	if(shmid < 0)
		shmid = shmget(key, 0, 0);
	printf("shared memory id:%d\n",shmid);
	if(shmid < 0)
		return -1;
	return shmid;
}



void Del_ShareMem(void * ptr,int shmid)
{
   if(shmdt(ptr)==-1)
   {
   	printf("shmdt failed\n");
       exit(0);
   }
   if(shmctl(shmid,IPC_RMID,0)==-1)
   {
       printf("shmctl(IPC_RMID) failed\n");
       exit(0);
   }
}

