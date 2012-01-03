Description
===========
This project aims to implement a music compiler text-based musical composition inputs similar to 
[ABC notation](http://en.wikipedia.org/wiki/ABC_notation "ABC Notation").

In this project, I used [JFugue](http://www.jfugue.org/ "JFugue"), a famous java MIDI generation 
library, cross-translating a java file for JFugue input via Flex and GNU-Bison and then generate 
the output MIDI from it.

Build:

    $ make

Generate middle Java translation file (Score.java):

    $ ./music-compiler < [input-file]

Generate MIDI: 

    $ sh run.sh
    
Input File Structure
--------------------

    {
      [output-action]
      [notes]
    }
    
output-action (optional): three options: 1) save 2) save play 3) play save notes: notes in input 
form explained as in music-compiler-manual. 

Notes Structure
---------------

All notes (A, B, C, D, E, F, G, R) are defined as grammar rules like: 

    Note : A pitch chord octave duration
         | B pitch chord octave duration
         | C pitch chord octave duration
         | D pitch chord octave duration
         ...
         ..
         .
         
So, a note's structure followed by the rule: First comes the note, then pitch, then octave, then 
duration.

* Pitch: Basically about intonation. There are two pitches in my program; sharp (#) and flat (b).
* Chord: Basically about harmony. There are five chords in my program; major (maj), minor (min), 
  diminished (dim), augmented (aug) and sustained (sus).
* Octave: Basically about diapason. There are ten degrees of octave in my program (whose index 
  starts from 0 goes to 9). It must be a numerical value in the composition.
* Duration: The word explains itself:) It is about how long to play the note. There are seven 
  type of duration in my program; whole (w), half (h), quarter (q), eighth (i), sixteenth (s), 
  thirtysecond (t), sixty-fourth (x). 
  
A Sample Input would be:

    { 
      play save
      D5h E5h A5h Bb5h C#5h Rq A5q A5q Ab5h G5q G5q F#5h F5q 
      F5q E5q Eb5q D5q C#5q A3q D5q G5q F5h E5h D5h F5h 
      A5i G5i A5i D6i A5i F5i E5i F5i G5i A5i B5i C#6i D6i 
      F5i G5i A5i Bb5i E5i F5i G5i A5i G5i F5i E5i 
      F5i G5i A5i Bb5i C6i Bb5i A5i G5i A5i Bb5i C6i D6i 
      Eb6i C6i Bb5i A5i B5i C#6i D6i E6i F6i D6i C#6i B5i
      C#6i D6i E6i F6i G6i E6i A5i E6i D6i E6i F6i G6i 
      F6i E6i D6i C#6i D6q A5q F5q D5q
    }