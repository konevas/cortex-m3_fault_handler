/**
 * @brief Fault handler
 * 
 * @author Konev A.S.
 */

	SECTION .text:CODE(2)
	THUMB

	; Should be used in vector table as fault handlers entry
	; void(void)
	PUBWEAK fault_handler_entry

	; Will be called after stack frame retrieving
	; void(int * stack_ptr, int handler_index)
	PUBWEAK fault_common_handler


fault_handler_entry
	; Stack frame pointer to r0
	tst lr, #4
	ite ne
	mrsne r0, psp
	mrseq r0, msp

	; Vector index to r1
	mov r2, #0xED04 ;ICSR high
	movt r2, #0xE000 ;ICSR low
	ldr r1, [r2]
	mov r2, #0x01FF
	and r1, r1, r2

	bl fault_common_handler

	; Looping forever in case of exit from fault_handler
	infinite_loop: b infinite_loop


fault_common_handler
	; stub


	END
