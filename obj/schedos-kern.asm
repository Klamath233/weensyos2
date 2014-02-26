
obj/schedos-kern:     file format elf32-i386


Disassembly of section .text:

00100000 <multiboot>:
  100000:	02 b0 ad 1b 00 00    	add    0x1bad(%eax),%dh
  100006:	00 00                	add    %al,(%eax)
  100008:	fe 4f 52             	decb   0x52(%edi)
  10000b:	e4 bc                	in     $0xbc,%al

0010000c <multiboot_start>:
# The multiboot_start routine sets the stack pointer to the top of the
# SchedOS's kernel stack, then jumps to the 'start' routine in schedos-kern.c.

.globl multiboot_start
multiboot_start:
	movl $0x180000, %esp
  10000c:	bc 00 00 18 00       	mov    $0x180000,%esp
	pushl $0
  100011:	6a 00                	push   $0x0
	popfl
  100013:	9d                   	popf   
	call start
  100014:	e8 5e 02 00 00       	call   100277 <start>
  100019:	90                   	nop

0010001a <clock_int_handler>:
# Interrupt handlers
.align 2

	.globl clock_int_handler
clock_int_handler:
	pushl $0		// error code
  10001a:	6a 00                	push   $0x0
	pushl $32		// trap number
  10001c:	6a 20                	push   $0x20
	jmp _generic_int_handler
  10001e:	eb 40                	jmp    100060 <_generic_int_handler>

00100020 <sys_int48_handler>:

sys_int48_handler:
	pushl $0
  100020:	6a 00                	push   $0x0
	pushl $48
  100022:	6a 30                	push   $0x30
	jmp _generic_int_handler
  100024:	eb 3a                	jmp    100060 <_generic_int_handler>

00100026 <sys_int49_handler>:

sys_int49_handler:
	pushl $0
  100026:	6a 00                	push   $0x0
	pushl $49
  100028:	6a 31                	push   $0x31
	jmp _generic_int_handler
  10002a:	eb 34                	jmp    100060 <_generic_int_handler>

0010002c <sys_int50_handler>:

sys_int50_handler:
	pushl $0
  10002c:	6a 00                	push   $0x0
	pushl $50
  10002e:	6a 32                	push   $0x32
	jmp _generic_int_handler
  100030:	eb 2e                	jmp    100060 <_generic_int_handler>

00100032 <sys_int51_handler>:

sys_int51_handler:
	pushl $0
  100032:	6a 00                	push   $0x0
	pushl $51
  100034:	6a 33                	push   $0x33
	jmp _generic_int_handler
  100036:	eb 28                	jmp    100060 <_generic_int_handler>

00100038 <sys_int52_handler>:

sys_int52_handler:
	pushl $0
  100038:	6a 00                	push   $0x0
	pushl $52
  10003a:	6a 34                	push   $0x34
	jmp _generic_int_handler
  10003c:	eb 22                	jmp    100060 <_generic_int_handler>

0010003e <sys_int53_handler>:

sys_int53_handler:
	pushl $0
  10003e:	6a 00                	push   $0x0
	pushl $53
  100040:	6a 35                	push   $0x35
	jmp _generic_int_handler
  100042:	eb 1c                	jmp    100060 <_generic_int_handler>

00100044 <sys_int54_handler>:

sys_int54_handler:
	pushl $0
  100044:	6a 00                	push   $0x0
	pushl $54
  100046:	6a 36                	push   $0x36
	jmp _generic_int_handler
  100048:	eb 16                	jmp    100060 <_generic_int_handler>

0010004a <sys_int55_handler>:

sys_int55_handler:
	pushl $0
  10004a:	6a 00                	push   $0x0
	pushl $55
  10004c:	6a 37                	push   $0x37
	jmp _generic_int_handler
  10004e:	eb 10                	jmp    100060 <_generic_int_handler>

00100050 <sys_int56_handler>:

sys_int56_handler:
	pushl $0
  100050:	6a 00                	push   $0x0
	pushl $56
  100052:	6a 38                	push   $0x38
	jmp _generic_int_handler
  100054:	eb 0a                	jmp    100060 <_generic_int_handler>

00100056 <sys_int57_handler>:

sys_int57_handler:
	pushl $0
  100056:	6a 00                	push   $0x0
	pushl $57
  100058:	6a 39                	push   $0x39
	jmp _generic_int_handler
  10005a:	eb 04                	jmp    100060 <_generic_int_handler>

0010005c <default_int_handler>:

	.globl default_int_handler
default_int_handler:
	pushl $0
  10005c:	6a 00                	push   $0x0
	jmp _generic_int_handler
  10005e:	eb 00                	jmp    100060 <_generic_int_handler>

00100060 <_generic_int_handler>:
	# When we get here, the processor's interrupt mechanism has
	# pushed the old task status and stack registers onto the kernel stack.
	# Then one of the specific handlers pushed the trap number.
	# Now, we complete the 'registers_t' structure by pushing the extra
	# segment definitions and the general CPU registers.
	pushl %ds
  100060:	1e                   	push   %ds
	pushl %es
  100061:	06                   	push   %es
	pushal
  100062:	60                   	pusha  

	# Load the kernel's data segments into the extra segment registers
	# (although we don't use those extra segments!).
	movl $0x10, %eax
  100063:	b8 10 00 00 00       	mov    $0x10,%eax
	movw %ax, %ds
  100068:	8e d8                	mov    %eax,%ds
	movw %ax, %es
  10006a:	8e c0                	mov    %eax,%es

	# Call the kernel's 'interrupt' function.
	pushl %esp
  10006c:	54                   	push   %esp
	call interrupt
  10006d:	e8 5e 01 00 00       	call   1001d0 <interrupt>

00100072 <sys_int_handlers>:
  100072:	20 00                	and    %al,(%eax)
  100074:	10 00                	adc    %al,(%eax)
  100076:	26 00 10             	add    %dl,%es:(%eax)
  100079:	00 2c 00             	add    %ch,(%eax,%eax,1)
  10007c:	10 00                	adc    %al,(%eax)
  10007e:	32 00                	xor    (%eax),%al
  100080:	10 00                	adc    %al,(%eax)
  100082:	38 00                	cmp    %al,(%eax)
  100084:	10 00                	adc    %al,(%eax)
  100086:	3e 00 10             	add    %dl,%ds:(%eax)
  100089:	00 44 00 10          	add    %al,0x10(%eax,%eax,1)
  10008d:	00 4a 00             	add    %cl,0x0(%edx)
  100090:	10 00                	adc    %al,(%eax)
  100092:	50                   	push   %eax
  100093:	00 10                	add    %dl,(%eax)
  100095:	00 56 00             	add    %dl,0x0(%esi)
  100098:	10 00                	adc    %al,(%eax)
  10009a:	90                   	nop
  10009b:	90                   	nop

0010009c <schedule>:
#define LOWEST_PRIORITY -20
static int last_proc_id = 1;

void
schedule(void)
{
  10009c:	53                   	push   %ebx
  10009d:	83 ec 08             	sub    $0x8,%esp
    
	pid_t pid = current->p_pid;
  1000a0:	a1 90 7d 10 00       	mov    0x107d90,%eax
  1000a5:	8b 10                	mov    (%eax),%edx

	if (scheduling_algorithm == 0)
  1000a7:	a1 94 7d 10 00       	mov    0x107d94,%eax
  1000ac:	85 c0                	test   %eax,%eax
  1000ae:	75 1f                	jne    1000cf <schedule+0x33>
		while (1) {
			pid = (pid + 1) % NPROCS;
  1000b0:	b9 05 00 00 00       	mov    $0x5,%ecx
  1000b5:	8d 42 01             	lea    0x1(%edx),%eax
  1000b8:	99                   	cltd   
  1000b9:	f7 f9                	idiv   %ecx

			// Run the selected process, but skip
			// non-runnable processes.
			// Note that the 'run' function does not return.
			if (proc_array[pid].p_state == P_RUNNABLE)
  1000bb:	6b c2 54             	imul   $0x54,%edx,%eax
  1000be:	83 b8 c8 73 10 00 01 	cmpl   $0x1,0x1073c8(%eax)
  1000c5:	75 ee                	jne    1000b5 <schedule+0x19>
				run(&proc_array[pid]);
  1000c7:	83 ec 0c             	sub    $0xc,%esp
  1000ca:	e9 c4 00 00 00       	jmp    100193 <schedule+0xf7>
		}

	if (scheduling_algorithm == 1) {
  1000cf:	83 f8 01             	cmp    $0x1,%eax
  1000d2:	75 6a                	jne    10013e <schedule+0xa2>
        for (pid = 1; pid < NPROCS; pid++) {
            proc_array[pid].p_priority = NPROCS - pid;        
  1000d4:	c7 05 24 74 10 00 04 	movl   $0x4,0x107424
  1000db:	00 00 00 
  1000de:	31 d2                	xor    %edx,%edx
  1000e0:	c7 05 78 74 10 00 03 	movl   $0x3,0x107478
  1000e7:	00 00 00 
  1000ea:	c7 05 cc 74 10 00 02 	movl   $0x2,0x1074cc
  1000f1:	00 00 00 
  1000f4:	c7 05 20 75 10 00 01 	movl   $0x1,0x107520
  1000fb:	00 00 00 
  1000fe:	eb 25                	jmp    100125 <schedule+0x89>
        }
		while (1) {
			process_t *most_prior = NULL;
			for (pid = 1; pid < NPROCS; pid++) {
				if (proc_array[pid].p_state == P_RUNNABLE) {
  100100:	6b c8 54             	imul   $0x54,%eax,%ecx
  100103:	83 b9 c8 73 10 00 01 	cmpl   $0x1,0x1073c8(%ecx)
  10010a:	75 18                	jne    100124 <schedule+0x88>
					if ((most_prior && most_prior->p_priority <
  10010c:	85 d2                	test   %edx,%edx
  10010e:	74 0b                	je     10011b <schedule+0x7f>
  100110:	8b 5a 50             	mov    0x50(%edx),%ebx
  100113:	3b 99 d0 73 10 00    	cmp    0x1073d0(%ecx),%ebx
  100119:	7d 09                	jge    100124 <schedule+0x88>
						proc_array[pid].p_priority)
						|| !most_prior)
					{
						most_prior = &proc_array[pid];
  10011b:	6b d0 54             	imul   $0x54,%eax,%edx
  10011e:	81 c2 80 73 10 00    	add    $0x107380,%edx
        for (pid = 1; pid < NPROCS; pid++) {
            proc_array[pid].p_priority = NPROCS - pid;        
        }
		while (1) {
			process_t *most_prior = NULL;
			for (pid = 1; pid < NPROCS; pid++) {
  100124:	40                   	inc    %eax
  100125:	83 f8 04             	cmp    $0x4,%eax
  100128:	7e d6                	jle    100100 <schedule+0x64>
					{
						most_prior = &proc_array[pid];
					}
				}
			}
			if (most_prior)
  10012a:	85 d2                	test   %edx,%edx
  10012c:	75 07                	jne    100135 <schedule+0x99>
  10012e:	b8 01 00 00 00       	mov    $0x1,%eax
  100133:	eb cb                	jmp    100100 <schedule+0x64>
				run(most_prior);
  100135:	83 ec 0c             	sub    $0xc,%esp
  100138:	52                   	push   %edx
  100139:	e8 5f 04 00 00       	call   10059d <run>
		}
	}
		
	if (scheduling_algorithm == 2) {
  10013e:	83 f8 02             	cmp    $0x2,%eax
  100141:	75 6c                	jne    1001af <schedule+0x113>
  100143:	8b 1d 00 10 10 00    	mov    0x101000,%ebx
  100149:	ba ec ff ff ff       	mov    $0xffffffec,%edx
  10014e:	b0 01                	mov    $0x1,%al
  100150:	eb 19                	jmp    10016b <schedule+0xcf>
		while (1) {
		    int highest_priority = LOWEST_PRIORITY;
		    for (pid = 1; pid < NPROCS; pid++) {
		        if (proc_array[pid].p_state == P_RUNNABLE &&
  100152:	6b c8 54             	imul   $0x54,%eax,%ecx
  100155:	83 b9 c8 73 10 00 01 	cmpl   $0x1,0x1073c8(%ecx)
  10015c:	75 0c                	jne    10016a <schedule+0xce>
  10015e:	8b 89 d0 73 10 00    	mov    0x1073d0(%ecx),%ecx
  100164:	39 ca                	cmp    %ecx,%edx
  100166:	7d 02                	jge    10016a <schedule+0xce>
  100168:	89 ca                	mov    %ecx,%edx
	}
		
	if (scheduling_algorithm == 2) {
		while (1) {
		    int highest_priority = LOWEST_PRIORITY;
		    for (pid = 1; pid < NPROCS; pid++) {
  10016a:	40                   	inc    %eax
  10016b:	83 f8 04             	cmp    $0x4,%eax
  10016e:	7e e2                	jle    100152 <schedule+0xb6>
  100170:	b9 1c 74 10 00       	mov    $0x10741c,%ecx
  100175:	b8 01 00 00 00       	mov    $0x1,%eax
		            highest_priority = proc_array[pid].p_priority;
		        }
		    }
		    
		    for (pid = 1; pid < NPROCS; pid++) {
		        if (proc_array[pid].p_state == P_RUNNABLE &&
  10017a:	83 39 01             	cmpl   $0x1,(%ecx)
  10017d:	75 1c                	jne    10019b <schedule+0xff>
  10017f:	39 51 08             	cmp    %edx,0x8(%ecx)
  100182:	75 17                	jne    10019b <schedule+0xff>
  100184:	39 d8                	cmp    %ebx,%eax
  100186:	7e 13                	jle    10019b <schedule+0xff>
		            proc_array[pid].p_priority == highest_priority
		            && pid > last_proc_id)
		        {
		            last_proc_id = pid;
  100188:	a3 00 10 10 00       	mov    %eax,0x101000
		            run(&proc_array[pid]);
  10018d:	6b c0 54             	imul   $0x54,%eax,%eax
  100190:	83 ec 0c             	sub    $0xc,%esp
  100193:	05 80 73 10 00       	add    $0x107380,%eax
  100198:	50                   	push   %eax
  100199:	eb 9e                	jmp    100139 <schedule+0x9d>
		            proc_array[pid].p_priority > highest_priority) {
		            highest_priority = proc_array[pid].p_priority;
		        }
		    }
		    
		    for (pid = 1; pid < NPROCS; pid++) {
  10019b:	40                   	inc    %eax
  10019c:	83 c1 54             	add    $0x54,%ecx
  10019f:	83 f8 05             	cmp    $0x5,%eax
  1001a2:	75 d6                	jne    10017a <schedule+0xde>
  1001a4:	31 db                	xor    %ebx,%ebx
  1001a6:	ba ec ff ff ff       	mov    $0xffffffec,%edx
  1001ab:	b0 01                	mov    $0x1,%al
  1001ad:	eb a3                	jmp    100152 <schedule+0xb6>
		    
		    last_proc_id = 0;
		}
	}
	// If we get here, we are running an unknown scheduling algorithm.
	cursorpos = console_printf(cursorpos, 0x100, "\nUnknown scheduling algorithm %d\n", scheduling_algorithm);
  1001af:	8b 15 00 80 19 00    	mov    0x198000,%edx
  1001b5:	50                   	push   %eax
  1001b6:	68 8c 0b 10 00       	push   $0x100b8c
  1001bb:	68 00 01 00 00       	push   $0x100
  1001c0:	52                   	push   %edx
  1001c1:	e8 7c 09 00 00       	call   100b42 <console_printf>
  1001c6:	83 c4 10             	add    $0x10,%esp
  1001c9:	a3 00 80 19 00       	mov    %eax,0x198000
  1001ce:	eb fe                	jmp    1001ce <schedule+0x132>

001001d0 <interrupt>:
 *
 *****************************************************************************/

void
interrupt(registers_t *reg)
{
  1001d0:	57                   	push   %edi
	// Save the current process's register state
	// into its process descriptor
	current->p_registers = *reg;
  1001d1:	8b 3d 90 7d 10 00    	mov    0x107d90,%edi
  1001d7:	b9 11 00 00 00       	mov    $0x11,%ecx
 *
 *****************************************************************************/

void
interrupt(registers_t *reg)
{
  1001dc:	56                   	push   %esi
  1001dd:	53                   	push   %ebx
  1001de:	8b 5c 24 10          	mov    0x10(%esp),%ebx
	// Save the current process's register state
	// into its process descriptor
	current->p_registers = *reg;
  1001e2:	83 c7 04             	add    $0x4,%edi
  1001e5:	89 de                	mov    %ebx,%esi
  1001e7:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)

	switch (reg->reg_intno) {
  1001e9:	8b 43 28             	mov    0x28(%ebx),%eax
  1001ec:	83 f8 31             	cmp    $0x31,%eax
  1001ef:	74 1f                	je     100210 <interrupt+0x40>
  1001f1:	77 0c                	ja     1001ff <interrupt+0x2f>
  1001f3:	83 f8 20             	cmp    $0x20,%eax
  1001f6:	74 78                	je     100270 <interrupt+0xa0>
  1001f8:	83 f8 30             	cmp    $0x30,%eax
  1001fb:	74 0e                	je     10020b <interrupt+0x3b>
  1001fd:	eb 76                	jmp    100275 <interrupt+0xa5>
  1001ff:	83 f8 32             	cmp    $0x32,%eax
  100202:	74 23                	je     100227 <interrupt+0x57>
  100204:	83 f8 33             	cmp    $0x33,%eax
  100207:	74 2f                	je     100238 <interrupt+0x68>
  100209:	eb 6a                	jmp    100275 <interrupt+0xa5>

	case INT_SYS_YIELD:
		// The 'sys_yield' system call asks the kernel to schedule
		// the next process.
		schedule();
  10020b:	e8 8c fe ff ff       	call   10009c <schedule>
		// The application stored its exit status in the %eax register
		// before calling the system call.  The %eax register has
		// changed by now, but we can read the application's value
		// out of the 'reg' argument.
		// (This shows you how to transfer arguments to system calls!)
		current->p_state = P_ZOMBIE;
  100210:	a1 90 7d 10 00       	mov    0x107d90,%eax
		current->p_exit_status = reg->reg_eax;
  100215:	8b 53 1c             	mov    0x1c(%ebx),%edx
		// The application stored its exit status in the %eax register
		// before calling the system call.  The %eax register has
		// changed by now, but we can read the application's value
		// out of the 'reg' argument.
		// (This shows you how to transfer arguments to system calls!)
		current->p_state = P_ZOMBIE;
  100218:	c7 40 48 03 00 00 00 	movl   $0x3,0x48(%eax)
		current->p_exit_status = reg->reg_eax;
  10021f:	89 50 4c             	mov    %edx,0x4c(%eax)
		schedule();
  100222:	e8 75 fe ff ff       	call   10009c <schedule>

	case INT_SYS_RENICE:
		// 'sys_user*' are provided for your convenience, in case you
		// want to add a system call.
		current->p_priority = reg->reg_eax;
  100227:	a1 90 7d 10 00       	mov    0x107d90,%eax
		run(current);
  10022c:	83 ec 0c             	sub    $0xc,%esp
		schedule();

	case INT_SYS_RENICE:
		// 'sys_user*' are provided for your convenience, in case you
		// want to add a system call.
		current->p_priority = reg->reg_eax;
  10022f:	8b 53 1c             	mov    0x1c(%ebx),%edx
  100232:	89 50 50             	mov    %edx,0x50(%eax)
		run(current);
  100235:	50                   	push   %eax
  100236:	eb 33                	jmp    10026b <interrupt+0x9b>

	case INT_SYS_ATOMIC_PRINTC:
		/* Your code here (if you want). */
		lock_acquire(&cursor_lock);
  100238:	83 ec 0c             	sub    $0xc,%esp
  10023b:	68 8c 7d 10 00       	push   $0x107d8c
  100240:	e8 22 09 00 00       	call   100b67 <lock_acquire>
		*cursorpos++ = (uint16_t) reg->reg_eax;
  100245:	a1 00 80 19 00       	mov    0x198000,%eax
  10024a:	8b 53 1c             	mov    0x1c(%ebx),%edx
  10024d:	66 89 10             	mov    %dx,(%eax)
  100250:	83 c0 02             	add    $0x2,%eax
  100253:	a3 00 80 19 00       	mov    %eax,0x198000
		lock_release(&cursor_lock);
  100258:	c7 04 24 8c 7d 10 00 	movl   $0x107d8c,(%esp)
  10025f:	e8 1b 09 00 00       	call   100b7f <lock_release>
		run(current);
  100264:	58                   	pop    %eax
  100265:	ff 35 90 7d 10 00    	pushl  0x107d90
  10026b:	e8 2d 03 00 00       	call   10059d <run>

	case INT_CLOCK:
		// A clock interrupt occurred (so an application exhausted its
		// time quantum).
		// Switch to the next runnable process.
		schedule();
  100270:	e8 27 fe ff ff       	call   10009c <schedule>
  100275:	eb fe                	jmp    100275 <interrupt+0xa5>

00100277 <start>:
 *
 *****************************************************************************/

void
start(void)
{
  100277:	57                   	push   %edi

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
  100278:	bf 00 00 30 00       	mov    $0x300000,%edi
 *
 *****************************************************************************/

void
start(void)
{
  10027d:	56                   	push   %esi

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
  10027e:	31 f6                	xor    %esi,%esi
 *
 *****************************************************************************/

void
start(void)
{
  100280:	53                   	push   %ebx

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
  100281:	bb d4 73 10 00       	mov    $0x1073d4,%ebx
start(void)
{
	int i;

	// Set up hardware (schedos-x86.c)
	segments_init();
  100286:	e8 f1 00 00 00       	call   10037c <segments_init>
	interrupt_controller_init(1);
  10028b:	83 ec 0c             	sub    $0xc,%esp
  10028e:	6a 01                	push   $0x1
  100290:	e8 e2 01 00 00       	call   100477 <interrupt_controller_init>
	console_clear();
  100295:	e8 66 02 00 00       	call   100500 <console_clear>

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
  10029a:	83 c4 0c             	add    $0xc,%esp
  10029d:	68 a4 01 00 00       	push   $0x1a4
  1002a2:	6a 00                	push   $0x0
  1002a4:	68 80 73 10 00       	push   $0x107380
  1002a9:	e8 32 04 00 00       	call   1006e0 <memset>
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
  1002ae:	83 c4 10             	add    $0x10,%esp
	console_clear();

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
  1002b1:	c7 05 80 73 10 00 00 	movl   $0x0,0x107380
  1002b8:	00 00 00 
		proc_array[i].p_state = P_EMPTY;
  1002bb:	c7 05 c8 73 10 00 00 	movl   $0x0,0x1073c8
  1002c2:	00 00 00 
	console_clear();

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
  1002c5:	c7 05 d4 73 10 00 01 	movl   $0x1,0x1073d4
  1002cc:	00 00 00 
		proc_array[i].p_state = P_EMPTY;
  1002cf:	c7 05 1c 74 10 00 00 	movl   $0x0,0x10741c
  1002d6:	00 00 00 
	console_clear();

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
  1002d9:	c7 05 28 74 10 00 02 	movl   $0x2,0x107428
  1002e0:	00 00 00 
		proc_array[i].p_state = P_EMPTY;
  1002e3:	c7 05 70 74 10 00 00 	movl   $0x0,0x107470
  1002ea:	00 00 00 
	console_clear();

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
  1002ed:	c7 05 7c 74 10 00 03 	movl   $0x3,0x10747c
  1002f4:	00 00 00 
		proc_array[i].p_state = P_EMPTY;
  1002f7:	c7 05 c4 74 10 00 00 	movl   $0x0,0x1074c4
  1002fe:	00 00 00 
	console_clear();

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
  100301:	c7 05 d0 74 10 00 04 	movl   $0x4,0x1074d0
  100308:	00 00 00 
		proc_array[i].p_state = P_EMPTY;
  10030b:	c7 05 18 75 10 00 00 	movl   $0x0,0x107518
  100312:	00 00 00 
	for (i = 1; i < NPROCS; i++) {
		process_t *proc = &proc_array[i];
		uint32_t stack_ptr = PROC1_START + i * PROC_SIZE;

		// Initialize the process descriptor
		special_registers_init(proc);
  100315:	83 ec 0c             	sub    $0xc,%esp
  100318:	53                   	push   %ebx
  100319:	e8 96 02 00 00       	call   1005b4 <special_registers_init>

		// Set ESP
		proc->p_registers.reg_esp = stack_ptr;

		// Load process and set EIP, based on ELF image
		program_loader(i - 1, &proc->p_registers.reg_eip);
  10031e:	8d 43 34             	lea    0x34(%ebx),%eax
  100321:	5a                   	pop    %edx
  100322:	59                   	pop    %ecx

		// Initialize the process descriptor
		special_registers_init(proc);

		// Set ESP
		proc->p_registers.reg_esp = stack_ptr;
  100323:	89 7b 40             	mov    %edi,0x40(%ebx)

		// Mark the process as runnable!
		proc->p_state = P_RUNNABLE;

        // Initialize priority.
        proc->p_priority = 0;
  100326:	81 c7 00 00 10 00    	add    $0x100000,%edi

		// Set ESP
		proc->p_registers.reg_esp = stack_ptr;

		// Load process and set EIP, based on ELF image
		program_loader(i - 1, &proc->p_registers.reg_eip);
  10032c:	50                   	push   %eax
  10032d:	56                   	push   %esi

		// Mark the process as runnable!
		proc->p_state = P_RUNNABLE;

        // Initialize priority.
        proc->p_priority = 0;
  10032e:	46                   	inc    %esi

		// Set ESP
		proc->p_registers.reg_esp = stack_ptr;

		// Load process and set EIP, based on ELF image
		program_loader(i - 1, &proc->p_registers.reg_eip);
  10032f:	e8 bc 02 00 00       	call   1005f0 <program_loader>
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
	}

	// Set up process descriptors (the proc_array[])
	for (i = 1; i < NPROCS; i++) {
  100334:	83 c4 10             	add    $0x10,%esp

		// Load process and set EIP, based on ELF image
		program_loader(i - 1, &proc->p_registers.reg_eip);

		// Mark the process as runnable!
		proc->p_state = P_RUNNABLE;
  100337:	c7 43 48 01 00 00 00 	movl   $0x1,0x48(%ebx)

        // Initialize priority.
        proc->p_priority = 0;
  10033e:	c7 43 50 00 00 00 00 	movl   $0x0,0x50(%ebx)
  100345:	83 c3 54             	add    $0x54,%ebx
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
	}

	// Set up process descriptors (the proc_array[])
	for (i = 1; i < NPROCS; i++) {
  100348:	83 fe 04             	cmp    $0x4,%esi
  10034b:	75 c8                	jne    100315 <start+0x9e>
	}

	// Initialize the cursor-position shared variable to point to the
	// console's first character (the upper left).
	cursorpos = (uint16_t *) 0xB8000;
	lock_init(&cursor_lock);
  10034d:	83 ec 0c             	sub    $0xc,%esp
  100350:	68 8c 7d 10 00       	push   $0x107d8c
        proc->p_priority = 0;
	}

	// Initialize the cursor-position shared variable to point to the
	// console's first character (the upper left).
	cursorpos = (uint16_t *) 0xB8000;
  100355:	c7 05 00 80 19 00 00 	movl   $0xb8000,0x198000
  10035c:	80 0b 00 
	lock_init(&cursor_lock);
  10035f:	e8 f8 07 00 00       	call   100b5c <lock_init>
	// Initialize the scheduling algorithm.
	scheduling_algorithm = 0;
  100364:	c7 05 94 7d 10 00 00 	movl   $0x0,0x107d94
  10036b:	00 00 00 

	// Switch to the first process.
	run(&proc_array[1]);
  10036e:	c7 04 24 d4 73 10 00 	movl   $0x1073d4,(%esp)
  100375:	e8 23 02 00 00       	call   10059d <run>
  10037a:	90                   	nop
  10037b:	90                   	nop

0010037c <segments_init>:
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  10037c:	b8 24 75 10 00       	mov    $0x107524,%eax
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  100381:	b9 5c 00 10 00       	mov    $0x10005c,%ecx
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  100386:	89 c2                	mov    %eax,%edx
  100388:	c1 ea 10             	shr    $0x10,%edx
extern void default_int_handler(void);


void
segments_init(void)
{
  10038b:	53                   	push   %ebx
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  10038c:	bb 5c 00 10 00       	mov    $0x10005c,%ebx
  100391:	c1 eb 10             	shr    $0x10,%ebx
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  100394:	66 a3 3e 10 10 00    	mov    %ax,0x10103e
  10039a:	c1 e8 18             	shr    $0x18,%eax
  10039d:	88 15 40 10 10 00    	mov    %dl,0x101040
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  1003a3:	ba 8c 75 10 00       	mov    $0x10758c,%edx
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  1003a8:	a2 43 10 10 00       	mov    %al,0x101043
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  1003ad:	31 c0                	xor    %eax,%eax
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  1003af:	66 c7 05 3c 10 10 00 	movw   $0x68,0x10103c
  1003b6:	68 00 
  1003b8:	c6 05 42 10 10 00 40 	movb   $0x40,0x101042
		= SEG16(STS_T32A, (uint32_t) &kernel_task_descriptor,
			sizeof(taskstate_t), 0);
	segments[SEGSEL_TASKSTATE >> 3].sd_s = 0;
  1003bf:	c6 05 41 10 10 00 89 	movb   $0x89,0x101041

	// Set up kernel task descriptor, so we can receive interrupts
	kernel_task_descriptor.ts_esp0 = KERNEL_STACK_TOP;
  1003c6:	c7 05 28 75 10 00 00 	movl   $0x180000,0x107528
  1003cd:	00 18 00 
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;
  1003d0:	66 c7 05 2c 75 10 00 	movw   $0x10,0x10752c
  1003d7:	10 00 

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  1003d9:	66 89 0c c5 8c 75 10 	mov    %cx,0x10758c(,%eax,8)
  1003e0:	00 
  1003e1:	66 c7 44 c2 02 08 00 	movw   $0x8,0x2(%edx,%eax,8)
  1003e8:	c6 44 c2 04 00       	movb   $0x0,0x4(%edx,%eax,8)
  1003ed:	c6 44 c2 05 8e       	movb   $0x8e,0x5(%edx,%eax,8)
  1003f2:	66 89 5c c2 06       	mov    %bx,0x6(%edx,%eax,8)
	kernel_task_descriptor.ts_esp0 = KERNEL_STACK_TOP;
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
  1003f7:	40                   	inc    %eax
  1003f8:	3d 00 01 00 00       	cmp    $0x100,%eax
  1003fd:	75 da                	jne    1003d9 <segments_init+0x5d>
		SETGATE(interrupt_descriptors[i], 0,
			SEGSEL_KERN_CODE, default_int_handler, 0);

	// The clock interrupt gets special handling
	SETGATE(interrupt_descriptors[INT_CLOCK], 0,
  1003ff:	b8 1a 00 10 00       	mov    $0x10001a,%eax

	// System calls get special handling.
	// Note that the last argument is '3'.  This means that unprivileged
	// (level-3) applications may generate these interrupts.
	for (i = INT_SYS_YIELD; i < INT_SYS_YIELD + 10; i++)
		SETGATE(interrupt_descriptors[i], 0,
  100404:	ba 8c 75 10 00       	mov    $0x10758c,%edx
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
			SEGSEL_KERN_CODE, default_int_handler, 0);

	// The clock interrupt gets special handling
	SETGATE(interrupt_descriptors[INT_CLOCK], 0,
  100409:	66 a3 8c 76 10 00    	mov    %ax,0x10768c
  10040f:	c1 e8 10             	shr    $0x10,%eax
  100412:	66 a3 92 76 10 00    	mov    %ax,0x107692
  100418:	b8 30 00 00 00       	mov    $0x30,%eax
  10041d:	66 c7 05 8e 76 10 00 	movw   $0x8,0x10768e
  100424:	08 00 
  100426:	c6 05 90 76 10 00 00 	movb   $0x0,0x107690
  10042d:	c6 05 91 76 10 00 8e 	movb   $0x8e,0x107691

	// System calls get special handling.
	// Note that the last argument is '3'.  This means that unprivileged
	// (level-3) applications may generate these interrupts.
	for (i = INT_SYS_YIELD; i < INT_SYS_YIELD + 10; i++)
		SETGATE(interrupt_descriptors[i], 0,
  100434:	8b 0c 85 b2 ff 0f 00 	mov    0xfffb2(,%eax,4),%ecx
  10043b:	66 c7 44 c2 02 08 00 	movw   $0x8,0x2(%edx,%eax,8)
  100442:	66 89 0c c5 8c 75 10 	mov    %cx,0x10758c(,%eax,8)
  100449:	00 
  10044a:	c1 e9 10             	shr    $0x10,%ecx
  10044d:	c6 44 c2 04 00       	movb   $0x0,0x4(%edx,%eax,8)
  100452:	c6 44 c2 05 ee       	movb   $0xee,0x5(%edx,%eax,8)
  100457:	66 89 4c c2 06       	mov    %cx,0x6(%edx,%eax,8)
		SEGSEL_KERN_CODE, clock_int_handler, 0);

	// System calls get special handling.
	// Note that the last argument is '3'.  This means that unprivileged
	// (level-3) applications may generate these interrupts.
	for (i = INT_SYS_YIELD; i < INT_SYS_YIELD + 10; i++)
  10045c:	40                   	inc    %eax
  10045d:	83 f8 3a             	cmp    $0x3a,%eax
  100460:	75 d2                	jne    100434 <segments_init+0xb8>
		SETGATE(interrupt_descriptors[i], 0,
			SEGSEL_KERN_CODE, sys_int_handlers[i - INT_SYS_YIELD], 3);

	// Reload segment pointers
	asm volatile("lgdt global_descriptor_table\n\t"
  100462:	b0 28                	mov    $0x28,%al
  100464:	0f 01 15 04 10 10 00 	lgdtl  0x101004
  10046b:	0f 00 d8             	ltr    %ax
  10046e:	0f 01 1d 0c 10 10 00 	lidtl  0x10100c
		     "lidt interrupt_descriptor_table"
		     : : "r" ((uint16_t) SEGSEL_TASKSTATE));

	// Convince compiler that all symbols were used
	(void) global_descriptor_table, (void) interrupt_descriptor_table;
}
  100475:	5b                   	pop    %ebx
  100476:	c3                   	ret    

00100477 <interrupt_controller_init>:
#define	TIMER_FREQ	1193182
#define TIMER_DIV(x)	((TIMER_FREQ+(x)/2)/(x))

void
interrupt_controller_init(bool_t allow_clock_interrupt)
{
  100477:	55                   	push   %ebp
}

static inline void
outb(int port, uint8_t data)
{
	asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
  100478:	b0 ff                	mov    $0xff,%al
  10047a:	57                   	push   %edi
  10047b:	56                   	push   %esi
  10047c:	53                   	push   %ebx
  10047d:	bb 21 00 00 00       	mov    $0x21,%ebx
  100482:	89 da                	mov    %ebx,%edx
  100484:	ee                   	out    %al,(%dx)
  100485:	b9 a1 00 00 00       	mov    $0xa1,%ecx
  10048a:	89 ca                	mov    %ecx,%edx
  10048c:	ee                   	out    %al,(%dx)
  10048d:	be 11 00 00 00       	mov    $0x11,%esi
  100492:	bf 20 00 00 00       	mov    $0x20,%edi
  100497:	89 f0                	mov    %esi,%eax
  100499:	89 fa                	mov    %edi,%edx
  10049b:	ee                   	out    %al,(%dx)
  10049c:	b0 20                	mov    $0x20,%al
  10049e:	89 da                	mov    %ebx,%edx
  1004a0:	ee                   	out    %al,(%dx)
  1004a1:	b0 04                	mov    $0x4,%al
  1004a3:	ee                   	out    %al,(%dx)
  1004a4:	b0 03                	mov    $0x3,%al
  1004a6:	ee                   	out    %al,(%dx)
  1004a7:	bd a0 00 00 00       	mov    $0xa0,%ebp
  1004ac:	89 f0                	mov    %esi,%eax
  1004ae:	89 ea                	mov    %ebp,%edx
  1004b0:	ee                   	out    %al,(%dx)
  1004b1:	b0 28                	mov    $0x28,%al
  1004b3:	89 ca                	mov    %ecx,%edx
  1004b5:	ee                   	out    %al,(%dx)
  1004b6:	b0 02                	mov    $0x2,%al
  1004b8:	ee                   	out    %al,(%dx)
  1004b9:	b0 01                	mov    $0x1,%al
  1004bb:	ee                   	out    %al,(%dx)
  1004bc:	b0 68                	mov    $0x68,%al
  1004be:	89 fa                	mov    %edi,%edx
  1004c0:	ee                   	out    %al,(%dx)
  1004c1:	be 0a 00 00 00       	mov    $0xa,%esi
  1004c6:	89 f0                	mov    %esi,%eax
  1004c8:	ee                   	out    %al,(%dx)
  1004c9:	b0 68                	mov    $0x68,%al
  1004cb:	89 ea                	mov    %ebp,%edx
  1004cd:	ee                   	out    %al,(%dx)
  1004ce:	89 f0                	mov    %esi,%eax
  1004d0:	ee                   	out    %al,(%dx)

	outb(IO_PIC2, 0x68);               /* OCW3 */
	outb(IO_PIC2, 0x0a);               /* OCW3 */

	// mask all interrupts again, except possibly for clock interrupt
	outb(IO_PIC1+1, (allow_clock_interrupt ? 0xFE : 0xFF));
  1004d1:	83 7c 24 14 01       	cmpl   $0x1,0x14(%esp)
  1004d6:	89 da                	mov    %ebx,%edx
  1004d8:	19 c0                	sbb    %eax,%eax
  1004da:	f7 d0                	not    %eax
  1004dc:	05 ff 00 00 00       	add    $0xff,%eax
  1004e1:	ee                   	out    %al,(%dx)
  1004e2:	b0 ff                	mov    $0xff,%al
  1004e4:	89 ca                	mov    %ecx,%edx
  1004e6:	ee                   	out    %al,(%dx)
	outb(IO_PIC2+1, 0xFF);

	// if the clock interrupt is allowed, initialize the clock
	if (allow_clock_interrupt) {
  1004e7:	83 7c 24 14 00       	cmpl   $0x0,0x14(%esp)
  1004ec:	74 0d                	je     1004fb <interrupt_controller_init+0x84>
  1004ee:	b2 43                	mov    $0x43,%dl
  1004f0:	b0 34                	mov    $0x34,%al
  1004f2:	ee                   	out    %al,(%dx)
  1004f3:	b0 a9                	mov    $0xa9,%al
  1004f5:	b2 40                	mov    $0x40,%dl
  1004f7:	ee                   	out    %al,(%dx)
  1004f8:	b0 04                	mov    $0x4,%al
  1004fa:	ee                   	out    %al,(%dx)
		outb(TIMER_MODE, TIMER_SEL0 | TIMER_RATEGEN | TIMER_16BIT);
		outb(IO_TIMER1, TIMER_DIV(HZ) % 256);
		outb(IO_TIMER1, TIMER_DIV(HZ) / 256);
	}
}
  1004fb:	5b                   	pop    %ebx
  1004fc:	5e                   	pop    %esi
  1004fd:	5f                   	pop    %edi
  1004fe:	5d                   	pop    %ebp
  1004ff:	c3                   	ret    

00100500 <console_clear>:
 *
 *****************************************************************************/

void
console_clear(void)
{
  100500:	56                   	push   %esi
	int i;
	cursorpos = (uint16_t *) 0xB8000;
  100501:	31 c0                	xor    %eax,%eax
 *
 *****************************************************************************/

void
console_clear(void)
{
  100503:	53                   	push   %ebx
	int i;
	cursorpos = (uint16_t *) 0xB8000;
  100504:	c7 05 00 80 19 00 00 	movl   $0xb8000,0x198000
  10050b:	80 0b 00 

	for (i = 0; i < 80 * 25; i++)
		cursorpos[i] = ' ' | 0x0700;
  10050e:	8b 15 00 80 19 00    	mov    0x198000,%edx
  100514:	66 c7 04 02 20 07    	movw   $0x720,(%edx,%eax,1)
  10051a:	83 c0 02             	add    $0x2,%eax
console_clear(void)
{
	int i;
	cursorpos = (uint16_t *) 0xB8000;

	for (i = 0; i < 80 * 25; i++)
  10051d:	3d a0 0f 00 00       	cmp    $0xfa0,%eax
  100522:	75 ea                	jne    10050e <console_clear+0xe>
  100524:	be d4 03 00 00       	mov    $0x3d4,%esi
  100529:	b0 0e                	mov    $0xe,%al
  10052b:	89 f2                	mov    %esi,%edx
  10052d:	ee                   	out    %al,(%dx)
  10052e:	31 c9                	xor    %ecx,%ecx
  100530:	bb d5 03 00 00       	mov    $0x3d5,%ebx
  100535:	88 c8                	mov    %cl,%al
  100537:	89 da                	mov    %ebx,%edx
  100539:	ee                   	out    %al,(%dx)
  10053a:	b0 0f                	mov    $0xf,%al
  10053c:	89 f2                	mov    %esi,%edx
  10053e:	ee                   	out    %al,(%dx)
  10053f:	88 c8                	mov    %cl,%al
  100541:	89 da                	mov    %ebx,%edx
  100543:	ee                   	out    %al,(%dx)
		cursorpos[i] = ' ' | 0x0700;
	outb(0x3D4, 14);
	outb(0x3D5, 0 / 256);
	outb(0x3D4, 15);
	outb(0x3D5, 0 % 256);
}
  100544:	5b                   	pop    %ebx
  100545:	5e                   	pop    %esi
  100546:	c3                   	ret    

00100547 <console_read_digit>:

static inline uint8_t
inb(int port)
{
	uint8_t data;
	asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
  100547:	ba 64 00 00 00       	mov    $0x64,%edx
  10054c:	ec                   	in     (%dx),%al
int
console_read_digit(void)
{
	uint8_t data;

	if ((inb(KBSTATP) & KBS_DIB) == 0)
  10054d:	a8 01                	test   $0x1,%al
  10054f:	74 45                	je     100596 <console_read_digit+0x4f>
  100551:	b2 60                	mov    $0x60,%dl
  100553:	ec                   	in     (%dx),%al
		return -1;

	data = inb(KBDATAP);
	if (data >= 0x02 && data <= 0x0A)
  100554:	8d 50 fe             	lea    -0x2(%eax),%edx
  100557:	80 fa 08             	cmp    $0x8,%dl
  10055a:	77 05                	ja     100561 <console_read_digit+0x1a>
		return data - 0x02 + 1;
  10055c:	0f b6 c0             	movzbl %al,%eax
  10055f:	48                   	dec    %eax
  100560:	c3                   	ret    
	else if (data == 0x0B)
  100561:	3c 0b                	cmp    $0xb,%al
  100563:	74 35                	je     10059a <console_read_digit+0x53>
		return 0;
	else if (data >= 0x47 && data <= 0x49)
  100565:	8d 50 b9             	lea    -0x47(%eax),%edx
  100568:	80 fa 02             	cmp    $0x2,%dl
  10056b:	77 07                	ja     100574 <console_read_digit+0x2d>
		return data - 0x47 + 7;
  10056d:	0f b6 c0             	movzbl %al,%eax
  100570:	83 e8 40             	sub    $0x40,%eax
  100573:	c3                   	ret    
	else if (data >= 0x4B && data <= 0x4D)
  100574:	8d 50 b5             	lea    -0x4b(%eax),%edx
  100577:	80 fa 02             	cmp    $0x2,%dl
  10057a:	77 07                	ja     100583 <console_read_digit+0x3c>
		return data - 0x4B + 4;
  10057c:	0f b6 c0             	movzbl %al,%eax
  10057f:	83 e8 47             	sub    $0x47,%eax
  100582:	c3                   	ret    
	else if (data >= 0x4F && data <= 0x51)
  100583:	8d 50 b1             	lea    -0x4f(%eax),%edx
  100586:	80 fa 02             	cmp    $0x2,%dl
  100589:	77 07                	ja     100592 <console_read_digit+0x4b>
		return data - 0x4F + 1;
  10058b:	0f b6 c0             	movzbl %al,%eax
  10058e:	83 e8 4e             	sub    $0x4e,%eax
  100591:	c3                   	ret    
	else if (data == 0x53)
  100592:	3c 53                	cmp    $0x53,%al
  100594:	74 04                	je     10059a <console_read_digit+0x53>
  100596:	83 c8 ff             	or     $0xffffffff,%eax
  100599:	c3                   	ret    
  10059a:	31 c0                	xor    %eax,%eax
		return 0;
	else
		return -1;
}
  10059c:	c3                   	ret    

0010059d <run>:
 *
 *****************************************************************************/

void
run(process_t *proc)
{
  10059d:	8b 44 24 04          	mov    0x4(%esp),%eax
	current = proc;
  1005a1:	a3 90 7d 10 00       	mov    %eax,0x107d90

	asm volatile("movl %0,%%esp\n\t"
  1005a6:	83 c0 04             	add    $0x4,%eax
  1005a9:	89 c4                	mov    %eax,%esp
  1005ab:	61                   	popa   
  1005ac:	07                   	pop    %es
  1005ad:	1f                   	pop    %ds
  1005ae:	83 c4 08             	add    $0x8,%esp
  1005b1:	cf                   	iret   
  1005b2:	eb fe                	jmp    1005b2 <run+0x15>

001005b4 <special_registers_init>:
 *
 *****************************************************************************/

void
special_registers_init(process_t *proc)
{
  1005b4:	53                   	push   %ebx
  1005b5:	83 ec 0c             	sub    $0xc,%esp
  1005b8:	8b 5c 24 14          	mov    0x14(%esp),%ebx
	memset(&proc->p_registers, 0, sizeof(registers_t));
  1005bc:	6a 44                	push   $0x44
  1005be:	6a 00                	push   $0x0
  1005c0:	8d 43 04             	lea    0x4(%ebx),%eax
  1005c3:	50                   	push   %eax
  1005c4:	e8 17 01 00 00       	call   1006e0 <memset>
	proc->p_registers.reg_cs = SEGSEL_APP_CODE | 3;
  1005c9:	66 c7 43 38 1b 00    	movw   $0x1b,0x38(%ebx)
	proc->p_registers.reg_ds = SEGSEL_APP_DATA | 3;
  1005cf:	66 c7 43 28 23 00    	movw   $0x23,0x28(%ebx)
	proc->p_registers.reg_es = SEGSEL_APP_DATA | 3;
  1005d5:	66 c7 43 24 23 00    	movw   $0x23,0x24(%ebx)
	proc->p_registers.reg_ss = SEGSEL_APP_DATA | 3;
  1005db:	66 c7 43 44 23 00    	movw   $0x23,0x44(%ebx)
	// Enable interrupts
	proc->p_registers.reg_eflags = EFLAGS_IF;
  1005e1:	c7 43 3c 00 02 00 00 	movl   $0x200,0x3c(%ebx)
}
  1005e8:	83 c4 18             	add    $0x18,%esp
  1005eb:	5b                   	pop    %ebx
  1005ec:	c3                   	ret    
  1005ed:	90                   	nop
  1005ee:	90                   	nop
  1005ef:	90                   	nop

001005f0 <program_loader>:
		    uint32_t filesz, uint32_t memsz);
static void loader_panic(void);

void
program_loader(int program_id, uint32_t *entry_point)
{
  1005f0:	55                   	push   %ebp
  1005f1:	57                   	push   %edi
  1005f2:	56                   	push   %esi
  1005f3:	53                   	push   %ebx
  1005f4:	83 ec 1c             	sub    $0x1c,%esp
  1005f7:	8b 44 24 30          	mov    0x30(%esp),%eax
	struct Proghdr *ph, *eph;
	struct Elf *elf_header;
	int nprograms = sizeof(ramimages) / sizeof(ramimages[0]);

	if (program_id < 0 || program_id >= nprograms)
  1005fb:	83 f8 03             	cmp    $0x3,%eax
  1005fe:	7f 04                	jg     100604 <program_loader+0x14>
  100600:	85 c0                	test   %eax,%eax
  100602:	79 02                	jns    100606 <program_loader+0x16>
  100604:	eb fe                	jmp    100604 <program_loader+0x14>
		loader_panic();

	// is this a valid ELF?
	elf_header = (struct Elf *) ramimages[program_id].begin;
  100606:	8b 34 c5 44 10 10 00 	mov    0x101044(,%eax,8),%esi
	if (elf_header->e_magic != ELF_MAGIC)
  10060d:	81 3e 7f 45 4c 46    	cmpl   $0x464c457f,(%esi)
  100613:	74 02                	je     100617 <program_loader+0x27>
  100615:	eb fe                	jmp    100615 <program_loader+0x25>
		loader_panic();

	// load each program segment (ignores ph flags)
	ph = (struct Proghdr*) ((const uint8_t *) elf_header + elf_header->e_phoff);
  100617:	8b 5e 1c             	mov    0x1c(%esi),%ebx
	eph = ph + elf_header->e_phnum;
  10061a:	0f b7 6e 2c          	movzwl 0x2c(%esi),%ebp
	elf_header = (struct Elf *) ramimages[program_id].begin;
	if (elf_header->e_magic != ELF_MAGIC)
		loader_panic();

	// load each program segment (ignores ph flags)
	ph = (struct Proghdr*) ((const uint8_t *) elf_header + elf_header->e_phoff);
  10061e:	01 f3                	add    %esi,%ebx
	eph = ph + elf_header->e_phnum;
  100620:	c1 e5 05             	shl    $0x5,%ebp
  100623:	8d 2c 2b             	lea    (%ebx,%ebp,1),%ebp
	for (; ph < eph; ph++)
  100626:	eb 3f                	jmp    100667 <program_loader+0x77>
		if (ph->p_type == ELF_PROG_LOAD)
  100628:	83 3b 01             	cmpl   $0x1,(%ebx)
  10062b:	75 37                	jne    100664 <program_loader+0x74>
			copyseg((void *) ph->p_va,
  10062d:	8b 43 08             	mov    0x8(%ebx),%eax
// then clear the memory from 'va+filesz' up to 'va+memsz' (set it to 0).
static void
copyseg(void *dst, const uint8_t *src, uint32_t filesz, uint32_t memsz)
{
	uint32_t va = (uint32_t) dst;
	uint32_t end_va = va + filesz;
  100630:	8b 7b 10             	mov    0x10(%ebx),%edi
	memsz += va;
  100633:	8b 53 14             	mov    0x14(%ebx),%edx
// then clear the memory from 'va+filesz' up to 'va+memsz' (set it to 0).
static void
copyseg(void *dst, const uint8_t *src, uint32_t filesz, uint32_t memsz)
{
	uint32_t va = (uint32_t) dst;
	uint32_t end_va = va + filesz;
  100636:	01 c7                	add    %eax,%edi
	memsz += va;
  100638:	01 c2                	add    %eax,%edx
	va &= ~(PAGESIZE - 1);		// round to page boundary
  10063a:	25 00 f0 ff ff       	and    $0xfffff000,%eax
static void
copyseg(void *dst, const uint8_t *src, uint32_t filesz, uint32_t memsz)
{
	uint32_t va = (uint32_t) dst;
	uint32_t end_va = va + filesz;
	memsz += va;
  10063f:	89 54 24 0c          	mov    %edx,0xc(%esp)
	va &= ~(PAGESIZE - 1);		// round to page boundary

	// copy data
	memcpy((uint8_t *) va, src, end_va - va);
  100643:	52                   	push   %edx
  100644:	89 fa                	mov    %edi,%edx
  100646:	29 c2                	sub    %eax,%edx
  100648:	52                   	push   %edx
  100649:	8b 53 04             	mov    0x4(%ebx),%edx
  10064c:	01 f2                	add    %esi,%edx
  10064e:	52                   	push   %edx
  10064f:	50                   	push   %eax
  100650:	e8 27 00 00 00       	call   10067c <memcpy>
  100655:	83 c4 10             	add    $0x10,%esp
  100658:	eb 04                	jmp    10065e <program_loader+0x6e>

	// clear bss segment
	while (end_va < memsz)
		*((uint8_t *) end_va++) = 0;
  10065a:	c6 07 00             	movb   $0x0,(%edi)
  10065d:	47                   	inc    %edi

	// copy data
	memcpy((uint8_t *) va, src, end_va - va);

	// clear bss segment
	while (end_va < memsz)
  10065e:	3b 7c 24 0c          	cmp    0xc(%esp),%edi
  100662:	72 f6                	jb     10065a <program_loader+0x6a>
		loader_panic();

	// load each program segment (ignores ph flags)
	ph = (struct Proghdr*) ((const uint8_t *) elf_header + elf_header->e_phoff);
	eph = ph + elf_header->e_phnum;
	for (; ph < eph; ph++)
  100664:	83 c3 20             	add    $0x20,%ebx
  100667:	39 eb                	cmp    %ebp,%ebx
  100669:	72 bd                	jb     100628 <program_loader+0x38>
			copyseg((void *) ph->p_va,
				(const uint8_t *) elf_header + ph->p_offset,
				ph->p_filesz, ph->p_memsz);

	// store the entry point from the ELF header
	*entry_point = elf_header->e_entry;
  10066b:	8b 56 18             	mov    0x18(%esi),%edx
  10066e:	8b 44 24 34          	mov    0x34(%esp),%eax
  100672:	89 10                	mov    %edx,(%eax)
}
  100674:	83 c4 1c             	add    $0x1c,%esp
  100677:	5b                   	pop    %ebx
  100678:	5e                   	pop    %esi
  100679:	5f                   	pop    %edi
  10067a:	5d                   	pop    %ebp
  10067b:	c3                   	ret    

0010067c <memcpy>:
 *
 *   We must provide our own implementations of these basic functions. */

void *
memcpy(void *dst, const void *src, size_t n)
{
  10067c:	56                   	push   %esi
  10067d:	31 d2                	xor    %edx,%edx
  10067f:	53                   	push   %ebx
  100680:	8b 44 24 0c          	mov    0xc(%esp),%eax
  100684:	8b 5c 24 10          	mov    0x10(%esp),%ebx
  100688:	8b 74 24 14          	mov    0x14(%esp),%esi
	const char *s = (const char *) src;
	char *d = (char *) dst;
	while (n-- > 0)
  10068c:	eb 08                	jmp    100696 <memcpy+0x1a>
		*d++ = *s++;
  10068e:	8a 0c 13             	mov    (%ebx,%edx,1),%cl
  100691:	4e                   	dec    %esi
  100692:	88 0c 10             	mov    %cl,(%eax,%edx,1)
  100695:	42                   	inc    %edx
void *
memcpy(void *dst, const void *src, size_t n)
{
	const char *s = (const char *) src;
	char *d = (char *) dst;
	while (n-- > 0)
  100696:	85 f6                	test   %esi,%esi
  100698:	75 f4                	jne    10068e <memcpy+0x12>
		*d++ = *s++;
	return dst;
}
  10069a:	5b                   	pop    %ebx
  10069b:	5e                   	pop    %esi
  10069c:	c3                   	ret    

0010069d <memmove>:

void *
memmove(void *dst, const void *src, size_t n)
{
  10069d:	57                   	push   %edi
  10069e:	56                   	push   %esi
  10069f:	53                   	push   %ebx
  1006a0:	8b 44 24 10          	mov    0x10(%esp),%eax
  1006a4:	8b 7c 24 14          	mov    0x14(%esp),%edi
  1006a8:	8b 54 24 18          	mov    0x18(%esp),%edx
	const char *s = (const char *) src;
	char *d = (char *) dst;
	if (s < d && s + n > d) {
  1006ac:	39 c7                	cmp    %eax,%edi
  1006ae:	73 26                	jae    1006d6 <memmove+0x39>
  1006b0:	8d 34 17             	lea    (%edi,%edx,1),%esi
  1006b3:	39 c6                	cmp    %eax,%esi
  1006b5:	76 1f                	jbe    1006d6 <memmove+0x39>
		s += n, d += n;
  1006b7:	8d 3c 10             	lea    (%eax,%edx,1),%edi
  1006ba:	31 c9                	xor    %ecx,%ecx
		while (n-- > 0)
  1006bc:	eb 07                	jmp    1006c5 <memmove+0x28>
			*--d = *--s;
  1006be:	8a 1c 0e             	mov    (%esi,%ecx,1),%bl
  1006c1:	4a                   	dec    %edx
  1006c2:	88 1c 0f             	mov    %bl,(%edi,%ecx,1)
  1006c5:	49                   	dec    %ecx
{
	const char *s = (const char *) src;
	char *d = (char *) dst;
	if (s < d && s + n > d) {
		s += n, d += n;
		while (n-- > 0)
  1006c6:	85 d2                	test   %edx,%edx
  1006c8:	75 f4                	jne    1006be <memmove+0x21>
  1006ca:	eb 10                	jmp    1006dc <memmove+0x3f>
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  1006cc:	8a 1c 0f             	mov    (%edi,%ecx,1),%bl
  1006cf:	4a                   	dec    %edx
  1006d0:	88 1c 08             	mov    %bl,(%eax,%ecx,1)
  1006d3:	41                   	inc    %ecx
  1006d4:	eb 02                	jmp    1006d8 <memmove+0x3b>
  1006d6:	31 c9                	xor    %ecx,%ecx
	if (s < d && s + n > d) {
		s += n, d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  1006d8:	85 d2                	test   %edx,%edx
  1006da:	75 f0                	jne    1006cc <memmove+0x2f>
			*d++ = *s++;
	return dst;
}
  1006dc:	5b                   	pop    %ebx
  1006dd:	5e                   	pop    %esi
  1006de:	5f                   	pop    %edi
  1006df:	c3                   	ret    

001006e0 <memset>:

void *
memset(void *v, int c, size_t n)
{
  1006e0:	53                   	push   %ebx
  1006e1:	8b 44 24 08          	mov    0x8(%esp),%eax
  1006e5:	8b 5c 24 0c          	mov    0xc(%esp),%ebx
  1006e9:	8b 4c 24 10          	mov    0x10(%esp),%ecx
	char *p = (char *) v;
  1006ed:	89 c2                	mov    %eax,%edx
	while (n-- > 0)
  1006ef:	eb 04                	jmp    1006f5 <memset+0x15>
		*p++ = c;
  1006f1:	88 1a                	mov    %bl,(%edx)
  1006f3:	49                   	dec    %ecx
  1006f4:	42                   	inc    %edx

void *
memset(void *v, int c, size_t n)
{
	char *p = (char *) v;
	while (n-- > 0)
  1006f5:	85 c9                	test   %ecx,%ecx
  1006f7:	75 f8                	jne    1006f1 <memset+0x11>
		*p++ = c;
	return v;
}
  1006f9:	5b                   	pop    %ebx
  1006fa:	c3                   	ret    

001006fb <strlen>:

size_t
strlen(const char *s)
{
  1006fb:	8b 54 24 04          	mov    0x4(%esp),%edx
  1006ff:	31 c0                	xor    %eax,%eax
	size_t n;
	for (n = 0; *s != '\0'; ++s)
  100701:	eb 01                	jmp    100704 <strlen+0x9>
		++n;
  100703:	40                   	inc    %eax

size_t
strlen(const char *s)
{
	size_t n;
	for (n = 0; *s != '\0'; ++s)
  100704:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
  100708:	75 f9                	jne    100703 <strlen+0x8>
		++n;
	return n;
}
  10070a:	c3                   	ret    

0010070b <strnlen>:

size_t
strnlen(const char *s, size_t maxlen)
{
  10070b:	8b 4c 24 04          	mov    0x4(%esp),%ecx
  10070f:	31 c0                	xor    %eax,%eax
  100711:	8b 54 24 08          	mov    0x8(%esp),%edx
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
  100715:	eb 01                	jmp    100718 <strnlen+0xd>
		++n;
  100717:	40                   	inc    %eax

size_t
strnlen(const char *s, size_t maxlen)
{
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
  100718:	39 d0                	cmp    %edx,%eax
  10071a:	74 06                	je     100722 <strnlen+0x17>
  10071c:	80 3c 01 00          	cmpb   $0x0,(%ecx,%eax,1)
  100720:	75 f5                	jne    100717 <strnlen+0xc>
		++n;
	return n;
}
  100722:	c3                   	ret    

00100723 <console_putc>:
 *
 *   Print a message onto the console, starting at the given cursor position. */

static uint16_t *
console_putc(uint16_t *cursor, unsigned char c, int color)
{
  100723:	56                   	push   %esi
	if (cursor >= CONSOLE_END)
  100724:	3d 9f 8f 0b 00       	cmp    $0xb8f9f,%eax
 *
 *   Print a message onto the console, starting at the given cursor position. */

static uint16_t *
console_putc(uint16_t *cursor, unsigned char c, int color)
{
  100729:	53                   	push   %ebx
  10072a:	89 c3                	mov    %eax,%ebx
	if (cursor >= CONSOLE_END)
  10072c:	76 05                	jbe    100733 <console_putc+0x10>
  10072e:	bb 00 80 0b 00       	mov    $0xb8000,%ebx
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
  100733:	80 fa 0a             	cmp    $0xa,%dl
  100736:	75 2c                	jne    100764 <console_putc+0x41>
		int pos = (cursor - CONSOLE_BEGIN) % 80;
  100738:	8d 83 00 80 f4 ff    	lea    -0xb8000(%ebx),%eax
  10073e:	be 50 00 00 00       	mov    $0x50,%esi
  100743:	d1 f8                	sar    %eax
		for (; pos != 80; pos++)
			*cursor++ = ' ' | color;
  100745:	83 c9 20             	or     $0x20,%ecx
console_putc(uint16_t *cursor, unsigned char c, int color)
{
	if (cursor >= CONSOLE_END)
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
		int pos = (cursor - CONSOLE_BEGIN) % 80;
  100748:	99                   	cltd   
  100749:	f7 fe                	idiv   %esi
  10074b:	89 de                	mov    %ebx,%esi
  10074d:	89 d0                	mov    %edx,%eax
		for (; pos != 80; pos++)
  10074f:	eb 07                	jmp    100758 <console_putc+0x35>
			*cursor++ = ' ' | color;
  100751:	66 89 0e             	mov    %cx,(%esi)
{
	if (cursor >= CONSOLE_END)
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
		int pos = (cursor - CONSOLE_BEGIN) % 80;
		for (; pos != 80; pos++)
  100754:	40                   	inc    %eax
			*cursor++ = ' ' | color;
  100755:	83 c6 02             	add    $0x2,%esi
{
	if (cursor >= CONSOLE_END)
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
		int pos = (cursor - CONSOLE_BEGIN) % 80;
		for (; pos != 80; pos++)
  100758:	83 f8 50             	cmp    $0x50,%eax
  10075b:	75 f4                	jne    100751 <console_putc+0x2e>
  10075d:	29 d0                	sub    %edx,%eax
  10075f:	8d 04 43             	lea    (%ebx,%eax,2),%eax
  100762:	eb 0b                	jmp    10076f <console_putc+0x4c>
			*cursor++ = ' ' | color;
	} else
		*cursor++ = c | color;
  100764:	0f b6 d2             	movzbl %dl,%edx
  100767:	09 ca                	or     %ecx,%edx
  100769:	66 89 13             	mov    %dx,(%ebx)
  10076c:	8d 43 02             	lea    0x2(%ebx),%eax
	return cursor;
}
  10076f:	5b                   	pop    %ebx
  100770:	5e                   	pop    %esi
  100771:	c3                   	ret    

00100772 <fill_numbuf>:
static const char lower_digits[] = "0123456789abcdef";

static char *
fill_numbuf(char *numbuf_end, uint32_t val, int base, const char *digits,
	    int precision)
{
  100772:	56                   	push   %esi
  100773:	53                   	push   %ebx
  100774:	8b 74 24 0c          	mov    0xc(%esp),%esi
	*--numbuf_end = '\0';
  100778:	8d 58 ff             	lea    -0x1(%eax),%ebx
  10077b:	c6 40 ff 00          	movb   $0x0,-0x1(%eax)
	if (precision != 0 || val != 0)
  10077f:	83 7c 24 10 00       	cmpl   $0x0,0x10(%esp)
  100784:	75 04                	jne    10078a <fill_numbuf+0x18>
  100786:	85 d2                	test   %edx,%edx
  100788:	74 10                	je     10079a <fill_numbuf+0x28>
		do {
			*--numbuf_end = digits[val % base];
  10078a:	89 d0                	mov    %edx,%eax
  10078c:	31 d2                	xor    %edx,%edx
  10078e:	f7 f1                	div    %ecx
  100790:	4b                   	dec    %ebx
  100791:	8a 14 16             	mov    (%esi,%edx,1),%dl
  100794:	88 13                	mov    %dl,(%ebx)
			val /= base;
  100796:	89 c2                	mov    %eax,%edx
  100798:	eb ec                	jmp    100786 <fill_numbuf+0x14>
		} while (val != 0);
	return numbuf_end;
}
  10079a:	89 d8                	mov    %ebx,%eax
  10079c:	5b                   	pop    %ebx
  10079d:	5e                   	pop    %esi
  10079e:	c3                   	ret    

0010079f <console_vprintf>:
#define FLAG_PLUSPOSITIVE	(1<<4)
static const char flag_chars[] = "#0- +";

uint16_t *
console_vprintf(uint16_t *cursor, int color, const char *format, va_list val)
{
  10079f:	55                   	push   %ebp
  1007a0:	57                   	push   %edi
  1007a1:	56                   	push   %esi
  1007a2:	53                   	push   %ebx
  1007a3:	83 ec 38             	sub    $0x38,%esp
  1007a6:	8b 74 24 4c          	mov    0x4c(%esp),%esi
  1007aa:	8b 7c 24 54          	mov    0x54(%esp),%edi
  1007ae:	8b 5c 24 58          	mov    0x58(%esp),%ebx
	int flags, width, zeros, precision, negative, numeric, len;
#define NUMBUFSIZ 20
	char numbuf[NUMBUFSIZ];
	char *data;

	for (; *format; ++format) {
  1007b2:	e9 60 03 00 00       	jmp    100b17 <console_vprintf+0x378>
		if (*format != '%') {
  1007b7:	80 fa 25             	cmp    $0x25,%dl
  1007ba:	74 13                	je     1007cf <console_vprintf+0x30>
			cursor = console_putc(cursor, *format, color);
  1007bc:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  1007c0:	0f b6 d2             	movzbl %dl,%edx
  1007c3:	89 f0                	mov    %esi,%eax
  1007c5:	e8 59 ff ff ff       	call   100723 <console_putc>
  1007ca:	e9 45 03 00 00       	jmp    100b14 <console_vprintf+0x375>
			continue;
		}

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
  1007cf:	47                   	inc    %edi
  1007d0:	c7 44 24 14 00 00 00 	movl   $0x0,0x14(%esp)
  1007d7:	00 
  1007d8:	eb 12                	jmp    1007ec <console_vprintf+0x4d>
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
				++flagc;
  1007da:	41                   	inc    %ecx

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
  1007db:	8a 11                	mov    (%ecx),%dl
  1007dd:	84 d2                	test   %dl,%dl
  1007df:	74 1a                	je     1007fb <console_vprintf+0x5c>
  1007e1:	89 e8                	mov    %ebp,%eax
  1007e3:	38 c2                	cmp    %al,%dl
  1007e5:	75 f3                	jne    1007da <console_vprintf+0x3b>
  1007e7:	e9 3f 03 00 00       	jmp    100b2b <console_vprintf+0x38c>
			continue;
		}

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
  1007ec:	8a 17                	mov    (%edi),%dl
  1007ee:	84 d2                	test   %dl,%dl
  1007f0:	74 0b                	je     1007fd <console_vprintf+0x5e>
  1007f2:	b9 b0 0b 10 00       	mov    $0x100bb0,%ecx
  1007f7:	89 d5                	mov    %edx,%ebp
  1007f9:	eb e0                	jmp    1007db <console_vprintf+0x3c>
  1007fb:	89 ea                	mov    %ebp,%edx
			flags |= (1 << (flagc - flag_chars));
		}

		// process width
		width = -1;
		if (*format >= '1' && *format <= '9') {
  1007fd:	8d 42 cf             	lea    -0x31(%edx),%eax
  100800:	3c 08                	cmp    $0x8,%al
  100802:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
  100809:	00 
  10080a:	76 13                	jbe    10081f <console_vprintf+0x80>
  10080c:	eb 1d                	jmp    10082b <console_vprintf+0x8c>
			for (width = 0; *format >= '0' && *format <= '9'; )
				width = 10 * width + *format++ - '0';
  10080e:	6b 54 24 0c 0a       	imul   $0xa,0xc(%esp),%edx
  100813:	0f be c0             	movsbl %al,%eax
  100816:	47                   	inc    %edi
  100817:	8d 44 02 d0          	lea    -0x30(%edx,%eax,1),%eax
  10081b:	89 44 24 0c          	mov    %eax,0xc(%esp)
		}

		// process width
		width = -1;
		if (*format >= '1' && *format <= '9') {
			for (width = 0; *format >= '0' && *format <= '9'; )
  10081f:	8a 07                	mov    (%edi),%al
  100821:	8d 50 d0             	lea    -0x30(%eax),%edx
  100824:	80 fa 09             	cmp    $0x9,%dl
  100827:	76 e5                	jbe    10080e <console_vprintf+0x6f>
  100829:	eb 18                	jmp    100843 <console_vprintf+0xa4>
				width = 10 * width + *format++ - '0';
		} else if (*format == '*') {
  10082b:	80 fa 2a             	cmp    $0x2a,%dl
  10082e:	c7 44 24 0c ff ff ff 	movl   $0xffffffff,0xc(%esp)
  100835:	ff 
  100836:	75 0b                	jne    100843 <console_vprintf+0xa4>
			width = va_arg(val, int);
  100838:	83 c3 04             	add    $0x4,%ebx
			++format;
  10083b:	47                   	inc    %edi
		width = -1;
		if (*format >= '1' && *format <= '9') {
			for (width = 0; *format >= '0' && *format <= '9'; )
				width = 10 * width + *format++ - '0';
		} else if (*format == '*') {
			width = va_arg(val, int);
  10083c:	8b 53 fc             	mov    -0x4(%ebx),%edx
  10083f:	89 54 24 0c          	mov    %edx,0xc(%esp)
			++format;
		}

		// process precision
		precision = -1;
		if (*format == '.') {
  100843:	83 cd ff             	or     $0xffffffff,%ebp
  100846:	80 3f 2e             	cmpb   $0x2e,(%edi)
  100849:	75 37                	jne    100882 <console_vprintf+0xe3>
			++format;
  10084b:	47                   	inc    %edi
			if (*format >= '0' && *format <= '9') {
  10084c:	31 ed                	xor    %ebp,%ebp
  10084e:	8a 07                	mov    (%edi),%al
  100850:	8d 50 d0             	lea    -0x30(%eax),%edx
  100853:	80 fa 09             	cmp    $0x9,%dl
  100856:	76 0d                	jbe    100865 <console_vprintf+0xc6>
  100858:	eb 17                	jmp    100871 <console_vprintf+0xd2>
				for (precision = 0; *format >= '0' && *format <= '9'; )
					precision = 10 * precision + *format++ - '0';
  10085a:	6b ed 0a             	imul   $0xa,%ebp,%ebp
  10085d:	0f be c0             	movsbl %al,%eax
  100860:	47                   	inc    %edi
  100861:	8d 6c 05 d0          	lea    -0x30(%ebp,%eax,1),%ebp
		// process precision
		precision = -1;
		if (*format == '.') {
			++format;
			if (*format >= '0' && *format <= '9') {
				for (precision = 0; *format >= '0' && *format <= '9'; )
  100865:	8a 07                	mov    (%edi),%al
  100867:	8d 50 d0             	lea    -0x30(%eax),%edx
  10086a:	80 fa 09             	cmp    $0x9,%dl
  10086d:	76 eb                	jbe    10085a <console_vprintf+0xbb>
  10086f:	eb 11                	jmp    100882 <console_vprintf+0xe3>
					precision = 10 * precision + *format++ - '0';
			} else if (*format == '*') {
  100871:	3c 2a                	cmp    $0x2a,%al
  100873:	75 0b                	jne    100880 <console_vprintf+0xe1>
				precision = va_arg(val, int);
  100875:	83 c3 04             	add    $0x4,%ebx
				++format;
  100878:	47                   	inc    %edi
			++format;
			if (*format >= '0' && *format <= '9') {
				for (precision = 0; *format >= '0' && *format <= '9'; )
					precision = 10 * precision + *format++ - '0';
			} else if (*format == '*') {
				precision = va_arg(val, int);
  100879:	8b 6b fc             	mov    -0x4(%ebx),%ebp
				++format;
			}
			if (precision < 0)
  10087c:	85 ed                	test   %ebp,%ebp
  10087e:	79 02                	jns    100882 <console_vprintf+0xe3>
  100880:	31 ed                	xor    %ebp,%ebp
		}

		// process main conversion character
		negative = 0;
		numeric = 0;
		switch (*format) {
  100882:	8a 07                	mov    (%edi),%al
  100884:	3c 64                	cmp    $0x64,%al
  100886:	74 34                	je     1008bc <console_vprintf+0x11d>
  100888:	7f 1d                	jg     1008a7 <console_vprintf+0x108>
  10088a:	3c 58                	cmp    $0x58,%al
  10088c:	0f 84 a2 00 00 00    	je     100934 <console_vprintf+0x195>
  100892:	3c 63                	cmp    $0x63,%al
  100894:	0f 84 bf 00 00 00    	je     100959 <console_vprintf+0x1ba>
  10089a:	3c 43                	cmp    $0x43,%al
  10089c:	0f 85 d0 00 00 00    	jne    100972 <console_vprintf+0x1d3>
  1008a2:	e9 a3 00 00 00       	jmp    10094a <console_vprintf+0x1ab>
  1008a7:	3c 75                	cmp    $0x75,%al
  1008a9:	74 4d                	je     1008f8 <console_vprintf+0x159>
  1008ab:	3c 78                	cmp    $0x78,%al
  1008ad:	74 5c                	je     10090b <console_vprintf+0x16c>
  1008af:	3c 73                	cmp    $0x73,%al
  1008b1:	0f 85 bb 00 00 00    	jne    100972 <console_vprintf+0x1d3>
  1008b7:	e9 86 00 00 00       	jmp    100942 <console_vprintf+0x1a3>
		case 'd': {
			int x = va_arg(val, int);
  1008bc:	83 c3 04             	add    $0x4,%ebx
  1008bf:	8b 53 fc             	mov    -0x4(%ebx),%edx
			data = fill_numbuf(numbuf + NUMBUFSIZ, x > 0 ? x : -x, 10, upper_digits, precision);
  1008c2:	89 d1                	mov    %edx,%ecx
  1008c4:	c1 f9 1f             	sar    $0x1f,%ecx
  1008c7:	89 0c 24             	mov    %ecx,(%esp)
  1008ca:	31 ca                	xor    %ecx,%edx
  1008cc:	55                   	push   %ebp
  1008cd:	29 ca                	sub    %ecx,%edx
  1008cf:	68 b8 0b 10 00       	push   $0x100bb8
  1008d4:	b9 0a 00 00 00       	mov    $0xa,%ecx
  1008d9:	8d 44 24 40          	lea    0x40(%esp),%eax
  1008dd:	e8 90 fe ff ff       	call   100772 <fill_numbuf>
  1008e2:	89 44 24 0c          	mov    %eax,0xc(%esp)
			if (x < 0)
  1008e6:	58                   	pop    %eax
  1008e7:	5a                   	pop    %edx
  1008e8:	ba 01 00 00 00       	mov    $0x1,%edx
  1008ed:	8b 04 24             	mov    (%esp),%eax
  1008f0:	83 e0 01             	and    $0x1,%eax
  1008f3:	e9 a5 00 00 00       	jmp    10099d <console_vprintf+0x1fe>
				negative = 1;
			numeric = 1;
			break;
		}
		case 'u': {
			unsigned x = va_arg(val, unsigned);
  1008f8:	83 c3 04             	add    $0x4,%ebx
			data = fill_numbuf(numbuf + NUMBUFSIZ, x, 10, upper_digits, precision);
  1008fb:	b9 0a 00 00 00       	mov    $0xa,%ecx
  100900:	8b 53 fc             	mov    -0x4(%ebx),%edx
  100903:	55                   	push   %ebp
  100904:	68 b8 0b 10 00       	push   $0x100bb8
  100909:	eb 11                	jmp    10091c <console_vprintf+0x17d>
			numeric = 1;
			break;
		}
		case 'x': {
			unsigned x = va_arg(val, unsigned);
  10090b:	83 c3 04             	add    $0x4,%ebx
			data = fill_numbuf(numbuf + NUMBUFSIZ, x, 16, lower_digits, precision);
  10090e:	8b 53 fc             	mov    -0x4(%ebx),%edx
  100911:	55                   	push   %ebp
  100912:	68 cc 0b 10 00       	push   $0x100bcc
  100917:	b9 10 00 00 00       	mov    $0x10,%ecx
  10091c:	8d 44 24 40          	lea    0x40(%esp),%eax
  100920:	e8 4d fe ff ff       	call   100772 <fill_numbuf>
  100925:	ba 01 00 00 00       	mov    $0x1,%edx
  10092a:	89 44 24 0c          	mov    %eax,0xc(%esp)
  10092e:	31 c0                	xor    %eax,%eax
			numeric = 1;
			break;
  100930:	59                   	pop    %ecx
  100931:	59                   	pop    %ecx
  100932:	eb 69                	jmp    10099d <console_vprintf+0x1fe>
		}
		case 'X': {
			unsigned x = va_arg(val, unsigned);
  100934:	83 c3 04             	add    $0x4,%ebx
			data = fill_numbuf(numbuf + NUMBUFSIZ, x, 16, upper_digits, precision);
  100937:	8b 53 fc             	mov    -0x4(%ebx),%edx
  10093a:	55                   	push   %ebp
  10093b:	68 b8 0b 10 00       	push   $0x100bb8
  100940:	eb d5                	jmp    100917 <console_vprintf+0x178>
			numeric = 1;
			break;
		}
		case 's':
			data = va_arg(val, char *);
  100942:	83 c3 04             	add    $0x4,%ebx
  100945:	8b 43 fc             	mov    -0x4(%ebx),%eax
  100948:	eb 40                	jmp    10098a <console_vprintf+0x1eb>
			break;
		case 'C':
			color = va_arg(val, int);
  10094a:	83 c3 04             	add    $0x4,%ebx
  10094d:	8b 53 fc             	mov    -0x4(%ebx),%edx
  100950:	89 54 24 50          	mov    %edx,0x50(%esp)
			goto done;
  100954:	e9 bd 01 00 00       	jmp    100b16 <console_vprintf+0x377>
		case 'c':
			data = numbuf;
			numbuf[0] = va_arg(val, int);
  100959:	83 c3 04             	add    $0x4,%ebx
  10095c:	8b 43 fc             	mov    -0x4(%ebx),%eax
			numbuf[1] = '\0';
  10095f:	8d 4c 24 24          	lea    0x24(%esp),%ecx
  100963:	c6 44 24 25 00       	movb   $0x0,0x25(%esp)
  100968:	89 4c 24 04          	mov    %ecx,0x4(%esp)
		case 'C':
			color = va_arg(val, int);
			goto done;
		case 'c':
			data = numbuf;
			numbuf[0] = va_arg(val, int);
  10096c:	88 44 24 24          	mov    %al,0x24(%esp)
  100970:	eb 27                	jmp    100999 <console_vprintf+0x1fa>
			numbuf[1] = '\0';
			break;
		normal:
		default:
			data = numbuf;
			numbuf[0] = (*format ? *format : '%');
  100972:	84 c0                	test   %al,%al
  100974:	75 02                	jne    100978 <console_vprintf+0x1d9>
  100976:	b0 25                	mov    $0x25,%al
  100978:	88 44 24 24          	mov    %al,0x24(%esp)
			numbuf[1] = '\0';
  10097c:	c6 44 24 25 00       	movb   $0x0,0x25(%esp)
			if (!*format)
  100981:	80 3f 00             	cmpb   $0x0,(%edi)
  100984:	74 0a                	je     100990 <console_vprintf+0x1f1>
  100986:	8d 44 24 24          	lea    0x24(%esp),%eax
  10098a:	89 44 24 04          	mov    %eax,0x4(%esp)
  10098e:	eb 09                	jmp    100999 <console_vprintf+0x1fa>
				format--;
  100990:	8d 54 24 24          	lea    0x24(%esp),%edx
  100994:	4f                   	dec    %edi
  100995:	89 54 24 04          	mov    %edx,0x4(%esp)
  100999:	31 d2                	xor    %edx,%edx
  10099b:	31 c0                	xor    %eax,%eax
			break;
		}

		if (precision >= 0)
			len = strnlen(data, precision);
  10099d:	31 c9                	xor    %ecx,%ecx
			if (!*format)
				format--;
			break;
		}

		if (precision >= 0)
  10099f:	83 fd ff             	cmp    $0xffffffff,%ebp
  1009a2:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  1009a9:	74 1f                	je     1009ca <console_vprintf+0x22b>
  1009ab:	89 04 24             	mov    %eax,(%esp)
  1009ae:	eb 01                	jmp    1009b1 <console_vprintf+0x212>
size_t
strnlen(const char *s, size_t maxlen)
{
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
		++n;
  1009b0:	41                   	inc    %ecx

size_t
strnlen(const char *s, size_t maxlen)
{
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
  1009b1:	39 e9                	cmp    %ebp,%ecx
  1009b3:	74 0a                	je     1009bf <console_vprintf+0x220>
  1009b5:	8b 44 24 04          	mov    0x4(%esp),%eax
  1009b9:	80 3c 08 00          	cmpb   $0x0,(%eax,%ecx,1)
  1009bd:	75 f1                	jne    1009b0 <console_vprintf+0x211>
  1009bf:	8b 04 24             	mov    (%esp),%eax
				format--;
			break;
		}

		if (precision >= 0)
			len = strnlen(data, precision);
  1009c2:	89 0c 24             	mov    %ecx,(%esp)
  1009c5:	eb 1f                	jmp    1009e6 <console_vprintf+0x247>
size_t
strlen(const char *s)
{
	size_t n;
	for (n = 0; *s != '\0'; ++s)
		++n;
  1009c7:	42                   	inc    %edx
  1009c8:	eb 09                	jmp    1009d3 <console_vprintf+0x234>
  1009ca:	89 d1                	mov    %edx,%ecx
  1009cc:	8b 14 24             	mov    (%esp),%edx
  1009cf:	89 44 24 08          	mov    %eax,0x8(%esp)

size_t
strlen(const char *s)
{
	size_t n;
	for (n = 0; *s != '\0'; ++s)
  1009d3:	8b 44 24 04          	mov    0x4(%esp),%eax
  1009d7:	80 3c 10 00          	cmpb   $0x0,(%eax,%edx,1)
  1009db:	75 ea                	jne    1009c7 <console_vprintf+0x228>
  1009dd:	8b 44 24 08          	mov    0x8(%esp),%eax
  1009e1:	89 14 24             	mov    %edx,(%esp)
  1009e4:	89 ca                	mov    %ecx,%edx

		if (precision >= 0)
			len = strnlen(data, precision);
		else
			len = strlen(data);
		if (numeric && negative)
  1009e6:	85 c0                	test   %eax,%eax
  1009e8:	74 0c                	je     1009f6 <console_vprintf+0x257>
  1009ea:	84 d2                	test   %dl,%dl
  1009ec:	c7 44 24 08 2d 00 00 	movl   $0x2d,0x8(%esp)
  1009f3:	00 
  1009f4:	75 24                	jne    100a1a <console_vprintf+0x27b>
			negative = '-';
		else if (flags & FLAG_PLUSPOSITIVE)
  1009f6:	f6 44 24 14 10       	testb  $0x10,0x14(%esp)
  1009fb:	c7 44 24 08 2b 00 00 	movl   $0x2b,0x8(%esp)
  100a02:	00 
  100a03:	75 15                	jne    100a1a <console_vprintf+0x27b>
			negative = '+';
		else if (flags & FLAG_SPACEPOSITIVE)
  100a05:	8b 44 24 14          	mov    0x14(%esp),%eax
  100a09:	83 e0 08             	and    $0x8,%eax
  100a0c:	83 f8 01             	cmp    $0x1,%eax
  100a0f:	19 c9                	sbb    %ecx,%ecx
  100a11:	f7 d1                	not    %ecx
  100a13:	83 e1 20             	and    $0x20,%ecx
  100a16:	89 4c 24 08          	mov    %ecx,0x8(%esp)
			negative = ' ';
		else
			negative = 0;
		if (numeric && precision > len)
  100a1a:	3b 2c 24             	cmp    (%esp),%ebp
  100a1d:	7e 0d                	jle    100a2c <console_vprintf+0x28d>
  100a1f:	84 d2                	test   %dl,%dl
  100a21:	74 40                	je     100a63 <console_vprintf+0x2c4>
			zeros = precision - len;
  100a23:	2b 2c 24             	sub    (%esp),%ebp
  100a26:	89 6c 24 10          	mov    %ebp,0x10(%esp)
  100a2a:	eb 3f                	jmp    100a6b <console_vprintf+0x2cc>
		else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
  100a2c:	84 d2                	test   %dl,%dl
  100a2e:	74 33                	je     100a63 <console_vprintf+0x2c4>
  100a30:	8b 44 24 14          	mov    0x14(%esp),%eax
  100a34:	83 e0 06             	and    $0x6,%eax
  100a37:	83 f8 02             	cmp    $0x2,%eax
  100a3a:	75 27                	jne    100a63 <console_vprintf+0x2c4>
  100a3c:	45                   	inc    %ebp
  100a3d:	75 24                	jne    100a63 <console_vprintf+0x2c4>
			 && numeric && precision < 0
			 && len + !!negative < width)
  100a3f:	31 c0                	xor    %eax,%eax
			negative = ' ';
		else
			negative = 0;
		if (numeric && precision > len)
			zeros = precision - len;
		else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
  100a41:	8b 0c 24             	mov    (%esp),%ecx
			 && numeric && precision < 0
			 && len + !!negative < width)
  100a44:	83 7c 24 08 00       	cmpl   $0x0,0x8(%esp)
  100a49:	0f 95 c0             	setne  %al
			negative = ' ';
		else
			negative = 0;
		if (numeric && precision > len)
			zeros = precision - len;
		else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
  100a4c:	8d 14 08             	lea    (%eax,%ecx,1),%edx
  100a4f:	3b 54 24 0c          	cmp    0xc(%esp),%edx
  100a53:	7d 0e                	jge    100a63 <console_vprintf+0x2c4>
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
  100a55:	8b 54 24 0c          	mov    0xc(%esp),%edx
  100a59:	29 ca                	sub    %ecx,%edx
  100a5b:	29 c2                	sub    %eax,%edx
  100a5d:	89 54 24 10          	mov    %edx,0x10(%esp)
			negative = ' ';
		else
			negative = 0;
		if (numeric && precision > len)
			zeros = precision - len;
		else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
  100a61:	eb 08                	jmp    100a6b <console_vprintf+0x2cc>
  100a63:	c7 44 24 10 00 00 00 	movl   $0x0,0x10(%esp)
  100a6a:	00 
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
  100a6b:	8b 6c 24 0c          	mov    0xc(%esp),%ebp
  100a6f:	31 c0                	xor    %eax,%eax
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  100a71:	8b 4c 24 14          	mov    0x14(%esp),%ecx
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
  100a75:	2b 2c 24             	sub    (%esp),%ebp
  100a78:	83 7c 24 08 00       	cmpl   $0x0,0x8(%esp)
  100a7d:	0f 95 c0             	setne  %al
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  100a80:	83 e1 04             	and    $0x4,%ecx
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
  100a83:	29 c5                	sub    %eax,%ebp
  100a85:	89 f0                	mov    %esi,%eax
  100a87:	2b 6c 24 10          	sub    0x10(%esp),%ebp
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  100a8b:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  100a8f:	eb 0f                	jmp    100aa0 <console_vprintf+0x301>
			cursor = console_putc(cursor, ' ', color);
  100a91:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  100a95:	ba 20 00 00 00       	mov    $0x20,%edx
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  100a9a:	4d                   	dec    %ebp
			cursor = console_putc(cursor, ' ', color);
  100a9b:	e8 83 fc ff ff       	call   100723 <console_putc>
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  100aa0:	85 ed                	test   %ebp,%ebp
  100aa2:	7e 07                	jle    100aab <console_vprintf+0x30c>
  100aa4:	83 7c 24 0c 00       	cmpl   $0x0,0xc(%esp)
  100aa9:	74 e6                	je     100a91 <console_vprintf+0x2f2>
			cursor = console_putc(cursor, ' ', color);
		if (negative)
  100aab:	83 7c 24 08 00       	cmpl   $0x0,0x8(%esp)
  100ab0:	89 c6                	mov    %eax,%esi
  100ab2:	74 23                	je     100ad7 <console_vprintf+0x338>
			cursor = console_putc(cursor, negative, color);
  100ab4:	0f b6 54 24 08       	movzbl 0x8(%esp),%edx
  100ab9:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  100abd:	e8 61 fc ff ff       	call   100723 <console_putc>
  100ac2:	89 c6                	mov    %eax,%esi
  100ac4:	eb 11                	jmp    100ad7 <console_vprintf+0x338>
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
  100ac6:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  100aca:	ba 30 00 00 00       	mov    $0x30,%edx
		width -= len + zeros + !!negative;
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
			cursor = console_putc(cursor, ' ', color);
		if (negative)
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
  100acf:	4e                   	dec    %esi
			cursor = console_putc(cursor, '0', color);
  100ad0:	e8 4e fc ff ff       	call   100723 <console_putc>
  100ad5:	eb 06                	jmp    100add <console_vprintf+0x33e>
  100ad7:	89 f0                	mov    %esi,%eax
  100ad9:	8b 74 24 10          	mov    0x10(%esp),%esi
		width -= len + zeros + !!negative;
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
			cursor = console_putc(cursor, ' ', color);
		if (negative)
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
  100add:	85 f6                	test   %esi,%esi
  100adf:	7f e5                	jg     100ac6 <console_vprintf+0x327>
  100ae1:	8b 34 24             	mov    (%esp),%esi
  100ae4:	eb 15                	jmp    100afb <console_vprintf+0x35c>
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
			cursor = console_putc(cursor, *data, color);
  100ae6:	8b 4c 24 04          	mov    0x4(%esp),%ecx
			cursor = console_putc(cursor, ' ', color);
		if (negative)
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
  100aea:	4e                   	dec    %esi
			cursor = console_putc(cursor, *data, color);
  100aeb:	0f b6 11             	movzbl (%ecx),%edx
  100aee:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  100af2:	e8 2c fc ff ff       	call   100723 <console_putc>
			cursor = console_putc(cursor, ' ', color);
		if (negative)
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
  100af7:	ff 44 24 04          	incl   0x4(%esp)
  100afb:	85 f6                	test   %esi,%esi
  100afd:	7f e7                	jg     100ae6 <console_vprintf+0x347>
  100aff:	eb 0f                	jmp    100b10 <console_vprintf+0x371>
			cursor = console_putc(cursor, *data, color);
		for (; width > 0; --width)
			cursor = console_putc(cursor, ' ', color);
  100b01:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  100b05:	ba 20 00 00 00       	mov    $0x20,%edx
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
			cursor = console_putc(cursor, *data, color);
		for (; width > 0; --width)
  100b0a:	4d                   	dec    %ebp
			cursor = console_putc(cursor, ' ', color);
  100b0b:	e8 13 fc ff ff       	call   100723 <console_putc>
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
			cursor = console_putc(cursor, *data, color);
		for (; width > 0; --width)
  100b10:	85 ed                	test   %ebp,%ebp
  100b12:	7f ed                	jg     100b01 <console_vprintf+0x362>
  100b14:	89 c6                	mov    %eax,%esi
	int flags, width, zeros, precision, negative, numeric, len;
#define NUMBUFSIZ 20
	char numbuf[NUMBUFSIZ];
	char *data;

	for (; *format; ++format) {
  100b16:	47                   	inc    %edi
  100b17:	8a 17                	mov    (%edi),%dl
  100b19:	84 d2                	test   %dl,%dl
  100b1b:	0f 85 96 fc ff ff    	jne    1007b7 <console_vprintf+0x18>
			cursor = console_putc(cursor, ' ', color);
	done: ;
	}

	return cursor;
}
  100b21:	83 c4 38             	add    $0x38,%esp
  100b24:	89 f0                	mov    %esi,%eax
  100b26:	5b                   	pop    %ebx
  100b27:	5e                   	pop    %esi
  100b28:	5f                   	pop    %edi
  100b29:	5d                   	pop    %ebp
  100b2a:	c3                   	ret    
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
				++flagc;
			if (*flagc == '\0')
				break;
			flags |= (1 << (flagc - flag_chars));
  100b2b:	81 e9 b0 0b 10 00    	sub    $0x100bb0,%ecx
  100b31:	b8 01 00 00 00       	mov    $0x1,%eax
  100b36:	d3 e0                	shl    %cl,%eax
			continue;
		}

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
  100b38:	47                   	inc    %edi
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
				++flagc;
			if (*flagc == '\0')
				break;
			flags |= (1 << (flagc - flag_chars));
  100b39:	09 44 24 14          	or     %eax,0x14(%esp)
  100b3d:	e9 aa fc ff ff       	jmp    1007ec <console_vprintf+0x4d>

00100b42 <console_printf>:
uint16_t *
console_printf(uint16_t *cursor, int color, const char *format, ...)
{
	va_list val;
	va_start(val, format);
	cursor = console_vprintf(cursor, color, format, val);
  100b42:	8d 44 24 10          	lea    0x10(%esp),%eax
  100b46:	50                   	push   %eax
  100b47:	ff 74 24 10          	pushl  0x10(%esp)
  100b4b:	ff 74 24 10          	pushl  0x10(%esp)
  100b4f:	ff 74 24 10          	pushl  0x10(%esp)
  100b53:	e8 47 fc ff ff       	call   10079f <console_vprintf>
  100b58:	83 c4 10             	add    $0x10,%esp
	va_end(val);
	return cursor;
}
  100b5b:	c3                   	ret    

00100b5c <lock_init>:
#include "lock.h"

void
lock_init(lock_t *l) 
{
	l->lock = 0;
  100b5c:	8b 44 24 04          	mov    0x4(%esp),%eax
  100b60:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
}
  100b66:	c3                   	ret    

00100b67 <lock_acquire>:

void
lock_acquire(lock_t *l) 
{
  100b67:	53                   	push   %ebx
  100b68:	8b 54 24 08          	mov    0x8(%esp),%edx
static inline uint32_t compare_and_swap(uint32_t *addr, uint32_t expected, uint32_t desired) __attribute__((always_inline));

static inline uint32_t
compare_and_swap(uint32_t *addr, uint32_t expected, uint32_t desired)
{
	asm volatile("lock cmpxchg %2,%1"
  100b6c:	b9 01 00 00 00       	mov    $0x1,%ecx
  100b71:	31 db                	xor    %ebx,%ebx
  100b73:	89 d8                	mov    %ebx,%eax
  100b75:	f0 0f b1 0a          	lock cmpxchg %ecx,(%edx)
	while(compare_and_swap(&l->lock, UNLOCKED, LOCKED))
  100b79:	85 c0                	test   %eax,%eax
  100b7b:	75 f6                	jne    100b73 <lock_acquire+0xc>
		;
}
  100b7d:	5b                   	pop    %ebx
  100b7e:	c3                   	ret    

00100b7f <lock_release>:

void
lock_release(lock_t *l)
{
	l->lock = 0;
  100b7f:	8b 44 24 04          	mov    0x4(%esp),%eax
  100b83:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
}
  100b89:	c3                   	ret    
