#include "rng.h"
#include "types.h"
static uint32_t m_w = 0xabcd1234;
static uint32_t m_z = 0x9876fedc;

uint32_t
get_random()
{
	m_z = 36969 * (m_z & 65535) + (m_z >> 16);
	m_w = 18000 * (m_w & 65535) + (m_w >> 16);
	return (m_z << 16) + m_w;
}
