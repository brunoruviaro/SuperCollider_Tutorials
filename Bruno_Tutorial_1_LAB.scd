// **********************************************
// DAY 1 LAB - CCRMA SUPERCOLLIDER WORKSHOP 2012
// **********************************************

// LAB EXERCISE 1
// Analyze the Pbind below. Find out:
// a) The exact frequencies being played (rounded to one decimal only);
// b) The closest integer MIDI note of these frequencies.
// Hint: look for MIDI in the SimpleNumbers help file.

(
 Pbind(
  \freq, Pseq(([ 1/1, 3/2, 4/3, 9/8, 16/9, 5/4, 8/5 ] * 440) + 10, 1),
  \dur, Prand([0.2, 0.4, 0.3], inf)
 ).play
)

/*
Pbind above and some examples borrowed from Charles Céleste Hutchins:
http://sc3howto.blogspot.com/2010/06/pbinds.html
*/


// LAB EXERCISE 2
/*
Take the Pbind from Exercise #1. Modify it in the following way:
a) Add an offset to each frequency, randomly chosen between 10 and 20 Hz each time
b) Durations:
[0.2, 0.4] played twice
[0.3, 0.3, 0.6] played once
...and repeat the whole thing 3 times.

*/


// LAB EXERCISE 3
// Copy once more the original Pbind from Exercise #1.
// Make it play a bass line with the following durations:
// [1/2, 1/2, 1/2, 1/2, 3/4, 3/4, 1/2]
// Then, changing only one value, make it play twice as fast.
// Finally, using the \sustain key, make it staccato (i.e., sustain values shorter than duration).


// LAB EXERCISE 4
// Listen to the audio file Day_1_LAB_Exercise_4.flac.
// Your goal is to create a Pattern that sounds like that.
// Use your solution to Exercise 3 as point of departure.

// http://ccrma.stanford.edu/~ruviaro/temp/Day_1_LAB_Exercise_4.flac
















// Scroll down to see the solutions.















////////////////////////////////////////////////////////////////////////////
// LAB EXERCISE 1 SOLUTION
// Frequencies:
Pseq(([ 1/1, 3/2, 4/3, 9/8, 16/9, 5/4, 8/5 ] * 440) + 10, 1).asStream.all.round(0.1);
// MIDI notes:
Pseq(([ 1/1, 3/2, 4/3, 9/8, 16/9, 5/4, 8/5 ] * 440) + 10, 1).asStream.all.cpsmidi.round;


////////////////////////////////////////////////////////////////////////////
// LAB EXERCISE 2 SOLUTION
(
 Pbind(
  \freq,  Pseq([ 1/1, 3/2, 4/3, 9/8, 16/9, 5/4, 8/5 ] * 440, inf) + Pwhite(10,20,inf),
  \dur,  Pseq([Pseq([0.2, 0.4], 2), Pseq([0.3, 0.3, 0.6], 1)], 3)
 ).play
)

////////////////////////////////////////////////////////////////////////////
// LAB EXERCISE 3 SOLUTION
(
 Pbind(
  \freq,  Pseq([ 1/1, 3/2, 4/3, 9/8, 16/9, 5/4, 8/5 ] * 40 , inf),
  \dur,  Pseq( [1/2, 1/2, 1/2, 1/2, 3/4, 3/4, 1/2] * 0.5, 10),
  \sustain, Pseq( [1/2, 1/2, 1/2, 1/2, 3/4, 3/4, 1/2] * 0.1, 10)
 ).play
)
// Another solution, this time using a local variable.
// Ask your instructors about local variables... :-)
(
var durs = [1/2, 1/2, 1/2, 1/2, 3/4, 3/4, 1/2];
Pbind(
  \freq,  Pseq([ 1/1, 3/2, 4/3, 9/8, 16/9, 5/4, 8/5 ] * 40 , inf),
  \dur,  Pseq(durs * 0.5, 10),
  \sustain, Pseq(durs * 0.1, 10)
 ).play
)


////////////////////////////////////////////////////////////////////////////
// LAB EXERCISE 4 SOLUTION
Pseq(
[Pbind(
  \freq,  Pseq([ 1/1, 3/2, 4/3, 9/8, 16/9, 5/4, 8/5 ] * 40 , inf),
  \dur,  Pseq( [1/2, 1/2, 1/2, 1/2, 3/4, 3/4, 1/2] * 0.5, 1),
  \sustain, Pseq( [1/2, 1/2, 1/2, 1/2, 3/4, 3/4, 1/2] * 0.1, 1)
 ),
Pbind(
  \freq,  Prand([ 1/1, 3/2, 4/3, 9/8, 16/9, 5/4, 8/5 ] * 60 , inf),
  \dur,  Pseq( [1/2, 1/2, 1/2, 1/2, 3/4, 3/4, 1/2] * 0.5, 1),
  \sustain, Pseq( [1/2, 1/2, 1/2, 1/2, 3/4, 3/4, 1/2] * 0.1, 1)
 )], inf).play;


