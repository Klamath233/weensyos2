
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
  100014:	e8 26 03 00 00       	call   10033f <start>
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
  10006d:	e8 1d 02 00 00       	call   10028f <interrupt>

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
static int last_proc_id = 1;
static pid_t candidate_array[NPROCS - 1];
static int candidate_number = 0;
void
schedule(void)
{
  10009c:	55                   	push   %ebp
  10009d:	57                   	push   %edi
  10009e:	56                   	push   %esi
  10009f:	53                   	push   %ebx
  1000a0:	83 ec 0c             	sub    $0xc,%esp
    
	pid_t pid = current->p_pid;
  1000a3:	a1 44 7f 10 00       	mov    0x107f44,%eax
  1000a8:	8b 10                	mov    (%eax),%edx

	if (scheduling_algorithm == 0)
  1000aa:	a1 48 7f 10 00       	mov    0x107f48,%eax
  1000af:	85 c0                	test   %eax,%eax
  1000b1:	75 1c                	jne    1000cf <schedule+0x33>
		while (1) {
			pid = (pid + 1) % NPROCS;
  1000b3:	b9 05 00 00 00       	mov    $0x5,%ecx
  1000b8:	8d 42 01             	lea    0x1(%edx),%eax
  1000bb:	99                   	cltd   
  1000bc:	f7 f9                	idiv   %ecx

			// Run the selected process, but skip
			// non-runnable processes.
			// Note that the 'run' function does not return.
			if (proc_array[pid].p_state == P_RUNNABLE)
  1000be:	6b c2 5c             	imul   $0x5c,%edx,%eax
  1000c1:	83 b8 44 75 10 00 01 	cmpl   $0x1,0x107544(%eax)
  1000c8:	75 ee                	jne    1000b8 <schedule+0x1c>
  1000ca:	e9 91 01 00 00       	jmp    100260 <schedule+0x1c4>
				run(&proc_array[pid]);
		}

	if (scheduling_algorithm == 1) {
  1000cf:	83 f8 01             	cmp    $0x1,%eax
  1000d2:	75 6a                	jne    10013e <schedule+0xa2>
        for (pid = 1; pid < NPROCS; pid++) {
            proc_array[pid].p_priority = NPROCS - pid;        
  1000d4:	c7 05 a8 75 10 00 04 	movl   $0x4,0x1075a8
  1000db:	00 00 00 
  1000de:	31 d2                	xor    %edx,%edx
  1000e0:	c7 05 04 76 10 00 03 	movl   $0x3,0x107604
  1000e7:	00 00 00 
  1000ea:	c7 05 60 76 10 00 02 	movl   $0x2,0x107660
  1000f1:	00 00 00 
  1000f4:	c7 05 bc 76 10 00 01 	movl   $0x1,0x1076bc
  1000fb:	00 00 00 
  1000fe:	eb 25                	jmp    100125 <schedule+0x89>
        }
		while (1) {
			process_t *most_prior = NULL;
			for (pid = 1; pid < NPROCS; pid++) {
				if (proc_array[pid].p_state == P_RUNNABLE) {
  100100:	6b c8 5c             	imul   $0x5c,%eax,%ecx
  100103:	83 b9 44 75 10 00 01 	cmpl   $0x1,0x107544(%ecx)
  10010a:	75 18                	jne    100124 <schedule+0x88>
					if ((most_prior && most_prior->p_priority <
  10010c:	85 d2                	test   %edx,%edx
  10010e:	74 0b                	je     10011b <schedule+0x7f>
  100110:	8b 5a 50             	mov    0x50(%edx),%ebx
  100113:	3b 99 4c 75 10 00    	cmp    0x10754c(%ecx),%ebx
  100119:	7d 09                	jge    100124 <schedule+0x88>
						proc_array[pid].p_priority)
						|| !most_prior)
					{
						most_prior = &proc_array[pid];
  10011b:	6b d0 5c             	imul   $0x5c,%eax,%edx
  10011e:	81 c2 fc 74 10 00    	add    $0x1074fc,%edx
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
  100139:	e8 33 05 00 00       	call   100671 <run>
		}
	}
		
	if (scheduling_algorithm == 2) {
  10013e:	83 f8 02             	cmp    $0x2,%eax
  100141:	75 69                	jne    1001ac <schedule+0x110>
  100143:	8b 1d 00 10 10 00    	mov    0x101000,%ebx
  100149:	ba ec ff ff ff       	mov    $0xffffffec,%edx
  10014e:	b0 01                	mov    $0x1,%al
  100150:	eb 19                	jmp    10016b <schedule+0xcf>
		while (1) {
		    int highest_priority = LOWEST_PRIORITY;
		    for (pid = 1; pid < NPROCS; pid++) {
		        if (proc_array[pid].p_state == P_RUNNABLE &&
  100152:	6b c8 5c             	imul   $0x5c,%eax,%ecx
  100155:	83 b9 44 75 10 00 01 	cmpl   $0x1,0x107544(%ecx)
  10015c:	75 0c                	jne    10016a <schedule+0xce>
  10015e:	8b 89 4c 75 10 00    	mov    0x10754c(%ecx),%ecx
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
  100170:	b9 a0 75 10 00       	mov    $0x1075a0,%ecx
  100175:	b8 01 00 00 00       	mov    $0x1,%eax
		            highest_priority = proc_array[pid].p_priority;
		        }
		    }
		    
		    for (pid = 1; pid < NPROCS; pid++) {
		        if (proc_array[pid].p_state == P_RUNNABLE &&
  10017a:	83 39 01             	cmpl   $0x1,(%ecx)
  10017d:	75 19                	jne    100198 <schedule+0xfc>
  10017f:	39 51 08             	cmp    %edx,0x8(%ecx)
  100182:	75 14                	jne    100198 <schedule+0xfc>
  100184:	39 d8                	cmp    %ebx,%eax
  100186:	7e 10                	jle    100198 <schedule+0xfc>
		            proc_array[pid].p_priority == highest_priority
		            && pid > last_proc_id)
		        {
		            last_proc_id = pid;
  100188:	a3 00 10 10 00       	mov    %eax,0x101000
		            run(&proc_array[pid]);
  10018d:	83 ec 0c             	sub    $0xc,%esp
  100190:	6b c0 5c             	imul   $0x5c,%eax,%eax
  100193:	e9 cb 00 00 00       	jmp    100263 <schedule+0x1c7>
		            proc_array[pid].p_priority > highest_priority) {
		            highest_priority = proc_array[pid].p_priority;
		        }
		    }
		    
		    for (pid = 1; pid < NPROCS; pid++) {
  100198:	40                   	inc    %eax
  100199:	83 c1 5c             	add    $0x5c,%ecx
  10019c:	83 f8 05             	cmp    $0x5,%eax
  10019f:	75 d9                	jne    10017a <schedule+0xde>
  1001a1:	31 db                	xor    %ebx,%ebx
  1001a3:	ba ec ff ff ff       	mov    $0xffffffec,%edx
  1001a8:	b0 01                	mov    $0x1,%al
  1001aa:	eb a6                	jmp    100152 <schedule+0xb6>
		    
		    last_proc_id = 0;
		}
	}
	
	if (scheduling_algorithm == 3) {
  1001ac:	83 f8 03             	cmp    $0x3,%eax
  1001af:	0f 85 b9 00 00 00    	jne    10026e <schedule+0x1d2>
	        }
	        
	        // If no candidate, reset shares and restart loop.
	        if (candidate_array[0] == 0) {
	            for (pid = 1; pid < NPROCS; pid++) {
	                proc_array[pid].p_share = proc_array[pid].p_share_max;
  1001b5:	8b 2d b0 75 10 00    	mov    0x1075b0,%ebp
  1001bb:	8b 3d 0c 76 10 00    	mov    0x10760c,%edi
  1001c1:	8b 35 68 76 10 00    	mov    0x107668,%esi
  1001c7:	8b 1d c4 76 10 00    	mov    0x1076c4,%ebx
	        int i;
	        
	        // Initialize candidate array every loop.
	        candidate_number = 0;
	        for (i = 0; i < NPROCS - 1; i++) {
                candidate_array[i] = 0;
  1001cd:	c7 05 c8 76 10 00 00 	movl   $0x0,0x1076c8
  1001d4:	00 00 00 
  1001d7:	b9 a0 75 10 00       	mov    $0x1075a0,%ecx
  1001dc:	31 c0                	xor    %eax,%eax
  1001de:	c7 05 cc 76 10 00 00 	movl   $0x0,0x1076cc
  1001e5:	00 00 00 
  1001e8:	ba 01 00 00 00       	mov    $0x1,%edx
  1001ed:	c7 05 d0 76 10 00 00 	movl   $0x0,0x1076d0
  1001f4:	00 00 00 
  1001f7:	c7 05 d4 76 10 00 00 	movl   $0x0,0x1076d4
  1001fe:	00 00 00 
            }
            
            // Add candidates to array.
	        for (pid = 1; pid < NPROCS; pid++) {
	            if (proc_array[pid].p_state == P_RUNNABLE
  100201:	83 39 01             	cmpl   $0x1,(%ecx)
  100204:	75 0e                	jne    100214 <schedule+0x178>
  100206:	83 79 0c 00          	cmpl   $0x0,0xc(%ecx)
  10020a:	7e 08                	jle    100214 <schedule+0x178>
	                && proc_array[pid].p_share > 0) 
	            {
	                candidate_array[candidate_number++] = pid;
  10020c:	89 14 85 c8 76 10 00 	mov    %edx,0x1076c8(,%eax,4)
  100213:	40                   	inc    %eax
	        for (i = 0; i < NPROCS - 1; i++) {
                candidate_array[i] = 0;
            }
            
            // Add candidates to array.
	        for (pid = 1; pid < NPROCS; pid++) {
  100214:	42                   	inc    %edx
  100215:	83 c1 5c             	add    $0x5c,%ecx
  100218:	83 fa 05             	cmp    $0x5,%edx
  10021b:	75 e4                	jne    100201 <schedule+0x165>
	                candidate_array[candidate_number++] = pid;
	            }
	        }
	        
	        // If no candidate, reset shares and restart loop.
	        if (candidate_array[0] == 0) {
  10021d:	83 3d c8 76 10 00 00 	cmpl   $0x0,0x1076c8
  100224:	75 1a                	jne    100240 <schedule+0x1a4>
	            for (pid = 1; pid < NPROCS; pid++) {
	                proc_array[pid].p_share = proc_array[pid].p_share_max;
  100226:	89 2d ac 75 10 00    	mov    %ebp,0x1075ac
  10022c:	89 3d 08 76 10 00    	mov    %edi,0x107608
  100232:	89 35 64 76 10 00    	mov    %esi,0x107664
  100238:	89 1d c0 76 10 00    	mov    %ebx,0x1076c0
	        
	        // Pick a random candidate and consume its share.
	        pid_t chosen = candidate_array[get_random() % candidate_number];
	        proc_array[chosen].p_share--;
	        run(&proc_array[chosen]);
	    }
  10023e:	eb 8d                	jmp    1001cd <schedule+0x131>
  100240:	a3 f8 74 10 00       	mov    %eax,0x1074f8
	            }
	            continue;
	        }
	        
	        // Pick a random candidate and consume its share.
	        pid_t chosen = candidate_array[get_random() % candidate_number];
  100245:	e8 16 0a 00 00       	call   100c60 <get_random>
  10024a:	31 d2                	xor    %edx,%edx
  10024c:	f7 35 f8 74 10 00    	divl   0x1074f8
	        proc_array[chosen].p_share--;
  100252:	6b 04 95 c8 76 10 00 	imul   $0x5c,0x1076c8(,%edx,4),%eax
  100259:	5c 
  10025a:	ff 88 50 75 10 00    	decl   0x107550(%eax)
	        run(&proc_array[chosen]);
  100260:	83 ec 0c             	sub    $0xc,%esp
  100263:	05 fc 74 10 00       	add    $0x1074fc,%eax
  100268:	50                   	push   %eax
  100269:	e9 cb fe ff ff       	jmp    100139 <schedule+0x9d>
	    }
	}
	// If we get here, we are running an unknown scheduling algorithm.
	cursorpos = console_printf(cursorpos, 0x100, "\nUnknown scheduling algorithm %d\n", scheduling_algorithm);
  10026e:	8b 15 00 80 19 00    	mov    0x198000,%edx
  100274:	50                   	push   %eax
  100275:	68 9c 0c 10 00       	push   $0x100c9c
  10027a:	68 00 01 00 00       	push   $0x100
  10027f:	52                   	push   %edx
  100280:	e8 91 09 00 00       	call   100c16 <console_printf>
  100285:	83 c4 10             	add    $0x10,%esp
  100288:	a3 00 80 19 00       	mov    %eax,0x198000
  10028d:	eb fe                	jmp    10028d <schedule+0x1f1>

0010028f <interrupt>:
 *
 *****************************************************************************/

void
interrupt(registers_t *reg)
{
  10028f:	57                   	push   %edi
	// Save the current process's register state
	// into its process descriptor
	current->p_registers = *reg;
  100290:	a1 44 7f 10 00       	mov    0x107f44,%eax
  100295:	b9 11 00 00 00       	mov    $0x11,%ecx
 *
 *****************************************************************************/

void
interrupt(registers_t *reg)
{
  10029a:	56                   	push   %esi
  10029b:	53                   	push   %ebx
  10029c:	8b 5c 24 10          	mov    0x10(%esp),%ebx
	// Save the current process's register state
	// into its process descriptor
	current->p_registers = *reg;
  1002a0:	8d 78 04             	lea    0x4(%eax),%edi
  1002a3:	89 de                	mov    %ebx,%esi
  1002a5:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)

	switch (reg->reg_intno) {
  1002a7:	8b 53 28             	mov    0x28(%ebx),%edx
  1002aa:	83 fa 32             	cmp    $0x32,%edx
  1002ad:	74 38                	je     1002e7 <interrupt+0x58>
  1002af:	77 0e                	ja     1002bf <interrupt+0x30>
  1002b1:	83 fa 30             	cmp    $0x30,%edx
  1002b4:	74 15                	je     1002cb <interrupt+0x3c>
  1002b6:	77 18                	ja     1002d0 <interrupt+0x41>
  1002b8:	83 fa 20             	cmp    $0x20,%edx
  1002bb:	74 7b                	je     100338 <interrupt+0xa9>
  1002bd:	eb 7e                	jmp    10033d <interrupt+0xae>
  1002bf:	83 fa 33             	cmp    $0x33,%edx
  1002c2:	74 30                	je     1002f4 <interrupt+0x65>
  1002c4:	83 fa 34             	cmp    $0x34,%edx
  1002c7:	74 63                	je     10032c <interrupt+0x9d>
  1002c9:	eb 72                	jmp    10033d <interrupt+0xae>

	case INT_SYS_YIELD:
		// The 'sys_yield' system call asks the kernel to schedule
		// the next process.
		schedule();
  1002cb:	e8 cc fd ff ff       	call   10009c <schedule>
		// The application stored its exit status in the %eax register
		// before calling the system call.  The %eax register has
		// changed by now, but we can read the application's value
		// out of the 'reg' argument.
		// (This shows you how to transfer arguments to system calls!)
		current->p_state = P_ZOMBIE;
  1002d0:	a1 44 7f 10 00       	mov    0x107f44,%eax
		current->p_exit_status = reg->reg_eax;
  1002d5:	8b 53 1c             	mov    0x1c(%ebx),%edx
		// The application stored its exit status in the %eax register
		// before calling the system call.  The %eax register has
		// changed by now, but we can read the application's value
		// out of the 'reg' argument.
		// (This shows you how to transfer arguments to system calls!)
		current->p_state = P_ZOMBIE;
  1002d8:	c7 40 48 03 00 00 00 	movl   $0x3,0x48(%eax)
		current->p_exit_status = reg->reg_eax;
  1002df:	89 50 4c             	mov    %edx,0x4c(%eax)
		schedule();
  1002e2:	e8 b5 fd ff ff       	call   10009c <schedule>

	case INT_SYS_RENICE:
		// 'sys_user*' are provided for your convenience, in case you
		// want to add a system call.
		current->p_priority = reg->reg_eax;
  1002e7:	a1 44 7f 10 00       	mov    0x107f44,%eax
  1002ec:	8b 53 1c             	mov    0x1c(%ebx),%edx
  1002ef:	89 50 50             	mov    %edx,0x50(%eax)
  1002f2:	eb 3e                	jmp    100332 <interrupt+0xa3>
		run(current);

	case INT_SYS_ATOMIC_PRINTC:
		/* Your code here (if you want). */
		lock_acquire(&cursor_lock);
  1002f4:	83 ec 0c             	sub    $0xc,%esp
  1002f7:	68 40 7f 10 00       	push   $0x107f40
  1002fc:	e8 3a 09 00 00       	call   100c3b <lock_acquire>
		*cursorpos++ = (uint16_t) reg->reg_eax;
  100301:	a1 00 80 19 00       	mov    0x198000,%eax
  100306:	8b 53 1c             	mov    0x1c(%ebx),%edx
  100309:	66 89 10             	mov    %dx,(%eax)
  10030c:	83 c0 02             	add    $0x2,%eax
  10030f:	a3 00 80 19 00       	mov    %eax,0x198000
		lock_release(&cursor_lock);
  100314:	c7 04 24 40 7f 10 00 	movl   $0x107f40,(%esp)
  10031b:	e8 33 09 00 00       	call   100c53 <lock_release>
		run(current);
  100320:	58                   	pop    %eax
  100321:	ff 35 44 7f 10 00    	pushl  0x107f44
  100327:	e8 45 03 00 00       	call   100671 <run>
	
	case INT_SYS_SET_SHARE:
		// 'sys_user*' are provided for your convenience, in case you
		// want to add a system call.
		current->p_share_max = reg->reg_eax;
  10032c:	8b 53 1c             	mov    0x1c(%ebx),%edx
  10032f:	89 50 58             	mov    %edx,0x58(%eax)
		run(current);
  100332:	83 ec 0c             	sub    $0xc,%esp
  100335:	50                   	push   %eax
  100336:	eb ef                	jmp    100327 <interrupt+0x98>

	case INT_CLOCK:
		// A clock interrupt occurred (so an application exhausted its
		// time quantum).
		// Switch to the next runnable process.
		schedule();
  100338:	e8 5f fd ff ff       	call   10009c <schedule>
  10033d:	eb fe                	jmp    10033d <interrupt+0xae>

0010033f <start>:
 *
 *****************************************************************************/

void
start(void)
{
  10033f:	57                   	push   %edi

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
  100340:	bf 00 00 30 00       	mov    $0x300000,%edi
 *
 *****************************************************************************/

void
start(void)
{
  100345:	56                   	push   %esi

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
  100346:	31 f6                	xor    %esi,%esi
 *
 *****************************************************************************/

void
start(void)
{
  100348:	53                   	push   %ebx

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
  100349:	bb 58 75 10 00       	mov    $0x107558,%ebx
start(void)
{
	int i;

	// Set up hardware (schedos-x86.c)
	segments_init();
  10034e:	e8 fd 00 00 00       	call   100450 <segments_init>
	interrupt_controller_init(0);
  100353:	83 ec 0c             	sub    $0xc,%esp
  100356:	6a 00                	push   $0x0
  100358:	e8 ee 01 00 00       	call   10054b <interrupt_controller_init>
	console_clear();
  10035d:	e8 72 02 00 00       	call   1005d4 <console_clear>

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
  100362:	83 c4 0c             	add    $0xc,%esp
  100365:	68 cc 01 00 00       	push   $0x1cc
  10036a:	6a 00                	push   $0x0
  10036c:	68 fc 74 10 00       	push   $0x1074fc
  100371:	e8 3e 04 00 00       	call   1007b4 <memset>
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
  100376:	83 c4 10             	add    $0x10,%esp
	console_clear();

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
  100379:	c7 05 fc 74 10 00 00 	movl   $0x0,0x1074fc
  100380:	00 00 00 
		proc_array[i].p_state = P_EMPTY;
  100383:	c7 05 44 75 10 00 00 	movl   $0x0,0x107544
  10038a:	00 00 00 
	console_clear();

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
  10038d:	c7 05 58 75 10 00 01 	movl   $0x1,0x107558
  100394:	00 00 00 
		proc_array[i].p_state = P_EMPTY;
  100397:	c7 05 a0 75 10 00 00 	movl   $0x0,0x1075a0
  10039e:	00 00 00 
	console_clear();

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
  1003a1:	c7 05 b4 75 10 00 02 	movl   $0x2,0x1075b4
  1003a8:	00 00 00 
		proc_array[i].p_state = P_EMPTY;
  1003ab:	c7 05 fc 75 10 00 00 	movl   $0x0,0x1075fc
  1003b2:	00 00 00 
	console_clear();

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
  1003b5:	c7 05 10 76 10 00 03 	movl   $0x3,0x107610
  1003bc:	00 00 00 
		proc_array[i].p_state = P_EMPTY;
  1003bf:	c7 05 58 76 10 00 00 	movl   $0x0,0x107658
  1003c6:	00 00 00 
	console_clear();

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
  1003c9:	c7 05 6c 76 10 00 04 	movl   $0x4,0x10766c
  1003d0:	00 00 00 
		proc_array[i].p_state = P_EMPTY;
  1003d3:	c7 05 b4 76 10 00 00 	movl   $0x0,0x1076b4
  1003da:	00 00 00 
	for (i = 1; i < NPROCS; i++) {
		process_t *proc = &proc_array[i];
		uint32_t stack_ptr = PROC1_START + i * PROC_SIZE;

		// Initialize the process descriptor
		special_registers_init(proc);
  1003dd:	83 ec 0c             	sub    $0xc,%esp
  1003e0:	53                   	push   %ebx
  1003e1:	e8 a2 02 00 00       	call   100688 <special_registers_init>

		// Set ESP
		proc->p_registers.reg_esp = stack_ptr;

		// Load process and set EIP, based on ELF image
		program_loader(i - 1, &proc->p_registers.reg_eip);
  1003e6:	8d 43 34             	lea    0x34(%ebx),%eax
  1003e9:	5a                   	pop    %edx
  1003ea:	59                   	pop    %ecx

		// Initialize the process descriptor
		special_registers_init(proc);

		// Set ESP
		proc->p_registers.reg_esp = stack_ptr;
  1003eb:	89 7b 40             	mov    %edi,0x40(%ebx)
        // Initialize priority.
        proc->p_priority = 0;
        
        // Initialize share.
        proc->p_share_max = 1;
        proc->p_share = proc->p_share_max;
  1003ee:	81 c7 00 00 10 00    	add    $0x100000,%edi

		// Set ESP
		proc->p_registers.reg_esp = stack_ptr;

		// Load process and set EIP, based on ELF image
		program_loader(i - 1, &proc->p_registers.reg_eip);
  1003f4:	50                   	push   %eax
  1003f5:	56                   	push   %esi
        // Initialize priority.
        proc->p_priority = 0;
        
        // Initialize share.
        proc->p_share_max = 1;
        proc->p_share = proc->p_share_max;
  1003f6:	46                   	inc    %esi

		// Set ESP
		proc->p_registers.reg_esp = stack_ptr;

		// Load process and set EIP, based on ELF image
		program_loader(i - 1, &proc->p_registers.reg_eip);
  1003f7:	e8 c8 02 00 00       	call   1006c4 <program_loader>
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
	}

	// Set up process descriptors (the proc_array[])
	for (i = 1; i < NPROCS; i++) {
  1003fc:	83 c4 10             	add    $0x10,%esp

		// Load process and set EIP, based on ELF image
		program_loader(i - 1, &proc->p_registers.reg_eip);

		// Mark the process as runnable!
		proc->p_state = P_RUNNABLE;
  1003ff:	c7 43 48 01 00 00 00 	movl   $0x1,0x48(%ebx)

        // Initialize priority.
        proc->p_priority = 0;
  100406:	c7 43 50 00 00 00 00 	movl   $0x0,0x50(%ebx)
        
        // Initialize share.
        proc->p_share_max = 1;
  10040d:	c7 43 58 01 00 00 00 	movl   $0x1,0x58(%ebx)
        proc->p_share = proc->p_share_max;
  100414:	c7 43 54 01 00 00 00 	movl   $0x1,0x54(%ebx)
  10041b:	83 c3 5c             	add    $0x5c,%ebx
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
	}

	// Set up process descriptors (the proc_array[])
	for (i = 1; i < NPROCS; i++) {
  10041e:	83 fe 04             	cmp    $0x4,%esi
  100421:	75 ba                	jne    1003dd <start+0x9e>
	}

	// Initialize the cursor-position shared variable to point to the
	// console's first character (the upper left).
	cursorpos = (uint16_t *) 0xB8000;
	lock_init(&cursor_lock);
  100423:	83 ec 0c             	sub    $0xc,%esp
  100426:	68 40 7f 10 00       	push   $0x107f40
        proc->p_share = proc->p_share_max;
	}

	// Initialize the cursor-position shared variable to point to the
	// console's first character (the upper left).
	cursorpos = (uint16_t *) 0xB8000;
  10042b:	c7 05 00 80 19 00 00 	movl   $0xb8000,0x198000
  100432:	80 0b 00 
	lock_init(&cursor_lock);
  100435:	e8 f6 07 00 00       	call   100c30 <lock_init>
	// Initialize the scheduling algorithm.
	scheduling_algorithm = 3;
  10043a:	c7 05 48 7f 10 00 03 	movl   $0x3,0x107f48
  100441:	00 00 00 

	// Switch to the first process.
	run(&proc_array[1]);
  100444:	c7 04 24 58 75 10 00 	movl   $0x107558,(%esp)
  10044b:	e8 21 02 00 00       	call   100671 <run>

00100450 <segments_init>:
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  100450:	b8 d8 76 10 00       	mov    $0x1076d8,%eax
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  100455:	b9 5c 00 10 00       	mov    $0x10005c,%ecx
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  10045a:	89 c2                	mov    %eax,%edx
  10045c:	c1 ea 10             	shr    $0x10,%edx
extern void default_int_handler(void);


void
segments_init(void)
{
  10045f:	53                   	push   %ebx
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  100460:	bb 5c 00 10 00       	mov    $0x10005c,%ebx
  100465:	c1 eb 10             	shr    $0x10,%ebx
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  100468:	66 a3 3e 10 10 00    	mov    %ax,0x10103e
  10046e:	c1 e8 18             	shr    $0x18,%eax
  100471:	88 15 40 10 10 00    	mov    %dl,0x101040
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  100477:	ba 40 77 10 00       	mov    $0x107740,%edx
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  10047c:	a2 43 10 10 00       	mov    %al,0x101043
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  100481:	31 c0                	xor    %eax,%eax
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  100483:	66 c7 05 3c 10 10 00 	movw   $0x68,0x10103c
  10048a:	68 00 
  10048c:	c6 05 42 10 10 00 40 	movb   $0x40,0x101042
		= SEG16(STS_T32A, (uint32_t) &kernel_task_descriptor,
			sizeof(taskstate_t), 0);
	segments[SEGSEL_TASKSTATE >> 3].sd_s = 0;
  100493:	c6 05 41 10 10 00 89 	movb   $0x89,0x101041

	// Set up kernel task descriptor, so we can receive interrupts
	kernel_task_descriptor.ts_esp0 = KERNEL_STACK_TOP;
  10049a:	c7 05 dc 76 10 00 00 	movl   $0x180000,0x1076dc
  1004a1:	00 18 00 
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;
  1004a4:	66 c7 05 e0 76 10 00 	movw   $0x10,0x1076e0
  1004ab:	10 00 

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  1004ad:	66 89 0c c5 40 77 10 	mov    %cx,0x107740(,%eax,8)
  1004b4:	00 
  1004b5:	66 c7 44 c2 02 08 00 	movw   $0x8,0x2(%edx,%eax,8)
  1004bc:	c6 44 c2 04 00       	movb   $0x0,0x4(%edx,%eax,8)
  1004c1:	c6 44 c2 05 8e       	movb   $0x8e,0x5(%edx,%eax,8)
  1004c6:	66 89 5c c2 06       	mov    %bx,0x6(%edx,%eax,8)
	kernel_task_descriptor.ts_esp0 = KERNEL_STACK_TOP;
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
  1004cb:	40                   	inc    %eax
  1004cc:	3d 00 01 00 00       	cmp    $0x100,%eax
  1004d1:	75 da                	jne    1004ad <segments_init+0x5d>
		SETGATE(interrupt_descriptors[i], 0,
			SEGSEL_KERN_CODE, default_int_handler, 0);

	// The clock interrupt gets special handling
	SETGATE(interrupt_descriptors[INT_CLOCK], 0,
  1004d3:	b8 1a 00 10 00       	mov    $0x10001a,%eax

	// System calls get special handling.
	// Note that the last argument is '3'.  This means that unprivileged
	// (level-3) applications may generate these interrupts.
	for (i = INT_SYS_YIELD; i < INT_SYS_YIELD + 10; i++)
		SETGATE(interrupt_descriptors[i], 0,
  1004d8:	ba 40 77 10 00       	mov    $0x107740,%edx
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
			SEGSEL_KERN_CODE, default_int_handler, 0);

	// The clock interrupt gets special handling
	SETGATE(interrupt_descriptors[INT_CLOCK], 0,
  1004dd:	66 a3 40 78 10 00    	mov    %ax,0x107840
  1004e3:	c1 e8 10             	shr    $0x10,%eax
  1004e6:	66 a3 46 78 10 00    	mov    %ax,0x107846
  1004ec:	b8 30 00 00 00       	mov    $0x30,%eax
  1004f1:	66 c7 05 42 78 10 00 	movw   $0x8,0x107842
  1004f8:	08 00 
  1004fa:	c6 05 44 78 10 00 00 	movb   $0x0,0x107844
  100501:	c6 05 45 78 10 00 8e 	movb   $0x8e,0x107845

	// System calls get special handling.
	// Note that the last argument is '3'.  This means that unprivileged
	// (level-3) applications may generate these interrupts.
	for (i = INT_SYS_YIELD; i < INT_SYS_YIELD + 10; i++)
		SETGATE(interrupt_descriptors[i], 0,
  100508:	8b 0c 85 b2 ff 0f 00 	mov    0xfffb2(,%eax,4),%ecx
  10050f:	66 c7 44 c2 02 08 00 	movw   $0x8,0x2(%edx,%eax,8)
  100516:	66 89 0c c5 40 77 10 	mov    %cx,0x107740(,%eax,8)
  10051d:	00 
  10051e:	c1 e9 10             	shr    $0x10,%ecx
  100521:	c6 44 c2 04 00       	movb   $0x0,0x4(%edx,%eax,8)
  100526:	c6 44 c2 05 ee       	movb   $0xee,0x5(%edx,%eax,8)
  10052b:	66 89 4c c2 06       	mov    %cx,0x6(%edx,%eax,8)
		SEGSEL_KERN_CODE, clock_int_handler, 0);

	// System calls get special handling.
	// Note that the last argument is '3'.  This means that unprivileged
	// (level-3) applications may generate these interrupts.
	for (i = INT_SYS_YIELD; i < INT_SYS_YIELD + 10; i++)
  100530:	40                   	inc    %eax
  100531:	83 f8 3a             	cmp    $0x3a,%eax
  100534:	75 d2                	jne    100508 <segments_init+0xb8>
		SETGATE(interrupt_descriptors[i], 0,
			SEGSEL_KERN_CODE, sys_int_handlers[i - INT_SYS_YIELD], 3);

	// Reload segment pointers
	asm volatile("lgdt global_descriptor_table\n\t"
  100536:	b0 28                	mov    $0x28,%al
  100538:	0f 01 15 04 10 10 00 	lgdtl  0x101004
  10053f:	0f 00 d8             	ltr    %ax
  100542:	0f 01 1d 0c 10 10 00 	lidtl  0x10100c
		     "lidt interrupt_descriptor_table"
		     : : "r" ((uint16_t) SEGSEL_TASKSTATE));

	// Convince compiler that all symbols were used
	(void) global_descriptor_table, (void) interrupt_descriptor_table;
}
  100549:	5b                   	pop    %ebx
  10054a:	c3                   	ret    

0010054b <interrupt_controller_init>:
#define	TIMER_FREQ	1193182
#define TIMER_DIV(x)	((TIMER_FREQ+(x)/2)/(x))

void
interrupt_controller_init(bool_t allow_clock_interrupt)
{
  10054b:	55                   	push   %ebp
}

static inline void
outb(int port, uint8_t data)
{
	asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
  10054c:	b0 ff                	mov    $0xff,%al
  10054e:	57                   	push   %edi
  10054f:	56                   	push   %esi
  100550:	53                   	push   %ebx
  100551:	bb 21 00 00 00       	mov    $0x21,%ebx
  100556:	89 da                	mov    %ebx,%edx
  100558:	ee                   	out    %al,(%dx)
  100559:	b9 a1 00 00 00       	mov    $0xa1,%ecx
  10055e:	89 ca                	mov    %ecx,%edx
  100560:	ee                   	out    %al,(%dx)
  100561:	be 11 00 00 00       	mov    $0x11,%esi
  100566:	bf 20 00 00 00       	mov    $0x20,%edi
  10056b:	89 f0                	mov    %esi,%eax
  10056d:	89 fa                	mov    %edi,%edx
  10056f:	ee                   	out    %al,(%dx)
  100570:	b0 20                	mov    $0x20,%al
  100572:	89 da                	mov    %ebx,%edx
  100574:	ee                   	out    %al,(%dx)
  100575:	b0 04                	mov    $0x4,%al
  100577:	ee                   	out    %al,(%dx)
  100578:	b0 03                	mov    $0x3,%al
  10057a:	ee                   	out    %al,(%dx)
  10057b:	bd a0 00 00 00       	mov    $0xa0,%ebp
  100580:	89 f0                	mov    %esi,%eax
  100582:	89 ea                	mov    %ebp,%edx
  100584:	ee                   	out    %al,(%dx)
  100585:	b0 28                	mov    $0x28,%al
  100587:	89 ca                	mov    %ecx,%edx
  100589:	ee                   	out    %al,(%dx)
  10058a:	b0 02                	mov    $0x2,%al
  10058c:	ee                   	out    %al,(%dx)
  10058d:	b0 01                	mov    $0x1,%al
  10058f:	ee                   	out    %al,(%dx)
  100590:	b0 68                	mov    $0x68,%al
  100592:	89 fa                	mov    %edi,%edx
  100594:	ee                   	out    %al,(%dx)
  100595:	be 0a 00 00 00       	mov    $0xa,%esi
  10059a:	89 f0                	mov    %esi,%eax
  10059c:	ee                   	out    %al,(%dx)
  10059d:	b0 68                	mov    $0x68,%al
  10059f:	89 ea                	mov    %ebp,%edx
  1005a1:	ee                   	out    %al,(%dx)
  1005a2:	89 f0                	mov    %esi,%eax
  1005a4:	ee                   	out    %al,(%dx)

	outb(IO_PIC2, 0x68);               /* OCW3 */
	outb(IO_PIC2, 0x0a);               /* OCW3 */

	// mask all interrupts again, except possibly for clock interrupt
	outb(IO_PIC1+1, (allow_clock_interrupt ? 0xFE : 0xFF));
  1005a5:	83 7c 24 14 01       	cmpl   $0x1,0x14(%esp)
  1005aa:	89 da                	mov    %ebx,%edx
  1005ac:	19 c0                	sbb    %eax,%eax
  1005ae:	f7 d0                	not    %eax
  1005b0:	05 ff 00 00 00       	add    $0xff,%eax
  1005b5:	ee                   	out    %al,(%dx)
  1005b6:	b0 ff                	mov    $0xff,%al
  1005b8:	89 ca                	mov    %ecx,%edx
  1005ba:	ee                   	out    %al,(%dx)
	outb(IO_PIC2+1, 0xFF);

	// if the clock interrupt is allowed, initialize the clock
	if (allow_clock_interrupt) {
  1005bb:	83 7c 24 14 00       	cmpl   $0x0,0x14(%esp)
  1005c0:	74 0d                	je     1005cf <interrupt_controller_init+0x84>
  1005c2:	b2 43                	mov    $0x43,%dl
  1005c4:	b0 34                	mov    $0x34,%al
  1005c6:	ee                   	out    %al,(%dx)
  1005c7:	b0 a9                	mov    $0xa9,%al
  1005c9:	b2 40                	mov    $0x40,%dl
  1005cb:	ee                   	out    %al,(%dx)
  1005cc:	b0 04                	mov    $0x4,%al
  1005ce:	ee                   	out    %al,(%dx)
		outb(TIMER_MODE, TIMER_SEL0 | TIMER_RATEGEN | TIMER_16BIT);
		outb(IO_TIMER1, TIMER_DIV(HZ) % 256);
		outb(IO_TIMER1, TIMER_DIV(HZ) / 256);
	}
}
  1005cf:	5b                   	pop    %ebx
  1005d0:	5e                   	pop    %esi
  1005d1:	5f                   	pop    %edi
  1005d2:	5d                   	pop    %ebp
  1005d3:	c3                   	ret    

001005d4 <console_clear>:
 *
 *****************************************************************************/

void
console_clear(void)
{
  1005d4:	56                   	push   %esi
	int i;
	cursorpos = (uint16_t *) 0xB8000;
  1005d5:	31 c0                	xor    %eax,%eax
 *
 *****************************************************************************/

void
console_clear(void)
{
  1005d7:	53                   	push   %ebx
	int i;
	cursorpos = (uint16_t *) 0xB8000;
  1005d8:	c7 05 00 80 19 00 00 	movl   $0xb8000,0x198000
  1005df:	80 0b 00 

	for (i = 0; i < 80 * 25; i++)
		cursorpos[i] = ' ' | 0x0700;
  1005e2:	8b 15 00 80 19 00    	mov    0x198000,%edx
  1005e8:	66 c7 04 02 20 07    	movw   $0x720,(%edx,%eax,1)
  1005ee:	83 c0 02             	add    $0x2,%eax
console_clear(void)
{
	int i;
	cursorpos = (uint16_t *) 0xB8000;

	for (i = 0; i < 80 * 25; i++)
  1005f1:	3d a0 0f 00 00       	cmp    $0xfa0,%eax
  1005f6:	75 ea                	jne    1005e2 <console_clear+0xe>
  1005f8:	be d4 03 00 00       	mov    $0x3d4,%esi
  1005fd:	b0 0e                	mov    $0xe,%al
  1005ff:	89 f2                	mov    %esi,%edx
  100601:	ee                   	out    %al,(%dx)
  100602:	31 c9                	xor    %ecx,%ecx
  100604:	bb d5 03 00 00       	mov    $0x3d5,%ebx
  100609:	88 c8                	mov    %cl,%al
  10060b:	89 da                	mov    %ebx,%edx
  10060d:	ee                   	out    %al,(%dx)
  10060e:	b0 0f                	mov    $0xf,%al
  100610:	89 f2                	mov    %esi,%edx
  100612:	ee                   	out    %al,(%dx)
  100613:	88 c8                	mov    %cl,%al
  100615:	89 da                	mov    %ebx,%edx
  100617:	ee                   	out    %al,(%dx)
		cursorpos[i] = ' ' | 0x0700;
	outb(0x3D4, 14);
	outb(0x3D5, 0 / 256);
	outb(0x3D4, 15);
	outb(0x3D5, 0 % 256);
}
  100618:	5b                   	pop    %ebx
  100619:	5e                   	pop    %esi
  10061a:	c3                   	ret    

0010061b <console_read_digit>:

static inline uint8_t
inb(int port)
{
	uint8_t data;
	asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
  10061b:	ba 64 00 00 00       	mov    $0x64,%edx
  100620:	ec                   	in     (%dx),%al
int
console_read_digit(void)
{
	uint8_t data;

	if ((inb(KBSTATP) & KBS_DIB) == 0)
  100621:	a8 01                	test   $0x1,%al
  100623:	74 45                	je     10066a <console_read_digit+0x4f>
  100625:	b2 60                	mov    $0x60,%dl
  100627:	ec                   	in     (%dx),%al
		return -1;

	data = inb(KBDATAP);
	if (data >= 0x02 && data <= 0x0A)
  100628:	8d 50 fe             	lea    -0x2(%eax),%edx
  10062b:	80 fa 08             	cmp    $0x8,%dl
  10062e:	77 05                	ja     100635 <console_read_digit+0x1a>
		return data - 0x02 + 1;
  100630:	0f b6 c0             	movzbl %al,%eax
  100633:	48                   	dec    %eax
  100634:	c3                   	ret    
	else if (data == 0x0B)
  100635:	3c 0b                	cmp    $0xb,%al
  100637:	74 35                	je     10066e <console_read_digit+0x53>
		return 0;
	else if (data >= 0x47 && data <= 0x49)
  100639:	8d 50 b9             	lea    -0x47(%eax),%edx
  10063c:	80 fa 02             	cmp    $0x2,%dl
  10063f:	77 07                	ja     100648 <console_read_digit+0x2d>
		return data - 0x47 + 7;
  100641:	0f b6 c0             	movzbl %al,%eax
  100644:	83 e8 40             	sub    $0x40,%eax
  100647:	c3                   	ret    
	else if (data >= 0x4B && data <= 0x4D)
  100648:	8d 50 b5             	lea    -0x4b(%eax),%edx
  10064b:	80 fa 02             	cmp    $0x2,%dl
  10064e:	77 07                	ja     100657 <console_read_digit+0x3c>
		return data - 0x4B + 4;
  100650:	0f b6 c0             	movzbl %al,%eax
  100653:	83 e8 47             	sub    $0x47,%eax
  100656:	c3                   	ret    
	else if (data >= 0x4F && data <= 0x51)
  100657:	8d 50 b1             	lea    -0x4f(%eax),%edx
  10065a:	80 fa 02             	cmp    $0x2,%dl
  10065d:	77 07                	ja     100666 <console_read_digit+0x4b>
		return data - 0x4F + 1;
  10065f:	0f b6 c0             	movzbl %al,%eax
  100662:	83 e8 4e             	sub    $0x4e,%eax
  100665:	c3                   	ret    
	else if (data == 0x53)
  100666:	3c 53                	cmp    $0x53,%al
  100668:	74 04                	je     10066e <console_read_digit+0x53>
  10066a:	83 c8 ff             	or     $0xffffffff,%eax
  10066d:	c3                   	ret    
  10066e:	31 c0                	xor    %eax,%eax
		return 0;
	else
		return -1;
}
  100670:	c3                   	ret    

00100671 <run>:
 *
 *****************************************************************************/

void
run(process_t *proc)
{
  100671:	8b 44 24 04          	mov    0x4(%esp),%eax
	current = proc;
  100675:	a3 44 7f 10 00       	mov    %eax,0x107f44

	asm volatile("movl %0,%%esp\n\t"
  10067a:	83 c0 04             	add    $0x4,%eax
  10067d:	89 c4                	mov    %eax,%esp
  10067f:	61                   	popa   
  100680:	07                   	pop    %es
  100681:	1f                   	pop    %ds
  100682:	83 c4 08             	add    $0x8,%esp
  100685:	cf                   	iret   
  100686:	eb fe                	jmp    100686 <run+0x15>

00100688 <special_registers_init>:
 *
 *****************************************************************************/

void
special_registers_init(process_t *proc)
{
  100688:	53                   	push   %ebx
  100689:	83 ec 0c             	sub    $0xc,%esp
  10068c:	8b 5c 24 14          	mov    0x14(%esp),%ebx
	memset(&proc->p_registers, 0, sizeof(registers_t));
  100690:	6a 44                	push   $0x44
  100692:	6a 00                	push   $0x0
  100694:	8d 43 04             	lea    0x4(%ebx),%eax
  100697:	50                   	push   %eax
  100698:	e8 17 01 00 00       	call   1007b4 <memset>
	proc->p_registers.reg_cs = SEGSEL_APP_CODE | 3;
  10069d:	66 c7 43 38 1b 00    	movw   $0x1b,0x38(%ebx)
	proc->p_registers.reg_ds = SEGSEL_APP_DATA | 3;
  1006a3:	66 c7 43 28 23 00    	movw   $0x23,0x28(%ebx)
	proc->p_registers.reg_es = SEGSEL_APP_DATA | 3;
  1006a9:	66 c7 43 24 23 00    	movw   $0x23,0x24(%ebx)
	proc->p_registers.reg_ss = SEGSEL_APP_DATA | 3;
  1006af:	66 c7 43 44 23 00    	movw   $0x23,0x44(%ebx)
	// Enable interrupts
	proc->p_registers.reg_eflags = EFLAGS_IF;
  1006b5:	c7 43 3c 00 02 00 00 	movl   $0x200,0x3c(%ebx)
}
  1006bc:	83 c4 18             	add    $0x18,%esp
  1006bf:	5b                   	pop    %ebx
  1006c0:	c3                   	ret    
  1006c1:	90                   	nop
  1006c2:	90                   	nop
  1006c3:	90                   	nop

001006c4 <program_loader>:
		    uint32_t filesz, uint32_t memsz);
static void loader_panic(void);

void
program_loader(int program_id, uint32_t *entry_point)
{
  1006c4:	55                   	push   %ebp
  1006c5:	57                   	push   %edi
  1006c6:	56                   	push   %esi
  1006c7:	53                   	push   %ebx
  1006c8:	83 ec 1c             	sub    $0x1c,%esp
  1006cb:	8b 44 24 30          	mov    0x30(%esp),%eax
	struct Proghdr *ph, *eph;
	struct Elf *elf_header;
	int nprograms = sizeof(ramimages) / sizeof(ramimages[0]);

	if (program_id < 0 || program_id >= nprograms)
  1006cf:	83 f8 03             	cmp    $0x3,%eax
  1006d2:	7f 04                	jg     1006d8 <program_loader+0x14>
  1006d4:	85 c0                	test   %eax,%eax
  1006d6:	79 02                	jns    1006da <program_loader+0x16>
  1006d8:	eb fe                	jmp    1006d8 <program_loader+0x14>
		loader_panic();

	// is this a valid ELF?
	elf_header = (struct Elf *) ramimages[program_id].begin;
  1006da:	8b 34 c5 44 10 10 00 	mov    0x101044(,%eax,8),%esi
	if (elf_header->e_magic != ELF_MAGIC)
  1006e1:	81 3e 7f 45 4c 46    	cmpl   $0x464c457f,(%esi)
  1006e7:	74 02                	je     1006eb <program_loader+0x27>
  1006e9:	eb fe                	jmp    1006e9 <program_loader+0x25>
		loader_panic();

	// load each program segment (ignores ph flags)
	ph = (struct Proghdr*) ((const uint8_t *) elf_header + elf_header->e_phoff);
  1006eb:	8b 5e 1c             	mov    0x1c(%esi),%ebx
	eph = ph + elf_header->e_phnum;
  1006ee:	0f b7 6e 2c          	movzwl 0x2c(%esi),%ebp
	elf_header = (struct Elf *) ramimages[program_id].begin;
	if (elf_header->e_magic != ELF_MAGIC)
		loader_panic();

	// load each program segment (ignores ph flags)
	ph = (struct Proghdr*) ((const uint8_t *) elf_header + elf_header->e_phoff);
  1006f2:	01 f3                	add    %esi,%ebx
	eph = ph + elf_header->e_phnum;
  1006f4:	c1 e5 05             	shl    $0x5,%ebp
  1006f7:	8d 2c 2b             	lea    (%ebx,%ebp,1),%ebp
	for (; ph < eph; ph++)
  1006fa:	eb 3f                	jmp    10073b <program_loader+0x77>
		if (ph->p_type == ELF_PROG_LOAD)
  1006fc:	83 3b 01             	cmpl   $0x1,(%ebx)
  1006ff:	75 37                	jne    100738 <program_loader+0x74>
			copyseg((void *) ph->p_va,
  100701:	8b 43 08             	mov    0x8(%ebx),%eax
// then clear the memory from 'va+filesz' up to 'va+memsz' (set it to 0).
static void
copyseg(void *dst, const uint8_t *src, uint32_t filesz, uint32_t memsz)
{
	uint32_t va = (uint32_t) dst;
	uint32_t end_va = va + filesz;
  100704:	8b 7b 10             	mov    0x10(%ebx),%edi
	memsz += va;
  100707:	8b 53 14             	mov    0x14(%ebx),%edx
// then clear the memory from 'va+filesz' up to 'va+memsz' (set it to 0).
static void
copyseg(void *dst, const uint8_t *src, uint32_t filesz, uint32_t memsz)
{
	uint32_t va = (uint32_t) dst;
	uint32_t end_va = va + filesz;
  10070a:	01 c7                	add    %eax,%edi
	memsz += va;
  10070c:	01 c2                	add    %eax,%edx
	va &= ~(PAGESIZE - 1);		// round to page boundary
  10070e:	25 00 f0 ff ff       	and    $0xfffff000,%eax
static void
copyseg(void *dst, const uint8_t *src, uint32_t filesz, uint32_t memsz)
{
	uint32_t va = (uint32_t) dst;
	uint32_t end_va = va + filesz;
	memsz += va;
  100713:	89 54 24 0c          	mov    %edx,0xc(%esp)
	va &= ~(PAGESIZE - 1);		// round to page boundary

	// copy data
	memcpy((uint8_t *) va, src, end_va - va);
  100717:	52                   	push   %edx
  100718:	89 fa                	mov    %edi,%edx
  10071a:	29 c2                	sub    %eax,%edx
  10071c:	52                   	push   %edx
  10071d:	8b 53 04             	mov    0x4(%ebx),%edx
  100720:	01 f2                	add    %esi,%edx
  100722:	52                   	push   %edx
  100723:	50                   	push   %eax
  100724:	e8 27 00 00 00       	call   100750 <memcpy>
  100729:	83 c4 10             	add    $0x10,%esp
  10072c:	eb 04                	jmp    100732 <program_loader+0x6e>

	// clear bss segment
	while (end_va < memsz)
		*((uint8_t *) end_va++) = 0;
  10072e:	c6 07 00             	movb   $0x0,(%edi)
  100731:	47                   	inc    %edi

	// copy data
	memcpy((uint8_t *) va, src, end_va - va);

	// clear bss segment
	while (end_va < memsz)
  100732:	3b 7c 24 0c          	cmp    0xc(%esp),%edi
  100736:	72 f6                	jb     10072e <program_loader+0x6a>
		loader_panic();

	// load each program segment (ignores ph flags)
	ph = (struct Proghdr*) ((const uint8_t *) elf_header + elf_header->e_phoff);
	eph = ph + elf_header->e_phnum;
	for (; ph < eph; ph++)
  100738:	83 c3 20             	add    $0x20,%ebx
  10073b:	39 eb                	cmp    %ebp,%ebx
  10073d:	72 bd                	jb     1006fc <program_loader+0x38>
			copyseg((void *) ph->p_va,
				(const uint8_t *) elf_header + ph->p_offset,
				ph->p_filesz, ph->p_memsz);

	// store the entry point from the ELF header
	*entry_point = elf_header->e_entry;
  10073f:	8b 56 18             	mov    0x18(%esi),%edx
  100742:	8b 44 24 34          	mov    0x34(%esp),%eax
  100746:	89 10                	mov    %edx,(%eax)
}
  100748:	83 c4 1c             	add    $0x1c,%esp
  10074b:	5b                   	pop    %ebx
  10074c:	5e                   	pop    %esi
  10074d:	5f                   	pop    %edi
  10074e:	5d                   	pop    %ebp
  10074f:	c3                   	ret    

00100750 <memcpy>:
 *
 *   We must provide our own implementations of these basic functions. */

void *
memcpy(void *dst, const void *src, size_t n)
{
  100750:	56                   	push   %esi
  100751:	31 d2                	xor    %edx,%edx
  100753:	53                   	push   %ebx
  100754:	8b 44 24 0c          	mov    0xc(%esp),%eax
  100758:	8b 5c 24 10          	mov    0x10(%esp),%ebx
  10075c:	8b 74 24 14          	mov    0x14(%esp),%esi
	const char *s = (const char *) src;
	char *d = (char *) dst;
	while (n-- > 0)
  100760:	eb 08                	jmp    10076a <memcpy+0x1a>
		*d++ = *s++;
  100762:	8a 0c 13             	mov    (%ebx,%edx,1),%cl
  100765:	4e                   	dec    %esi
  100766:	88 0c 10             	mov    %cl,(%eax,%edx,1)
  100769:	42                   	inc    %edx
void *
memcpy(void *dst, const void *src, size_t n)
{
	const char *s = (const char *) src;
	char *d = (char *) dst;
	while (n-- > 0)
  10076a:	85 f6                	test   %esi,%esi
  10076c:	75 f4                	jne    100762 <memcpy+0x12>
		*d++ = *s++;
	return dst;
}
  10076e:	5b                   	pop    %ebx
  10076f:	5e                   	pop    %esi
  100770:	c3                   	ret    

00100771 <memmove>:

void *
memmove(void *dst, const void *src, size_t n)
{
  100771:	57                   	push   %edi
  100772:	56                   	push   %esi
  100773:	53                   	push   %ebx
  100774:	8b 44 24 10          	mov    0x10(%esp),%eax
  100778:	8b 7c 24 14          	mov    0x14(%esp),%edi
  10077c:	8b 54 24 18          	mov    0x18(%esp),%edx
	const char *s = (const char *) src;
	char *d = (char *) dst;
	if (s < d && s + n > d) {
  100780:	39 c7                	cmp    %eax,%edi
  100782:	73 26                	jae    1007aa <memmove+0x39>
  100784:	8d 34 17             	lea    (%edi,%edx,1),%esi
  100787:	39 c6                	cmp    %eax,%esi
  100789:	76 1f                	jbe    1007aa <memmove+0x39>
		s += n, d += n;
  10078b:	8d 3c 10             	lea    (%eax,%edx,1),%edi
  10078e:	31 c9                	xor    %ecx,%ecx
		while (n-- > 0)
  100790:	eb 07                	jmp    100799 <memmove+0x28>
			*--d = *--s;
  100792:	8a 1c 0e             	mov    (%esi,%ecx,1),%bl
  100795:	4a                   	dec    %edx
  100796:	88 1c 0f             	mov    %bl,(%edi,%ecx,1)
  100799:	49                   	dec    %ecx
{
	const char *s = (const char *) src;
	char *d = (char *) dst;
	if (s < d && s + n > d) {
		s += n, d += n;
		while (n-- > 0)
  10079a:	85 d2                	test   %edx,%edx
  10079c:	75 f4                	jne    100792 <memmove+0x21>
  10079e:	eb 10                	jmp    1007b0 <memmove+0x3f>
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  1007a0:	8a 1c 0f             	mov    (%edi,%ecx,1),%bl
  1007a3:	4a                   	dec    %edx
  1007a4:	88 1c 08             	mov    %bl,(%eax,%ecx,1)
  1007a7:	41                   	inc    %ecx
  1007a8:	eb 02                	jmp    1007ac <memmove+0x3b>
  1007aa:	31 c9                	xor    %ecx,%ecx
	if (s < d && s + n > d) {
		s += n, d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  1007ac:	85 d2                	test   %edx,%edx
  1007ae:	75 f0                	jne    1007a0 <memmove+0x2f>
			*d++ = *s++;
	return dst;
}
  1007b0:	5b                   	pop    %ebx
  1007b1:	5e                   	pop    %esi
  1007b2:	5f                   	pop    %edi
  1007b3:	c3                   	ret    

001007b4 <memset>:

void *
memset(void *v, int c, size_t n)
{
  1007b4:	53                   	push   %ebx
  1007b5:	8b 44 24 08          	mov    0x8(%esp),%eax
  1007b9:	8b 5c 24 0c          	mov    0xc(%esp),%ebx
  1007bd:	8b 4c 24 10          	mov    0x10(%esp),%ecx
	char *p = (char *) v;
  1007c1:	89 c2                	mov    %eax,%edx
	while (n-- > 0)
  1007c3:	eb 04                	jmp    1007c9 <memset+0x15>
		*p++ = c;
  1007c5:	88 1a                	mov    %bl,(%edx)
  1007c7:	49                   	dec    %ecx
  1007c8:	42                   	inc    %edx

void *
memset(void *v, int c, size_t n)
{
	char *p = (char *) v;
	while (n-- > 0)
  1007c9:	85 c9                	test   %ecx,%ecx
  1007cb:	75 f8                	jne    1007c5 <memset+0x11>
		*p++ = c;
	return v;
}
  1007cd:	5b                   	pop    %ebx
  1007ce:	c3                   	ret    

001007cf <strlen>:

size_t
strlen(const char *s)
{
  1007cf:	8b 54 24 04          	mov    0x4(%esp),%edx
  1007d3:	31 c0                	xor    %eax,%eax
	size_t n;
	for (n = 0; *s != '\0'; ++s)
  1007d5:	eb 01                	jmp    1007d8 <strlen+0x9>
		++n;
  1007d7:	40                   	inc    %eax

size_t
strlen(const char *s)
{
	size_t n;
	for (n = 0; *s != '\0'; ++s)
  1007d8:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
  1007dc:	75 f9                	jne    1007d7 <strlen+0x8>
		++n;
	return n;
}
  1007de:	c3                   	ret    

001007df <strnlen>:

size_t
strnlen(const char *s, size_t maxlen)
{
  1007df:	8b 4c 24 04          	mov    0x4(%esp),%ecx
  1007e3:	31 c0                	xor    %eax,%eax
  1007e5:	8b 54 24 08          	mov    0x8(%esp),%edx
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
  1007e9:	eb 01                	jmp    1007ec <strnlen+0xd>
		++n;
  1007eb:	40                   	inc    %eax

size_t
strnlen(const char *s, size_t maxlen)
{
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
  1007ec:	39 d0                	cmp    %edx,%eax
  1007ee:	74 06                	je     1007f6 <strnlen+0x17>
  1007f0:	80 3c 01 00          	cmpb   $0x0,(%ecx,%eax,1)
  1007f4:	75 f5                	jne    1007eb <strnlen+0xc>
		++n;
	return n;
}
  1007f6:	c3                   	ret    

001007f7 <console_putc>:
 *
 *   Print a message onto the console, starting at the given cursor position. */

static uint16_t *
console_putc(uint16_t *cursor, unsigned char c, int color)
{
  1007f7:	56                   	push   %esi
	if (cursor >= CONSOLE_END)
  1007f8:	3d 9f 8f 0b 00       	cmp    $0xb8f9f,%eax
 *
 *   Print a message onto the console, starting at the given cursor position. */

static uint16_t *
console_putc(uint16_t *cursor, unsigned char c, int color)
{
  1007fd:	53                   	push   %ebx
  1007fe:	89 c3                	mov    %eax,%ebx
	if (cursor >= CONSOLE_END)
  100800:	76 05                	jbe    100807 <console_putc+0x10>
  100802:	bb 00 80 0b 00       	mov    $0xb8000,%ebx
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
  100807:	80 fa 0a             	cmp    $0xa,%dl
  10080a:	75 2c                	jne    100838 <console_putc+0x41>
		int pos = (cursor - CONSOLE_BEGIN) % 80;
  10080c:	8d 83 00 80 f4 ff    	lea    -0xb8000(%ebx),%eax
  100812:	be 50 00 00 00       	mov    $0x50,%esi
  100817:	d1 f8                	sar    %eax
		for (; pos != 80; pos++)
			*cursor++ = ' ' | color;
  100819:	83 c9 20             	or     $0x20,%ecx
console_putc(uint16_t *cursor, unsigned char c, int color)
{
	if (cursor >= CONSOLE_END)
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
		int pos = (cursor - CONSOLE_BEGIN) % 80;
  10081c:	99                   	cltd   
  10081d:	f7 fe                	idiv   %esi
  10081f:	89 de                	mov    %ebx,%esi
  100821:	89 d0                	mov    %edx,%eax
		for (; pos != 80; pos++)
  100823:	eb 07                	jmp    10082c <console_putc+0x35>
			*cursor++ = ' ' | color;
  100825:	66 89 0e             	mov    %cx,(%esi)
{
	if (cursor >= CONSOLE_END)
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
		int pos = (cursor - CONSOLE_BEGIN) % 80;
		for (; pos != 80; pos++)
  100828:	40                   	inc    %eax
			*cursor++ = ' ' | color;
  100829:	83 c6 02             	add    $0x2,%esi
{
	if (cursor >= CONSOLE_END)
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
		int pos = (cursor - CONSOLE_BEGIN) % 80;
		for (; pos != 80; pos++)
  10082c:	83 f8 50             	cmp    $0x50,%eax
  10082f:	75 f4                	jne    100825 <console_putc+0x2e>
  100831:	29 d0                	sub    %edx,%eax
  100833:	8d 04 43             	lea    (%ebx,%eax,2),%eax
  100836:	eb 0b                	jmp    100843 <console_putc+0x4c>
			*cursor++ = ' ' | color;
	} else
		*cursor++ = c | color;
  100838:	0f b6 d2             	movzbl %dl,%edx
  10083b:	09 ca                	or     %ecx,%edx
  10083d:	66 89 13             	mov    %dx,(%ebx)
  100840:	8d 43 02             	lea    0x2(%ebx),%eax
	return cursor;
}
  100843:	5b                   	pop    %ebx
  100844:	5e                   	pop    %esi
  100845:	c3                   	ret    

00100846 <fill_numbuf>:
static const char lower_digits[] = "0123456789abcdef";

static char *
fill_numbuf(char *numbuf_end, uint32_t val, int base, const char *digits,
	    int precision)
{
  100846:	56                   	push   %esi
  100847:	53                   	push   %ebx
  100848:	8b 74 24 0c          	mov    0xc(%esp),%esi
	*--numbuf_end = '\0';
  10084c:	8d 58 ff             	lea    -0x1(%eax),%ebx
  10084f:	c6 40 ff 00          	movb   $0x0,-0x1(%eax)
	if (precision != 0 || val != 0)
  100853:	83 7c 24 10 00       	cmpl   $0x0,0x10(%esp)
  100858:	75 04                	jne    10085e <fill_numbuf+0x18>
  10085a:	85 d2                	test   %edx,%edx
  10085c:	74 10                	je     10086e <fill_numbuf+0x28>
		do {
			*--numbuf_end = digits[val % base];
  10085e:	89 d0                	mov    %edx,%eax
  100860:	31 d2                	xor    %edx,%edx
  100862:	f7 f1                	div    %ecx
  100864:	4b                   	dec    %ebx
  100865:	8a 14 16             	mov    (%esi,%edx,1),%dl
  100868:	88 13                	mov    %dl,(%ebx)
			val /= base;
  10086a:	89 c2                	mov    %eax,%edx
  10086c:	eb ec                	jmp    10085a <fill_numbuf+0x14>
		} while (val != 0);
	return numbuf_end;
}
  10086e:	89 d8                	mov    %ebx,%eax
  100870:	5b                   	pop    %ebx
  100871:	5e                   	pop    %esi
  100872:	c3                   	ret    

00100873 <console_vprintf>:
#define FLAG_PLUSPOSITIVE	(1<<4)
static const char flag_chars[] = "#0- +";

uint16_t *
console_vprintf(uint16_t *cursor, int color, const char *format, va_list val)
{
  100873:	55                   	push   %ebp
  100874:	57                   	push   %edi
  100875:	56                   	push   %esi
  100876:	53                   	push   %ebx
  100877:	83 ec 38             	sub    $0x38,%esp
  10087a:	8b 74 24 4c          	mov    0x4c(%esp),%esi
  10087e:	8b 7c 24 54          	mov    0x54(%esp),%edi
  100882:	8b 5c 24 58          	mov    0x58(%esp),%ebx
	int flags, width, zeros, precision, negative, numeric, len;
#define NUMBUFSIZ 20
	char numbuf[NUMBUFSIZ];
	char *data;

	for (; *format; ++format) {
  100886:	e9 60 03 00 00       	jmp    100beb <console_vprintf+0x378>
		if (*format != '%') {
  10088b:	80 fa 25             	cmp    $0x25,%dl
  10088e:	74 13                	je     1008a3 <console_vprintf+0x30>
			cursor = console_putc(cursor, *format, color);
  100890:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  100894:	0f b6 d2             	movzbl %dl,%edx
  100897:	89 f0                	mov    %esi,%eax
  100899:	e8 59 ff ff ff       	call   1007f7 <console_putc>
  10089e:	e9 45 03 00 00       	jmp    100be8 <console_vprintf+0x375>
			continue;
		}

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
  1008a3:	47                   	inc    %edi
  1008a4:	c7 44 24 14 00 00 00 	movl   $0x0,0x14(%esp)
  1008ab:	00 
  1008ac:	eb 12                	jmp    1008c0 <console_vprintf+0x4d>
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
				++flagc;
  1008ae:	41                   	inc    %ecx

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
  1008af:	8a 11                	mov    (%ecx),%dl
  1008b1:	84 d2                	test   %dl,%dl
  1008b3:	74 1a                	je     1008cf <console_vprintf+0x5c>
  1008b5:	89 e8                	mov    %ebp,%eax
  1008b7:	38 c2                	cmp    %al,%dl
  1008b9:	75 f3                	jne    1008ae <console_vprintf+0x3b>
  1008bb:	e9 3f 03 00 00       	jmp    100bff <console_vprintf+0x38c>
			continue;
		}

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
  1008c0:	8a 17                	mov    (%edi),%dl
  1008c2:	84 d2                	test   %dl,%dl
  1008c4:	74 0b                	je     1008d1 <console_vprintf+0x5e>
  1008c6:	b9 c0 0c 10 00       	mov    $0x100cc0,%ecx
  1008cb:	89 d5                	mov    %edx,%ebp
  1008cd:	eb e0                	jmp    1008af <console_vprintf+0x3c>
  1008cf:	89 ea                	mov    %ebp,%edx
			flags |= (1 << (flagc - flag_chars));
		}

		// process width
		width = -1;
		if (*format >= '1' && *format <= '9') {
  1008d1:	8d 42 cf             	lea    -0x31(%edx),%eax
  1008d4:	3c 08                	cmp    $0x8,%al
  1008d6:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
  1008dd:	00 
  1008de:	76 13                	jbe    1008f3 <console_vprintf+0x80>
  1008e0:	eb 1d                	jmp    1008ff <console_vprintf+0x8c>
			for (width = 0; *format >= '0' && *format <= '9'; )
				width = 10 * width + *format++ - '0';
  1008e2:	6b 54 24 0c 0a       	imul   $0xa,0xc(%esp),%edx
  1008e7:	0f be c0             	movsbl %al,%eax
  1008ea:	47                   	inc    %edi
  1008eb:	8d 44 02 d0          	lea    -0x30(%edx,%eax,1),%eax
  1008ef:	89 44 24 0c          	mov    %eax,0xc(%esp)
		}

		// process width
		width = -1;
		if (*format >= '1' && *format <= '9') {
			for (width = 0; *format >= '0' && *format <= '9'; )
  1008f3:	8a 07                	mov    (%edi),%al
  1008f5:	8d 50 d0             	lea    -0x30(%eax),%edx
  1008f8:	80 fa 09             	cmp    $0x9,%dl
  1008fb:	76 e5                	jbe    1008e2 <console_vprintf+0x6f>
  1008fd:	eb 18                	jmp    100917 <console_vprintf+0xa4>
				width = 10 * width + *format++ - '0';
		} else if (*format == '*') {
  1008ff:	80 fa 2a             	cmp    $0x2a,%dl
  100902:	c7 44 24 0c ff ff ff 	movl   $0xffffffff,0xc(%esp)
  100909:	ff 
  10090a:	75 0b                	jne    100917 <console_vprintf+0xa4>
			width = va_arg(val, int);
  10090c:	83 c3 04             	add    $0x4,%ebx
			++format;
  10090f:	47                   	inc    %edi
		width = -1;
		if (*format >= '1' && *format <= '9') {
			for (width = 0; *format >= '0' && *format <= '9'; )
				width = 10 * width + *format++ - '0';
		} else if (*format == '*') {
			width = va_arg(val, int);
  100910:	8b 53 fc             	mov    -0x4(%ebx),%edx
  100913:	89 54 24 0c          	mov    %edx,0xc(%esp)
			++format;
		}

		// process precision
		precision = -1;
		if (*format == '.') {
  100917:	83 cd ff             	or     $0xffffffff,%ebp
  10091a:	80 3f 2e             	cmpb   $0x2e,(%edi)
  10091d:	75 37                	jne    100956 <console_vprintf+0xe3>
			++format;
  10091f:	47                   	inc    %edi
			if (*format >= '0' && *format <= '9') {
  100920:	31 ed                	xor    %ebp,%ebp
  100922:	8a 07                	mov    (%edi),%al
  100924:	8d 50 d0             	lea    -0x30(%eax),%edx
  100927:	80 fa 09             	cmp    $0x9,%dl
  10092a:	76 0d                	jbe    100939 <console_vprintf+0xc6>
  10092c:	eb 17                	jmp    100945 <console_vprintf+0xd2>
				for (precision = 0; *format >= '0' && *format <= '9'; )
					precision = 10 * precision + *format++ - '0';
  10092e:	6b ed 0a             	imul   $0xa,%ebp,%ebp
  100931:	0f be c0             	movsbl %al,%eax
  100934:	47                   	inc    %edi
  100935:	8d 6c 05 d0          	lea    -0x30(%ebp,%eax,1),%ebp
		// process precision
		precision = -1;
		if (*format == '.') {
			++format;
			if (*format >= '0' && *format <= '9') {
				for (precision = 0; *format >= '0' && *format <= '9'; )
  100939:	8a 07                	mov    (%edi),%al
  10093b:	8d 50 d0             	lea    -0x30(%eax),%edx
  10093e:	80 fa 09             	cmp    $0x9,%dl
  100941:	76 eb                	jbe    10092e <console_vprintf+0xbb>
  100943:	eb 11                	jmp    100956 <console_vprintf+0xe3>
					precision = 10 * precision + *format++ - '0';
			} else if (*format == '*') {
  100945:	3c 2a                	cmp    $0x2a,%al
  100947:	75 0b                	jne    100954 <console_vprintf+0xe1>
				precision = va_arg(val, int);
  100949:	83 c3 04             	add    $0x4,%ebx
				++format;
  10094c:	47                   	inc    %edi
			++format;
			if (*format >= '0' && *format <= '9') {
				for (precision = 0; *format >= '0' && *format <= '9'; )
					precision = 10 * precision + *format++ - '0';
			} else if (*format == '*') {
				precision = va_arg(val, int);
  10094d:	8b 6b fc             	mov    -0x4(%ebx),%ebp
				++format;
			}
			if (precision < 0)
  100950:	85 ed                	test   %ebp,%ebp
  100952:	79 02                	jns    100956 <console_vprintf+0xe3>
  100954:	31 ed                	xor    %ebp,%ebp
		}

		// process main conversion character
		negative = 0;
		numeric = 0;
		switch (*format) {
  100956:	8a 07                	mov    (%edi),%al
  100958:	3c 64                	cmp    $0x64,%al
  10095a:	74 34                	je     100990 <console_vprintf+0x11d>
  10095c:	7f 1d                	jg     10097b <console_vprintf+0x108>
  10095e:	3c 58                	cmp    $0x58,%al
  100960:	0f 84 a2 00 00 00    	je     100a08 <console_vprintf+0x195>
  100966:	3c 63                	cmp    $0x63,%al
  100968:	0f 84 bf 00 00 00    	je     100a2d <console_vprintf+0x1ba>
  10096e:	3c 43                	cmp    $0x43,%al
  100970:	0f 85 d0 00 00 00    	jne    100a46 <console_vprintf+0x1d3>
  100976:	e9 a3 00 00 00       	jmp    100a1e <console_vprintf+0x1ab>
  10097b:	3c 75                	cmp    $0x75,%al
  10097d:	74 4d                	je     1009cc <console_vprintf+0x159>
  10097f:	3c 78                	cmp    $0x78,%al
  100981:	74 5c                	je     1009df <console_vprintf+0x16c>
  100983:	3c 73                	cmp    $0x73,%al
  100985:	0f 85 bb 00 00 00    	jne    100a46 <console_vprintf+0x1d3>
  10098b:	e9 86 00 00 00       	jmp    100a16 <console_vprintf+0x1a3>
		case 'd': {
			int x = va_arg(val, int);
  100990:	83 c3 04             	add    $0x4,%ebx
  100993:	8b 53 fc             	mov    -0x4(%ebx),%edx
			data = fill_numbuf(numbuf + NUMBUFSIZ, x > 0 ? x : -x, 10, upper_digits, precision);
  100996:	89 d1                	mov    %edx,%ecx
  100998:	c1 f9 1f             	sar    $0x1f,%ecx
  10099b:	89 0c 24             	mov    %ecx,(%esp)
  10099e:	31 ca                	xor    %ecx,%edx
  1009a0:	55                   	push   %ebp
  1009a1:	29 ca                	sub    %ecx,%edx
  1009a3:	68 c8 0c 10 00       	push   $0x100cc8
  1009a8:	b9 0a 00 00 00       	mov    $0xa,%ecx
  1009ad:	8d 44 24 40          	lea    0x40(%esp),%eax
  1009b1:	e8 90 fe ff ff       	call   100846 <fill_numbuf>
  1009b6:	89 44 24 0c          	mov    %eax,0xc(%esp)
			if (x < 0)
  1009ba:	58                   	pop    %eax
  1009bb:	5a                   	pop    %edx
  1009bc:	ba 01 00 00 00       	mov    $0x1,%edx
  1009c1:	8b 04 24             	mov    (%esp),%eax
  1009c4:	83 e0 01             	and    $0x1,%eax
  1009c7:	e9 a5 00 00 00       	jmp    100a71 <console_vprintf+0x1fe>
				negative = 1;
			numeric = 1;
			break;
		}
		case 'u': {
			unsigned x = va_arg(val, unsigned);
  1009cc:	83 c3 04             	add    $0x4,%ebx
			data = fill_numbuf(numbuf + NUMBUFSIZ, x, 10, upper_digits, precision);
  1009cf:	b9 0a 00 00 00       	mov    $0xa,%ecx
  1009d4:	8b 53 fc             	mov    -0x4(%ebx),%edx
  1009d7:	55                   	push   %ebp
  1009d8:	68 c8 0c 10 00       	push   $0x100cc8
  1009dd:	eb 11                	jmp    1009f0 <console_vprintf+0x17d>
			numeric = 1;
			break;
		}
		case 'x': {
			unsigned x = va_arg(val, unsigned);
  1009df:	83 c3 04             	add    $0x4,%ebx
			data = fill_numbuf(numbuf + NUMBUFSIZ, x, 16, lower_digits, precision);
  1009e2:	8b 53 fc             	mov    -0x4(%ebx),%edx
  1009e5:	55                   	push   %ebp
  1009e6:	68 dc 0c 10 00       	push   $0x100cdc
  1009eb:	b9 10 00 00 00       	mov    $0x10,%ecx
  1009f0:	8d 44 24 40          	lea    0x40(%esp),%eax
  1009f4:	e8 4d fe ff ff       	call   100846 <fill_numbuf>
  1009f9:	ba 01 00 00 00       	mov    $0x1,%edx
  1009fe:	89 44 24 0c          	mov    %eax,0xc(%esp)
  100a02:	31 c0                	xor    %eax,%eax
			numeric = 1;
			break;
  100a04:	59                   	pop    %ecx
  100a05:	59                   	pop    %ecx
  100a06:	eb 69                	jmp    100a71 <console_vprintf+0x1fe>
		}
		case 'X': {
			unsigned x = va_arg(val, unsigned);
  100a08:	83 c3 04             	add    $0x4,%ebx
			data = fill_numbuf(numbuf + NUMBUFSIZ, x, 16, upper_digits, precision);
  100a0b:	8b 53 fc             	mov    -0x4(%ebx),%edx
  100a0e:	55                   	push   %ebp
  100a0f:	68 c8 0c 10 00       	push   $0x100cc8
  100a14:	eb d5                	jmp    1009eb <console_vprintf+0x178>
			numeric = 1;
			break;
		}
		case 's':
			data = va_arg(val, char *);
  100a16:	83 c3 04             	add    $0x4,%ebx
  100a19:	8b 43 fc             	mov    -0x4(%ebx),%eax
  100a1c:	eb 40                	jmp    100a5e <console_vprintf+0x1eb>
			break;
		case 'C':
			color = va_arg(val, int);
  100a1e:	83 c3 04             	add    $0x4,%ebx
  100a21:	8b 53 fc             	mov    -0x4(%ebx),%edx
  100a24:	89 54 24 50          	mov    %edx,0x50(%esp)
			goto done;
  100a28:	e9 bd 01 00 00       	jmp    100bea <console_vprintf+0x377>
		case 'c':
			data = numbuf;
			numbuf[0] = va_arg(val, int);
  100a2d:	83 c3 04             	add    $0x4,%ebx
  100a30:	8b 43 fc             	mov    -0x4(%ebx),%eax
			numbuf[1] = '\0';
  100a33:	8d 4c 24 24          	lea    0x24(%esp),%ecx
  100a37:	c6 44 24 25 00       	movb   $0x0,0x25(%esp)
  100a3c:	89 4c 24 04          	mov    %ecx,0x4(%esp)
		case 'C':
			color = va_arg(val, int);
			goto done;
		case 'c':
			data = numbuf;
			numbuf[0] = va_arg(val, int);
  100a40:	88 44 24 24          	mov    %al,0x24(%esp)
  100a44:	eb 27                	jmp    100a6d <console_vprintf+0x1fa>
			numbuf[1] = '\0';
			break;
		normal:
		default:
			data = numbuf;
			numbuf[0] = (*format ? *format : '%');
  100a46:	84 c0                	test   %al,%al
  100a48:	75 02                	jne    100a4c <console_vprintf+0x1d9>
  100a4a:	b0 25                	mov    $0x25,%al
  100a4c:	88 44 24 24          	mov    %al,0x24(%esp)
			numbuf[1] = '\0';
  100a50:	c6 44 24 25 00       	movb   $0x0,0x25(%esp)
			if (!*format)
  100a55:	80 3f 00             	cmpb   $0x0,(%edi)
  100a58:	74 0a                	je     100a64 <console_vprintf+0x1f1>
  100a5a:	8d 44 24 24          	lea    0x24(%esp),%eax
  100a5e:	89 44 24 04          	mov    %eax,0x4(%esp)
  100a62:	eb 09                	jmp    100a6d <console_vprintf+0x1fa>
				format--;
  100a64:	8d 54 24 24          	lea    0x24(%esp),%edx
  100a68:	4f                   	dec    %edi
  100a69:	89 54 24 04          	mov    %edx,0x4(%esp)
  100a6d:	31 d2                	xor    %edx,%edx
  100a6f:	31 c0                	xor    %eax,%eax
			break;
		}

		if (precision >= 0)
			len = strnlen(data, precision);
  100a71:	31 c9                	xor    %ecx,%ecx
			if (!*format)
				format--;
			break;
		}

		if (precision >= 0)
  100a73:	83 fd ff             	cmp    $0xffffffff,%ebp
  100a76:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  100a7d:	74 1f                	je     100a9e <console_vprintf+0x22b>
  100a7f:	89 04 24             	mov    %eax,(%esp)
  100a82:	eb 01                	jmp    100a85 <console_vprintf+0x212>
size_t
strnlen(const char *s, size_t maxlen)
{
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
		++n;
  100a84:	41                   	inc    %ecx

size_t
strnlen(const char *s, size_t maxlen)
{
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
  100a85:	39 e9                	cmp    %ebp,%ecx
  100a87:	74 0a                	je     100a93 <console_vprintf+0x220>
  100a89:	8b 44 24 04          	mov    0x4(%esp),%eax
  100a8d:	80 3c 08 00          	cmpb   $0x0,(%eax,%ecx,1)
  100a91:	75 f1                	jne    100a84 <console_vprintf+0x211>
  100a93:	8b 04 24             	mov    (%esp),%eax
				format--;
			break;
		}

		if (precision >= 0)
			len = strnlen(data, precision);
  100a96:	89 0c 24             	mov    %ecx,(%esp)
  100a99:	eb 1f                	jmp    100aba <console_vprintf+0x247>
size_t
strlen(const char *s)
{
	size_t n;
	for (n = 0; *s != '\0'; ++s)
		++n;
  100a9b:	42                   	inc    %edx
  100a9c:	eb 09                	jmp    100aa7 <console_vprintf+0x234>
  100a9e:	89 d1                	mov    %edx,%ecx
  100aa0:	8b 14 24             	mov    (%esp),%edx
  100aa3:	89 44 24 08          	mov    %eax,0x8(%esp)

size_t
strlen(const char *s)
{
	size_t n;
	for (n = 0; *s != '\0'; ++s)
  100aa7:	8b 44 24 04          	mov    0x4(%esp),%eax
  100aab:	80 3c 10 00          	cmpb   $0x0,(%eax,%edx,1)
  100aaf:	75 ea                	jne    100a9b <console_vprintf+0x228>
  100ab1:	8b 44 24 08          	mov    0x8(%esp),%eax
  100ab5:	89 14 24             	mov    %edx,(%esp)
  100ab8:	89 ca                	mov    %ecx,%edx

		if (precision >= 0)
			len = strnlen(data, precision);
		else
			len = strlen(data);
		if (numeric && negative)
  100aba:	85 c0                	test   %eax,%eax
  100abc:	74 0c                	je     100aca <console_vprintf+0x257>
  100abe:	84 d2                	test   %dl,%dl
  100ac0:	c7 44 24 08 2d 00 00 	movl   $0x2d,0x8(%esp)
  100ac7:	00 
  100ac8:	75 24                	jne    100aee <console_vprintf+0x27b>
			negative = '-';
		else if (flags & FLAG_PLUSPOSITIVE)
  100aca:	f6 44 24 14 10       	testb  $0x10,0x14(%esp)
  100acf:	c7 44 24 08 2b 00 00 	movl   $0x2b,0x8(%esp)
  100ad6:	00 
  100ad7:	75 15                	jne    100aee <console_vprintf+0x27b>
			negative = '+';
		else if (flags & FLAG_SPACEPOSITIVE)
  100ad9:	8b 44 24 14          	mov    0x14(%esp),%eax
  100add:	83 e0 08             	and    $0x8,%eax
  100ae0:	83 f8 01             	cmp    $0x1,%eax
  100ae3:	19 c9                	sbb    %ecx,%ecx
  100ae5:	f7 d1                	not    %ecx
  100ae7:	83 e1 20             	and    $0x20,%ecx
  100aea:	89 4c 24 08          	mov    %ecx,0x8(%esp)
			negative = ' ';
		else
			negative = 0;
		if (numeric && precision > len)
  100aee:	3b 2c 24             	cmp    (%esp),%ebp
  100af1:	7e 0d                	jle    100b00 <console_vprintf+0x28d>
  100af3:	84 d2                	test   %dl,%dl
  100af5:	74 40                	je     100b37 <console_vprintf+0x2c4>
			zeros = precision - len;
  100af7:	2b 2c 24             	sub    (%esp),%ebp
  100afa:	89 6c 24 10          	mov    %ebp,0x10(%esp)
  100afe:	eb 3f                	jmp    100b3f <console_vprintf+0x2cc>
		else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
  100b00:	84 d2                	test   %dl,%dl
  100b02:	74 33                	je     100b37 <console_vprintf+0x2c4>
  100b04:	8b 44 24 14          	mov    0x14(%esp),%eax
  100b08:	83 e0 06             	and    $0x6,%eax
  100b0b:	83 f8 02             	cmp    $0x2,%eax
  100b0e:	75 27                	jne    100b37 <console_vprintf+0x2c4>
  100b10:	45                   	inc    %ebp
  100b11:	75 24                	jne    100b37 <console_vprintf+0x2c4>
			 && numeric && precision < 0
			 && len + !!negative < width)
  100b13:	31 c0                	xor    %eax,%eax
			negative = ' ';
		else
			negative = 0;
		if (numeric && precision > len)
			zeros = precision - len;
		else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
  100b15:	8b 0c 24             	mov    (%esp),%ecx
			 && numeric && precision < 0
			 && len + !!negative < width)
  100b18:	83 7c 24 08 00       	cmpl   $0x0,0x8(%esp)
  100b1d:	0f 95 c0             	setne  %al
			negative = ' ';
		else
			negative = 0;
		if (numeric && precision > len)
			zeros = precision - len;
		else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
  100b20:	8d 14 08             	lea    (%eax,%ecx,1),%edx
  100b23:	3b 54 24 0c          	cmp    0xc(%esp),%edx
  100b27:	7d 0e                	jge    100b37 <console_vprintf+0x2c4>
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
  100b29:	8b 54 24 0c          	mov    0xc(%esp),%edx
  100b2d:	29 ca                	sub    %ecx,%edx
  100b2f:	29 c2                	sub    %eax,%edx
  100b31:	89 54 24 10          	mov    %edx,0x10(%esp)
			negative = ' ';
		else
			negative = 0;
		if (numeric && precision > len)
			zeros = precision - len;
		else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
  100b35:	eb 08                	jmp    100b3f <console_vprintf+0x2cc>
  100b37:	c7 44 24 10 00 00 00 	movl   $0x0,0x10(%esp)
  100b3e:	00 
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
  100b3f:	8b 6c 24 0c          	mov    0xc(%esp),%ebp
  100b43:	31 c0                	xor    %eax,%eax
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  100b45:	8b 4c 24 14          	mov    0x14(%esp),%ecx
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
  100b49:	2b 2c 24             	sub    (%esp),%ebp
  100b4c:	83 7c 24 08 00       	cmpl   $0x0,0x8(%esp)
  100b51:	0f 95 c0             	setne  %al
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  100b54:	83 e1 04             	and    $0x4,%ecx
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
  100b57:	29 c5                	sub    %eax,%ebp
  100b59:	89 f0                	mov    %esi,%eax
  100b5b:	2b 6c 24 10          	sub    0x10(%esp),%ebp
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  100b5f:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  100b63:	eb 0f                	jmp    100b74 <console_vprintf+0x301>
			cursor = console_putc(cursor, ' ', color);
  100b65:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  100b69:	ba 20 00 00 00       	mov    $0x20,%edx
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  100b6e:	4d                   	dec    %ebp
			cursor = console_putc(cursor, ' ', color);
  100b6f:	e8 83 fc ff ff       	call   1007f7 <console_putc>
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  100b74:	85 ed                	test   %ebp,%ebp
  100b76:	7e 07                	jle    100b7f <console_vprintf+0x30c>
  100b78:	83 7c 24 0c 00       	cmpl   $0x0,0xc(%esp)
  100b7d:	74 e6                	je     100b65 <console_vprintf+0x2f2>
			cursor = console_putc(cursor, ' ', color);
		if (negative)
  100b7f:	83 7c 24 08 00       	cmpl   $0x0,0x8(%esp)
  100b84:	89 c6                	mov    %eax,%esi
  100b86:	74 23                	je     100bab <console_vprintf+0x338>
			cursor = console_putc(cursor, negative, color);
  100b88:	0f b6 54 24 08       	movzbl 0x8(%esp),%edx
  100b8d:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  100b91:	e8 61 fc ff ff       	call   1007f7 <console_putc>
  100b96:	89 c6                	mov    %eax,%esi
  100b98:	eb 11                	jmp    100bab <console_vprintf+0x338>
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
  100b9a:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  100b9e:	ba 30 00 00 00       	mov    $0x30,%edx
		width -= len + zeros + !!negative;
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
			cursor = console_putc(cursor, ' ', color);
		if (negative)
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
  100ba3:	4e                   	dec    %esi
			cursor = console_putc(cursor, '0', color);
  100ba4:	e8 4e fc ff ff       	call   1007f7 <console_putc>
  100ba9:	eb 06                	jmp    100bb1 <console_vprintf+0x33e>
  100bab:	89 f0                	mov    %esi,%eax
  100bad:	8b 74 24 10          	mov    0x10(%esp),%esi
		width -= len + zeros + !!negative;
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
			cursor = console_putc(cursor, ' ', color);
		if (negative)
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
  100bb1:	85 f6                	test   %esi,%esi
  100bb3:	7f e5                	jg     100b9a <console_vprintf+0x327>
  100bb5:	8b 34 24             	mov    (%esp),%esi
  100bb8:	eb 15                	jmp    100bcf <console_vprintf+0x35c>
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
			cursor = console_putc(cursor, *data, color);
  100bba:	8b 4c 24 04          	mov    0x4(%esp),%ecx
			cursor = console_putc(cursor, ' ', color);
		if (negative)
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
  100bbe:	4e                   	dec    %esi
			cursor = console_putc(cursor, *data, color);
  100bbf:	0f b6 11             	movzbl (%ecx),%edx
  100bc2:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  100bc6:	e8 2c fc ff ff       	call   1007f7 <console_putc>
			cursor = console_putc(cursor, ' ', color);
		if (negative)
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
  100bcb:	ff 44 24 04          	incl   0x4(%esp)
  100bcf:	85 f6                	test   %esi,%esi
  100bd1:	7f e7                	jg     100bba <console_vprintf+0x347>
  100bd3:	eb 0f                	jmp    100be4 <console_vprintf+0x371>
			cursor = console_putc(cursor, *data, color);
		for (; width > 0; --width)
			cursor = console_putc(cursor, ' ', color);
  100bd5:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  100bd9:	ba 20 00 00 00       	mov    $0x20,%edx
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
			cursor = console_putc(cursor, *data, color);
		for (; width > 0; --width)
  100bde:	4d                   	dec    %ebp
			cursor = console_putc(cursor, ' ', color);
  100bdf:	e8 13 fc ff ff       	call   1007f7 <console_putc>
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
			cursor = console_putc(cursor, *data, color);
		for (; width > 0; --width)
  100be4:	85 ed                	test   %ebp,%ebp
  100be6:	7f ed                	jg     100bd5 <console_vprintf+0x362>
  100be8:	89 c6                	mov    %eax,%esi
	int flags, width, zeros, precision, negative, numeric, len;
#define NUMBUFSIZ 20
	char numbuf[NUMBUFSIZ];
	char *data;

	for (; *format; ++format) {
  100bea:	47                   	inc    %edi
  100beb:	8a 17                	mov    (%edi),%dl
  100bed:	84 d2                	test   %dl,%dl
  100bef:	0f 85 96 fc ff ff    	jne    10088b <console_vprintf+0x18>
			cursor = console_putc(cursor, ' ', color);
	done: ;
	}

	return cursor;
}
  100bf5:	83 c4 38             	add    $0x38,%esp
  100bf8:	89 f0                	mov    %esi,%eax
  100bfa:	5b                   	pop    %ebx
  100bfb:	5e                   	pop    %esi
  100bfc:	5f                   	pop    %edi
  100bfd:	5d                   	pop    %ebp
  100bfe:	c3                   	ret    
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
				++flagc;
			if (*flagc == '\0')
				break;
			flags |= (1 << (flagc - flag_chars));
  100bff:	81 e9 c0 0c 10 00    	sub    $0x100cc0,%ecx
  100c05:	b8 01 00 00 00       	mov    $0x1,%eax
  100c0a:	d3 e0                	shl    %cl,%eax
			continue;
		}

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
  100c0c:	47                   	inc    %edi
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
				++flagc;
			if (*flagc == '\0')
				break;
			flags |= (1 << (flagc - flag_chars));
  100c0d:	09 44 24 14          	or     %eax,0x14(%esp)
  100c11:	e9 aa fc ff ff       	jmp    1008c0 <console_vprintf+0x4d>

00100c16 <console_printf>:
uint16_t *
console_printf(uint16_t *cursor, int color, const char *format, ...)
{
	va_list val;
	va_start(val, format);
	cursor = console_vprintf(cursor, color, format, val);
  100c16:	8d 44 24 10          	lea    0x10(%esp),%eax
  100c1a:	50                   	push   %eax
  100c1b:	ff 74 24 10          	pushl  0x10(%esp)
  100c1f:	ff 74 24 10          	pushl  0x10(%esp)
  100c23:	ff 74 24 10          	pushl  0x10(%esp)
  100c27:	e8 47 fc ff ff       	call   100873 <console_vprintf>
  100c2c:	83 c4 10             	add    $0x10,%esp
	va_end(val);
	return cursor;
}
  100c2f:	c3                   	ret    

00100c30 <lock_init>:
#include "lock.h"

void
lock_init(lock_t *l) 
{
	l->lock = 0;
  100c30:	8b 44 24 04          	mov    0x4(%esp),%eax
  100c34:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
}
  100c3a:	c3                   	ret    

00100c3b <lock_acquire>:

void
lock_acquire(lock_t *l) 
{
  100c3b:	53                   	push   %ebx
  100c3c:	8b 54 24 08          	mov    0x8(%esp),%edx
static inline uint32_t compare_and_swap(uint32_t *addr, uint32_t expected, uint32_t desired) __attribute__((always_inline));

static inline uint32_t
compare_and_swap(uint32_t *addr, uint32_t expected, uint32_t desired)
{
	asm volatile("lock cmpxchg %2,%1"
  100c40:	b9 01 00 00 00       	mov    $0x1,%ecx
  100c45:	31 db                	xor    %ebx,%ebx
  100c47:	89 d8                	mov    %ebx,%eax
  100c49:	f0 0f b1 0a          	lock cmpxchg %ecx,(%edx)
	while(compare_and_swap(&l->lock, UNLOCKED, LOCKED))
  100c4d:	85 c0                	test   %eax,%eax
  100c4f:	75 f6                	jne    100c47 <lock_acquire+0xc>
		;
}
  100c51:	5b                   	pop    %ebx
  100c52:	c3                   	ret    

00100c53 <lock_release>:

void
lock_release(lock_t *l)
{
	l->lock = 0;
  100c53:	8b 44 24 04          	mov    0x4(%esp),%eax
  100c57:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
}
  100c5d:	c3                   	ret    
  100c5e:	90                   	nop
  100c5f:	90                   	nop

00100c60 <get_random>:
static uint32_t m_z = 0x9876fedc;

uint32_t
get_random()
{
	m_z = 36969 * (m_z & 65535) + (m_z >> 16);
  100c60:	8b 15 64 10 10 00    	mov    0x101064,%edx
  100c66:	0f b7 c2             	movzwl %dx,%eax
  100c69:	69 c0 69 90 00 00    	imul   $0x9069,%eax,%eax
  100c6f:	c1 ea 10             	shr    $0x10,%edx
  100c72:	8d 14 10             	lea    (%eax,%edx,1),%edx
	m_w = 18000 * (m_w & 65535) + (m_w >> 16);
  100c75:	a1 68 10 10 00       	mov    0x101068,%eax
static uint32_t m_z = 0x9876fedc;

uint32_t
get_random()
{
	m_z = 36969 * (m_z & 65535) + (m_z >> 16);
  100c7a:	89 15 64 10 10 00    	mov    %edx,0x101064
	m_w = 18000 * (m_w & 65535) + (m_w >> 16);
  100c80:	c1 e2 10             	shl    $0x10,%edx
  100c83:	0f b7 c8             	movzwl %ax,%ecx
  100c86:	69 c9 50 46 00 00    	imul   $0x4650,%ecx,%ecx
  100c8c:	c1 e8 10             	shr    $0x10,%eax
  100c8f:	8d 04 01             	lea    (%ecx,%eax,1),%eax
  100c92:	a3 68 10 10 00       	mov    %eax,0x101068
  100c97:	8d 04 02             	lea    (%edx,%eax,1),%eax
	return (m_z << 16) + m_w;
}
  100c9a:	c3                   	ret    
