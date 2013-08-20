//////////////
// PATTERNS //
//////////////

// QUICK INTRO TO PATTERNS
// The goal is to start making sound right away as you learn to use Patterns.
// Don't worry about every single detail of what is happening under the hood.
// Later on, you can learn a lot more about Patterns by reading the
// great "Pattern Guide" (by James Harkins) in the Documentation.

// A Pattern is like a blueprint for a building, or a recipe.
// The Pattern below specifies the following recipe: "take the list provided and read through it 2 times".

Pseq([1, 2, 3, 4, 5], 2);

// If you evaluate the line above, you see no actual result: it's just a recipe.
// In order to quickly see the results of the recipe, we do this:

Pseq([1, 2, 3, 4, 5], 2).asStream.all;

// This is just to understand what the Pattern will do when 'streamed' in time.
// Supose we want to play a simple scale: C minor, ascending, each note lasting 0.3 seconds:

(
Pbind(
	\midinote, Pseq([60, 62, 63, 65, 67, 68, 71, 72]),
	\dur, 0.3,
).play;
)

// Pbind is the structure that 'binds it all together'. It's a collection of key/value pairs.
// Inside, you can specify sequences of values for pitches, durations, amplitude, etc.
// Normally you will use Patterns to define these sequences of values.
// IMPORTANT: Pbind will use default values for parameteres you do not explicitly specify.
// If you omit "dur", for example, it will use a default 1-second duration for each note:

(
Pbind(
	\midinote, Pseq([60, 62, 63, 65, 67, 68, 71, 72]),
).play;
)

// Here's another example using Pseq for notes, durations, and amplitudes:
(
Pbind(
	\midinote, Pseq([60, 67, 78, 71, 40], 2),
	\dur, Pseq([0.1, 0.1, 0.5, 0.4, 1], inf),
	\amp, Pseq([0.1, 0.2, 0.3, 0.2, 0.2], inf);
).play;
)

// The examples below will use that C minor scale a lot, so let's store it into a variable:
h = [60, 62, 63, 65, 67, 68, 71, 72];

// We'll now go through a bunch of different Patterns.
// Like when we learn to speak a new language, this is the moment
// of learning new words to expand our vocabulary.
// If you can't figure out what the Pattern is doing,
// put your cursor on the Pattern name and type ctrl + D (help file)

// Pseq
(
Pbind(
	\midinote, Pseq(list: h, repeats: 4),
	\dur, 0.15;
).play;
)

// Pser
(
Pbind(
	\midinote, Pser(list: h, repeats: 11),
	\dur, 0.15;
).play;
)

// Pslide
(
Pbind(
	\midinote, Pslide(list: h, repeats: 7, len: 3, step: 1),
	\dur, 0.15;
).play;
)

// Prand
(
p = Pbind(
    \midinote, Prand(h, inf),
    \dur, 0.2;
).play;
)

// Pxrand
(
p = Pbind(
    \midinote, Pxrand(h, inf),
	\dur, 0.2;
).play;
)

// Pwhite
(
p = Pbind(
    \midinote, Pseq(h, 3),
	\dur, Pwhite(0.1, 0.3);
).play;
)


// Pshuf
(
p = Pbind(
    \midinote, Pshuf(h, 6),
	\dur, Prand([0.1, 0.2], inf);
).play;
)

// Define some chords
c = [[60, 63, 67], [62, 65, 68], [63, 67, 70], [65, 68, 72]];

// Chords with Pseq
(
Pbind(
	\midinote, Pseq(list: c, repeats: 3),
	\dur, 0.15;
).play;
)

// Place
(
Pbind(
	\midinote, Place(list: c, repeats: 3),
	\dur, 0.15;
).play;
)

// Check it out what Place does:
Place(c, 3).asStream.all;

// Now let's create new series of numbers from scratch
// (no use of pre-defined sets of numbers like h and c above)

// Pseries
(
p = Pbind(
    \midinote, Pseries(start: 90, step: -2, length: 21),
	\dur, 0.1;
).play;
)

// Pgeom
(
p = Pbind(
    \midinote, Pseries(start: 90, step: -2, length: 21),
	\dur, Pgeom(start: 0.1, grow: 1.1);
).play;
)

// Ppatlace
(
p = Pbind(
    \midinote, Ppatlace([
        Pseries(60, 2, 8),    // first, third etc. notes
        Pseries(72, 2, 8)    // second, fourth etc. notes
    ], inf),
    \dur, 0.25
).play;
)

// Check it out what it does:
Ppatlace([Pseries(60, 2, 8), Pseries(72, 2, 8)], inf).asStream.all

// You can use freq instead of midinote
(
Pbind(
	\freq, Pseries(220, 220, 8), // first 8 partials of 220Hz
	\dur, 0.25;
).play;
)
// Another option: degree (as in scale degree)
(
Pbind(
	\degree, Pseq([0, 1, 2, 3, 4, 5, 6, 7], 1),
	\dur, 0.25;
).play;
)

// Major scale is default for degrees. How to change scales:
(
Pbind(
	\scale, Scale.phrygian, // try minor, chromatic, dorian, etc
	\degree, Pseq([0, 1, 2, 3, 4, 5, 6, 7], 1),
	\dur, 0.25;
).play;
)

// Ptuple
(
Pbind(
	\scale, Scale.phrygian,
	\degree, Ptuple([
		Pseq([5, 6, 5, 6, 8, 7, 6, 7], inf),
		Pseq([3, 4, 3, 5, 5, 5, 5, 4], inf),
		Pseq([0, 0, 0, 2, 3, 4, 3, 1], inf)], inf),
	\dur, Pseq([0.15, 0.15, 0.25, 0.25, 0.15, 0.15, 0.25], inf),
	\sustain, 0.1;
).play;
)

/* See more at
"http://doc.sccode.org/Tutorials/A-Practical-Guide/PG_02_Basic_Vocabulary.html"
*/

// "Flock of seagulls" example by James Harkins
(
Pbind(
    \degree, Pslide((-6, -4 .. 12), 8, 3, 1, 0),
    \dur, Pseq([0.1, 0.1, 0.2], inf),
    \sustain, 0.15
).play;
)

// So far we have been using the "default" instrument. Let's load a few more interesting ones.
// "PMCrotale"
// "blips"
// "noisy"
// "hihat"
// "snare"
// "kick"
// "kick2"

/*
From this point on we need the file SynthDefs_2013.scd to be evaluated, so that these new synths are loaded into memory. Two ways of doing this:

a) Open the file "SynthDefs_2013.scd" and evaluate it (Ctrl + A, then Ctrl + Enter);

OR

b) Change the file path below to match the location of the this file on your computer and then evaluate the line.
*/

"/home/ruviaro/Music/SuperCollider/SynthDefs_2013.scd".load;

(
Pbind(
	\instrument, "PMCrotale",
	\midinote, Pseq([60, 67, 78, 71, 40]),
	\dur, Pseq([0.1, 0.1, 0.5, 0.4, 1]),
	\art, 1,
	\amp, 0.1;
).play;
)

// How about the Ptuple example again with crotales?
(
Pbind(
	\instrument, "PMCrotale",
	\scale, Scale.phrygian,
	\degree, Ptuple([
		Pseq([5, 6, 5, 6, 8, 7, 6, 7], inf),
		Pseq([3, 4, 3, 5, 5, 5, 5, 4], inf),
		Pseq([0, 0, 0, 2, 3, 4, 3, 1], inf)], inf),
	\dur, Pseq([0.15, 0.15, 0.25, 0.25, 0.15, 0.15, 0.25], inf),
	\art, 0.5,
	\amp, 0.3;
).play;
)

// "PMCrotale" instrument has a specific "art" (Attack and Release Time) parameter. Try changing it.
// Each instrument will have its own specific parameters. Some (like dur) are very common.
// We will see later how to create your own instruments.
// For now, just use the ones provided to practice writing Pbinds and Patterns.

// Write a Pattern for the \art parameter. Suggestion: try Prand or Pwhite.
(
Pbind(
	\instrument, "PMCrotale",
	\scale, Scale.phrygian,
	\degree, Ptuple([
		Pseq([5, 6, 5, 6, 8, 7, 6, 7], inf),
		Pseq([3, 4, 3, 5, 5, 5, 5, 4], inf),
		Pseq([0, 0, 0, 2, 3, 4, 3, 1], inf)], inf),
	\dur, Pseq([0.15, 0.15, 0.25, 0.25, 0.15, 0.15, 0.25], inf),
	\art, // WRITE A PATTERN HERE (don't forget the comma at the end)
	\amp, 0.3;
).play;
)

// Keep going: for every example below, change existing Patterns, create new ones, etc.

// "blips" instrument example. Relevant parameters: freq, dur, numharm, release, amp.
(
Pbind(
	\instrument, "blips",
	\freq, Pseq([20, 27, 38, 21, 30], inf) * 3, // try other multipliers
	\dur, Pseq([1, 1, 0.5, 0.4, 1], inf),
	\numharm, Pwhite(10, 50),
	\rel, 1,
	\amp, Pwhite(0.1, 1);
).play;
)

// "noisy" instrument example. Relevant parameters: freq, dur, amp.
(
Pbind(
	\instrument, "noisy",
	\freq, Pseries(110, 10, 20),
	\dur, Pseq([1/4, 1/4, 1/8], inf),
	\amp, Pwhite(0.1, 0.4);
).play;
)

// "hihat" instrument example. Relevant parameters: duration, filter frequency, release.
(
Pbind(
	\instrument, "hihat",
	\dur, Pseq([1/2, 1/2, 1/2, 1/4, 1/4] * 0.35, inf), // + Prand([0, 0.001],inf),
	\ffreq, 9000, // Prand([15000, 9000, 8000], inf),
	\rel, 0.1; // Prand( (0.01, 0.02 .. 0.1), inf)
).play;
)

// "snare" instrument example.
(
Pbind(
	\instrument, "snare",
	\dur, Prand([1.5, 2.5, 3, 4.7, 6]*1/3, inf),
	\sinfreq, Pwhite(100,160,inf),
	\amp, 0.05;
).play;
)

// "kick" instrument example.
(
Pbind(
	\instrument, "kick",
	\dur, Pseq([1, Rest, 1, Rest], inf) * 1/4,
	\amp, Pseq([0.5, Rest, 1, Rest], inf),
	\rel, 0.5, // Pwhite(0.5, 0.7, inf),
	\glissf, 0.2; // Pwhite(0.1, 0.9, inf)
).play;
)

// "kick3" instrument example

(
p = Pbind(
	\instrument, "kick3",
	\punch, Pseq([
		Pseq([0.01], 4),
		Pseq([0.1], 4),
		Pseq([1], 4),
		Pseq([10], 4),
		Pseq([100], 4),
		Pseq([1000], 4)], inf),
	\amp, 0.1, // careful: can be loud!
	\dur, 0.5,
).play;
)

// A shorter way of writing the above:
(
p = Pbind(
	\instrument, "kick3",
	\punch, Place([0.01, 0.25, 1, 4, 30, 1000]!4, inf),
	\amp, 0.1, // careful: can be loud!
	\dur, 0.5,
).play;
)

Place([0.01, 0.1, 1, 10, 100, 1000]!4, 40).asStream.all;

// Chords (note the "tone" parameter)
(
Pbind(
	\instrument, "PMCrotale",
	\midinote, Pseq([[57,60,64]-3, [57,60,64]-6], inf)-Prand([0,1,3],inf),
	\dur, Prand([1/2, 1/2, 1/4, 1/3, 1/3, 1/5], inf),
	\art, Prand([1.5, 1.75, 2], inf),
	\tone, Pwhite(2, 3),
	\amp, Prand([0.2, 0.3, 0.1],inf),
).play;
)


// **********************************


// Remember, you can always use .asStream.all to quickly check what the ouput of a pattern will look like.

Pseq([1, 2, 3], 4).asStream.all;    // 12 items = 4 repeats * 3 items
Pser([1, 2, 3, 4, 5, 6, 7], 5).asStream.all;    // 5 items only
Pwhite(0, 7, 10).asStream.all; // 10 random numbers between 0 and 7 (including 7)

Pslide([1, 2, 3, 4, 5, 6, 7, 8], 10, 3, 1, 0, false).asStream.all;

// Another way of writing the same thing (declaring arguments explicitly may be helpful):
(
Pslide(
	list: [1, 2, 3, 4, 5, 6, 7, 8],
	repeats: 10, 	// number of segments
	len: 3,      	// length of each segment
	step: 1,	// step between segments
	start: 0,	// what index to start at
	wrapAtEnd: false	// do not wrap around
).asStream.all.clump(3)		// clump -- easier to see the groupings
)

// Dirty trick to generate an Array:

(-5, -4 .. 12)

// So this is what we get:

Pslide((-5, -4 .. 12), 20, 3, 1, 0, false).asStream.all.clump(3);

/*

EXERCISE: use Pseries and Pgeom to write a simple Pbind achieving the following musical goals:

a) Create a three-octave descending scale using Pseries;
b) Create a decreasing series of durations (rallentando) using Pgeom. First note played should have a duration of 1 second, and each successive note should have a shorter duration.
c) Make every third note accented -- something like mf, p, p, mf, p, p, ... etc.

*/

// Scroll down for solution







































// One solution for the exercise above
(
p = Pbind(
	\degree, Pseries(7, -1, 22),
	\dur, Pgeom(1, 0.9, 22),
	\amp, Pser([0.3, 0.1, 0.1], 22),
	\legato, 0.3)
)

p.play;






