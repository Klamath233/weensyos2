
obj/schedos-3:     file format elf32-i386


Disassembly of section .text:

00400000 <start>:
#ifndef SHARE_VALUE
#define SHARE_VALUE 1
#endif
void
start(void)
{
  400000:	53                   	push   %ebx
  400001:	31 d2                	xor    %edx,%edx
 *****************************************************************************/

static inline void
sys_atomic_printc(uint16_t colored_char)
{
	asm volatile("int %0\n"
  400003:	bb 33 09 00 00       	mov    $0x933,%ebx
 *****************************************************************************/

static inline void
sys_renice(int priority)
{
	asm volatile("int %0\n"
  400008:	b9 03 00 00 00       	mov    $0x3,%ecx
  40000d:	eb 0b                	jmp    40001a <start+0x1a>
	int i;

	for (i = 0; i < RUNCOUNT; i++) {
		// Write characters to the console, yielding after each one.
		if (i == 100) {
  40000f:	83 fa 64             	cmp    $0x64,%edx
  400012:	75 06                	jne    40001a <start+0x1a>
  400014:	89 c8                	mov    %ecx,%eax
  400016:	cd 32                	int    $0x32
 *****************************************************************************/

static inline void
sys_set_share(int share)
{
	asm volatile("int %0\n"
  400018:	cd 34                	int    $0x34
 *****************************************************************************/

static inline void
sys_atomic_printc(uint16_t colored_char)
{
	asm volatile("int %0\n"
  40001a:	89 d8                	mov    %ebx,%eax
  40001c:	cd 33                	int    $0x33
sys_yield(void)
{
	// We call a system call by causing an interrupt with the 'int'
	// instruction.  In weensyos, the type of system call is indicated
	// by the interrupt number -- here, INT_SYS_YIELD.
	asm volatile("int %0\n"
  40001e:	cd 30                	int    $0x30
void
start(void)
{
	int i;

	for (i = 0; i < RUNCOUNT; i++) {
  400020:	42                   	inc    %edx
  400021:	81 fa 40 01 00 00    	cmp    $0x140,%edx
  400027:	75 e6                	jne    40000f <start+0xf>
	// the kernel can look up that register value to read the argument.
	// Here, the status is loaded into register %eax.
	// You can load other registers with similar syntax; specifically:
	//	"a" = %eax, "b" = %ebx, "c" = %ecx, "d" = %edx,
	//	"S" = %esi, "D" = %edi.
	asm volatile("int %0\n"
  400029:	31 c0                	xor    %eax,%eax
  40002b:	cd 31                	int    $0x31
  40002d:	eb fe                	jmp    40002d <start+0x2d>
