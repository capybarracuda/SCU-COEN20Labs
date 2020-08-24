//Silas Kidd Myers
//Lab 5: Multiplication
//30 April 2020
        .syntax		unified
        .cpu		cortex-m4
        .text

        //int32_t MxPlusB(int32_t x, int32_t mtop, int32_t mbtm, int32_t b);
        .global		MxPlusB
        .thumb_func
    MxPlusB:
        //return (mtop + rounding)/(mbtm) * x + b
        //rounding =  (((( (mtop * x * mbtm) >> 31) * mbtm) << 1) + mbtm) / 2 ;
        PUSH    {R4, R5}

		
		//calculate rounding
		MUL		R0, R0, R1//multiply x by mtop to get dividend
		MOV 	R4, R0 //copy dividend
		MUL 	R0, R2, R4//multiply dividend by mbtm
		LDR		R5, =31//prepare for asr
		ASR 	R0, R0, R5//shift right  by 31
		MUL 	R0, R0, R2// multiply by mbtm
		LDR		R5, =1//prepare for lsl
		LSL		R0, R0, R5//shift left once
		ADD		R0, R0, R2//add mbtm
		LDR 	R5, =2//prepare for division
		SDIV	R0, R0, R5//r0 is now rounding

		//calculate quotient
		ADD		R0, R0, R4// add rounding and dividend
		SDIV	R0, R0, R2//(rounding + dividend) / divisor

		//add b
		ADD 	R0, R0, R3//add b
		POP 	{R4, R5}
		BX LR
        .end
