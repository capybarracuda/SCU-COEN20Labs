// Silas Kidd Myers
// May 21, 2020
// zeller.s
// This is my starter code for Lab7a of COEN 20.

		.syntax		unified
		.cpu		cortex-m4
		.text
		
		.global		Zeller1
		.thumb_func
	// uint32_t Zeller1(uint32_t k, uint32_t m, uint32_t D, uint32_t C);
	// This function can use multiply and divide instructions.
	Zeller1:
		// TODO: Write your Assembly code for the 'Zeller1' function.
		PUSH 	{R4,R5}

		LDR 	R4, =13
		MUL 	R4, R4, R1 //R4 = 13 * m
		SUB 	R4, R4, 1 //R4 = R4 - 1
		LDR 	R5, =5
		UDIV 	R4, R4, R5 //R4 = R4 / 5
		ADD 	R0, R0, R4 //R0 = k + R4
		ADD 	R0, R0, R2 //R0 = R0 + D
		LDR 	R4, =4
		UDIV 	R4, R2, R4 //R4 = D / 4
		ADD 	R0, R0, R4 //R0 = R0 + R4
		LDR 	R4, =4
		UDIV	 R4, R3, R4 //R4 = C / 4
		ADD 	R0, R0, R4 //R0 = R0 + R4
		LDR 	R4, =2
		MUL 	R4, R4, R3 //R4 = 2 * C
		SUB 	R0, R0, R4 //R0 = R0 - R4

		LDR 	R5, =7
		SDIV 	R4, R0, R5 //Zeller # / 7 -> R4
		MULS	R4, R4, R5 //multiply number again -> r4
		SUB 	R0, R0, R4 //difference between R0 and R4 is R0 % 7

		CMP 	R0, 0
		IT 		LT
		ADDLT 	R0, R0, 7 //if(R0 < 0): R0 = R0 + 7
		POP 	{R4,R5}
		BX 		LR

		.global		Zeller2
		.thumb_func
	// uint32_t Zeller2(uint32_t k, uint32_t m, uint32_t D, uint32_t C);
	// This function CANNOT use divide instructions (SDIV or UDIV).
	Zeller2:
		// TODO: Write your Assembly code for the 'Zeller2' function.
		PUSH 	{R4,R5}

		LDR 	R4, =13
		MUL 	R4, R4, R1 //R4 = 13 * m
		SUB 	R4, R4, 1 //R4 = R4 - 1

		LDR 	R5,=858993459 //R5 = 2^32 / 5
		SMMUL 	R4,R4,R5//divides r4 by 5

		ADD		R0, R0, R4 //R0 = k + R4
		ADD 	R0, R0, R2 //R0 = R0 + D
		
		LDR 	R4, =1073741824 //R4 = 2^32 / 4
		SMMUL 	R4, R2, R4 //divides r2 by 4

		ADD 	R0, R0, R4 //R0 = R0 + R4

		LDR 	R4, =1073741824 //R4 = 2^32 / 4
		SMMUL 	R4, R3, R4 //divides r3 by 4
		
		ADD 	R0, R0, R4 //R0 = R0 + R4
		LDR 	R4, =2
		MUL 	R4, R4, R3 //R4 = 2 * C
		SUB 	R0, R0, R4 //R0 = R0 + R4

		LDR		R5,=613566756 //R5 = 2^32 / 7
		SMMUL 	R4,R0,R5 //divides r0 by 7

		LDR 	R5, =7
		MULS 	R4, R4, R5 //multiplies back using last formula for modulus
		SUB 	R0, R0, R4 //R0 = R0 % 7

		CMP 	R0, 0
		IT 		LT
		ADDLT 	R0, R0, 7 //if(R0 < 0): R0 = R0 + 7
		POP 	{R4,R5}
		BX 		LR

		.global		Zeller3
		.thumb_func
	// uint32_t Zeller3(uint32_t k, uint32_t m, uint32_t D, uint32_t C);
	// This function CANNOT use multiply instructions (MUL, MLS, etc.).
	Zeller3:
		// TODO: Write your Assembly code for the 'Zeller3' function.
		PUSH	{R4,R5}

		LSL 	R4, R1, 4 //multiply m by 2^4 into r4
		SUB 	R4,R4, R1, LSL 1 //m*16-m*2
		SUB 	R4,R4, R1 //14*m-m = 13*m

		SUB 	R4, R4, 1 //R4 = R4 - 1
		LDR 	R5, =5
		UDIV 	R4, R4, R5 //R4 = R4 / 5
		ADD 	R0, R0, R4 //R0 = k + R4
		ADD 	R0, R0, R2 //R0 = R0 + D
		LDR 	R4, =4
		UDIV 	R4, R2, R4 //R4 = D / 4
		ADD 	R0, R0, R4 //R0 = R0 + R4
		LDR 	R4, =4
		UDIV 	R4, R3, R4 //R4 = C / 4
		ADD 	R0, R0, R4 //R0 = R0 + R4

		LSL 	R4, R3, 1 //R4 = 2 * C

		SUB 	R0, R0, R4 //R0 = R0 + R4

		LDR 	R5, =7
		SDIV 	R4, R0, R5

		RSB 	R4, R4, R4, LSL 3 //R4 = R4 * 8 - R4

		SUB 	R0, R0, R4 //R0 = R0 % 7

		CMP 	R0, 0
		IT 		LT
		ADDLT 	R0, R0, 7 //if(R0 < 0): R0 = R0 + 7
		POP 	{R4,R5}
		BX 		LR
	.end
