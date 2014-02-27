
obj/schedos-2:     file format elf32-i386


Disassembly of section .text:

00300000 <start>:
#ifndef SHARE_VALUE
#define SHARE_VALUE 1
#endif
void
start(void)
{
  300000:	53                   	push   %ebx
  300001:	31 d2                	xor    %edx,%edx
 *****************************************************************************/

static inline void
sys_atomic_printc(uint16_t colored_char)
{
	asm volatile("int %0\n"
  300003:	bb 32 0a 00 00       	mov    $0xa32,%ebx
 *****************************************************************************/

static inline void
sys_renice(int priority)
{
	asm volatile("int %0\n"
  300008:	b9 02 00 00 00       	mov    $0x2,%ecx
  30000d:	eb 0b                	jmp    30001a <start+0x1a>
	int i;

	for (i = 0; i < RUNCOUNT; i++) {
		// Write characters to the console, yielding after each one.
		if (i == 100) {
  30000f:	83 fa 64             	cmp    $0x64,%edx
  300012:	75 06                	jne    30001a <start+0x1a>
  300014:	89 c8                	mov    %ecx,%eax
  300016:	cd 32                	int    $0x32
 *****************************************************************************/

static inline void
sys_set_share(int share)
{
	asm volatile("int %0\n"
  300018:	cd 34                	int    $0x34
 *****************************************************************************/

static inline void
sys_atomic_printc(uint16_t colored_char)
{
	asm volatile("int %0\n"
  30001a:	89 d8                	mov    %ebx,%eax
  30001c:	cd 33                	int    $0x33
sys_yield(void)
{
	// We call a system call by causing an interrupt with the 'int'
	// instruction.  In weensyos, the type of system call is indicated
	// by the interrupt number -- here, INT_SYS_YIELD.
	asm volatile("int %0\n"
  30001e:	cd 30                	int    $0x30
void
start(void)
{
	int i;

	for (i = 0; i < RUNCOUNT; i++) {
  300020:	42                   	inc    %edx
  300021:	81 fa 40 01 00 00    	cmp    $0x140,%edx
  300027:	75 e6                	jne    30000f <start+0xf>
	// the kernel can look up that register value to read the argument.
	// Here, the status is loaded into register %eax.
	// You can load other registers with similar syntax; specifically:
	//	"a" = %eax, "b" = %ebx, "c" = %ecx, "d" = %edx,
	//	"S" = %esi, "D" = %edi.
	asm volatile("int %0\n"
  300029:	31 c0                	xor    %eax,%eax
  30002b:	cd 31                	int    $0x31
  30002d:	eb fe                	jmp    30002d <start+0x2d>
