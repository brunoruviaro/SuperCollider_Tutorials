// ************************************************
// BRUNO'S TUTORIAL 1 - SUPERCOLLIDER, THE BASICS
// ************************************************

// This is a little drier than tutorial zero...
// Take a deep breath, and go...!

// BASICS (starting SC, making sound, stopping sound, comments)
// MESSAGES AND ARGUMENTS
// NESTING
// RECEIVER NOTATION, FUNCTIONAL NOTATION
// ENCLOSURES
// VARIABLES
// HELP FILES
//
// EVENTS
// INTRO TO PATTERNS

//////////
// BASICS
//////////

// How to evaluate a line:
// Ctrl + Enter

// Evaluate lines below and see the results.

"Hello World".postln;

// How to evaluate a region:
// Put your cursor anywhere in between the first and last parentheses, and evaluate.
(
"[me] Hello World, how are you?".postln;
"[world] I'm OK, I guess".postln;
"[me] You do look a bit pale".postln;
)

// Question for later: watch the output of evaluating the region above. Why is the last line printed twice?

// Use Ctrl + Alt + P if you need to erase everything in the Post window.
// Moving on...
// Get yourself some GUI:

s.makeGui; // optional
s.meter; // nice to have

// Boot the sound server:

s.boot // or use Ctrl + B shortcut, or click "boot" on the little GUI from s.makeGui

// Make some sound:
{SinOsc.ar(440, 0, 0.2)}.play; // simple oscillator; how to stop it?

// How to stop all sounds:
// Ctrl + period

// WRITING COMMENTS
// This is a comment.
// Anything written after two slashes is a comment.
// Write a lot of comments in your code. You will not regret.

"This is not a comment".postln; // THIS is a comment!

/*

For longer comments, you can use a slash followed by an asterisk to open it,
and an asterisk followed by a slash to close it. Everything written between these
two markers will be a comment.

Write a lot of comments in your code. You will not regret.

*/

//////////////////////////
// MESSAGES AND ARGUMENTS
//////////////////////////

// Message: a lowercase word followed by a pair of parentheses containing a list of arguments.
// Arguments: lists of items separated by commas, inside parentheses, next to a message.

rand(100); // evaluate this several times, and watch the post window

rand(100.0); // if you use a float, a float is returned

rrand(440, 880); // different from rand; this allows you to specify a range with two arguments

exprand(1.0, 100.0); // another message with 2 arguments

// More examples of messages with arguments:

dup("fun", 20); // Rebecca Black
round([3.365, 5.923, 1009.19]);
round([3.365, 5.923, 1009.199], 0.1);
sort([56, 12, 62, 71, 1, 53, 4]);

///////////
// NESTING
///////////

round(dup({rrand(1,10)}, 25), 0.1);

// To "read" nested code, start from innermost nested message and work your way outwards:

rrand(1,10);
dup({rrand(1,10)}, 25);
round(dup({rrand(1,10)}, 25));

// Notice the difference between these two nested statements, by the way:

dup( rrand(1,10), 25);
dup( {rrand(1,10)}, 25); // more on this later


//////////////////////////////////////////
// RECEIVER NOTATION, FUNCTIONAL NOTATION
//////////////////////////////////////////

// Functional notation:

rand(100)

// ReceiverObject.message notation:

100.rand

// The two statements above mean the same thing. You can use either way of writing.
// Another example, now with more than one argument:

dup("hello", 20); // functional notation
"hello".dup(20);  // same thing in receiver notation

// The first argument of a message can be placed in front of the message, separated by a dot.

// EXERCISE: How would you rewrite these statements?

{SinOsc.ar(440, 0, 0.2)}.play; // rewrite this using functional notation only

dup(round(rand(1000.0), 0.1), 5); // rewrite this using receiver notation only

// It's a matter of style and convention. Sometimes one method can be clearer than the other.
// "Things that begin with uppercase letters (like SinOsc) are nearly always written as receiver.messages" [p. 11]

//////////////
// ENCLOSURES
//////////////

// Four types: (parentheses), [brackets], {braces}, and "quotation marks"

// (PARENTHESES)
// Parentheses are used to enclose argument lists, as seen before.
// They can also be used to force precedence:
5 + 10 * 4   // SuperCollider goes left to right, regardless of operators.
5 + (10 * 4) // Want the multiplication first? You have to be explicit.

// Messages normally take precedence:
5 + 10.squared // 10 is squared first, then result is added to 5
(5 + 10).squared // 5 and 10 are added first, then the result is squared

// [BRACKETS]
// Brackets define a collection of items. One common type of collection is called an Array.
[10, 11, 12, 13, 14, 15, 16, 17, "wow"]
[10, 11, 12, 13, 14, 15, 16, 17, "wow"].reverse
[10, 11, 12, 13, 14, 15, 16, 17, "wow"].choose
[10, 11, 12, 13, 14, 15, 16, 17, "wow"].mirror
[10, 11, 12, 13, 14, 15, 16, 17, "wow"].size
[10, 11, 12, 13, 14, 15, 16, 17, "wow"].at(0)
[10, 11, 12, 13, 14, 15, 16, 17, "wow"] ++ 999
[60, 72, 70, 65].midicps.round(0.1)
["cat", "mouse", "dog"].choose.dup(10)

(1..10)       // ...dirty trick to quickly generate an array.
(1, 3 .. 20)  // Yes, maybe confusing in the beginning. Better face it early on though! :-)

// For a handy summary of common Array operations, see
// https://ccrma.stanford.edu/wiki/SuperCollider_Quick_Reference#Arrays

// {BRACES}
// Curly braces define functions. Functions perform specific tasks that are usually repeated several times, normally with different results.

rand(1000.0) // This just picks a random number and returns it
{rand(1000.0)} // This creates and a function and returns the function

// This line says: "pick a random number, duplicate it 5 times"
dup(rand(1000.0), 5)

// Whereas this line says: "pick this function, duplicate it 5 times"
dup({rand(1000.0)}, 5)

// The line above has a similar result as this:
[rand(1000.0), rand(1000.0), rand(1000.0), rand(1000.0), rand(1000.0)]

{100.rand}.dup(10); // Here's a function receiving the message dup
{100.rand}.dup(10).plot; // Here's a function receiving the message dup; the result of it receives the message plot
{100.rand}.dup(50).sort.plot;
{rrand(1, 10)}.dup(12).sort.reverse;
{SinOsc.ar(440, 0, 0.2)}.plot; // Here's a function receiving the message plot
{SinOsc.ar(440, 0, 0.2)}.play; // Here's a function receiving the message play
{SinOsc.ar(440, 0, 0.2)}.scope; // Here's a function receiving the message scope

// "QUOTATION MARKS"

"Hello Again, World".postln;

"Quotation marks are used to enclose a string of characters (including spaces) as a single unit".postln

{"All work and no play makes Jack a dull boy".postln}.dup(1000); "".postln;

// These are called "strings." If you use single quotes, you will create a symbol.

'symbol'

\symbol // same as above

[1, 2, 3, \symbol, 4, "a string", 5];

// Symbols may be interchangeable with strings (though not always).

"This is a great string".size
"This is a great string".at(5)
'This is a great symbol'.size

/////////////
// VARIABLES
/////////////

// Default set of SC variables: lowercase letters a through z.

(
a = 440;
b = 3;
c = "math operations";
[c, a, b, a*b, a+b, a.pow(b), a.mod(b)];
)

// Once you assign a default variable, it remains valid until you close SC or re-assign it.
// Evaluate the lines below in order:

a; // evaluate this; it is still 440
a = "not anymore";
a; // evaluate this; 440 is gone, string "not anymore" replaced it

// Compare these two assignments (variables e and f):
e = {100.rand}.dup(10).plot;
e; // What is stored here?

f = {{100.rand}.dup(10).plot};
f; // What is stored here?

e.value; // To whom is the message "value" being sent to? What is being returned?
f.value; // To whom is the message "value" being sent to? What is being returned?

// You can define variables in other ways as well.

// You can use the key word "var" to define a variable with limited scope:
(
var scu = [500, "El", "Camino", "Real"];
scu.postln;
scu = scu.reverse;
scu.postln;
)

// You can also declare variables of less limited scope using a tilde:

~knoll = [660, 1910, 1946, 1986, 1975, 1989, 2005, 2012, "you won't get rid of me so easily"];
~knoll.reverse;
~knoll;

/*
This will remain valid until you restart SuperCollider. They are called "environment variables."
From the SC Book: "(...) similar to the a to z ones, but user defined. They will work anywhere in your patch, in other patches, even in other windows. By contrast, the [local] variables will work only inside the function where they are declared." (p. 25)
*/

//////////////
// HELP FILES
//////////////

// Select or place your cursor in the middle of a SC word, and type Ctrl + D:

Saw

// Documentation is integrated with the IDE interface.
// Also available online: http://doc.sccode.org/

//////////
// EVENTS
//////////

// The simplest Event ever:

().play;

(
 var evt;
 evt = Event.new;
 evt.play;
)

// Note the local variable being defined inside the parentheses! Valid only in there.

// An Event is a collection of key/value pairs that defines a specific action to be taken in response to the message "play". By default, Events specify notes to be played.

(freq: 547, amp: 0.1, dur: 2, pan: 0).play;

// Events understand standard names such as freq, amp, dur. If you don't specify some of them, it will use default values.

(freq: 440, amp: 0.1).play

// Using a variable:

e = (freq: 440, amp: 0.1, dur: 2)
e.play;

e.at(\freq)        // Access a value by name
e[\freq]
e.freq

e.put(\freq, 880);    // Change a value by name
e[\freq] = 660;
e.freq = 220;

e.put(\amp, 0.6);    // Add a new value into the event
e.put(\dur, nil);    // Remove a value

e.play;

// The Events shown above create just one note. Now we can use Patterns to specify sequences of notes:

p = Pbind(\freq, Pseq([440, 550, 660, 770, 660]), \dur, 0.3, \amp, 0.2).play;

// Pbind allows you to use Patterns to generate event sequences.

p = Pbind.new.play; // If you don't specify anything, it will just play default Event forever...
p.stop;

p = Pbind(\freq, 880, \dur, 0.1).play;
p.stop;

// The cool thing about Pbind is that you can use Patterns inside it.
// Pseq (seen above) allows you to specify a list of values to be read in order.

(
p = Pbind(
    \degree, Pseq([0, 0, 4, 4, 5, 5, 4], 1),
    \dur, Pseq([0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 1], 1)
).play;
)

// Pseq and Pser:
// Pseq plays through a list, with a specified number of repeats.
// Pser plays through a list as many times as needed until a specified number of results.
// Don't worry about the "asStream.all" messages now.

Pseq([1, 2, 3], 4).asStream.all;    // 12 items = 4 repeats * 3 items
Pser([1, 2, 3, 4, 5, 6, 7], 5).asStream.all;    // 5 items only

// How about Pwhite? "White" refers to "white noise." Pwhite produces random numbers with equal distribution.

Pwhite(0, 7, 10).asStream.all; // 10 random numbers between 0 and 7 (including 7)

p = Pbind(\degree, Pwhite(0, 7, inf), \dur, 0.25, \legato, 1).play; // inf: goes forever
p.stop;

// Let's add one more: Prand chooses items from a list randomly.

p = Pbind(\degree, Pwhite(0, 7, inf), \dur, Prand([0.25, 0.5, 0.75], inf), \legato, 1).play;
p.stop;

// You may be wondering what's the difference between things like Prand, Pwhite, and other simpler constructions we saw earlier:

Pwhite(0, 7, 10).asStream.all; // 10 random numbers between 0 and 7 (including 7)
{8.rand}.dup(10); // 10 random numbers between 0 and 7 (see rand in SimpleNumber Help file)

Prand([11, 22, 33], 10).asStream.all; // picks random values from list 10 times
{[11, 22, 33].choose}.dup(10); // picks random values from list 10 times

// What is the difference? They do the same thing through different methods. But Patterns are specialized objects to be used in constructions such as Pbind.

// One more example of Patterns in action: Pslide.
// "Flock of Seagulls!" example from PG_02_Basic_Vocabulary tutorial (Help files)

(
p = Pbind(
    \degree, Pslide((-5, -4 .. 12), 28, 3, 1, 0, false),
    \dur, Pseq([0.1, 0.1, 0.133], inf),
    \sustain, 0.15
).play;
)

// Pslide plays overlapping segments from a list.
// Pslide(list, repeats, len, step, start, wrapAtEnd)

Pslide([1, 2, 3, 4, 5, 6, 7, 8], 10, 3, 1, 0, false).asStream.all;

// Another way of writing the same thing:
(
Pslide(
	list: [1, 2, 3, 4, 5, 6, 7, 8],
	repeats: 10,  // number of segments
	len: 3,       // length of each segment
	step: 1,	  // step between segments
	start: 0,	  // what index to start at
	wrapAtEnd: false	// do not wrap around
).asStream.all.clump(3)		// clump -- easier to see the groupings
)

// You may have noticed the dirty trick generating the Array:

(-5, -4 .. 12)

// So this is what we get:

Pslide((-5, -4 .. 12), 20, 3, 1, 0, false).asStream.all.clump(3);


/*

EXERCISE: take a look at the Help files for Pseries and Pgeom. Write a simple Pbind to achieve the following musical goals:

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
	\amp, Pser([0.3, 0.1, 0.1], 22))
)

p.play;

// Functional notation vs. Receiver notation

play( {ar(SinOsc, 440, 0, 0.2)} )

dup(round(rand(1000.0), 0.1), 5); // rewrite this using receiver notation only:
1000.0.rand.round(0.1).dup(5) // this is easier to read

// END OF DAY 1 LECTURE!
// And just to prove that we were not kidding about that "global variable" business, check it out:

~knoll

// Yup, it's still there.








