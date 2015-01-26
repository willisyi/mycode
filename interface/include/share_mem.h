#define BUF_MAX_SZ 10000
#define SHM_KEY 33

int ShareMemInit(int shmid,int key);  //intial shared memory
void Del_ShareMem(void * ptr,int shmid);


struct shared_use{
    int UsedSize;
    char buf[BUF_MAX_SZ];
};


