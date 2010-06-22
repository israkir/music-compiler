/* 
 =================================================================================
 * Program Name 	: notation-scanner.l
 * Author		: #B96902133, Hakki Caner Kirmizi
 * Date			: 20100613
 * Description		: A notation scanner for music-compiler program.
 * Environment		: Windows-7 Entreprise
 * Editor		: vim 7.2 for WIN 
 * Integration Tests	: linux2.csie.ntu.edu.tw
 * Flex			: 2.5.35
 * Bison		: bison (GNU Bison) 2.4.1
 * Compiler		: gcc (Debian 4.4.4-5) 4.4.4
 * Version Control	: TortoiseSVN 1.6.8, Build 19260 - 32 Bit
 * Project Hosting	: http://code.google.com/p/music-compiler/
 *
 =================================================================================
 */
%{
	#include "music-compiler.tab.h"
%}
 
	/* Grab yylineno in order to output syntax error(s) in parsing stage */
%option yylineno noyywrap
  
	/* ----- DEFINITIONS PART ----- */

	/* DEFINITIONS FOR FINITE AUTOMATA */
	/* ------------------------------- */


	/* DELIMITER: any occurence of 'space', 'tab' or 'newline' */
DELIMITER		[ \t\n]

	/* DIGIT: any digit from 0 to 9 */
DIGIT			[0-9]

	/* COMMENT: any c style comment */
COMMENT			("/*"([^*]|[\r\n]|(\*+([^*/]|[\r\n])))*"*"+"/")|("//".*)



%%	/* ----- RULES PART ----- */

	/* rules for output action */

"play"			{ yylval.act = strdup(yytext); return PLAY; }
"save"			{ yylval.act = strdup(yytext); return SAVE; }

	/* rules for notes */
"A"				{ yylval.note = strdup(yytext); return A; }
"B"				{ yylval.note = strdup(yytext); return B; }
"C"				{ yylval.note = strdup(yytext); return C; }
"D"				{ yylval.note = strdup(yytext); return D; }
"E"				{ yylval.note = strdup(yytext); return E; }
"F"				{ yylval.note = strdup(yytext); return F; }
"G"				{ yylval.note = strdup(yytext); return G; }
"R"				{ yylval.note = strdup(yytext); return R; }

"#"				{ yylval.pitch = strdup(yytext); return SRP; }
"b"				{ yylval.pitch = strdup(yytext); return FLT; }

	/* rules for chords */
"maj"			{ yylval.chord = strdup(yytext); return MAJ; }
"min"			{ yylval.chord = strdup(yytext); return MNR; }
"dim"			{ yylval.chord = strdup(yytext); return DIM; }
"aug"			{ yylval.chord = strdup(yytext); return AUG; }
"sus"			{ yylval.chord = strdup(yytext); return SUS; }

	/* rule for octave */
{DIGIT}			{ yylval.octave = strdup(yytext); return NO; }

	/* rules for duration signs */
"w"				{ yylval.dur = strdup(yytext); return w; }
"h"				{ yylval.dur = strdup(yytext); return h; }
"q"				{ yylval.dur = strdup(yytext); return q; }
"i"				{ yylval.dur = strdup(yytext); return i; }
"s"				{ yylval.dur = strdup(yytext); return s; }
"t"				{ yylval.dur = strdup(yytext); return t; }
"x"				{ yylval.dur = strdup(yytext); return x; }

	/* ignore any kind of white space; i.e. no 'action'! */
{DELIMITER}+

	/* ignore any kind of comments; i.e. no 'action'! */
{COMMENT}
	
	/* new line */
\n|.	 		{ return yytext[0]; }



%%	/* ----- USER CODE PART ----- */
