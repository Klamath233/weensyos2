
obj/schedos-4:     file format elf32-i386


Disassembly of section .text:

00500000 <start>:
#ifndef NICE_VALUE
#define NICE_VALUE 0
#endif
void
start(void)
{
  500000:	53                   	push   %ebx
  500001:	31 d2                	xor    %edx,%edx
sys_atomic_printc(uint16_t colored_char)
{
	// We call a system call by causing an interrupt with the 'int'
	// instruction.  In weensyos, the type of system call is indicated
	// by the interrupt number -- here, INT_SYS_YIELD.
	asm volatile("int %0\n"
  500003:	bb 34 0e 00 00       	mov    $0xe34,%ebx
sys_renice(int priority)
{
	// We call a system call by causing an interrupt with the 'int'
	// instruction.  In weensyos, the type of system call is indicated
	// by the interrupt number -- here, INT_SYS_YIELD.
	asm volatile("int %0\n"
  500008:	31 c9                	xor    %ecx,%ecx
  50000a:	eb 09                	jmp    500015 <start+0x15>
	int i;

	for (i = 0; i < RUNCOUNT; i++) {
		// Write characters to the console, yielding after each one.
		if (i == 100) {
  50000c:	83 fa 64             	cmp    $0x64,%edx
  50000f:	75 04                	jne    500015 <start+0x15>
  500011:	89 c8                	mov    %ecx,%eax
  500013:	cd 32                	int    $0x32
sys_atomic_printc(uint16_t colored_char)
{
	// We call a system call by causing an interrupt with the 'int'
	// instruction.  In weensyos, the type of system call is indicated
	// by the interrupt number -- here, INT_SYS_YIELD.
	asm volatile("int %0\n"
  500015:	89 d8                	mov    %ebx,%eax
  500017:	cd 33                	int    $0x33
sys_yield(void)
{
	// We call a system call by causing an interrupt with the 'int'
	// instruction.  In weensyos, the type of system call is indicated
	// by the interrupt number -- here, INT_SYS_YIELD.
	asm volatile("int %0\n"
  500019:	cd 30                	int    $0x30
void
start(void)
{
	int i;

	for (i = 0; i < RUNCOUNT; i++) {
  50001b:	42                   	inc    %edx
  50001c:	81 fa 40 01 00 00    	cmp    $0x140,%edx
  500022:	75 e8                	jne    50000c <start+0xc>
	// the kernel can look up that register value to read the argument.
	// Here, the status is loaded into register %eax.
	// You can load other registers with similar syntax; specifically:
	//	"a" = %eax, "b" = %ebx, "c" = %ecx, "d" = %edx,
	//	"S" = %esi, "D" = %edi.
	asm volatile("int %0\n"
  500024:	31 c0                	xor    %eax,%eax
  500026:	cd 31                	int    $0x31
  500028:	eb fe                	jmp    500028 <start+0x28>
