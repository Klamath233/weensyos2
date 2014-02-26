#ifndef __LOCK_H__
#define __LOCK_H__

#define UNLOCKED 0
#define LOCKED 1

typedef struct {
	uint32_t lock;
} lock_t;

void lock_init(lock_t *);
void lock_acquire(lock_t *);
void lock_release(lock_t *);

#endif
