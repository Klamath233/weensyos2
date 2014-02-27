#include "x86sync.h"
#include "lock.h"

void
lock_init(lock_t *l) 
{
	l->lock = UNLOCKED;
}

#ifdef COMPARE_AND_SWAP
void
lock_acquire(lock_t *l) 
{
	while (compare_and_swap(&l->lock, UNLOCKED, LOCKED) != UNLOCKED)
		;
}
#else
void
lock_acquire(lock_t *l)
{
    while ((int)atomic_swap(&l->lock, LOCKED) != UNLOCKED)
        ;
}
#endif
void
lock_release(lock_t *l)
{
	l->lock = UNLOCKED;
}

