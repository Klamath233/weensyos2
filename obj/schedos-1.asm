
obj/schedos-1:     file format elf32-i386


Disassembly of section .text:

00200000 <start>:
#ifndef SHARE_VALUE
#define SHARE_VALUE 1
#endif
void
start(void)
{
  200000:	53                   	push   %ebx
  200001:	31 d2                	xor    %edx,%edx
sys_atomic_printc(uint16_t colored_char)
{
	// We call a system call by causing an interrupt with the 'int'
	// instruction.  In weensyos, the type of system call is indicated
	// by the interrupt number -- here, INT_SYS_YIELD.
	asm volatile("int %0\n"
  200003:	bb 31 0c 00 00       	mov    $0xc31,%ebx
sys_renice(int priority)
{
	// We call a system call by causing an interrupt with the 'int'
	// instruction.  In weensyos, the type of system call is indicated
	// by the interrupt number -- here, INT_SYS_YIELD.
	asm volatile("int %0\n"
  200008:	31 c9                	xor    %ecx,%ecx
  20000a:	eb 10                	jmp    20001c <start+0x1c>
	int i;

	for (i = 0; i < RUNCOUNT; i++) {
		// Write characters to the console, yielding after each one.
		if (i == 100) {
  20000c:	83 fa 64             	cmp    $0x64,%edx
  20000f:	75 0b                	jne    20001c <start+0x1c>
  200011:	89 c8                	mov    %ecx,%eax
  200013:	cd 32                	int    $0x32
sys_set_share(int share)
{
	// We call a system call by causing an interrupt with the 'int'
	// instruction.  In weensyos, the type of system call is indicated
	// by the interrupt number -- here, INT_SYS_YIELD.
	asm volatile("int %0\n"
  200015:	b8 01 00 00 00       	mov    $0x1,%eax
  20001a:	cd 34                	int    $0x34
sys_atomic_printc(uint16_t colored_char)
{
	// We call a system call by causing an interrupt with the 'int'
	// instruction.  In weensyos, the type of system call is indicated
	// by the interrupt number -- here, INT_SYS_YIELD.
	asm volatile("int %0\n"
  20001c:	89 d8                	mov    %ebx,%eax
  20001e:	cd 33                	int    $0x33
sys_yield(void)
{
	// We call a system call by causing an interrupt with the 'int'
	// instruction.  In weensyos, the type of system call is indicated
	// by the interrupt number -- here, INT_SYS_YIELD.
	asm volatile("int %0\n"
  200020:	cd 30                	int    $0x30
void
start(void)
{
	int i;

	for (i = 0; i < RUNCOUNT; i++) {
  200022:	42                   	inc    %edx
  200023:	81 fa 40 01 00 00    	cmp    $0x140,%edx
  200029:	75 e1                	jne    20000c <start+0xc>
	// the kernel can look up that register value to read the argument.
	// Here, the status is loaded into register %eax.
	// You can load other registers with similar syntax; specifically:
	//	"a" = %eax, "b" = %ebx, "c" = %ecx, "d" = %edx,
	//	"S" = %esi, "D" = %edi.
	asm volatile("int %0\n"
  20002b:	31 c0                	xor    %eax,%eax
  20002d:	cd 31                	int    $0x31
  20002f:	eb fe                	jmp    20002f <start+0x2f>
