
obj/schedos-2:     file format elf32-i386


Disassembly of section .text:

00300000 <start>:
#ifndef NICE_VALUE
#define NICE_VALUE 0
#endif
void
start(void)
{
  300000:	53                   	push   %ebx
  300001:	31 d2                	xor    %edx,%edx
sys_atomic_printc(uint16_t colored_char)
{
	// We call a system call by causing an interrupt with the 'int'
	// instruction.  In weensyos, the type of system call is indicated
	// by the interrupt number -- here, INT_SYS_YIELD.
	asm volatile("int %0\n"
  300003:	bb 32 0a 00 00       	mov    $0xa32,%ebx
sys_renice(int priority)
{
	// We call a system call by causing an interrupt with the 'int'
	// instruction.  In weensyos, the type of system call is indicated
	// by the interrupt number -- here, INT_SYS_YIELD.
	asm volatile("int %0\n"
  300008:	31 c9                	xor    %ecx,%ecx
  30000a:	eb 09                	jmp    300015 <start+0x15>
	int i;

	for (i = 0; i < RUNCOUNT; i++) {
		// Write characters to the console, yielding after each one.
		if (i == 100) {
  30000c:	83 fa 64             	cmp    $0x64,%edx
  30000f:	75 04                	jne    300015 <start+0x15>
  300011:	89 c8                	mov    %ecx,%eax
  300013:	cd 32                	int    $0x32
sys_atomic_printc(uint16_t colored_char)
{
	// We call a system call by causing an interrupt with the 'int'
	// instruction.  In weensyos, the type of system call is indicated
	// by the interrupt number -- here, INT_SYS_YIELD.
	asm volatile("int %0\n"
  300015:	89 d8                	mov    %ebx,%eax
  300017:	cd 33                	int    $0x33
sys_yield(void)
{
	// We call a system call by causing an interrupt with the 'int'
	// instruction.  In weensyos, the type of system call is indicated
	// by the interrupt number -- here, INT_SYS_YIELD.
	asm volatile("int %0\n"
  300019:	cd 30                	int    $0x30
void
start(void)
{
	int i;

	for (i = 0; i < RUNCOUNT; i++) {
  30001b:	42                   	inc    %edx
  30001c:	81 fa 40 01 00 00    	cmp    $0x140,%edx
  300022:	75 e8                	jne    30000c <start+0xc>
	// the kernel can look up that register value to read the argument.
	// Here, the status is loaded into register %eax.
	// You can load other registers with similar syntax; specifically:
	//	"a" = %eax, "b" = %ebx, "c" = %ecx, "d" = %edx,
	//	"S" = %esi, "D" = %edi.
	asm volatile("int %0\n"
  300024:	31 c0                	xor    %eax,%eax
  300026:	cd 31                	int    $0x31
  300028:	eb fe                	jmp    300028 <start+0x28>
