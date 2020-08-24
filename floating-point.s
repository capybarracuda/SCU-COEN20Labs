// Vineet Joshi
// November 26, 2019
// floating-point.s
// This is my starter code for Lab7a of COEN 20.

		.syntax		unified
		.cpu		cortex-m4
		.text
		
		.global		Discriminant
		.thumb_func
	// float Discriminant(float a, float b, float c);
	Discriminant:
		// TODO: Write your Assembly code for the 'Discriminant' function.
		VMUL.F32	S3, S1, S1// s3 = b^2
		VMOV		S4, 4// s4 = 4
		VMUL.F32	S4, S4, S0// s4 = 4*a
		VMUL.F32	S4, S4, S2//s4 = 4*a*c
		VSUB.F32 	S0, S3, S4//s0 = b^2 - 4*a*c
		BX 			LR
		
		.global		Quadratic
		.thumb_func
	// float Quadratic(float x, float a, float b, float c);
	Quadratic:
		// TODO: Write your Assembly code for the 'Quadratic' function.
		VMUL.F32	S4, S0, S0//x^2
		VMUL.F32	S1, S1, S4//a*x^2
		VMUL.F32	S0, S0, S2//b*x

		VADD.F32 	S0, S0, S1//b*x + a*x^2
		VADD.F32	S0, S0, S3//ax^2 + bx + c
		BX 			LR

		
		.global		Root1
		.thumb_func
	// float Root1(float a, float b, float c);
	Root1:
		// TODO: Write your Assembly code for the 'Root1' function.
		VPUSH 		{S16, S17}
		VNEG.F32	S17, S1//obtain -b
		VMOV 		S16, S0 // save a
		BL 			Discriminant// S0 = discriminant
		VSQRT.F32 	S0, S0// sqrt(disc)
		VADD.F32	S0, S17, S0// -b + sqrt(disc)

		VMOV 		S5, 2//s5=2
		VMUL.F32 	S4, S16, S5//a*2

		VDIV.F32 	S0, S0, S16// (-b + sqrt(disc))/ 2a
		VPOP 		{S16, S17}
		BX 			LR		


		.global		Root2
		.thumb_func
	// float Root2(float a, float b, float c);
	Root2:
		// TODO: Write your Assembly code for the 'Root2' function.
		VPUSH 		{S16, S17}
		VNEG.F32	S17, S1//obtain -b
		VMOV 		S16, S0 // save a
		BL 			Discriminant// S0 = discriminant
		VSQRT.F32 	S0, S0// sqrt(disc)
		VSUB.F32	S0, S17, S0// -b - sqrt(disc)

		VMOV 		S5, 2//s5=2
		VMUL.F32 	S4, S16, S5//a*2

		VDIV.F32	S0, S16, S4// (-b - sqrt(disc))/ 2a
		VPOP 		{S16, S17}
		BX 			LR		
		.end
