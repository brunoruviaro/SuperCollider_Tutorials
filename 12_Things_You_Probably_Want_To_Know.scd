////////////////////////////////////////////////////////////////
// 12 Tips for SuperCollider Beginners
////////////////////////////////////////////////////////////////


// *****************************************
// 1. MULTICHANNEL EXPANSION
// *****************************************

// Open the Server meter to see what's going on in these examples.

s.meter; // same as Ctrl + M shortcut

// This sends sound to the left channel (which is bus 0 in SC):
{SinOsc.ar(440, 0, 0.1)}.play;

// This sends sound to the left and right channels (bus 0 and 1):
{SinOsc.ar([440, 550], 0, 0.1)}.play;

// This sends sound to outputs 0, 1, and 2:
{SinOsc.ar([440, 550, 660], 0, 0.1)}.play;

// This sends sound to outputs 0, 1, 2, 3, 4, 5:
{SinOsc.ar([440, 550, 660, 100, 412, 1067], 0, 0.1)}.play;

/*
In the example above, you probably only hear the first two channels, unless you have a multichannel soundcard and more than 2 loudspeakers in your studio.

In a nutshell: everytime you provide an Array of arguments to a UGen, it will
"multichannel expand" to the number of elements in the array.

From the manual:
"When an Array is given as an input to a unit generator it causes an array of multiple copies of that unit generator to be made, each with a different value from the input array. This is called multichannel expansion."
*/

// Read more about it here:
"Multichannel Expansion".help

// Or read online: http://doc.sccode.org/Guides/Multichannel-Expansion.html



// ***********************************
// 2. THAT FUNNY EXCLAMATION MARK
// ***********************************

// What is this?

30!4

// It simply creates an array containing
// the same item a number of times.
// Evaluate and see the results.
// Essentially, this is the same as writing:

Array.fill(4, 30);


// ******************************************
// 3. TWO DOTS WITHIN PARENTHESES
// ******************************************

// What is this?

(10..15);

// It's a shortcut to generate an array with an arithmetic series.
// The above is a shortcut to:

series(10, 11, 15);

// For a step different than 1, you can do this:

(10, 13 .. 20); // step of 3

// Which is a shortcut for this:

series(10, 13, 20);

// Another way to explicitly create an Array and fill it with an arithmetic series is this:

Array.series(size: 6, start: 10, step: 3);

/*

Note that the Array.series method implies a different way of thinking.

The (10..15) allows you to think this way: "just start from 10 then go all the way up to (and including) 15". You don't necessarily think about how many items the array will end up having.

The Array.series allows you to think this way: "just give me an array with 6 items total, starting from 10". You don't necessarily think about who is going to be the last number in the series.

Also note that the shortcut uses parentheses, not square brackets. The resulting array, of course, will be within square brackets.

*/

// In summary: all the lines below give the same result

(100, 97 .. 81);
series(100, 97, 81);
Array.series(7, 100, -3);

// If you need geometric series, use this:
Array.geom(size: 10, start: 1, grow: 2);




// ***********************************
// 4. VOLUME CONTROL GUI
// ***********************************

s.volume.gui; // why not, right?




// ******************
// 5. QUICK RECORD
// ******************

// Start recording:
s.record;

// Stop recording:
s.stopRecording;

// GUI with record button, volume control, mute button:
s.makeWindow

// The Post Window will show the path of the folder
// where the file will be saved. For more info,

Server.help; // scroll down to "Recording Support"

// Same doc file online:
// http://doc.sccode.org/Classes/Server.html




// **************************************************
// 6. BEING VERBOSE CAN BE HELPFUL IN THE BEGINNING
// **************************************************

// This:
{SinOsc.ar(440, 0, 0.1)}.play;
// ...can also be written like this:
{SinOsc.ar(freq: 440, phase: 0, mul: 0.1)}.play;

// This:
Array.series(4, 70, 1.5);
// ...can also be written like this:
Array.series(size: 4, start: 70, step: 1.5);

// This:
{Decay2.ar(Impulse.ar(8, 0, XLine.kr(1, 0.01, 5, 1, 0, 2)), 0.01, 0.15, Mix.ar(Pulse.ar([90,92], 0.3)))}.play;
// ...can also be written like this:
(
{Decay2.ar(
	in: Impulse.ar(
		freq: 8,
		mul: XLine.kr(start: 1, end: 0.01, dur: 5, doneAction: 2)),
	attackTime: 0.01,
	decayTime: 0.15,
	mul: Mix.ar(Pulse.ar(freq: [90,92], width: 0.3)))
}.play;
)

// Note that when you do use the green argument names explicitly, you are allowed
// to skip arguments that you do not want to use. In the first example,

{SinOsc.ar(440, 0, 0.1)}.play;

// the "zero" in the middle is for phase. You have to write it in in order to
// set the third argument (mul), even though the default value for phase
// would be zero anyway. On the other hand, you can skip it if you use argument names:

{SinOsc.ar(freq: 440, mul: 0.1)}.play;

// As you begin to learn SuperCollider, you may find it useful to explicitly use the argument
// names of your methods. Not only your code will be more readable for yourself the next day or
// the next month, but it will help you memorize what are the arguments.




// ********************
// 7. SIMPLE SYNTHDEF
// ********************

// Define it:
(
SynthDef("testing", {arg freq = 440, amp = 0.1;
	var env, snd;
	env = EnvGen.kr(Env.perc(attackTime: 0.01, releaseTime: 1, level: amp), doneAction: 2);
	snd = SinOsc.ar(freq: freq, mul: env);
	Out.ar(0, snd);
}).add;
)

// Use it:
Synth("testing");

Synth("testing", [\freq, 1200, \amp, 0.4]);




// ******************
// 8. DONEACTION: 2
// ******************

// What is this "doneAction: 2" that we see in many SynthDefs?
// Take a look at the following example.

// First open this server window:

s.plotTree;  // it's called the "node tree"

// Now play a simple sine wave:

x = {SinOsc.ar(440, 0, 0.1)}.play;

// The rectangle that showed up in the node tree
// represents the synth you are playing. It has
// some generic name like "temp_1000" or similar.
// Now stop the sound with this line:

x.free; // you will see the rectangle disappear.

// Now let's add a simple envelope to the sine wave:

x = {SinOsc.ar(freq: 440, mul: Line.kr(start: 0.1, end: 0, dur: 4))}.play;

// The sound fades out in 4 seconds, but notice
// that the synth is STILL running -- the rectangle
// did NOT disappear from the Node Tree window.
// The synth is simply sending out a continuous signal
// of zeros after Line.kr reached the end.
// That node will only be freed only when you do it explicitly:

x.free;

// Now evaluate this same line repeated times in sequence:

{SinOsc.ar(rrand(440, 1200), 0, Line.kr(0.1, 0, 3))}.play;

// You will see the synths piling up in the Node Tree window.
// Because we didn't assign each to a different variable,
// the only way to free them now is to hit ctrl + period.

// Finally: how to make a synth to FREE itself automatically?
// A very common example is: "please free this synth as soon
// as this envelope reaches the end". This is where doneAction: 2
// comes in. Run the example below and watch the Node Tree window:

{SinOsc.ar(440, 0, Line.kr(0.1, 0, 4, doneAction: 2))}.play;

// Learn more about this here:
"UGen done-actions".help



// **********************************
// 9. PBINDS WITH CUSTOM INSTRUMENTS
// **********************************

// Once you know how to create your own Synth Definitions,
// you can use Pbind to play them. For example, let's use the
// "testing" SynthDef that we created above at #7:

(
Pbind(
	\instrument, "testing",
	\freq, Pseq([440, 880, 650], 3),
	\amp, Pwhite(0.1, 0.5),
	\dur, Pwhite(0.3, 1)
).play;
)

// Notice that this works nicely since each note created
// by the SynthDef "testing" knows how to stop itself (doneAction: 2)




// ******************
// 11. FUNCTIONS
// ******************

// When you find yourself doing the same task several times,
// it may be a good time to create a reusable function.
// A function is something enclosed within curly braces.

f = { 2 + 2 }; // define the function

f.value; // put the function to work

// The function above is not that useful, as it only knows how to do one thing.
// Normally you will want to define functions that can accept arguments.

g = { arg a, b; ["a plus b", a+b, "a times b", a*b].postln };

g.value(3, 7); // now you can give any two numbers as arguments to the function
g.value(10, 14);

// Compare the difference:

~sillyRand = rrand(0, 10);
~sillyRand.value; // evaluate several times

~sillyRand2 = { rrand(0, 10) };
~sillyRand2.value; // evaluate several times





// ************************
// 12. HOW TO "DO" AN ARRAY
// ************************

// Often you will need to do some action over all items of a collection.
// Suppose you have a list of frequencies:

~myFreqs = Array.fill(10, { rrand(440, 880) });

// Now let's do some simple action on every item of the list:

~myFreqs.do({ arg item, count; ["Freq", item, "Closest midinote is", item.cpsmidi.round].postln });






// **************************************************************
// end of this tutorial
// **************************************************************