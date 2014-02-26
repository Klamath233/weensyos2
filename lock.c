#include "x86sync.h"
#include "lock.h"

void
lock_init(lock_t *l) 
{
	l->lock = 0;
}

void
lock_acquire(lock_t *l) 
{
	while(compare_and_swap(&l->lock, UNLOCKED, LOCKED))
		;
}

void
lock_release(lock_t *l)
{
	l->lock = 0;
}

