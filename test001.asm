/*
 * This test verifies that basic instructions
 * (data transfers, addition/subtraction, jumps) work.
 */

	lc r100, 0x10000000 // test result output pointer
	lc r101, halt
	lc r102, failure
	lc r103, success
	
	
	lc r104, image// "global vairable"
	lc r105, kernel//"global vairable"
	
	//lc r106, image// "local variable" variable to update in the row and col moves
	//lc r110, kernel// "local variable" variable to update in the row and col moves
	
	lc r111, result_image
	
	lc r107, loop_col_kernel
	lc r108, loop_row_kernel
	lc r109, loop_col_image
	lc r112, loop_start_pos_of_kernel
	lc r113, check
	
	
	
	mov r6, 0 //Accumilator
	mov r7, 0 //counter for the column in image
	mov r8, 0 //counter for the row in image
	
	
	loop_start_pos_of_kernel:
	mov r106, r104
	mov r110, r105
	mov r4, 0 //counter for the column in kernal
	mov r5, 0 //counter for the row in kernel
	
	
	//test mac on row
	loop_col_kernel:
	lub r1, r106
	lub r2, r110
	and r1, r1, r2
	add r6, r6, r1
	add r4, r4, 1
	cjmpe r108, r4, 3
	add r106, r106, 1
	add r110, r110, 1
	jmp r107
	
	
	
	loop_row_kernel:
	mov r4, 0
	add r106, r106, 5
	add r110, r110, 1
	add r5, r5, 1
	cjmpe r109, r5, 3
	jmp r107
	
	//save results in resilt_image
	loop_col_image:
	sb r111, r6
	add r111, r111, 1
	add r104, r104, 1
	//lc r105, kernel
	mov r6, 0
	add r7, r7, 1
	cjmpne r112, r7, 5
	
	
	loop_row_image:
	mov r7, 0
	add r104, r104, 2
	add r8, r8, 1
	cjmpne r112, r8, 5
	
	
	


	check:
	lc r150, result_image
	lub r151, r150
	cjmpne r102, r151, 4
	add r150, r150,1
	lub r151, r150
	cjmpne r102, r151, 5
	add r150, r150,1
	lub r151, r150
	cjmpne r102, r151, 4
	add r150, r150,1
	lub r151, r150
	cjmpne r102, r151, 4
	add r150, r150,1
	lub r151, r150
	cjmpne r102, r151, 3
	
	//secnd row results
	add r150, r150,1
	lub r151, r150
	cjmpne r102, r151, 6
	add r150, r150,1
	lub r151, r150
	cjmpne r102, r151, 8
	add r150, r150,1
	lub r151, r150
	cjmpne r102, r151, 6
	add r150, r150,1
	lub r151, r150
	cjmpne r102, r151, 5
	add r150, r150,1
	lub r151, r150
	cjmpne r102, r151, 3
	
	//thrd row
	add r150, r150,1
	lub r151, r150
	cjmpne r102, r151, 4
	add r150, r150,1
	lub r151, r150
	cjmpne r102, r151, 7
	add r150, r150,1
	lub r151, r150
	cjmpne r102, r151, 6
	add r150, r150,1
	lub r151, r150
	cjmpne r102, r151, 6
	add r150, r150,1
	lub r151, r150
	cjmpne r102, r151, 3
	
	
	//frth row
	add r150, r150,1
	lub r151, r150
	cjmpne r102, r151, 4
	add r150, r150,1
	lub r151, r150
	cjmpne r102, r151, 7
	add r150, r150,1
	lub r151, r150
	cjmpne r102, r151, 6
	add r150, r150,1
	lub r151, r150
	cjmpne r102, r151, 6
	add r150, r150,1
	lub r151, r150
	cjmpne r102, r151, 3
	
	
	//fifth and last row
	add r150, r150,1
	lub r151, r150
	cjmpne r102, r151, 2
	add r150, r150,1
	lub r151, r150
	cjmpne r102, r151, 4
	add r150, r150,1
	lub r151, r150
	cjmpne r102, r151, 4
	add r150, r150,1
	lub r151, r150
	cjmpne r102, r151, 5
	add r150, r150,1
	lub r151, r150
	cjmpne r102, r151, 3
	jmp r103

	
	
	
//5*5
image:
	//first row
	.byte 0x00
	.byte 0x00
	.byte 0x00
	.byte 0x00
	.byte 0x00
	.byte 0x00
	.byte 0x00
	//scnd row
	.byte 0x00
	.byte 0x01 
	.byte 0x01
	.byte 0x00
	.byte 0x01
	.byte 0x01
	.byte 0x00
	//thrd row
	.byte 0x00
	.byte 0x01
	.byte 0x01
	.byte 0x01
	.byte 0x00
	.byte 0x01
	.byte 0x00
	//frth row
	.byte 0x00
	.byte 0x01
	.byte 0x01
	.byte 0x01
	.byte 0x00
	.byte 0x00
	.byte 0x00
	//fifth row
	.byte 0x00
	.byte 0x00
	.byte 0x00
	.byte 0x01
	.byte 0x01
	.byte 0x01
	.byte 0x00
	//sixth row
	.byte 0x00
	.byte 0x01
	.byte 0x01
	.byte 0x01
	.byte 0x00
	.byte 0x01
	.byte 0x00
	//sventh row
	.byte 0x00
	.byte 0x00
	.byte 0x00
	.byte 0x00
	.byte 0x00
	.byte 0x00
	.byte 0x00
	
	
kernel:
	//first row
	.byte 0x01
	.byte 0x01
	.byte 0x01
	//sec row
	.byte 0x01
	.byte 0x01
	.byte 0x01
	//thrd row
	.byte 0x01 
	.byte 0x01
	.byte 0x01
	
	
result_image:
	//first row
	.byte 0x00
	.byte 0x00
	.byte 0x00
	.byte 0x00
	.byte 0x00
	//scnd row
	.byte 0x00
	.byte 0x00
	.byte 0x00
	.byte 0x00
	.byte 0x00
	//third row
	.byte 0x00
	.byte 0x00
	.byte 0x00
	.byte 0x00
	.byte 0x00
	//forth row
	.byte 0x00
	.byte 0x00
	.byte 0x00
	.byte 0x00
	.byte 0x00
	//fifth row
	.byte 0x00
	.byte 0x00
	.byte 0x00
	.byte 0x00
	.byte 0x00

	
	
failure:
	sw r100, 2
success:
	sw r100, 1
	
halt:
	hlt
	jmp r101



