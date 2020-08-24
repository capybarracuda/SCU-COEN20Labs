// Vineet Joshi
// November 3, 2019
// cube.s
// This is my starter code for Lab5a of COEN 20.

		.syntax		unified
		.cpu		cortex-m4
		.text
		
		.global		MatrixMultiply
		.thumb_func
	// void MatrixMultiply(int32_t a[3][3], int32_t b[3][3], int32_t c[3][3]);
	MatrixMultiply:
		// TODO: Write your Assembly code for the 'MatrixMultiply' function.
		PUSH	{R3,R4,R5,R6,R7,R8,R9,R10,R11,LR}
		mov		r3,0//r3 is iterator for row
		row_loop:
			cmp		R3,2//i<2
			bgt 	end_row
			mov 	R4,0//r4 is iterator for col, reinitialize every runthrough of row
			col_loop:
				cmp 	R4,2//j<2
				bgt		end_col
				mov 	R5,0//r5 is iterator for k

				//address of A[row][column] = row*(numcollumns) + collumn
				ldr		R11,=3//numcolumns
				mul 	R7,R3,R11//multiply  row and column together
				add		R7, R7, R4//add collumn index to address
								
				ldr		R6,=0//prepare to store 0
				str 	R6,[R0,R7,lsl 2]//set A[row][collumn] to 0
				//no longer using r6 in this context
				k_loop:
					cmp		R5,2//k<3
					bgt 	end_k
					
					//prepare r0,r1,r2 for mult and add
					mov		R6,R0//copy r0, still need it
					mov		R9,R1//copy r1, still need it
					mov		R8,R2//copy r2, still need it

					//need to retrieve value of A[row][column], B[row][k], C[k][col]
					ldr		R0,[R0,R7, lsl 2]//r0 = A[row[column]]

					mul		R7,R3,R11//multiply row*numcolumn
					add		R7,R7,R5//add column index to address
					ldr		R1,[R1,R7, lsl 2]
					
					mul 	R7,R5,R11//load k*numcolumn
					add		R7,R7,R4//add column index
					ldr 	R2,[R2,R7, lsl 2]

					bl		MultAndAdd//run multandadd

					mul 	R7,R3,R11//multiply  row and numcolumn together
					add		R7, R7, R4//add collumn index to address
					
					mov		R10,R0//save function return
					mov		R0,R6//move all the matrices back
					mov		R1,R9
					mov		R2,R8

					str 	R10,[R0,R7, lsl 2]//copy result of mult and add to A

					add 	R5,R5,1//increment iterator
					b 		k_loop
				end_k:
				add 	R4,R4,1//increment iterator
				b		col_loop
			end_col:
			add 	R3, R3, 1//increment iterator
			b		row_loop
		end_row:
		POP		{R3,R4,R5,R6,R7,R8,R9,R10,R11,PC}
		.end
