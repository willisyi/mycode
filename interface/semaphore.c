#include <stdio.h>

#include "semaphore.h" 


int set_semvalue(int sem_id,int val)
{
	union semun sem_union;

	sem_union.val = val;
	if(semctl(sem_id, 0, SETVAL, sem_union) == -1) return(0);
	return(1);
}

/* ����del_semvalueͨ��semctl���������ź���,
 * ��command��������ΪIPC_RMID,��ʾҪ��ɾ��һ���Ѿ�����ʹ�õ��ź�����ʶ��
 */
void del_semvalue(int sem_id)
{
	union semun sem_union;
    
	if (semctl(sem_id, 0, IPC_RMID, sem_union) == -1)
		fprintf(stderr, "Failed to delete semaphore\n");
}

/* ����semaphore_p ִ��P()����,��sem_b�ṹ�е�sem_op����Ϊ-1. */
int semaphore_p(int sem_id)
{
	struct sembuf sem_b;
    
	sem_b.sem_num = 0;
	sem_b.sem_op = -1; /* P() */
	sem_b.sem_flg = SEM_UNDO;
	if (semop(sem_id, &sem_b, 1) == -1) 
	{
		fprintf(stderr, "semaphore_p failed\n");
		return(0);
	}
	return(1);
}

/* ����semaphore_vִ��V()����,��sem_b�ṹ�е�sem_op����Ϊ+1 */
int semaphore_v(int sem_id)
{
	struct sembuf sem_b;
    
	sem_b.sem_num = 0;
	sem_b.sem_op = 1; /* V() */
	sem_b.sem_flg = SEM_UNDO;
	if (semop(sem_id, &sem_b, 1) == -1) 
	{
		fprintf(stderr, "semaphore_v failed\n");
		return(0);
    }
	return(1);
}

