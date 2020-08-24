// Silas Kidd Myers
// June 4, 2020
// q16Divide.s
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