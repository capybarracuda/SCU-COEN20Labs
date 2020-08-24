// Vineet Joshi
// October 3, 2019
// functions.s
// This is my starter code for Lab2a of COEN 20.

		.syntax		unified
		.cpu		cortex-m4
		.text
	
	// int32_t Add(int32_t a, int32_t b);
		.global		Add
		.thumb_func
	Add:
		// TODO: Write your Assembly code for the 'Add' function.
		PUSH {R4, R5, LR}
		MOV R4, R1 
		R0 = a
		MOV R5,R0
		MOV R0,R4
		ADD R0,R0,R5 
		POP {R4,R5,PC}

	// int32_t Less1(int32_t a);
		.global		Less1
		.thumb_func
	Less1:
		// TODO: Write your Assembly code for the 'Less1' function.
		PUSH {R4, LR}
		MOV R4,R0
		SUB R0,R4,1
		POP {R4,PC}
	// int32_t Square2x(int32_t x);
		.global		Square2x
		.thumb_func
	Square2x:
		// TODO: Write your Assembly code for the 'Square2x' function.
		PUSH {R4, LR}
		ADD R0,R0,R0
		BL Square 
		POP {R4,PC}
	// int32_t Last(int32_t x);
		.global		Last
		.thumb_func
	Last:
		// TODO: Write your Assembly code for the 'Last' function.
		PUSH {R4, LR}
		MOV R4, R0 
		BL SquareRoot
		ADD R0, R0, R4
		POP {R4,PC}
		.end
