#include <sys/types.h>
#include <sys/ipc.h>
#include <sys/sem.h>

/*�����������static �ؼ���,��ʾ����������ڲ�����,
 *ֻ���ڱ��ļ��ڵ���.
 */
int set_semvalue(int sem_id,int val);	//�����ź���
void del_semvalue(int sem_id);	//ɾ���ź���
int semaphore_p(int sem_id);	//-1
int semaphore_v(int sem_id);	// +1

#if defined(__GNU_LIBRARY__) && !defined(_SEM_SEMUN_UNDEFINED)
    /* union semun is defined by including <sys/sem.h> */
#else
    /* according to X/OPEN we have to define it ourselves */
    union semun {
        int val;                    /* value for SETVAL */
        struct semid_ds *buf;       /* buffer for IPC_STAT, IPC_SET */
        unsigned short int *array;  /* array for GETALL, SETALL */
        struct seminfo *__buf;      /* buffer for IPC_INFO */
    };
#endif



