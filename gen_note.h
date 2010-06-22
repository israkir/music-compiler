enum note_ops {
	A_NOTE=0, B_NOTE, C_NOTE, D_NOTE, E_NOTE, F_NOTE, G_NOTE, R_NOTE
};

enum pitch_ops {
	SHARP=0, FLAT
};

enum chord_ops {
	MAJOR=0, MINOR, DIMINISHED, AUGMENTED, SUSTAINED
};

enum dur_ops {
	EMPTY=0, DUR_WHOLE, DUR_HALF, DUR_QUARTER, 
	DUR_8TH, DUR_16TH, DUR_32ND, DUR_64TH, DUR_1_128TH
};
	
char *note_name[] = { "A", "B", "C", "D", "E", "F", "G", "R" };

char *pitch_name[] = { "#", "b" };

char *chord_name[] = { "maj", "min", "dim" "aug", "sus" };

char *dur_name[] = { " ", "w", "h", "q" "i", "s", "t", "x", "n" };
							 

void add_note(FILE* outfp, enum note_ops op) {
	switch(op) {
		case A_NOTE:
		fprintf(outfp, "%s", note_name[op]);
		break;
		case B_NOTE:
		fprintf(outfp, "%s", note_name[op]);
		break;
		case C_NOTE:
		fprintf(outfp, "%s", note_name[op]);
		break;
		case D_NOTE:
		fprintf(outfp, "%s", note_name[op]);
		break;
		case E_NOTE:
		fprintf(outfp, "%s", note_name[op]);
		break;
		case F_NOTE:
		fprintf(outfp, "%s", note_name[op]);
		break;
		case G_NOTE:
		fprintf(outfp, "%s", note_name[op]);
		break;
		case R_NOTE:
		fprintf(outfp, "%s", note_name[op]);
		break;
	}
}

void add_pitch(FILE* outfp, enum pitch_ops op) {
	switch(op) {
		case SHARP:
		fprintf(outfp, "%s", pitch_name[op]);
		break;
		case FLAT:
		fprintf(outfp, "%s", pitch_name[op]);
		break;
	}
}

void add_octave(FILE* outfp, char *no) {
	fprintf(outfp, "%s", no);
}

void add_chord(FILE* outfp, enum chord_ops op) {
	switch(op) {
		case MAJOR:
		fprintf(outfp, "%s", chord_name[op]);
		break;
		case MINOR:
		fprintf(outfp, "%s", chord_name[op]);
		break;
		case DIMINISHED:
		fprintf(outfp, "%s", chord_name[op]);
		break;
		case AUGMENTED:
		fprintf(outfp, "%s", chord_name[op]);
		break;
		case SUSTAINED:
		fprintf(outfp, "%s", chord_name[op]);
		break;
	}
}

void add_duration(FILE* outfp, enum dur_ops op) {
	switch(op) {
		case EMPTY:
		fprintf(outfp, " ", dur_name[op]);
		break;
		case DUR_WHOLE:
		fprintf(outfp, "%s ", dur_name[op]);
		break;
		case DUR_HALF:
		fprintf(outfp, "%s ", dur_name[op]);
		break;
		case DUR_QUARTER:
		fprintf(outfp, "%s ", dur_name[op]);
		break;
		case DUR_8TH:
		fprintf(outfp, "%s ", dur_name[op]);
		break;
		case DUR_16TH:
		fprintf(outfp, "%s ", dur_name[op]);
		break;
		case DUR_32ND:
		fprintf(outfp, "%s ", dur_name[op]);
		break;
		case DUR_64TH:
		fprintf(outfp, "%s ", dur_name[op]);
		break;
	}
}

void change_instrument(FILE* outfp, char *inst) {
	if (inst != "blank")
		fprintf(outfp, " I[%s] ", inst);
}
