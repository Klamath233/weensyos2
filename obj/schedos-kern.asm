
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
  100014:	e8 bf 03 00 00       	call   1003d8 <start>
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
  10006d:	e8 b6 02 00 00       	call   100328 <interrupt>

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

	if (scheduling_algorithm == 0) { // Round Robin.
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
  1000ca:	e9 2a 02 00 00       	jmp    1002f9 <schedule+0x25d>
				run(&proc_array[pid]);
		}
	}

	if (scheduling_algorithm == 1) { // Strict Priority.
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
  100139:	e8 cf 05 00 00       	call   10070d <run>
		}
	}
		
	if (scheduling_algorithm == 2) { // Priority
  10013e:	83 f8 02             	cmp    $0x2,%eax
  100141:	75 69                	jne    1001ac <schedule+0x110>
  100143:	8b 1d 00 10 10 00    	mov    0x101000,%ebx
  100149:	b0 01                	mov    $0x1,%al
  10014b:	ba ec ff ff ff       	mov    $0xffffffec,%edx
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
		
	if (scheduling_algorithm == 2) { // Priority
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
		            && pid > last_proc_id) // Clock algorithm.
		        {
		            last_proc_id = pid;
  100188:	a3 00 10 10 00       	mov    %eax,0x101000
		            run(&proc_array[pid]);
  10018d:	83 ec 0c             	sub    $0xc,%esp
  100190:	6b c0 5c             	imul   $0x5c,%eax,%eax
  100193:	e9 64 01 00 00       	jmp    1002fc <schedule+0x260>
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
  1001a3:	b0 01                	mov    $0x1,%al
  1001a5:	ba ec ff ff ff       	mov    $0xffffffec,%edx
  1001aa:	eb a6                	jmp    100152 <schedule+0xb6>
		    
		    last_proc_id = 0;
		}
	}
	
	if (scheduling_algorithm == 3) { // Propotional Share.
  1001ac:	83 f8 03             	cmp    $0x3,%eax
  1001af:	0f 85 95 00 00 00    	jne    10024a <schedule+0x1ae>
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
  100245:	e9 94 00 00 00       	jmp    1002de <schedule+0x242>
	}
	
		if (scheduling_algorithm == 4) { // Lottery.
  10024a:	83 f8 04             	cmp    $0x4,%eax
  10024d:	0f 85 b4 00 00 00    	jne    100307 <schedule+0x26b>
	        // If no candidate, randomize maximum share.
	        // Then, reset shares and restart loop.
	        if (candidate_array[0] == 0) {
	            for (pid = 1; pid < NPROCS; pid++) {
	                // `+1' to avoid starvation.
	                proc_array[pid].p_share_max = get_random() % MAX_LOTTERY_TICKET + 1;
  100253:	be 0a 00 00 00       	mov    $0xa,%esi
	        int i;
	        
	        // Initialize candidate array every loop.
	        candidate_number = 0;
	        for (i = 0; i < NPROCS - 1; i++) {
                candidate_array[i] = 0;
  100258:	c7 05 c8 76 10 00 00 	movl   $0x0,0x1076c8
  10025f:	00 00 00 
  100262:	b9 a0 75 10 00       	mov    $0x1075a0,%ecx
  100267:	31 c0                	xor    %eax,%eax
  100269:	c7 05 cc 76 10 00 00 	movl   $0x0,0x1076cc
  100270:	00 00 00 
  100273:	ba 01 00 00 00       	mov    $0x1,%edx
  100278:	c7 05 d0 76 10 00 00 	movl   $0x0,0x1076d0
  10027f:	00 00 00 
  100282:	c7 05 d4 76 10 00 00 	movl   $0x0,0x1076d4
  100289:	00 00 00 
            }
            
            // Add candidates to array.
	        for (pid = 1; pid < NPROCS; pid++) {
	            if (proc_array[pid].p_state == P_RUNNABLE
  10028c:	83 39 01             	cmpl   $0x1,(%ecx)
  10028f:	75 0e                	jne    10029f <schedule+0x203>
  100291:	83 79 0c 00          	cmpl   $0x0,0xc(%ecx)
  100295:	7e 08                	jle    10029f <schedule+0x203>
	                && proc_array[pid].p_share > 0) 
	            {
	                candidate_array[candidate_number++] = pid;
  100297:	89 14 85 c8 76 10 00 	mov    %edx,0x1076c8(,%eax,4)
  10029e:	40                   	inc    %eax
	        for (i = 0; i < NPROCS - 1; i++) {
                candidate_array[i] = 0;
            }
            
            // Add candidates to array.
	        for (pid = 1; pid < NPROCS; pid++) {
  10029f:	42                   	inc    %edx
  1002a0:	83 c1 5c             	add    $0x5c,%ecx
  1002a3:	83 fa 05             	cmp    $0x5,%edx
  1002a6:	75 e4                	jne    10028c <schedule+0x1f0>
	            }
	        }
	        
	        // If no candidate, randomize maximum share.
	        // Then, reset shares and restart loop.
	        if (candidate_array[0] == 0) {
  1002a8:	83 3d c8 76 10 00 00 	cmpl   $0x0,0x1076c8
	        for (i = 0; i < NPROCS - 1; i++) {
                candidate_array[i] = 0;
            }
            
            // Add candidates to array.
	        for (pid = 1; pid < NPROCS; pid++) {
  1002af:	a3 f8 74 10 00       	mov    %eax,0x1074f8
	            }
	        }
	        
	        // If no candidate, randomize maximum share.
	        // Then, reset shares and restart loop.
	        if (candidate_array[0] == 0) {
  1002b4:	75 28                	jne    1002de <schedule+0x242>
  1002b6:	31 db                	xor    %ebx,%ebx
	            for (pid = 1; pid < NPROCS; pid++) {
	                // `+1' to avoid starvation.
	                proc_array[pid].p_share_max = get_random() % MAX_LOTTERY_TICKET + 1;
  1002b8:	e8 37 0a 00 00       	call   100cf4 <get_random>
  1002bd:	31 d2                	xor    %edx,%edx
  1002bf:	f7 f6                	div    %esi
  1002c1:	42                   	inc    %edx
  1002c2:	89 93 b0 75 10 00    	mov    %edx,0x1075b0(%ebx)
	                proc_array[pid].p_share = proc_array[pid].p_share_max;
  1002c8:	89 93 ac 75 10 00    	mov    %edx,0x1075ac(%ebx)
  1002ce:	83 c3 5c             	add    $0x5c,%ebx
	        }
	        
	        // If no candidate, randomize maximum share.
	        // Then, reset shares and restart loop.
	        if (candidate_array[0] == 0) {
	            for (pid = 1; pid < NPROCS; pid++) {
  1002d1:	81 fb 70 01 00 00    	cmp    $0x170,%ebx
  1002d7:	75 df                	jne    1002b8 <schedule+0x21c>
  1002d9:	e9 7a ff ff ff       	jmp    100258 <schedule+0x1bc>
	            }
	            continue;
	        }
	        
	        // Pick a random candidate and consume its share.
	        pid_t chosen = candidate_array[get_random() % candidate_number];
  1002de:	e8 11 0a 00 00       	call   100cf4 <get_random>
  1002e3:	31 d2                	xor    %edx,%edx
  1002e5:	f7 35 f8 74 10 00    	divl   0x1074f8
	        proc_array[chosen].p_share--;
  1002eb:	6b 04 95 c8 76 10 00 	imul   $0x5c,0x1076c8(,%edx,4),%eax
  1002f2:	5c 
  1002f3:	ff 88 50 75 10 00    	decl   0x107550(%eax)
	        run(&proc_array[chosen]);
  1002f9:	83 ec 0c             	sub    $0xc,%esp
  1002fc:	05 fc 74 10 00       	add    $0x1074fc,%eax
  100301:	50                   	push   %eax
  100302:	e9 32 fe ff ff       	jmp    100139 <schedule+0x9d>
	    }
	}
	// If we get here, we are running an unknown scheduling algorithm.
	cursorpos = console_printf(cursorpos, 0x100, "\nUnknown scheduling algorithm %d\n", scheduling_algorithm);
  100307:	8b 15 00 80 19 00    	mov    0x198000,%edx
  10030d:	50                   	push   %eax
  10030e:	68 30 0d 10 00       	push   $0x100d30
  100313:	68 00 01 00 00       	push   $0x100
  100318:	52                   	push   %edx
  100319:	e8 94 09 00 00       	call   100cb2 <console_printf>
  10031e:	83 c4 10             	add    $0x10,%esp
  100321:	a3 00 80 19 00       	mov    %eax,0x198000
  100326:	eb fe                	jmp    100326 <schedule+0x28a>

00100328 <interrupt>:
 *
 *****************************************************************************/

void
interrupt(registers_t *reg)
{
  100328:	57                   	push   %edi
	// Save the current process's register state
	// into its process descriptor
	current->p_registers = *reg;
  100329:	a1 44 7f 10 00       	mov    0x107f44,%eax
  10032e:	b9 11 00 00 00       	mov    $0x11,%ecx
 *
 *****************************************************************************/

void
interrupt(registers_t *reg)
{
  100333:	56                   	push   %esi
  100334:	53                   	push   %ebx
  100335:	8b 5c 24 10          	mov    0x10(%esp),%ebx
	// Save the current process's register state
	// into its process descriptor
	current->p_registers = *reg;
  100339:	8d 78 04             	lea    0x4(%eax),%edi
  10033c:	89 de                	mov    %ebx,%esi
  10033e:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)

	switch (reg->reg_intno) {
  100340:	8b 53 28             	mov    0x28(%ebx),%edx
  100343:	83 fa 32             	cmp    $0x32,%edx
  100346:	74 38                	je     100380 <interrupt+0x58>
  100348:	77 0e                	ja     100358 <interrupt+0x30>
  10034a:	83 fa 30             	cmp    $0x30,%edx
  10034d:	74 15                	je     100364 <interrupt+0x3c>
  10034f:	77 18                	ja     100369 <interrupt+0x41>
  100351:	83 fa 20             	cmp    $0x20,%edx
  100354:	74 7b                	je     1003d1 <interrupt+0xa9>
  100356:	eb 7e                	jmp    1003d6 <interrupt+0xae>
  100358:	83 fa 33             	cmp    $0x33,%edx
  10035b:	74 30                	je     10038d <interrupt+0x65>
  10035d:	83 fa 34             	cmp    $0x34,%edx
  100360:	74 63                	je     1003c5 <interrupt+0x9d>
  100362:	eb 72                	jmp    1003d6 <interrupt+0xae>

	case INT_SYS_YIELD:
		// The 'sys_yield' system call asks the kernel to schedule
		// the next process.
		schedule();
  100364:	e8 33 fd ff ff       	call   10009c <schedule>
		// The application stored its exit status in the %eax register
		// before calling the system call.  The %eax register has
		// changed by now, but we can read the application's value
		// out of the 'reg' argument.
		// (This shows you how to transfer arguments to system calls!)
		current->p_state = P_ZOMBIE;
  100369:	a1 44 7f 10 00       	mov    0x107f44,%eax
		current->p_exit_status = reg->reg_eax;
  10036e:	8b 53 1c             	mov    0x1c(%ebx),%edx
		// The application stored its exit status in the %eax register
		// before calling the system call.  The %eax register has
		// changed by now, but we can read the application's value
		// out of the 'reg' argument.
		// (This shows you how to transfer arguments to system calls!)
		current->p_state = P_ZOMBIE;
  100371:	c7 40 48 03 00 00 00 	movl   $0x3,0x48(%eax)
		current->p_exit_status = reg->reg_eax;
  100378:	89 50 4c             	mov    %edx,0x4c(%eax)
		schedule();
  10037b:	e8 1c fd ff ff       	call   10009c <schedule>

	case INT_SYS_RENICE:
		// `sys_renice' system call sets the priority of the current process.
		current->p_priority = reg->reg_eax;
  100380:	a1 44 7f 10 00       	mov    0x107f44,%eax
  100385:	8b 53 1c             	mov    0x1c(%ebx),%edx
  100388:	89 50 50             	mov    %edx,0x50(%eax)
  10038b:	eb 3e                	jmp    1003cb <interrupt+0xa3>
		run(current);

	case INT_SYS_ATOMIC_PRINTC:
		// `sys_atomic_printc' prints a character to screen atomically.
		lock_acquire(&cursor_lock);
  10038d:	83 ec 0c             	sub    $0xc,%esp
  100390:	68 40 7f 10 00       	push   $0x107f40
  100395:	e8 3d 09 00 00       	call   100cd7 <lock_acquire>
		*cursorpos++ = (uint16_t) reg->reg_eax;
  10039a:	a1 00 80 19 00       	mov    0x198000,%eax
  10039f:	8b 53 1c             	mov    0x1c(%ebx),%edx
  1003a2:	66 89 10             	mov    %dx,(%eax)
  1003a5:	83 c0 02             	add    $0x2,%eax
  1003a8:	a3 00 80 19 00       	mov    %eax,0x198000
		lock_release(&cursor_lock);
  1003ad:	c7 04 24 40 7f 10 00 	movl   $0x107f40,(%esp)
  1003b4:	e8 2e 09 00 00       	call   100ce7 <lock_release>
		run(current);
  1003b9:	58                   	pop    %eax
  1003ba:	ff 35 44 7f 10 00    	pushl  0x107f44
  1003c0:	e8 48 03 00 00       	call   10070d <run>
	
	case INT_SYS_SET_SHARE:
		// `sys_set_share' sets the maximum share of the current process
		current->p_share_max = reg->reg_eax;
  1003c5:	8b 53 1c             	mov    0x1c(%ebx),%edx
  1003c8:	89 50 58             	mov    %edx,0x58(%eax)
		run(current);
  1003cb:	83 ec 0c             	sub    $0xc,%esp
  1003ce:	50                   	push   %eax
  1003cf:	eb ef                	jmp    1003c0 <interrupt+0x98>

	case INT_CLOCK:
		// A clock interrupt occurred (so an application exhausted its
		// time quantum).
		// Switch to the next runnable process.
		schedule();
  1003d1:	e8 c6 fc ff ff       	call   10009c <schedule>
  1003d6:	eb fe                	jmp    1003d6 <interrupt+0xae>

001003d8 <start>:
 *
 *****************************************************************************/

void
start(void)
{
  1003d8:	57                   	push   %edi

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
  1003d9:	bf 00 00 30 00       	mov    $0x300000,%edi
 *
 *****************************************************************************/

void
start(void)
{
  1003de:	56                   	push   %esi

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
  1003df:	31 f6                	xor    %esi,%esi
 *
 *****************************************************************************/

void
start(void)
{
  1003e1:	53                   	push   %ebx

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
  1003e2:	bb 58 75 10 00       	mov    $0x107558,%ebx
start(void)
{
	int i;

	// Set up hardware (schedos-x86.c)
	segments_init();
  1003e7:	e8 00 01 00 00       	call   1004ec <segments_init>
	interrupt_controller_init(0);
  1003ec:	83 ec 0c             	sub    $0xc,%esp
  1003ef:	6a 00                	push   $0x0
  1003f1:	e8 f1 01 00 00       	call   1005e7 <interrupt_controller_init>
	console_clear();
  1003f6:	e8 75 02 00 00       	call   100670 <console_clear>

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
  1003fb:	83 c4 0c             	add    $0xc,%esp
  1003fe:	68 cc 01 00 00       	push   $0x1cc
  100403:	6a 00                	push   $0x0
  100405:	68 fc 74 10 00       	push   $0x1074fc
  10040a:	e8 41 04 00 00       	call   100850 <memset>
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
  10040f:	83 c4 10             	add    $0x10,%esp
	console_clear();

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
  100412:	c7 05 fc 74 10 00 00 	movl   $0x0,0x1074fc
  100419:	00 00 00 
		proc_array[i].p_state = P_EMPTY;
  10041c:	c7 05 44 75 10 00 00 	movl   $0x0,0x107544
  100423:	00 00 00 
	console_clear();

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
  100426:	c7 05 58 75 10 00 01 	movl   $0x1,0x107558
  10042d:	00 00 00 
		proc_array[i].p_state = P_EMPTY;
  100430:	c7 05 a0 75 10 00 00 	movl   $0x0,0x1075a0
  100437:	00 00 00 
	console_clear();

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
  10043a:	c7 05 b4 75 10 00 02 	movl   $0x2,0x1075b4
  100441:	00 00 00 
		proc_array[i].p_state = P_EMPTY;
  100444:	c7 05 fc 75 10 00 00 	movl   $0x0,0x1075fc
  10044b:	00 00 00 
	console_clear();

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
  10044e:	c7 05 10 76 10 00 03 	movl   $0x3,0x107610
  100455:	00 00 00 
		proc_array[i].p_state = P_EMPTY;
  100458:	c7 05 58 76 10 00 00 	movl   $0x0,0x107658
  10045f:	00 00 00 
	console_clear();

	// Initialize process descriptors as empty
	memset(proc_array, 0, sizeof(proc_array));
	for (i = 0; i < NPROCS; i++) {
		proc_array[i].p_pid = i;
  100462:	c7 05 6c 76 10 00 04 	movl   $0x4,0x10766c
  100469:	00 00 00 
		proc_array[i].p_state = P_EMPTY;
  10046c:	c7 05 b4 76 10 00 00 	movl   $0x0,0x1076b4
  100473:	00 00 00 
	for (i = 1; i < NPROCS; i++) {
		process_t *proc = &proc_array[i];
		uint32_t stack_ptr = PROC1_START + i * PROC_SIZE;

		// Initialize the process descriptor
		special_registers_init(proc);
  100476:	83 ec 0c             	sub    $0xc,%esp
  100479:	53                   	push   %ebx
  10047a:	e8 a5 02 00 00       	call   100724 <special_registers_init>

		// Set ESP
		proc->p_registers.reg_esp = stack_ptr;

		// Load process and set EIP, based on ELF image
		program_loader(i - 1, &proc->p_registers.reg_eip);
  10047f:	8d 43 34             	lea    0x34(%ebx),%eax
  100482:	5a                   	pop    %edx
  100483:	59                   	pop    %ecx

		// Initialize the process descriptor
		special_registers_init(proc);

		// Set ESP
		proc->p_registers.reg_esp = stack_ptr;
  100484:	89 7b 40             	mov    %edi,0x40(%ebx)
        // Initialize priority. (for algorithm 1 and 2)
        proc->p_priority = 0;
        
        // Initialize share. (for algorithm 3 and 4)
        proc->p_share_max = 1;
        proc->p_share = proc->p_share_max;
  100487:	81 c7 00 00 10 00    	add    $0x100000,%edi

		// Set ESP
		proc->p_registers.reg_esp = stack_ptr;

		// Load process and set EIP, based on ELF image
		program_loader(i - 1, &proc->p_registers.reg_eip);
  10048d:	50                   	push   %eax
  10048e:	56                   	push   %esi
        // Initialize priority. (for algorithm 1 and 2)
        proc->p_priority = 0;
        
        // Initialize share. (for algorithm 3 and 4)
        proc->p_share_max = 1;
        proc->p_share = proc->p_share_max;
  10048f:	46                   	inc    %esi

		// Set ESP
		proc->p_registers.reg_esp = stack_ptr;

		// Load process and set EIP, based on ELF image
		program_loader(i - 1, &proc->p_registers.reg_eip);
  100490:	e8 cb 02 00 00       	call   100760 <program_loader>
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
	}

	// Set up process descriptors (the proc_array[])
	for (i = 1; i < NPROCS; i++) {
  100495:	83 c4 10             	add    $0x10,%esp

		// Load process and set EIP, based on ELF image
		program_loader(i - 1, &proc->p_registers.reg_eip);

		// Mark the process as runnable!
		proc->p_state = P_RUNNABLE;
  100498:	c7 43 48 01 00 00 00 	movl   $0x1,0x48(%ebx)

        // Initialize priority. (for algorithm 1 and 2)
        proc->p_priority = 0;
  10049f:	c7 43 50 00 00 00 00 	movl   $0x0,0x50(%ebx)
        
        // Initialize share. (for algorithm 3 and 4)
        proc->p_share_max = 1;
  1004a6:	c7 43 58 01 00 00 00 	movl   $0x1,0x58(%ebx)
        proc->p_share = proc->p_share_max;
  1004ad:	c7 43 54 01 00 00 00 	movl   $0x1,0x54(%ebx)
  1004b4:	83 c3 5c             	add    $0x5c,%ebx
		proc_array[i].p_pid = i;
		proc_array[i].p_state = P_EMPTY;
	}

	// Set up process descriptors (the proc_array[])
	for (i = 1; i < NPROCS; i++) {
  1004b7:	83 fe 04             	cmp    $0x4,%esi
  1004ba:	75 ba                	jne    100476 <start+0x9e>
	}

	// Initialize the cursor-position shared variable to point to the
	// console's first character (the upper left).
	cursorpos = (uint16_t *) 0xB8000;
	lock_init(&cursor_lock);
  1004bc:	83 ec 0c             	sub    $0xc,%esp
  1004bf:	68 40 7f 10 00       	push   $0x107f40
        proc->p_share = proc->p_share_max;
	}

	// Initialize the cursor-position shared variable to point to the
	// console's first character (the upper left).
	cursorpos = (uint16_t *) 0xB8000;
  1004c4:	c7 05 00 80 19 00 00 	movl   $0xb8000,0x198000
  1004cb:	80 0b 00 
	lock_init(&cursor_lock);
  1004ce:	e8 f9 07 00 00       	call   100ccc <lock_init>
	// Initialize the scheduling algorithm.
	scheduling_algorithm = 3;
  1004d3:	c7 05 48 7f 10 00 03 	movl   $0x3,0x107f48
  1004da:	00 00 00 
	// Switch to the first process.
	run(&proc_array[1]);
  1004dd:	c7 04 24 58 75 10 00 	movl   $0x107558,(%esp)
  1004e4:	e8 24 02 00 00       	call   10070d <run>
  1004e9:	90                   	nop
  1004ea:	90                   	nop
  1004eb:	90                   	nop

001004ec <segments_init>:
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  1004ec:	b8 d8 76 10 00       	mov    $0x1076d8,%eax
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  1004f1:	b9 5c 00 10 00       	mov    $0x10005c,%ecx
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  1004f6:	89 c2                	mov    %eax,%edx
  1004f8:	c1 ea 10             	shr    $0x10,%edx
extern void default_int_handler(void);


void
segments_init(void)
{
  1004fb:	53                   	push   %ebx
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  1004fc:	bb 5c 00 10 00       	mov    $0x10005c,%ebx
  100501:	c1 eb 10             	shr    $0x10,%ebx
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  100504:	66 a3 3e 10 10 00    	mov    %ax,0x10103e
  10050a:	c1 e8 18             	shr    $0x18,%eax
  10050d:	88 15 40 10 10 00    	mov    %dl,0x101040
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  100513:	ba 40 77 10 00       	mov    $0x107740,%edx
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  100518:	a2 43 10 10 00       	mov    %al,0x101043
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  10051d:	31 c0                	xor    %eax,%eax
segments_init(void)
{
	int i;

	// Set task state segment
	segments[SEGSEL_TASKSTATE >> 3]
  10051f:	66 c7 05 3c 10 10 00 	movw   $0x68,0x10103c
  100526:	68 00 
  100528:	c6 05 42 10 10 00 40 	movb   $0x40,0x101042
		= SEG16(STS_T32A, (uint32_t) &kernel_task_descriptor,
			sizeof(taskstate_t), 0);
	segments[SEGSEL_TASKSTATE >> 3].sd_s = 0;
  10052f:	c6 05 41 10 10 00 89 	movb   $0x89,0x101041

	// Set up kernel task descriptor, so we can receive interrupts
	kernel_task_descriptor.ts_esp0 = KERNEL_STACK_TOP;
  100536:	c7 05 dc 76 10 00 00 	movl   $0x180000,0x1076dc
  10053d:	00 18 00 
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;
  100540:	66 c7 05 e0 76 10 00 	movw   $0x10,0x1076e0
  100547:	10 00 

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
  100549:	66 89 0c c5 40 77 10 	mov    %cx,0x107740(,%eax,8)
  100550:	00 
  100551:	66 c7 44 c2 02 08 00 	movw   $0x8,0x2(%edx,%eax,8)
  100558:	c6 44 c2 04 00       	movb   $0x0,0x4(%edx,%eax,8)
  10055d:	c6 44 c2 05 8e       	movb   $0x8e,0x5(%edx,%eax,8)
  100562:	66 89 5c c2 06       	mov    %bx,0x6(%edx,%eax,8)
	kernel_task_descriptor.ts_esp0 = KERNEL_STACK_TOP;
	kernel_task_descriptor.ts_ss0 = SEGSEL_KERN_DATA;

	// Set up interrupt descriptor table.
	// Most interrupts are effectively ignored
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
  100567:	40                   	inc    %eax
  100568:	3d 00 01 00 00       	cmp    $0x100,%eax
  10056d:	75 da                	jne    100549 <segments_init+0x5d>
		SETGATE(interrupt_descriptors[i], 0,
			SEGSEL_KERN_CODE, default_int_handler, 0);

	// The clock interrupt gets special handling
	SETGATE(interrupt_descriptors[INT_CLOCK], 0,
  10056f:	b8 1a 00 10 00       	mov    $0x10001a,%eax

	// System calls get special handling.
	// Note that the last argument is '3'.  This means that unprivileged
	// (level-3) applications may generate these interrupts.
	for (i = INT_SYS_YIELD; i < INT_SYS_YIELD + 10; i++)
		SETGATE(interrupt_descriptors[i], 0,
  100574:	ba 40 77 10 00       	mov    $0x107740,%edx
	for (i = 0; i < sizeof(interrupt_descriptors) / sizeof(gatedescriptor_t); i++)
		SETGATE(interrupt_descriptors[i], 0,
			SEGSEL_KERN_CODE, default_int_handler, 0);

	// The clock interrupt gets special handling
	SETGATE(interrupt_descriptors[INT_CLOCK], 0,
  100579:	66 a3 40 78 10 00    	mov    %ax,0x107840
  10057f:	c1 e8 10             	shr    $0x10,%eax
  100582:	66 a3 46 78 10 00    	mov    %ax,0x107846
  100588:	b8 30 00 00 00       	mov    $0x30,%eax
  10058d:	66 c7 05 42 78 10 00 	movw   $0x8,0x107842
  100594:	08 00 
  100596:	c6 05 44 78 10 00 00 	movb   $0x0,0x107844
  10059d:	c6 05 45 78 10 00 8e 	movb   $0x8e,0x107845

	// System calls get special handling.
	// Note that the last argument is '3'.  This means that unprivileged
	// (level-3) applications may generate these interrupts.
	for (i = INT_SYS_YIELD; i < INT_SYS_YIELD + 10; i++)
		SETGATE(interrupt_descriptors[i], 0,
  1005a4:	8b 0c 85 b2 ff 0f 00 	mov    0xfffb2(,%eax,4),%ecx
  1005ab:	66 c7 44 c2 02 08 00 	movw   $0x8,0x2(%edx,%eax,8)
  1005b2:	66 89 0c c5 40 77 10 	mov    %cx,0x107740(,%eax,8)
  1005b9:	00 
  1005ba:	c1 e9 10             	shr    $0x10,%ecx
  1005bd:	c6 44 c2 04 00       	movb   $0x0,0x4(%edx,%eax,8)
  1005c2:	c6 44 c2 05 ee       	movb   $0xee,0x5(%edx,%eax,8)
  1005c7:	66 89 4c c2 06       	mov    %cx,0x6(%edx,%eax,8)
		SEGSEL_KERN_CODE, clock_int_handler, 0);

	// System calls get special handling.
	// Note that the last argument is '3'.  This means that unprivileged
	// (level-3) applications may generate these interrupts.
	for (i = INT_SYS_YIELD; i < INT_SYS_YIELD + 10; i++)
  1005cc:	40                   	inc    %eax
  1005cd:	83 f8 3a             	cmp    $0x3a,%eax
  1005d0:	75 d2                	jne    1005a4 <segments_init+0xb8>
		SETGATE(interrupt_descriptors[i], 0,
			SEGSEL_KERN_CODE, sys_int_handlers[i - INT_SYS_YIELD], 3);

	// Reload segment pointers
	asm volatile("lgdt global_descriptor_table\n\t"
  1005d2:	b0 28                	mov    $0x28,%al
  1005d4:	0f 01 15 04 10 10 00 	lgdtl  0x101004
  1005db:	0f 00 d8             	ltr    %ax
  1005de:	0f 01 1d 0c 10 10 00 	lidtl  0x10100c
		     "lidt interrupt_descriptor_table"
		     : : "r" ((uint16_t) SEGSEL_TASKSTATE));

	// Convince compiler that all symbols were used
	(void) global_descriptor_table, (void) interrupt_descriptor_table;
}
  1005e5:	5b                   	pop    %ebx
  1005e6:	c3                   	ret    

001005e7 <interrupt_controller_init>:
#define	TIMER_FREQ	1193182
#define TIMER_DIV(x)	((TIMER_FREQ+(x)/2)/(x))

void
interrupt_controller_init(bool_t allow_clock_interrupt)
{
  1005e7:	55                   	push   %ebp
}

static inline void
outb(int port, uint8_t data)
{
	asm volatile("outb %0,%w1" : : "a" (data), "d" (port));
  1005e8:	b0 ff                	mov    $0xff,%al
  1005ea:	57                   	push   %edi
  1005eb:	56                   	push   %esi
  1005ec:	53                   	push   %ebx
  1005ed:	bb 21 00 00 00       	mov    $0x21,%ebx
  1005f2:	89 da                	mov    %ebx,%edx
  1005f4:	ee                   	out    %al,(%dx)
  1005f5:	b9 a1 00 00 00       	mov    $0xa1,%ecx
  1005fa:	89 ca                	mov    %ecx,%edx
  1005fc:	ee                   	out    %al,(%dx)
  1005fd:	be 11 00 00 00       	mov    $0x11,%esi
  100602:	bf 20 00 00 00       	mov    $0x20,%edi
  100607:	89 f0                	mov    %esi,%eax
  100609:	89 fa                	mov    %edi,%edx
  10060b:	ee                   	out    %al,(%dx)
  10060c:	b0 20                	mov    $0x20,%al
  10060e:	89 da                	mov    %ebx,%edx
  100610:	ee                   	out    %al,(%dx)
  100611:	b0 04                	mov    $0x4,%al
  100613:	ee                   	out    %al,(%dx)
  100614:	b0 03                	mov    $0x3,%al
  100616:	ee                   	out    %al,(%dx)
  100617:	bd a0 00 00 00       	mov    $0xa0,%ebp
  10061c:	89 f0                	mov    %esi,%eax
  10061e:	89 ea                	mov    %ebp,%edx
  100620:	ee                   	out    %al,(%dx)
  100621:	b0 28                	mov    $0x28,%al
  100623:	89 ca                	mov    %ecx,%edx
  100625:	ee                   	out    %al,(%dx)
  100626:	b0 02                	mov    $0x2,%al
  100628:	ee                   	out    %al,(%dx)
  100629:	b0 01                	mov    $0x1,%al
  10062b:	ee                   	out    %al,(%dx)
  10062c:	b0 68                	mov    $0x68,%al
  10062e:	89 fa                	mov    %edi,%edx
  100630:	ee                   	out    %al,(%dx)
  100631:	be 0a 00 00 00       	mov    $0xa,%esi
  100636:	89 f0                	mov    %esi,%eax
  100638:	ee                   	out    %al,(%dx)
  100639:	b0 68                	mov    $0x68,%al
  10063b:	89 ea                	mov    %ebp,%edx
  10063d:	ee                   	out    %al,(%dx)
  10063e:	89 f0                	mov    %esi,%eax
  100640:	ee                   	out    %al,(%dx)

	outb(IO_PIC2, 0x68);               /* OCW3 */
	outb(IO_PIC2, 0x0a);               /* OCW3 */

	// mask all interrupts again, except possibly for clock interrupt
	outb(IO_PIC1+1, (allow_clock_interrupt ? 0xFE : 0xFF));
  100641:	83 7c 24 14 01       	cmpl   $0x1,0x14(%esp)
  100646:	89 da                	mov    %ebx,%edx
  100648:	19 c0                	sbb    %eax,%eax
  10064a:	f7 d0                	not    %eax
  10064c:	05 ff 00 00 00       	add    $0xff,%eax
  100651:	ee                   	out    %al,(%dx)
  100652:	b0 ff                	mov    $0xff,%al
  100654:	89 ca                	mov    %ecx,%edx
  100656:	ee                   	out    %al,(%dx)
	outb(IO_PIC2+1, 0xFF);

	// if the clock interrupt is allowed, initialize the clock
	if (allow_clock_interrupt) {
  100657:	83 7c 24 14 00       	cmpl   $0x0,0x14(%esp)
  10065c:	74 0d                	je     10066b <interrupt_controller_init+0x84>
  10065e:	b2 43                	mov    $0x43,%dl
  100660:	b0 34                	mov    $0x34,%al
  100662:	ee                   	out    %al,(%dx)
  100663:	b0 55                	mov    $0x55,%al
  100665:	b2 40                	mov    $0x40,%dl
  100667:	ee                   	out    %al,(%dx)
  100668:	b0 02                	mov    $0x2,%al
  10066a:	ee                   	out    %al,(%dx)
		outb(TIMER_MODE, TIMER_SEL0 | TIMER_RATEGEN | TIMER_16BIT);
		outb(IO_TIMER1, TIMER_DIV(HZ) % 256);
		outb(IO_TIMER1, TIMER_DIV(HZ) / 256);
	}
}
  10066b:	5b                   	pop    %ebx
  10066c:	5e                   	pop    %esi
  10066d:	5f                   	pop    %edi
  10066e:	5d                   	pop    %ebp
  10066f:	c3                   	ret    

00100670 <console_clear>:
 *
 *****************************************************************************/

void
console_clear(void)
{
  100670:	56                   	push   %esi
	int i;
	cursorpos = (uint16_t *) 0xB8000;
  100671:	31 c0                	xor    %eax,%eax
 *
 *****************************************************************************/

void
console_clear(void)
{
  100673:	53                   	push   %ebx
	int i;
	cursorpos = (uint16_t *) 0xB8000;
  100674:	c7 05 00 80 19 00 00 	movl   $0xb8000,0x198000
  10067b:	80 0b 00 

	for (i = 0; i < 80 * 25; i++)
		cursorpos[i] = ' ' | 0x0700;
  10067e:	8b 15 00 80 19 00    	mov    0x198000,%edx
  100684:	66 c7 04 02 20 07    	movw   $0x720,(%edx,%eax,1)
  10068a:	83 c0 02             	add    $0x2,%eax
console_clear(void)
{
	int i;
	cursorpos = (uint16_t *) 0xB8000;

	for (i = 0; i < 80 * 25; i++)
  10068d:	3d a0 0f 00 00       	cmp    $0xfa0,%eax
  100692:	75 ea                	jne    10067e <console_clear+0xe>
  100694:	be d4 03 00 00       	mov    $0x3d4,%esi
  100699:	b0 0e                	mov    $0xe,%al
  10069b:	89 f2                	mov    %esi,%edx
  10069d:	ee                   	out    %al,(%dx)
  10069e:	31 c9                	xor    %ecx,%ecx
  1006a0:	bb d5 03 00 00       	mov    $0x3d5,%ebx
  1006a5:	88 c8                	mov    %cl,%al
  1006a7:	89 da                	mov    %ebx,%edx
  1006a9:	ee                   	out    %al,(%dx)
  1006aa:	b0 0f                	mov    $0xf,%al
  1006ac:	89 f2                	mov    %esi,%edx
  1006ae:	ee                   	out    %al,(%dx)
  1006af:	88 c8                	mov    %cl,%al
  1006b1:	89 da                	mov    %ebx,%edx
  1006b3:	ee                   	out    %al,(%dx)
		cursorpos[i] = ' ' | 0x0700;
	outb(0x3D4, 14);
	outb(0x3D5, 0 / 256);
	outb(0x3D4, 15);
	outb(0x3D5, 0 % 256);
}
  1006b4:	5b                   	pop    %ebx
  1006b5:	5e                   	pop    %esi
  1006b6:	c3                   	ret    

001006b7 <console_read_digit>:

static inline uint8_t
inb(int port)
{
	uint8_t data;
	asm volatile("inb %w1,%0" : "=a" (data) : "d" (port));
  1006b7:	ba 64 00 00 00       	mov    $0x64,%edx
  1006bc:	ec                   	in     (%dx),%al
int
console_read_digit(void)
{
	uint8_t data;

	if ((inb(KBSTATP) & KBS_DIB) == 0)
  1006bd:	a8 01                	test   $0x1,%al
  1006bf:	74 45                	je     100706 <console_read_digit+0x4f>
  1006c1:	b2 60                	mov    $0x60,%dl
  1006c3:	ec                   	in     (%dx),%al
		return -1;

	data = inb(KBDATAP);
	if (data >= 0x02 && data <= 0x0A)
  1006c4:	8d 50 fe             	lea    -0x2(%eax),%edx
  1006c7:	80 fa 08             	cmp    $0x8,%dl
  1006ca:	77 05                	ja     1006d1 <console_read_digit+0x1a>
		return data - 0x02 + 1;
  1006cc:	0f b6 c0             	movzbl %al,%eax
  1006cf:	48                   	dec    %eax
  1006d0:	c3                   	ret    
	else if (data == 0x0B)
  1006d1:	3c 0b                	cmp    $0xb,%al
  1006d3:	74 35                	je     10070a <console_read_digit+0x53>
		return 0;
	else if (data >= 0x47 && data <= 0x49)
  1006d5:	8d 50 b9             	lea    -0x47(%eax),%edx
  1006d8:	80 fa 02             	cmp    $0x2,%dl
  1006db:	77 07                	ja     1006e4 <console_read_digit+0x2d>
		return data - 0x47 + 7;
  1006dd:	0f b6 c0             	movzbl %al,%eax
  1006e0:	83 e8 40             	sub    $0x40,%eax
  1006e3:	c3                   	ret    
	else if (data >= 0x4B && data <= 0x4D)
  1006e4:	8d 50 b5             	lea    -0x4b(%eax),%edx
  1006e7:	80 fa 02             	cmp    $0x2,%dl
  1006ea:	77 07                	ja     1006f3 <console_read_digit+0x3c>
		return data - 0x4B + 4;
  1006ec:	0f b6 c0             	movzbl %al,%eax
  1006ef:	83 e8 47             	sub    $0x47,%eax
  1006f2:	c3                   	ret    
	else if (data >= 0x4F && data <= 0x51)
  1006f3:	8d 50 b1             	lea    -0x4f(%eax),%edx
  1006f6:	80 fa 02             	cmp    $0x2,%dl
  1006f9:	77 07                	ja     100702 <console_read_digit+0x4b>
		return data - 0x4F + 1;
  1006fb:	0f b6 c0             	movzbl %al,%eax
  1006fe:	83 e8 4e             	sub    $0x4e,%eax
  100701:	c3                   	ret    
	else if (data == 0x53)
  100702:	3c 53                	cmp    $0x53,%al
  100704:	74 04                	je     10070a <console_read_digit+0x53>
  100706:	83 c8 ff             	or     $0xffffffff,%eax
  100709:	c3                   	ret    
  10070a:	31 c0                	xor    %eax,%eax
		return 0;
	else
		return -1;
}
  10070c:	c3                   	ret    

0010070d <run>:
 *
 *****************************************************************************/

void
run(process_t *proc)
{
  10070d:	8b 44 24 04          	mov    0x4(%esp),%eax
	current = proc;
  100711:	a3 44 7f 10 00       	mov    %eax,0x107f44

	asm volatile("movl %0,%%esp\n\t"
  100716:	83 c0 04             	add    $0x4,%eax
  100719:	89 c4                	mov    %eax,%esp
  10071b:	61                   	popa   
  10071c:	07                   	pop    %es
  10071d:	1f                   	pop    %ds
  10071e:	83 c4 08             	add    $0x8,%esp
  100721:	cf                   	iret   
  100722:	eb fe                	jmp    100722 <run+0x15>

00100724 <special_registers_init>:
 *
 *****************************************************************************/

void
special_registers_init(process_t *proc)
{
  100724:	53                   	push   %ebx
  100725:	83 ec 0c             	sub    $0xc,%esp
  100728:	8b 5c 24 14          	mov    0x14(%esp),%ebx
	memset(&proc->p_registers, 0, sizeof(registers_t));
  10072c:	6a 44                	push   $0x44
  10072e:	6a 00                	push   $0x0
  100730:	8d 43 04             	lea    0x4(%ebx),%eax
  100733:	50                   	push   %eax
  100734:	e8 17 01 00 00       	call   100850 <memset>
	proc->p_registers.reg_cs = SEGSEL_APP_CODE | 3;
  100739:	66 c7 43 38 1b 00    	movw   $0x1b,0x38(%ebx)
	proc->p_registers.reg_ds = SEGSEL_APP_DATA | 3;
  10073f:	66 c7 43 28 23 00    	movw   $0x23,0x28(%ebx)
	proc->p_registers.reg_es = SEGSEL_APP_DATA | 3;
  100745:	66 c7 43 24 23 00    	movw   $0x23,0x24(%ebx)
	proc->p_registers.reg_ss = SEGSEL_APP_DATA | 3;
  10074b:	66 c7 43 44 23 00    	movw   $0x23,0x44(%ebx)
	// Enable interrupts
	proc->p_registers.reg_eflags = EFLAGS_IF;
  100751:	c7 43 3c 00 02 00 00 	movl   $0x200,0x3c(%ebx)
}
  100758:	83 c4 18             	add    $0x18,%esp
  10075b:	5b                   	pop    %ebx
  10075c:	c3                   	ret    
  10075d:	90                   	nop
  10075e:	90                   	nop
  10075f:	90                   	nop

00100760 <program_loader>:
		    uint32_t filesz, uint32_t memsz);
static void loader_panic(void);

void
program_loader(int program_id, uint32_t *entry_point)
{
  100760:	55                   	push   %ebp
  100761:	57                   	push   %edi
  100762:	56                   	push   %esi
  100763:	53                   	push   %ebx
  100764:	83 ec 1c             	sub    $0x1c,%esp
  100767:	8b 44 24 30          	mov    0x30(%esp),%eax
	struct Proghdr *ph, *eph;
	struct Elf *elf_header;
	int nprograms = sizeof(ramimages) / sizeof(ramimages[0]);

	if (program_id < 0 || program_id >= nprograms)
  10076b:	83 f8 03             	cmp    $0x3,%eax
  10076e:	7f 04                	jg     100774 <program_loader+0x14>
  100770:	85 c0                	test   %eax,%eax
  100772:	79 02                	jns    100776 <program_loader+0x16>
  100774:	eb fe                	jmp    100774 <program_loader+0x14>
		loader_panic();

	// is this a valid ELF?
	elf_header = (struct Elf *) ramimages[program_id].begin;
  100776:	8b 34 c5 44 10 10 00 	mov    0x101044(,%eax,8),%esi
	if (elf_header->e_magic != ELF_MAGIC)
  10077d:	81 3e 7f 45 4c 46    	cmpl   $0x464c457f,(%esi)
  100783:	74 02                	je     100787 <program_loader+0x27>
  100785:	eb fe                	jmp    100785 <program_loader+0x25>
		loader_panic();

	// load each program segment (ignores ph flags)
	ph = (struct Proghdr*) ((const uint8_t *) elf_header + elf_header->e_phoff);
  100787:	8b 5e 1c             	mov    0x1c(%esi),%ebx
	eph = ph + elf_header->e_phnum;
  10078a:	0f b7 6e 2c          	movzwl 0x2c(%esi),%ebp
	elf_header = (struct Elf *) ramimages[program_id].begin;
	if (elf_header->e_magic != ELF_MAGIC)
		loader_panic();

	// load each program segment (ignores ph flags)
	ph = (struct Proghdr*) ((const uint8_t *) elf_header + elf_header->e_phoff);
  10078e:	01 f3                	add    %esi,%ebx
	eph = ph + elf_header->e_phnum;
  100790:	c1 e5 05             	shl    $0x5,%ebp
  100793:	8d 2c 2b             	lea    (%ebx,%ebp,1),%ebp
	for (; ph < eph; ph++)
  100796:	eb 3f                	jmp    1007d7 <program_loader+0x77>
		if (ph->p_type == ELF_PROG_LOAD)
  100798:	83 3b 01             	cmpl   $0x1,(%ebx)
  10079b:	75 37                	jne    1007d4 <program_loader+0x74>
			copyseg((void *) ph->p_va,
  10079d:	8b 43 08             	mov    0x8(%ebx),%eax
// then clear the memory from 'va+filesz' up to 'va+memsz' (set it to 0).
static void
copyseg(void *dst, const uint8_t *src, uint32_t filesz, uint32_t memsz)
{
	uint32_t va = (uint32_t) dst;
	uint32_t end_va = va + filesz;
  1007a0:	8b 7b 10             	mov    0x10(%ebx),%edi
	memsz += va;
  1007a3:	8b 53 14             	mov    0x14(%ebx),%edx
// then clear the memory from 'va+filesz' up to 'va+memsz' (set it to 0).
static void
copyseg(void *dst, const uint8_t *src, uint32_t filesz, uint32_t memsz)
{
	uint32_t va = (uint32_t) dst;
	uint32_t end_va = va + filesz;
  1007a6:	01 c7                	add    %eax,%edi
	memsz += va;
  1007a8:	01 c2                	add    %eax,%edx
	va &= ~(PAGESIZE - 1);		// round to page boundary
  1007aa:	25 00 f0 ff ff       	and    $0xfffff000,%eax
static void
copyseg(void *dst, const uint8_t *src, uint32_t filesz, uint32_t memsz)
{
	uint32_t va = (uint32_t) dst;
	uint32_t end_va = va + filesz;
	memsz += va;
  1007af:	89 54 24 0c          	mov    %edx,0xc(%esp)
	va &= ~(PAGESIZE - 1);		// round to page boundary

	// copy data
	memcpy((uint8_t *) va, src, end_va - va);
  1007b3:	52                   	push   %edx
  1007b4:	89 fa                	mov    %edi,%edx
  1007b6:	29 c2                	sub    %eax,%edx
  1007b8:	52                   	push   %edx
  1007b9:	8b 53 04             	mov    0x4(%ebx),%edx
  1007bc:	01 f2                	add    %esi,%edx
  1007be:	52                   	push   %edx
  1007bf:	50                   	push   %eax
  1007c0:	e8 27 00 00 00       	call   1007ec <memcpy>
  1007c5:	83 c4 10             	add    $0x10,%esp
  1007c8:	eb 04                	jmp    1007ce <program_loader+0x6e>

	// clear bss segment
	while (end_va < memsz)
		*((uint8_t *) end_va++) = 0;
  1007ca:	c6 07 00             	movb   $0x0,(%edi)
  1007cd:	47                   	inc    %edi

	// copy data
	memcpy((uint8_t *) va, src, end_va - va);

	// clear bss segment
	while (end_va < memsz)
  1007ce:	3b 7c 24 0c          	cmp    0xc(%esp),%edi
  1007d2:	72 f6                	jb     1007ca <program_loader+0x6a>
		loader_panic();

	// load each program segment (ignores ph flags)
	ph = (struct Proghdr*) ((const uint8_t *) elf_header + elf_header->e_phoff);
	eph = ph + elf_header->e_phnum;
	for (; ph < eph; ph++)
  1007d4:	83 c3 20             	add    $0x20,%ebx
  1007d7:	39 eb                	cmp    %ebp,%ebx
  1007d9:	72 bd                	jb     100798 <program_loader+0x38>
			copyseg((void *) ph->p_va,
				(const uint8_t *) elf_header + ph->p_offset,
				ph->p_filesz, ph->p_memsz);

	// store the entry point from the ELF header
	*entry_point = elf_header->e_entry;
  1007db:	8b 56 18             	mov    0x18(%esi),%edx
  1007de:	8b 44 24 34          	mov    0x34(%esp),%eax
  1007e2:	89 10                	mov    %edx,(%eax)
}
  1007e4:	83 c4 1c             	add    $0x1c,%esp
  1007e7:	5b                   	pop    %ebx
  1007e8:	5e                   	pop    %esi
  1007e9:	5f                   	pop    %edi
  1007ea:	5d                   	pop    %ebp
  1007eb:	c3                   	ret    

001007ec <memcpy>:
 *
 *   We must provide our own implementations of these basic functions. */

void *
memcpy(void *dst, const void *src, size_t n)
{
  1007ec:	56                   	push   %esi
  1007ed:	31 d2                	xor    %edx,%edx
  1007ef:	53                   	push   %ebx
  1007f0:	8b 44 24 0c          	mov    0xc(%esp),%eax
  1007f4:	8b 5c 24 10          	mov    0x10(%esp),%ebx
  1007f8:	8b 74 24 14          	mov    0x14(%esp),%esi
	const char *s = (const char *) src;
	char *d = (char *) dst;
	while (n-- > 0)
  1007fc:	eb 08                	jmp    100806 <memcpy+0x1a>
		*d++ = *s++;
  1007fe:	8a 0c 13             	mov    (%ebx,%edx,1),%cl
  100801:	4e                   	dec    %esi
  100802:	88 0c 10             	mov    %cl,(%eax,%edx,1)
  100805:	42                   	inc    %edx
void *
memcpy(void *dst, const void *src, size_t n)
{
	const char *s = (const char *) src;
	char *d = (char *) dst;
	while (n-- > 0)
  100806:	85 f6                	test   %esi,%esi
  100808:	75 f4                	jne    1007fe <memcpy+0x12>
		*d++ = *s++;
	return dst;
}
  10080a:	5b                   	pop    %ebx
  10080b:	5e                   	pop    %esi
  10080c:	c3                   	ret    

0010080d <memmove>:

void *
memmove(void *dst, const void *src, size_t n)
{
  10080d:	57                   	push   %edi
  10080e:	56                   	push   %esi
  10080f:	53                   	push   %ebx
  100810:	8b 44 24 10          	mov    0x10(%esp),%eax
  100814:	8b 7c 24 14          	mov    0x14(%esp),%edi
  100818:	8b 54 24 18          	mov    0x18(%esp),%edx
	const char *s = (const char *) src;
	char *d = (char *) dst;
	if (s < d && s + n > d) {
  10081c:	39 c7                	cmp    %eax,%edi
  10081e:	73 26                	jae    100846 <memmove+0x39>
  100820:	8d 34 17             	lea    (%edi,%edx,1),%esi
  100823:	39 c6                	cmp    %eax,%esi
  100825:	76 1f                	jbe    100846 <memmove+0x39>
		s += n, d += n;
  100827:	8d 3c 10             	lea    (%eax,%edx,1),%edi
  10082a:	31 c9                	xor    %ecx,%ecx
		while (n-- > 0)
  10082c:	eb 07                	jmp    100835 <memmove+0x28>
			*--d = *--s;
  10082e:	8a 1c 0e             	mov    (%esi,%ecx,1),%bl
  100831:	4a                   	dec    %edx
  100832:	88 1c 0f             	mov    %bl,(%edi,%ecx,1)
  100835:	49                   	dec    %ecx
{
	const char *s = (const char *) src;
	char *d = (char *) dst;
	if (s < d && s + n > d) {
		s += n, d += n;
		while (n-- > 0)
  100836:	85 d2                	test   %edx,%edx
  100838:	75 f4                	jne    10082e <memmove+0x21>
  10083a:	eb 10                	jmp    10084c <memmove+0x3f>
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  10083c:	8a 1c 0f             	mov    (%edi,%ecx,1),%bl
  10083f:	4a                   	dec    %edx
  100840:	88 1c 08             	mov    %bl,(%eax,%ecx,1)
  100843:	41                   	inc    %ecx
  100844:	eb 02                	jmp    100848 <memmove+0x3b>
  100846:	31 c9                	xor    %ecx,%ecx
	if (s < d && s + n > d) {
		s += n, d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  100848:	85 d2                	test   %edx,%edx
  10084a:	75 f0                	jne    10083c <memmove+0x2f>
			*d++ = *s++;
	return dst;
}
  10084c:	5b                   	pop    %ebx
  10084d:	5e                   	pop    %esi
  10084e:	5f                   	pop    %edi
  10084f:	c3                   	ret    

00100850 <memset>:

void *
memset(void *v, int c, size_t n)
{
  100850:	53                   	push   %ebx
  100851:	8b 44 24 08          	mov    0x8(%esp),%eax
  100855:	8b 5c 24 0c          	mov    0xc(%esp),%ebx
  100859:	8b 4c 24 10          	mov    0x10(%esp),%ecx
	char *p = (char *) v;
  10085d:	89 c2                	mov    %eax,%edx
	while (n-- > 0)
  10085f:	eb 04                	jmp    100865 <memset+0x15>
		*p++ = c;
  100861:	88 1a                	mov    %bl,(%edx)
  100863:	49                   	dec    %ecx
  100864:	42                   	inc    %edx

void *
memset(void *v, int c, size_t n)
{
	char *p = (char *) v;
	while (n-- > 0)
  100865:	85 c9                	test   %ecx,%ecx
  100867:	75 f8                	jne    100861 <memset+0x11>
		*p++ = c;
	return v;
}
  100869:	5b                   	pop    %ebx
  10086a:	c3                   	ret    

0010086b <strlen>:

size_t
strlen(const char *s)
{
  10086b:	8b 54 24 04          	mov    0x4(%esp),%edx
  10086f:	31 c0                	xor    %eax,%eax
	size_t n;
	for (n = 0; *s != '\0'; ++s)
  100871:	eb 01                	jmp    100874 <strlen+0x9>
		++n;
  100873:	40                   	inc    %eax

size_t
strlen(const char *s)
{
	size_t n;
	for (n = 0; *s != '\0'; ++s)
  100874:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
  100878:	75 f9                	jne    100873 <strlen+0x8>
		++n;
	return n;
}
  10087a:	c3                   	ret    

0010087b <strnlen>:

size_t
strnlen(const char *s, size_t maxlen)
{
  10087b:	8b 4c 24 04          	mov    0x4(%esp),%ecx
  10087f:	31 c0                	xor    %eax,%eax
  100881:	8b 54 24 08          	mov    0x8(%esp),%edx
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
  100885:	eb 01                	jmp    100888 <strnlen+0xd>
		++n;
  100887:	40                   	inc    %eax

size_t
strnlen(const char *s, size_t maxlen)
{
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
  100888:	39 d0                	cmp    %edx,%eax
  10088a:	74 06                	je     100892 <strnlen+0x17>
  10088c:	80 3c 01 00          	cmpb   $0x0,(%ecx,%eax,1)
  100890:	75 f5                	jne    100887 <strnlen+0xc>
		++n;
	return n;
}
  100892:	c3                   	ret    

00100893 <console_putc>:
 *
 *   Print a message onto the console, starting at the given cursor position. */

static uint16_t *
console_putc(uint16_t *cursor, unsigned char c, int color)
{
  100893:	56                   	push   %esi
	if (cursor >= CONSOLE_END)
  100894:	3d 9f 8f 0b 00       	cmp    $0xb8f9f,%eax
 *
 *   Print a message onto the console, starting at the given cursor position. */

static uint16_t *
console_putc(uint16_t *cursor, unsigned char c, int color)
{
  100899:	53                   	push   %ebx
  10089a:	89 c3                	mov    %eax,%ebx
	if (cursor >= CONSOLE_END)
  10089c:	76 05                	jbe    1008a3 <console_putc+0x10>
  10089e:	bb 00 80 0b 00       	mov    $0xb8000,%ebx
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
  1008a3:	80 fa 0a             	cmp    $0xa,%dl
  1008a6:	75 2c                	jne    1008d4 <console_putc+0x41>
		int pos = (cursor - CONSOLE_BEGIN) % 80;
  1008a8:	8d 83 00 80 f4 ff    	lea    -0xb8000(%ebx),%eax
  1008ae:	be 50 00 00 00       	mov    $0x50,%esi
  1008b3:	d1 f8                	sar    %eax
		for (; pos != 80; pos++)
			*cursor++ = ' ' | color;
  1008b5:	83 c9 20             	or     $0x20,%ecx
console_putc(uint16_t *cursor, unsigned char c, int color)
{
	if (cursor >= CONSOLE_END)
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
		int pos = (cursor - CONSOLE_BEGIN) % 80;
  1008b8:	99                   	cltd   
  1008b9:	f7 fe                	idiv   %esi
  1008bb:	89 de                	mov    %ebx,%esi
  1008bd:	89 d0                	mov    %edx,%eax
		for (; pos != 80; pos++)
  1008bf:	eb 07                	jmp    1008c8 <console_putc+0x35>
			*cursor++ = ' ' | color;
  1008c1:	66 89 0e             	mov    %cx,(%esi)
{
	if (cursor >= CONSOLE_END)
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
		int pos = (cursor - CONSOLE_BEGIN) % 80;
		for (; pos != 80; pos++)
  1008c4:	40                   	inc    %eax
			*cursor++ = ' ' | color;
  1008c5:	83 c6 02             	add    $0x2,%esi
{
	if (cursor >= CONSOLE_END)
		cursor = CONSOLE_BEGIN;
	if (c == '\n') {
		int pos = (cursor - CONSOLE_BEGIN) % 80;
		for (; pos != 80; pos++)
  1008c8:	83 f8 50             	cmp    $0x50,%eax
  1008cb:	75 f4                	jne    1008c1 <console_putc+0x2e>
  1008cd:	29 d0                	sub    %edx,%eax
  1008cf:	8d 04 43             	lea    (%ebx,%eax,2),%eax
  1008d2:	eb 0b                	jmp    1008df <console_putc+0x4c>
			*cursor++ = ' ' | color;
	} else
		*cursor++ = c | color;
  1008d4:	0f b6 d2             	movzbl %dl,%edx
  1008d7:	09 ca                	or     %ecx,%edx
  1008d9:	66 89 13             	mov    %dx,(%ebx)
  1008dc:	8d 43 02             	lea    0x2(%ebx),%eax
	return cursor;
}
  1008df:	5b                   	pop    %ebx
  1008e0:	5e                   	pop    %esi
  1008e1:	c3                   	ret    

001008e2 <fill_numbuf>:
static const char lower_digits[] = "0123456789abcdef";

static char *
fill_numbuf(char *numbuf_end, uint32_t val, int base, const char *digits,
	    int precision)
{
  1008e2:	56                   	push   %esi
  1008e3:	53                   	push   %ebx
  1008e4:	8b 74 24 0c          	mov    0xc(%esp),%esi
	*--numbuf_end = '\0';
  1008e8:	8d 58 ff             	lea    -0x1(%eax),%ebx
  1008eb:	c6 40 ff 00          	movb   $0x0,-0x1(%eax)
	if (precision != 0 || val != 0)
  1008ef:	83 7c 24 10 00       	cmpl   $0x0,0x10(%esp)
  1008f4:	75 04                	jne    1008fa <fill_numbuf+0x18>
  1008f6:	85 d2                	test   %edx,%edx
  1008f8:	74 10                	je     10090a <fill_numbuf+0x28>
		do {
			*--numbuf_end = digits[val % base];
  1008fa:	89 d0                	mov    %edx,%eax
  1008fc:	31 d2                	xor    %edx,%edx
  1008fe:	f7 f1                	div    %ecx
  100900:	4b                   	dec    %ebx
  100901:	8a 14 16             	mov    (%esi,%edx,1),%dl
  100904:	88 13                	mov    %dl,(%ebx)
			val /= base;
  100906:	89 c2                	mov    %eax,%edx
  100908:	eb ec                	jmp    1008f6 <fill_numbuf+0x14>
		} while (val != 0);
	return numbuf_end;
}
  10090a:	89 d8                	mov    %ebx,%eax
  10090c:	5b                   	pop    %ebx
  10090d:	5e                   	pop    %esi
  10090e:	c3                   	ret    

0010090f <console_vprintf>:
#define FLAG_PLUSPOSITIVE	(1<<4)
static const char flag_chars[] = "#0- +";

uint16_t *
console_vprintf(uint16_t *cursor, int color, const char *format, va_list val)
{
  10090f:	55                   	push   %ebp
  100910:	57                   	push   %edi
  100911:	56                   	push   %esi
  100912:	53                   	push   %ebx
  100913:	83 ec 38             	sub    $0x38,%esp
  100916:	8b 74 24 4c          	mov    0x4c(%esp),%esi
  10091a:	8b 7c 24 54          	mov    0x54(%esp),%edi
  10091e:	8b 5c 24 58          	mov    0x58(%esp),%ebx
	int flags, width, zeros, precision, negative, numeric, len;
#define NUMBUFSIZ 20
	char numbuf[NUMBUFSIZ];
	char *data;

	for (; *format; ++format) {
  100922:	e9 60 03 00 00       	jmp    100c87 <console_vprintf+0x378>
		if (*format != '%') {
  100927:	80 fa 25             	cmp    $0x25,%dl
  10092a:	74 13                	je     10093f <console_vprintf+0x30>
			cursor = console_putc(cursor, *format, color);
  10092c:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  100930:	0f b6 d2             	movzbl %dl,%edx
  100933:	89 f0                	mov    %esi,%eax
  100935:	e8 59 ff ff ff       	call   100893 <console_putc>
  10093a:	e9 45 03 00 00       	jmp    100c84 <console_vprintf+0x375>
			continue;
		}

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
  10093f:	47                   	inc    %edi
  100940:	c7 44 24 14 00 00 00 	movl   $0x0,0x14(%esp)
  100947:	00 
  100948:	eb 12                	jmp    10095c <console_vprintf+0x4d>
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
				++flagc;
  10094a:	41                   	inc    %ecx

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
  10094b:	8a 11                	mov    (%ecx),%dl
  10094d:	84 d2                	test   %dl,%dl
  10094f:	74 1a                	je     10096b <console_vprintf+0x5c>
  100951:	89 e8                	mov    %ebp,%eax
  100953:	38 c2                	cmp    %al,%dl
  100955:	75 f3                	jne    10094a <console_vprintf+0x3b>
  100957:	e9 3f 03 00 00       	jmp    100c9b <console_vprintf+0x38c>
			continue;
		}

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
  10095c:	8a 17                	mov    (%edi),%dl
  10095e:	84 d2                	test   %dl,%dl
  100960:	74 0b                	je     10096d <console_vprintf+0x5e>
  100962:	b9 54 0d 10 00       	mov    $0x100d54,%ecx
  100967:	89 d5                	mov    %edx,%ebp
  100969:	eb e0                	jmp    10094b <console_vprintf+0x3c>
  10096b:	89 ea                	mov    %ebp,%edx
			flags |= (1 << (flagc - flag_chars));
		}

		// process width
		width = -1;
		if (*format >= '1' && *format <= '9') {
  10096d:	8d 42 cf             	lea    -0x31(%edx),%eax
  100970:	3c 08                	cmp    $0x8,%al
  100972:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
  100979:	00 
  10097a:	76 13                	jbe    10098f <console_vprintf+0x80>
  10097c:	eb 1d                	jmp    10099b <console_vprintf+0x8c>
			for (width = 0; *format >= '0' && *format <= '9'; )
				width = 10 * width + *format++ - '0';
  10097e:	6b 54 24 0c 0a       	imul   $0xa,0xc(%esp),%edx
  100983:	0f be c0             	movsbl %al,%eax
  100986:	47                   	inc    %edi
  100987:	8d 44 02 d0          	lea    -0x30(%edx,%eax,1),%eax
  10098b:	89 44 24 0c          	mov    %eax,0xc(%esp)
		}

		// process width
		width = -1;
		if (*format >= '1' && *format <= '9') {
			for (width = 0; *format >= '0' && *format <= '9'; )
  10098f:	8a 07                	mov    (%edi),%al
  100991:	8d 50 d0             	lea    -0x30(%eax),%edx
  100994:	80 fa 09             	cmp    $0x9,%dl
  100997:	76 e5                	jbe    10097e <console_vprintf+0x6f>
  100999:	eb 18                	jmp    1009b3 <console_vprintf+0xa4>
				width = 10 * width + *format++ - '0';
		} else if (*format == '*') {
  10099b:	80 fa 2a             	cmp    $0x2a,%dl
  10099e:	c7 44 24 0c ff ff ff 	movl   $0xffffffff,0xc(%esp)
  1009a5:	ff 
  1009a6:	75 0b                	jne    1009b3 <console_vprintf+0xa4>
			width = va_arg(val, int);
  1009a8:	83 c3 04             	add    $0x4,%ebx
			++format;
  1009ab:	47                   	inc    %edi
		width = -1;
		if (*format >= '1' && *format <= '9') {
			for (width = 0; *format >= '0' && *format <= '9'; )
				width = 10 * width + *format++ - '0';
		} else if (*format == '*') {
			width = va_arg(val, int);
  1009ac:	8b 53 fc             	mov    -0x4(%ebx),%edx
  1009af:	89 54 24 0c          	mov    %edx,0xc(%esp)
			++format;
		}

		// process precision
		precision = -1;
		if (*format == '.') {
  1009b3:	83 cd ff             	or     $0xffffffff,%ebp
  1009b6:	80 3f 2e             	cmpb   $0x2e,(%edi)
  1009b9:	75 37                	jne    1009f2 <console_vprintf+0xe3>
			++format;
  1009bb:	47                   	inc    %edi
			if (*format >= '0' && *format <= '9') {
  1009bc:	31 ed                	xor    %ebp,%ebp
  1009be:	8a 07                	mov    (%edi),%al
  1009c0:	8d 50 d0             	lea    -0x30(%eax),%edx
  1009c3:	80 fa 09             	cmp    $0x9,%dl
  1009c6:	76 0d                	jbe    1009d5 <console_vprintf+0xc6>
  1009c8:	eb 17                	jmp    1009e1 <console_vprintf+0xd2>
				for (precision = 0; *format >= '0' && *format <= '9'; )
					precision = 10 * precision + *format++ - '0';
  1009ca:	6b ed 0a             	imul   $0xa,%ebp,%ebp
  1009cd:	0f be c0             	movsbl %al,%eax
  1009d0:	47                   	inc    %edi
  1009d1:	8d 6c 05 d0          	lea    -0x30(%ebp,%eax,1),%ebp
		// process precision
		precision = -1;
		if (*format == '.') {
			++format;
			if (*format >= '0' && *format <= '9') {
				for (precision = 0; *format >= '0' && *format <= '9'; )
  1009d5:	8a 07                	mov    (%edi),%al
  1009d7:	8d 50 d0             	lea    -0x30(%eax),%edx
  1009da:	80 fa 09             	cmp    $0x9,%dl
  1009dd:	76 eb                	jbe    1009ca <console_vprintf+0xbb>
  1009df:	eb 11                	jmp    1009f2 <console_vprintf+0xe3>
					precision = 10 * precision + *format++ - '0';
			} else if (*format == '*') {
  1009e1:	3c 2a                	cmp    $0x2a,%al
  1009e3:	75 0b                	jne    1009f0 <console_vprintf+0xe1>
				precision = va_arg(val, int);
  1009e5:	83 c3 04             	add    $0x4,%ebx
				++format;
  1009e8:	47                   	inc    %edi
			++format;
			if (*format >= '0' && *format <= '9') {
				for (precision = 0; *format >= '0' && *format <= '9'; )
					precision = 10 * precision + *format++ - '0';
			} else if (*format == '*') {
				precision = va_arg(val, int);
  1009e9:	8b 6b fc             	mov    -0x4(%ebx),%ebp
				++format;
			}
			if (precision < 0)
  1009ec:	85 ed                	test   %ebp,%ebp
  1009ee:	79 02                	jns    1009f2 <console_vprintf+0xe3>
  1009f0:	31 ed                	xor    %ebp,%ebp
		}

		// process main conversion character
		negative = 0;
		numeric = 0;
		switch (*format) {
  1009f2:	8a 07                	mov    (%edi),%al
  1009f4:	3c 64                	cmp    $0x64,%al
  1009f6:	74 34                	je     100a2c <console_vprintf+0x11d>
  1009f8:	7f 1d                	jg     100a17 <console_vprintf+0x108>
  1009fa:	3c 58                	cmp    $0x58,%al
  1009fc:	0f 84 a2 00 00 00    	je     100aa4 <console_vprintf+0x195>
  100a02:	3c 63                	cmp    $0x63,%al
  100a04:	0f 84 bf 00 00 00    	je     100ac9 <console_vprintf+0x1ba>
  100a0a:	3c 43                	cmp    $0x43,%al
  100a0c:	0f 85 d0 00 00 00    	jne    100ae2 <console_vprintf+0x1d3>
  100a12:	e9 a3 00 00 00       	jmp    100aba <console_vprintf+0x1ab>
  100a17:	3c 75                	cmp    $0x75,%al
  100a19:	74 4d                	je     100a68 <console_vprintf+0x159>
  100a1b:	3c 78                	cmp    $0x78,%al
  100a1d:	74 5c                	je     100a7b <console_vprintf+0x16c>
  100a1f:	3c 73                	cmp    $0x73,%al
  100a21:	0f 85 bb 00 00 00    	jne    100ae2 <console_vprintf+0x1d3>
  100a27:	e9 86 00 00 00       	jmp    100ab2 <console_vprintf+0x1a3>
		case 'd': {
			int x = va_arg(val, int);
  100a2c:	83 c3 04             	add    $0x4,%ebx
  100a2f:	8b 53 fc             	mov    -0x4(%ebx),%edx
			data = fill_numbuf(numbuf + NUMBUFSIZ, x > 0 ? x : -x, 10, upper_digits, precision);
  100a32:	89 d1                	mov    %edx,%ecx
  100a34:	c1 f9 1f             	sar    $0x1f,%ecx
  100a37:	89 0c 24             	mov    %ecx,(%esp)
  100a3a:	31 ca                	xor    %ecx,%edx
  100a3c:	55                   	push   %ebp
  100a3d:	29 ca                	sub    %ecx,%edx
  100a3f:	68 5c 0d 10 00       	push   $0x100d5c
  100a44:	b9 0a 00 00 00       	mov    $0xa,%ecx
  100a49:	8d 44 24 40          	lea    0x40(%esp),%eax
  100a4d:	e8 90 fe ff ff       	call   1008e2 <fill_numbuf>
  100a52:	89 44 24 0c          	mov    %eax,0xc(%esp)
			if (x < 0)
  100a56:	58                   	pop    %eax
  100a57:	5a                   	pop    %edx
  100a58:	ba 01 00 00 00       	mov    $0x1,%edx
  100a5d:	8b 04 24             	mov    (%esp),%eax
  100a60:	83 e0 01             	and    $0x1,%eax
  100a63:	e9 a5 00 00 00       	jmp    100b0d <console_vprintf+0x1fe>
				negative = 1;
			numeric = 1;
			break;
		}
		case 'u': {
			unsigned x = va_arg(val, unsigned);
  100a68:	83 c3 04             	add    $0x4,%ebx
			data = fill_numbuf(numbuf + NUMBUFSIZ, x, 10, upper_digits, precision);
  100a6b:	b9 0a 00 00 00       	mov    $0xa,%ecx
  100a70:	8b 53 fc             	mov    -0x4(%ebx),%edx
  100a73:	55                   	push   %ebp
  100a74:	68 5c 0d 10 00       	push   $0x100d5c
  100a79:	eb 11                	jmp    100a8c <console_vprintf+0x17d>
			numeric = 1;
			break;
		}
		case 'x': {
			unsigned x = va_arg(val, unsigned);
  100a7b:	83 c3 04             	add    $0x4,%ebx
			data = fill_numbuf(numbuf + NUMBUFSIZ, x, 16, lower_digits, precision);
  100a7e:	8b 53 fc             	mov    -0x4(%ebx),%edx
  100a81:	55                   	push   %ebp
  100a82:	68 70 0d 10 00       	push   $0x100d70
  100a87:	b9 10 00 00 00       	mov    $0x10,%ecx
  100a8c:	8d 44 24 40          	lea    0x40(%esp),%eax
  100a90:	e8 4d fe ff ff       	call   1008e2 <fill_numbuf>
  100a95:	ba 01 00 00 00       	mov    $0x1,%edx
  100a9a:	89 44 24 0c          	mov    %eax,0xc(%esp)
  100a9e:	31 c0                	xor    %eax,%eax
			numeric = 1;
			break;
  100aa0:	59                   	pop    %ecx
  100aa1:	59                   	pop    %ecx
  100aa2:	eb 69                	jmp    100b0d <console_vprintf+0x1fe>
		}
		case 'X': {
			unsigned x = va_arg(val, unsigned);
  100aa4:	83 c3 04             	add    $0x4,%ebx
			data = fill_numbuf(numbuf + NUMBUFSIZ, x, 16, upper_digits, precision);
  100aa7:	8b 53 fc             	mov    -0x4(%ebx),%edx
  100aaa:	55                   	push   %ebp
  100aab:	68 5c 0d 10 00       	push   $0x100d5c
  100ab0:	eb d5                	jmp    100a87 <console_vprintf+0x178>
			numeric = 1;
			break;
		}
		case 's':
			data = va_arg(val, char *);
  100ab2:	83 c3 04             	add    $0x4,%ebx
  100ab5:	8b 43 fc             	mov    -0x4(%ebx),%eax
  100ab8:	eb 40                	jmp    100afa <console_vprintf+0x1eb>
			break;
		case 'C':
			color = va_arg(val, int);
  100aba:	83 c3 04             	add    $0x4,%ebx
  100abd:	8b 53 fc             	mov    -0x4(%ebx),%edx
  100ac0:	89 54 24 50          	mov    %edx,0x50(%esp)
			goto done;
  100ac4:	e9 bd 01 00 00       	jmp    100c86 <console_vprintf+0x377>
		case 'c':
			data = numbuf;
			numbuf[0] = va_arg(val, int);
  100ac9:	83 c3 04             	add    $0x4,%ebx
  100acc:	8b 43 fc             	mov    -0x4(%ebx),%eax
			numbuf[1] = '\0';
  100acf:	8d 4c 24 24          	lea    0x24(%esp),%ecx
  100ad3:	c6 44 24 25 00       	movb   $0x0,0x25(%esp)
  100ad8:	89 4c 24 04          	mov    %ecx,0x4(%esp)
		case 'C':
			color = va_arg(val, int);
			goto done;
		case 'c':
			data = numbuf;
			numbuf[0] = va_arg(val, int);
  100adc:	88 44 24 24          	mov    %al,0x24(%esp)
  100ae0:	eb 27                	jmp    100b09 <console_vprintf+0x1fa>
			numbuf[1] = '\0';
			break;
		normal:
		default:
			data = numbuf;
			numbuf[0] = (*format ? *format : '%');
  100ae2:	84 c0                	test   %al,%al
  100ae4:	75 02                	jne    100ae8 <console_vprintf+0x1d9>
  100ae6:	b0 25                	mov    $0x25,%al
  100ae8:	88 44 24 24          	mov    %al,0x24(%esp)
			numbuf[1] = '\0';
  100aec:	c6 44 24 25 00       	movb   $0x0,0x25(%esp)
			if (!*format)
  100af1:	80 3f 00             	cmpb   $0x0,(%edi)
  100af4:	74 0a                	je     100b00 <console_vprintf+0x1f1>
  100af6:	8d 44 24 24          	lea    0x24(%esp),%eax
  100afa:	89 44 24 04          	mov    %eax,0x4(%esp)
  100afe:	eb 09                	jmp    100b09 <console_vprintf+0x1fa>
				format--;
  100b00:	8d 54 24 24          	lea    0x24(%esp),%edx
  100b04:	4f                   	dec    %edi
  100b05:	89 54 24 04          	mov    %edx,0x4(%esp)
  100b09:	31 d2                	xor    %edx,%edx
  100b0b:	31 c0                	xor    %eax,%eax
			break;
		}

		if (precision >= 0)
			len = strnlen(data, precision);
  100b0d:	31 c9                	xor    %ecx,%ecx
			if (!*format)
				format--;
			break;
		}

		if (precision >= 0)
  100b0f:	83 fd ff             	cmp    $0xffffffff,%ebp
  100b12:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  100b19:	74 1f                	je     100b3a <console_vprintf+0x22b>
  100b1b:	89 04 24             	mov    %eax,(%esp)
  100b1e:	eb 01                	jmp    100b21 <console_vprintf+0x212>
size_t
strnlen(const char *s, size_t maxlen)
{
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
		++n;
  100b20:	41                   	inc    %ecx

size_t
strnlen(const char *s, size_t maxlen)
{
	size_t n;
	for (n = 0; n != maxlen && *s != '\0'; ++s)
  100b21:	39 e9                	cmp    %ebp,%ecx
  100b23:	74 0a                	je     100b2f <console_vprintf+0x220>
  100b25:	8b 44 24 04          	mov    0x4(%esp),%eax
  100b29:	80 3c 08 00          	cmpb   $0x0,(%eax,%ecx,1)
  100b2d:	75 f1                	jne    100b20 <console_vprintf+0x211>
  100b2f:	8b 04 24             	mov    (%esp),%eax
				format--;
			break;
		}

		if (precision >= 0)
			len = strnlen(data, precision);
  100b32:	89 0c 24             	mov    %ecx,(%esp)
  100b35:	eb 1f                	jmp    100b56 <console_vprintf+0x247>
size_t
strlen(const char *s)
{
	size_t n;
	for (n = 0; *s != '\0'; ++s)
		++n;
  100b37:	42                   	inc    %edx
  100b38:	eb 09                	jmp    100b43 <console_vprintf+0x234>
  100b3a:	89 d1                	mov    %edx,%ecx
  100b3c:	8b 14 24             	mov    (%esp),%edx
  100b3f:	89 44 24 08          	mov    %eax,0x8(%esp)

size_t
strlen(const char *s)
{
	size_t n;
	for (n = 0; *s != '\0'; ++s)
  100b43:	8b 44 24 04          	mov    0x4(%esp),%eax
  100b47:	80 3c 10 00          	cmpb   $0x0,(%eax,%edx,1)
  100b4b:	75 ea                	jne    100b37 <console_vprintf+0x228>
  100b4d:	8b 44 24 08          	mov    0x8(%esp),%eax
  100b51:	89 14 24             	mov    %edx,(%esp)
  100b54:	89 ca                	mov    %ecx,%edx

		if (precision >= 0)
			len = strnlen(data, precision);
		else
			len = strlen(data);
		if (numeric && negative)
  100b56:	85 c0                	test   %eax,%eax
  100b58:	74 0c                	je     100b66 <console_vprintf+0x257>
  100b5a:	84 d2                	test   %dl,%dl
  100b5c:	c7 44 24 08 2d 00 00 	movl   $0x2d,0x8(%esp)
  100b63:	00 
  100b64:	75 24                	jne    100b8a <console_vprintf+0x27b>
			negative = '-';
		else if (flags & FLAG_PLUSPOSITIVE)
  100b66:	f6 44 24 14 10       	testb  $0x10,0x14(%esp)
  100b6b:	c7 44 24 08 2b 00 00 	movl   $0x2b,0x8(%esp)
  100b72:	00 
  100b73:	75 15                	jne    100b8a <console_vprintf+0x27b>
			negative = '+';
		else if (flags & FLAG_SPACEPOSITIVE)
  100b75:	8b 44 24 14          	mov    0x14(%esp),%eax
  100b79:	83 e0 08             	and    $0x8,%eax
  100b7c:	83 f8 01             	cmp    $0x1,%eax
  100b7f:	19 c9                	sbb    %ecx,%ecx
  100b81:	f7 d1                	not    %ecx
  100b83:	83 e1 20             	and    $0x20,%ecx
  100b86:	89 4c 24 08          	mov    %ecx,0x8(%esp)
			negative = ' ';
		else
			negative = 0;
		if (numeric && precision > len)
  100b8a:	3b 2c 24             	cmp    (%esp),%ebp
  100b8d:	7e 0d                	jle    100b9c <console_vprintf+0x28d>
  100b8f:	84 d2                	test   %dl,%dl
  100b91:	74 40                	je     100bd3 <console_vprintf+0x2c4>
			zeros = precision - len;
  100b93:	2b 2c 24             	sub    (%esp),%ebp
  100b96:	89 6c 24 10          	mov    %ebp,0x10(%esp)
  100b9a:	eb 3f                	jmp    100bdb <console_vprintf+0x2cc>
		else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
  100b9c:	84 d2                	test   %dl,%dl
  100b9e:	74 33                	je     100bd3 <console_vprintf+0x2c4>
  100ba0:	8b 44 24 14          	mov    0x14(%esp),%eax
  100ba4:	83 e0 06             	and    $0x6,%eax
  100ba7:	83 f8 02             	cmp    $0x2,%eax
  100baa:	75 27                	jne    100bd3 <console_vprintf+0x2c4>
  100bac:	45                   	inc    %ebp
  100bad:	75 24                	jne    100bd3 <console_vprintf+0x2c4>
			 && numeric && precision < 0
			 && len + !!negative < width)
  100baf:	31 c0                	xor    %eax,%eax
			negative = ' ';
		else
			negative = 0;
		if (numeric && precision > len)
			zeros = precision - len;
		else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
  100bb1:	8b 0c 24             	mov    (%esp),%ecx
			 && numeric && precision < 0
			 && len + !!negative < width)
  100bb4:	83 7c 24 08 00       	cmpl   $0x0,0x8(%esp)
  100bb9:	0f 95 c0             	setne  %al
			negative = ' ';
		else
			negative = 0;
		if (numeric && precision > len)
			zeros = precision - len;
		else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
  100bbc:	8d 14 08             	lea    (%eax,%ecx,1),%edx
  100bbf:	3b 54 24 0c          	cmp    0xc(%esp),%edx
  100bc3:	7d 0e                	jge    100bd3 <console_vprintf+0x2c4>
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
  100bc5:	8b 54 24 0c          	mov    0xc(%esp),%edx
  100bc9:	29 ca                	sub    %ecx,%edx
  100bcb:	29 c2                	sub    %eax,%edx
  100bcd:	89 54 24 10          	mov    %edx,0x10(%esp)
			negative = ' ';
		else
			negative = 0;
		if (numeric && precision > len)
			zeros = precision - len;
		else if ((flags & (FLAG_ZERO | FLAG_LEFTJUSTIFY)) == FLAG_ZERO
  100bd1:	eb 08                	jmp    100bdb <console_vprintf+0x2cc>
  100bd3:	c7 44 24 10 00 00 00 	movl   $0x0,0x10(%esp)
  100bda:	00 
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
  100bdb:	8b 6c 24 0c          	mov    0xc(%esp),%ebp
  100bdf:	31 c0                	xor    %eax,%eax
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  100be1:	8b 4c 24 14          	mov    0x14(%esp),%ecx
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
  100be5:	2b 2c 24             	sub    (%esp),%ebp
  100be8:	83 7c 24 08 00       	cmpl   $0x0,0x8(%esp)
  100bed:	0f 95 c0             	setne  %al
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  100bf0:	83 e1 04             	and    $0x4,%ecx
			 && numeric && precision < 0
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
  100bf3:	29 c5                	sub    %eax,%ebp
  100bf5:	89 f0                	mov    %esi,%eax
  100bf7:	2b 6c 24 10          	sub    0x10(%esp),%ebp
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  100bfb:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  100bff:	eb 0f                	jmp    100c10 <console_vprintf+0x301>
			cursor = console_putc(cursor, ' ', color);
  100c01:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  100c05:	ba 20 00 00 00       	mov    $0x20,%edx
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  100c0a:	4d                   	dec    %ebp
			cursor = console_putc(cursor, ' ', color);
  100c0b:	e8 83 fc ff ff       	call   100893 <console_putc>
			 && len + !!negative < width)
			zeros = width - len - !!negative;
		else
			zeros = 0;
		width -= len + zeros + !!negative;
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
  100c10:	85 ed                	test   %ebp,%ebp
  100c12:	7e 07                	jle    100c1b <console_vprintf+0x30c>
  100c14:	83 7c 24 0c 00       	cmpl   $0x0,0xc(%esp)
  100c19:	74 e6                	je     100c01 <console_vprintf+0x2f2>
			cursor = console_putc(cursor, ' ', color);
		if (negative)
  100c1b:	83 7c 24 08 00       	cmpl   $0x0,0x8(%esp)
  100c20:	89 c6                	mov    %eax,%esi
  100c22:	74 23                	je     100c47 <console_vprintf+0x338>
			cursor = console_putc(cursor, negative, color);
  100c24:	0f b6 54 24 08       	movzbl 0x8(%esp),%edx
  100c29:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  100c2d:	e8 61 fc ff ff       	call   100893 <console_putc>
  100c32:	89 c6                	mov    %eax,%esi
  100c34:	eb 11                	jmp    100c47 <console_vprintf+0x338>
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
  100c36:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  100c3a:	ba 30 00 00 00       	mov    $0x30,%edx
		width -= len + zeros + !!negative;
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
			cursor = console_putc(cursor, ' ', color);
		if (negative)
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
  100c3f:	4e                   	dec    %esi
			cursor = console_putc(cursor, '0', color);
  100c40:	e8 4e fc ff ff       	call   100893 <console_putc>
  100c45:	eb 06                	jmp    100c4d <console_vprintf+0x33e>
  100c47:	89 f0                	mov    %esi,%eax
  100c49:	8b 74 24 10          	mov    0x10(%esp),%esi
		width -= len + zeros + !!negative;
		for (; !(flags & FLAG_LEFTJUSTIFY) && width > 0; --width)
			cursor = console_putc(cursor, ' ', color);
		if (negative)
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
  100c4d:	85 f6                	test   %esi,%esi
  100c4f:	7f e5                	jg     100c36 <console_vprintf+0x327>
  100c51:	8b 34 24             	mov    (%esp),%esi
  100c54:	eb 15                	jmp    100c6b <console_vprintf+0x35c>
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
			cursor = console_putc(cursor, *data, color);
  100c56:	8b 4c 24 04          	mov    0x4(%esp),%ecx
			cursor = console_putc(cursor, ' ', color);
		if (negative)
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
  100c5a:	4e                   	dec    %esi
			cursor = console_putc(cursor, *data, color);
  100c5b:	0f b6 11             	movzbl (%ecx),%edx
  100c5e:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  100c62:	e8 2c fc ff ff       	call   100893 <console_putc>
			cursor = console_putc(cursor, ' ', color);
		if (negative)
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
  100c67:	ff 44 24 04          	incl   0x4(%esp)
  100c6b:	85 f6                	test   %esi,%esi
  100c6d:	7f e7                	jg     100c56 <console_vprintf+0x347>
  100c6f:	eb 0f                	jmp    100c80 <console_vprintf+0x371>
			cursor = console_putc(cursor, *data, color);
		for (; width > 0; --width)
			cursor = console_putc(cursor, ' ', color);
  100c71:	8b 4c 24 50          	mov    0x50(%esp),%ecx
  100c75:	ba 20 00 00 00       	mov    $0x20,%edx
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
			cursor = console_putc(cursor, *data, color);
		for (; width > 0; --width)
  100c7a:	4d                   	dec    %ebp
			cursor = console_putc(cursor, ' ', color);
  100c7b:	e8 13 fc ff ff       	call   100893 <console_putc>
			cursor = console_putc(cursor, negative, color);
		for (; zeros > 0; --zeros)
			cursor = console_putc(cursor, '0', color);
		for (; len > 0; ++data, --len)
			cursor = console_putc(cursor, *data, color);
		for (; width > 0; --width)
  100c80:	85 ed                	test   %ebp,%ebp
  100c82:	7f ed                	jg     100c71 <console_vprintf+0x362>
  100c84:	89 c6                	mov    %eax,%esi
	int flags, width, zeros, precision, negative, numeric, len;
#define NUMBUFSIZ 20
	char numbuf[NUMBUFSIZ];
	char *data;

	for (; *format; ++format) {
  100c86:	47                   	inc    %edi
  100c87:	8a 17                	mov    (%edi),%dl
  100c89:	84 d2                	test   %dl,%dl
  100c8b:	0f 85 96 fc ff ff    	jne    100927 <console_vprintf+0x18>
			cursor = console_putc(cursor, ' ', color);
	done: ;
	}

	return cursor;
}
  100c91:	83 c4 38             	add    $0x38,%esp
  100c94:	89 f0                	mov    %esi,%eax
  100c96:	5b                   	pop    %ebx
  100c97:	5e                   	pop    %esi
  100c98:	5f                   	pop    %edi
  100c99:	5d                   	pop    %ebp
  100c9a:	c3                   	ret    
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
				++flagc;
			if (*flagc == '\0')
				break;
			flags |= (1 << (flagc - flag_chars));
  100c9b:	81 e9 54 0d 10 00    	sub    $0x100d54,%ecx
  100ca1:	b8 01 00 00 00       	mov    $0x1,%eax
  100ca6:	d3 e0                	shl    %cl,%eax
			continue;
		}

		// process flags
		flags = 0;
		for (++format; *format; ++format) {
  100ca8:	47                   	inc    %edi
			const char *flagc = flag_chars;
			while (*flagc != '\0' && *flagc != *format)
				++flagc;
			if (*flagc == '\0')
				break;
			flags |= (1 << (flagc - flag_chars));
  100ca9:	09 44 24 14          	or     %eax,0x14(%esp)
  100cad:	e9 aa fc ff ff       	jmp    10095c <console_vprintf+0x4d>

00100cb2 <console_printf>:
uint16_t *
console_printf(uint16_t *cursor, int color, const char *format, ...)
{
	va_list val;
	va_start(val, format);
	cursor = console_vprintf(cursor, color, format, val);
  100cb2:	8d 44 24 10          	lea    0x10(%esp),%eax
  100cb6:	50                   	push   %eax
  100cb7:	ff 74 24 10          	pushl  0x10(%esp)
  100cbb:	ff 74 24 10          	pushl  0x10(%esp)
  100cbf:	ff 74 24 10          	pushl  0x10(%esp)
  100cc3:	e8 47 fc ff ff       	call   10090f <console_vprintf>
  100cc8:	83 c4 10             	add    $0x10,%esp
	va_end(val);
	return cursor;
}
  100ccb:	c3                   	ret    

00100ccc <lock_init>:
#include "lock.h"

void
lock_init(lock_t *l) 
{
	l->lock = UNLOCKED;
  100ccc:	8b 44 24 04          	mov    0x4(%esp),%eax
  100cd0:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
}
  100cd6:	c3                   	ret    

00100cd7 <lock_acquire>:
		;
}
#else
void
lock_acquire(lock_t *l)
{
  100cd7:	8b 44 24 04          	mov    0x4(%esp),%eax
static inline uint32_t atomic_swap(uint32_t *addr, uint32_t val) __attribute__((always_inline));

static inline uint32_t
atomic_swap(uint32_t *addr, uint32_t val)
{
	asm volatile("xchgl %0, %1"
  100cdb:	ba 01 00 00 00       	mov    $0x1,%edx
  100ce0:	87 10                	xchg   %edx,(%eax)
    while ((int)atomic_swap(&l->lock, LOCKED) != UNLOCKED)
  100ce2:	85 d2                	test   %edx,%edx
  100ce4:	75 f5                	jne    100cdb <lock_acquire+0x4>
        ;
}
  100ce6:	c3                   	ret    

00100ce7 <lock_release>:
#endif
void
lock_release(lock_t *l)
{
	l->lock = UNLOCKED;
  100ce7:	8b 44 24 04          	mov    0x4(%esp),%eax
  100ceb:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
}
  100cf1:	c3                   	ret    
  100cf2:	90                   	nop
  100cf3:	90                   	nop

00100cf4 <get_random>:
static uint32_t m_z = 0x9876fedc;

uint32_t
get_random()
{
	m_z = 36969 * (m_z & 65535) + (m_z >> 16);
  100cf4:	8b 15 64 10 10 00    	mov    0x101064,%edx
  100cfa:	0f b7 c2             	movzwl %dx,%eax
  100cfd:	69 c0 69 90 00 00    	imul   $0x9069,%eax,%eax
  100d03:	c1 ea 10             	shr    $0x10,%edx
  100d06:	8d 14 10             	lea    (%eax,%edx,1),%edx
	m_w = 18000 * (m_w & 65535) + (m_w >> 16);
  100d09:	a1 68 10 10 00       	mov    0x101068,%eax
static uint32_t m_z = 0x9876fedc;

uint32_t
get_random()
{
	m_z = 36969 * (m_z & 65535) + (m_z >> 16);
  100d0e:	89 15 64 10 10 00    	mov    %edx,0x101064
	m_w = 18000 * (m_w & 65535) + (m_w >> 16);
  100d14:	c1 e2 10             	shl    $0x10,%edx
  100d17:	0f b7 c8             	movzwl %ax,%ecx
  100d1a:	69 c9 50 46 00 00    	imul   $0x4650,%ecx,%ecx
  100d20:	c1 e8 10             	shr    $0x10,%eax
  100d23:	8d 04 01             	lea    (%ecx,%eax,1),%eax
  100d26:	a3 68 10 10 00       	mov    %eax,0x101068
  100d2b:	8d 04 02             	lea    (%edx,%eax,1),%eax
	return (m_z << 16) + m_w;
}
  100d2e:	c3                   	ret    
