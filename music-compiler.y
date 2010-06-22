/* 
 =============================================================================
 * Program Name 	: music-compiler.y
 * Author		: #B96902133, Hakki Caner Kirmizi
 * Date			: 20100616
 * Description		: A parser implementation with semantic actions within for
 * 					music-compiler project.
 * Environment		: Windows-7 Entreprise
 * Editor		: vim 7.2 for WIN 
 * Integration Tests	: linux2.csie.ntu.edu.tw
 * Flex			: 2.5.35
 * Bison		: bison (GNU Bison) 2.4.1
 * Compiler		: gcc (Debian 4.4.4-5) 4.4.4
 * Version Control	: TortoiseSVN 1.6.8, Build 19260 - 32 Bit
 * Project Hosting	: http://code.google.com/p/music-compiler/
 *
 =============================================================================
 */

	/* ----- DEFINITIONS PART ----- */
	/* ============================ */
%{
	#include <stdio.h>
	#include <stdlib.h>
	#include <unistd.h>
	#include "gen_note.h"
	
	extern int yyparse();
	FILE* outfp;
	int only_save = 0;
	int play_then_save = 0;
	int save_then_play = 0;
	
%}

/* Data types used for tokens */
/* -------------------------- */
%union {
	char *act;
	char *note;
	char *pitch;
	char *chord;
	char *octave;
	char *dur;  /* duration */
}

/* Tokens coming from notation-scanner.l */
/* ---------------------------- */

%start score

%token <act> PLAY
%token <act> SAVE 

%token <note> A 
%token <note> B
%token <note> C
%token <note> D
%token <note> E
%token <note> F
%token <note> G
%token <note> R

%token <pitch> SRP
%token <pitch> FLT

%token <chord> MAJ
%token <chord> MNR
%token <chord> DIM
%token <chord> AUG
%token <chord> SUS

%token <octave> NO

%token <dur> w
%token <dur> h
%token <dur> q
%token <dur> i
%token <dur> s
%token <dur> t
%token <dur> x



%%	/* ----- GRAMMAR RULES PART ----- */
	/* ============================== */

score		: scoreBlock
			;
			
scoreBlock	: '{' outputAction noteStream '}'
			;

outputAction: /* lambda */ { }
			| SAVE { only_save = 1; }
			| SAVE PLAY { save_then_play = 1; }
			| PLAY SAVE { play_then_save = 1; }
			;

noteStream	: /*lambda */
			| note noteStream
			;

note		: A { add_note(outfp, A_NOTE); } pitch chord octave duration
			| B { add_note(outfp, B_NOTE); } pitch chord octave duration
			| C { add_note(outfp, C_NOTE); } pitch chord octave duration
			| D { add_note(outfp, D_NOTE); } pitch chord octave duration
			| E { add_note(outfp, E_NOTE); } pitch chord octave duration
			| F { add_note(outfp, F_NOTE); } pitch chord octave duration
			| G { add_note(outfp, G_NOTE); } pitch chord octave duration
			| R { add_note(outfp, R_NOTE); } pitch chord octave duration
			;
			
pitch		: /* lambda */
			| SRP { add_pitch(outfp, SHARP); } 
			| FLT { add_pitch(outfp, FLAT); }
			;

chord		: /* lambda */
			| MAJ { add_chord(outfp, MAJOR); }
			| MNR { add_chord(outfp, MINOR); }
			| DIM { add_chord(outfp, DIMINISHED); }
			| AUG { add_chord(outfp, AUGMENTED); }
			| SUS { add_chord(outfp, SUSTAINED); }
			;

octave		: /*lambda */
			| NO { add_octave(outfp, $1); }
			;

duration 	: /* lambda */ { add_duration(outfp, EMPTY); }
		 	| w { add_duration(outfp, DUR_WHOLE); }
		 	| h { add_duration(outfp, DUR_HALF); }
		 	| q { add_duration(outfp, DUR_QUARTER); }
		 	| i { add_duration(outfp, DUR_8TH); }
		 	| s { add_duration(outfp, DUR_16TH); }
		 	| t { add_duration(outfp, DUR_32ND); }
		 	| x { add_duration(outfp, DUR_64TH); }
		 	;
		 			
	
%%	/* ----- USER SUBROUTINES PART ----- */
	/* ================================= */


#include "lex.yy.c"

yyerror(const char *msg)
{
	printf("Fail (around line %d)\n", yylineno);
}

main()
{
	int ret = -1;
	int exec_ret = -1;
	char import[] = "import org.jfugue.*;\nimport java.io.*;\n\n";
	char class[] = "public class Score {\n";
	char main[] = "public static void main(String[] args) {\n";
	char new[] = "Player player = new Player();\nPattern pattern = new Pattern(\"";
	char only_play[] = "\");\nplayer.play(pattern);\n";
	char only_save[] = "\");\ntry {\nplayer.saveMidi(pattern, new File(\"Score.mid\"));\n} catch (IOException e) {\ne.printStackTrace();\n}";
	char play[] = "\nplayer.play(pattern);\n";
	char save[] = "\ntry {\nplayer.saveMidi(pattern, new File(\"Score.mid\"));\n} catch (IOException e) {\ne.printStackTrace();\n}";
	char exit[] = "System.exit(0);\n}\n}\n";
	
	outfp = fopen("Score.java", "w");
	fprintf(outfp, import);
	fprintf(outfp, class);
	fprintf(outfp, main);
	fprintf(outfp, new);
	
	ret = yyparse();
	if (ret == 0) {
		puts("Pass");
	}
	
	if (only_save == 1) {
		fprintf(outfp, only_save);
	} else if (save_then_play == 1) {
		fprintf(outfp, only_save);
		fprintf(outfp, play);
	} else if (play_then_save == 1) {
		fprintf(outfp, only_play);
		fprintf(outfp, save);
	} else {
		fprintf(outfp, only_save);
	}
	
	fprintf(outfp, exit);
	fclose(outfp);
	
	return 0;
}
