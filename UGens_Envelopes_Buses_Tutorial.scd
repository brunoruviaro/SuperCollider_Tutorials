// ******************************************
// UGens, Envelopes, Busses, etc.
// ******************************************

// LANGUAGE VS. SERVER; UGENS
// UGENS CONTROLLING OTHER UGENS; SCALING RANGES
// OTHER CONVENIENT MESSAGES: PLOT AND SCOPE
// AUDIO RATE, CONTROL RATE
// MOUSE INPUT
// MULTICHANNEL EXPANSION
// MIC INPUT
// PLAYING AN AUDIO FILE
// SYNTH DEFINITIONS
// A SIMPLE ENVELOPE; DONEACTION; PANNING
// BUSES, NODES



// --------------------------- //
// LANGUAGE VS. SERVER; UGENS
// --------------------------- //

rrand(-1, 1.0); // Generates a random number between -1 and +1 every time you evaluate. No sound involved. This happens in the SuperCollider Language.

// Caution: bring your volume down before evaluating the next line...

{ LFNoise0.ar(1) }.play;

// LFNoise0 (through the Server) sends out 44100 samples per second to your sound card. Each sample is a number between -1 and +1. LFNoise0.ar(1) picks a new random number every second. The .ar means that the output is at AUDIO RATE (commonly 44100 Hz). This is done by the Server.

// You can inspect what LFNoise0 is doing by using the message "poll":

{ LFNoise0.ar(1).poll }.play;

/* poll is polling the output of the UGen 10 times per second, by default, and posting the results in the post window. In other words, out of the 44100 samples being generated every second, poll picks only 10 per second. Try changing the frequency of LFNoise0 and watch (and hear) the results. If it's too loud, you can multiply it by 0.1, for example. */

{ (LFNoise0.ar(1) * 0.1).poll }.play;

// LFNoise0 is what we call a UGen (Unit Generator).

// From the Help file on UGen:
/* "UGens represent calculations with signals. They are the basic building blocks of synth definitions on the server, and are used to generate or process both audio and control signals. The many subclasses of UGen are the client-side representations of unit generators, and are used to specify their parameters when constructing synth definitions (see SynthDef). */

// Let's take a look at a less noisy UGen: SinOsc.

{ Out.ar(0, SinOsc.ar(440, 0, 0.01)) }.play;

{ SinOsc.ar(440, 0, 0.1) }.play; // parameters are: freq, phase, mul. Take a look at the Help file.

// You can be more explicit with the parameters:

{ SinOsc.ar(freq: 440, mul: 0.1) }.play; // note that I can omit a parameter if I'm using this method







// --------------------------------------------- //
// UGENS CONTROLLING OTHER UGENS; SCALING RANGES
// --------------------------------------------- //

/* Most UGens have the "mul" and "add" parameters. They are used to multiply (mul) and offset (add) the default range of numbers being generated. The default output range of UGens is either bipolar (-1 to +1) or unipolar (0 to 1). Suppose you want to have a SinOsc to play a new random note every second. Let's say you want the notes to be between 440 Hz and 880 Hz. This means you need to find a way to change the SinOsc's frequency value randomly, once every second, and make sure that value is within the 440-880 range. */

// LFNoise0 can do that. However, by default LFNoise0 outputs numbers between -1 and +1...

LFNoise0.ar.signalRange; // check it out

// There are two ways to change that, in order to rescale the values to the desired range.
// First let's take a look at the hard way...

// The "hard" way:
// Simply figure out the math to scale the range -1 to +1 to the new range 440 to 880.
// Then use the built-in mul and add parameters accordingly (most UGens have those parameters)
// Here is the code, indented and 'verbose' to make it more clear:

(
{SinOsc.ar(
	freq: LFNoise0.ar(freq: 5, mul: 220, add: 660),
	phase: 0,
	mul: 0.1)}.play
)

// Now the easy way:

(
{SinOsc.ar(
	freq: LFNoise0.ar(1).range(440, 880),
	phase: 0,
	mul: 0.1)}.play
)

// It is still good to understand how to use mul and add to scale things. You will need them at some point.
// Now, just for fun, try changing the frequency of the LFNoise0 above.
// Also try LFNoise1 and LFNoise2 instead of LFNoise0. What is the difference?







// --------------------------------------------- //
// OTHER CONVENIENT MESSAGES: PLOT AND SCOPE
// --------------------------------------------- //

// We just saw "range" -- a handy message to rescale the output of UGens.
// We also saw that "poll" is useful to inspect the output of UGens in the post window.
// Two other convenient messages are "plot" and "scope":

{ SinOsc.ar(400, 0, 0.1) }.plot; // a snapshot of the UGen output; no sound involved.
{ LFNoise0.ar(1000) }.plot;
{ LFNoise1.ar(1000) }.plot;
{ LFNoise2.ar(1000) }.plot;

// Tip: with the Plotter window active, hit "N" to Normalize the vertical axis.

{SinOsc.ar(440, 0, 0.1)}.scope; // play and visualize "stethoscope" window;
{LFNoise0.ar(freq: 2, mul: 0.5)}.scope;

// As you explore new UGens, use these messages to better understand what each UGen does.






// -------------------------- //
// AUDIO RATE, CONTROL RATE
// -------------------------- //

/*
In one of the examples above we used a .ar message to LFNoise0. As a result, the output of the LFNoise0 was at audio rate, i.e., 44100 samples per second (or 48k, 96k, etc, depending on your system). All we wanted in that case, though, was to change a value once or a few times per second. It is an overkill to use audio rate for that. That's where the notion of CONTROL RATE comes in. Take a look at the .kr message below:
*/

(
{SinOsc.ar(
	freq: LFNoise0.kr(1).range(440, 880),
	phase: 0,
	mul: 0.1)}.play
)

// SinOsc remains with .ar, because that's the sound generator.
// LFNoise0 gets a .kr, more "economic" (outputs less numbers per second).
// Since LFNoise0 here is just generating control data, we don't need .ar






// ------------ //
// MOUSE INPUT
//------------- //

// Try this:

(
{SinOsc.ar(
	freq: MouseX.kr(440, 880),
	phase: 0,
	mul: MouseY.kr(0.1, 0.5))}.play
)







// ----------------------- //
// MULTICHANNEL EXPANSION
// ----------------------- //

{SinOsc.ar([500, 1111], 0, 0.1)}.play // stereo

// Examples from SC Book, p. 14:

{Blip.ar(25, LFNoise0.kr(5, 12, 14), 0.3)}.play // mono

{Blip.ar(25, LFNoise0.kr([5, 10], 12, 14), 0.3)}.play // stereo

{Blip.ar(25, LFNoise0.kr([5, 10, 12, 25], 12, 14), 0.3)}.play // quad

// Check your level meters (s.meter);




// --------- //
// MIC INPUT
// --------- //

// Use headphones to avoid feedback
{SoundIn.ar(0)}.play;

// Stereo version
{SoundIn.ar([0, 1])}.play;

// Some reverb just for fun?
{FreeVerb.ar(SoundIn.ar([0, 1]), mix: 0.5, room: 0.9)}.play;







// ---------------------- //
// PLAYING AN AUDIO FILE
// ---------------------- //

// First, read the file into a buffer:

~buf1 = Buffer.read(s, "/home/ruviaro/Music/SuperCollider/wheels-mono.wav"); // one sound file
~buf2 = Buffer.read(s, "/home/ruviaro/Music/Sounds/mussorgsky-mono.wav"); // another sound file

// Play back:
{PlayBuf.ar(1, ~buf1)}.play; // number of channels and buffer
{PlayBuf.ar(1, ~buf2)}.play;

[~buf1.bufnum, ~buf1.numChannels, ~buf1.path, ~buf1.numFrames];
[~buf2.bufnum, ~buf2.numChannels, ~buf2.path, ~buf2.numFrames];

// Varying playback speed
// (numChannels, bufnum: 0, rate: 1, trigger: 1, startPos: 0, loop: 0, doneAction: 0)

{PlayBuf.ar(numChannels: 1,
	   bufnum: ~buf1,
	   rate: 2,
	   loop: 0)}.play; // play 2x faster

{PlayBuf.ar(1, ~buf1, 0.5, loop: 1)}.play; // play at half the speed
{PlayBuf.ar(1, ~buf1, Line.kr(0.5, 2, 10), loop: 1)}.play; // speeding up
{PlayBuf.ar(1, ~buf1, MouseY.kr(0.5, 3), loop: 1)}.play; // mouse control

// Changing direction (reverse)
{PlayBuf.ar(1, ~buf2, -1, loop: 1)}.play; // reverse sound
{PlayBuf.ar(1, ~buf2, -0.5, loop: 1)}.play; // play at half the speed AND reversed





// ------------------ //
// SYNTH DEFINITIONS
// -------------------//

{SinOsc.ar(440, 0, 0.3)}.play; // notice what appears in the post window.

// "A SynthDef (Synth Definition) describes which UGens are used and how they are plugged together. The Server can then use this definition to make running synths based on that synthesis recipe. When you use {}.play, SuperCollider does the work for you under the hood, such as autonaming the associated SynthDef and using it straight away to create a running synth, with the assigned temporary name." [SC Book, p. 22]

// Here's how to create a SynthDef without playing it immediately. The "add" message adds the SynthDef to the "list of SynthDefs SuperCollider knows about," allowing you to later run synths based on that recipe.

s.meter;

(
SynthDef("one_tone_only", {
	var out, freq = 440;
	out = SinOsc.ar(freq);
	Out.ar(0, out) // identify the output bus (more on that later)
}).add;
)

// Now we can use it at anytime, calling it by its name:

Synth("one_tone_only");

// This simple recipe can only make one note. Let's make something more flexible:

(
SynthDef("different_tones", {
	arg freq = 440;
	Out.ar(0, SinOsc.ar(freq)*0.1)
}).add;
)

// Now this synth recipe accepts arguments:

Synth("different_tones", ["freq", 550]); // how to pass an argument
Synth("different_tones", [\freq, 660]); // another way of writing
Synth("different_tones", ["freq", 770]);
Synth("different_tones"); // no argument? Default is used.

// Combine synths with variables for more independent control:

a = Synth("different_tones", [\freq, 64.midicps]);
b = Synth("different_tones", [\freq, 67.midicps]);
c = Synth("different_tones", [\freq, 71.midicps]);

a.set(\freq, 63.midicps);
c.set(\freq, 72.midicps);

(
a.set(\freq, 64.midicps);
b.set(\freq, 68.midicps);
c.set(\freq, 71.midicps);
)

b.set(\freq, 69.midicps); c.set(\freq, 73.midicps);

a.free; // "freeing" the synth
b.free;
c.free;




// -------------------------------------- //
// A SIMPLE ENVELOPE; DONEACTION; PANNING
// -------------------------------------- //

(
SynthDef("percussive_tones", {
	arg freq = 440, amp = 0.2, pan = 0;
	var snd;
	snd = SinOsc.ar(freq) * EnvGen.kr(Env.perc, doneAction: 2) * amp;
	snd = Pan2.ar(snd, pan);
	Out.ar(0, snd)
}).add;
)

// Watch synth nodes in the NodeTree window as you play notes:
s.plotTree;

// Run this several times:
Synth("percussive_tones", [\freq, rrand(400, 1200), \amp, rrand(0.1, 0.9), \pan, rrand(-1, 1.0)]);
Synth("percussive_tones", [\freq, 1000, \amp, 1, \pan, 1]);

a = Synth("different_tones", [\freq, 64.midicps]);
b = Synth("different_tones", [\freq, 67.midicps]);
c = Synth("different_tones", [\freq, 71.midicps]);

a.set(\freq, 63.midicps);

a.free; // watch plotTree window
b.free;
c.free;

// See how Env.perc & friends look like:
Env.perc.plot;
Env.linen.plot;
Env.triangle.plot;

/*
Understanding the SynthDef "percussive_tones":
Env creates a breakpoint envelope, and EnvGen plays it back at audio or control rate.
In the example above, we rely on all default values, but you can of course change them.
The "doneAction: 2" part means: "when this note is done, free the enclosing synth".
This way you don't have to free the synth manually with .free
See "UGen done-actions" Help file for more info.
Pan2 is a stereo panner. It takes a mono signal and pans it between -1 (left) to +1 (right).
*/






// ------------- //
// BUSES, NODES
// ------------- //

// Buses are used for routing audio or control signals.

{Out.ar(0, SinOsc.ar(440, 0, 0.1))}.play; // left channel

{Out.ar(1, SinOsc.ar(1240, 0, 0.1))}.play; // right channel

(
SynthDef("test_out", { arg outBus = 0;
	Out.ar(outBus, SinOsc.ar(MouseX.kr(440, 880), 0, 0.2))
	}).add;
)



a = Synth("test_out"); // plays default
a.set(\outBus, 1);
a.set(\outBus, 2); // see level meter
a.set(\outBus, 6); // see level meter

b = Synth("test_out", [\outBus, 1]);
a.free; b.free;

// AUDIO BUS EXAMPLE
// An example of audio bus used for an effect is shown below.

// busy tone (just listen for a couple seconds, then stop):
a = {Out.ar(0, SinOsc.ar([800, 880])*LFPulse.ar(2)*0.1)}.play
a.free;

s.plotTree
// Now run this ('turn reverb on' -- you won't hear anything at first)
r = {Out.ar(0, FreeVerb.ar(In.ar(55, 2), mix: 0.5, room: 0.9))}.play;

// Now run this second ('feed the busy tone into the reverb bus')
a = {Out.ar(55, SinOsc.ar([800, 880])*LFPulse.ar(2)*0.1)}.play;
a.free;

// Example using a sound file
~buf1 = Buffer.read(s, "/home/ruviaro/Music/SuperCollider/wheels-mono.wav");
~buf2 = Buffer.read(s, "/home/ruviaro/Music/Sounds/mussorgsky-mono.wav");

// Direct out:
a = {Out.ar(0, PlayBuf.ar(1, ~buf1))}.play;
a.free;

b = {Out.ar(0, PlayBuf.ar(1, ~buf2))}.play;
b.free;

// Reverb
a = {Out.ar(55, PlayBuf.ar(1, ~buf1) * 0.1)}.play;
a.free

b = {Out.ar(55, PlayBuf.ar(1, ~buf2))}.play;
b.free;

// Sine tones and audio file playback all go through same audio bus (~reverbIn).
// This audio bus is given as input to a reverb UGen.
// The final result is sent out to the speakers.

// The BUS Object
// In the examples above an arbitrary bus number was used for demonstration.
// In reality you don't have to be keeping track of bus numbers in this way.
// You can just use the Bus object to take care of that for you.

~reverbIn = Bus.audio(s, 1); // Bus audio choose an available bus; we store it into a variable.

// Same examples as before
// "Turn reverb on"
{Out.ar(0, FreeVerb.ar(In.ar(~reverbIn, 2), mix: 0.5, room: 0.9))}.play;
// "Send stuff to that bus"
{Out.ar(~reverbIn, SinOsc.ar([800, 880])*LFPulse.ar(2)*0.1)}.play




// CONTROL BUS EXAMPLE
// Below, an example of control buses (from SC Book, p. 27).
// Make sure you still have the audio files loaded on buffers
// (from PlayBuf examples), otherwise load them again.


(
~kbus1 = Bus.control; // a control bus
~kbus2 = Bus.control; // a control bus
)

~kbus1

(
{
	var speed, direction;
	speed = In.kr(~kbus1);
	direction = In.kr(~kbus2);
	Out.ar(0, PlayBuf.ar(0, ~buf1, (speed * direction), loop: 1));
}.play;
)

// Start the controls
(
{Out.kr(~kbus1, LFNoise1.kr(1).range(0.5, 2))}.play;
{Out.kr(~kbus2, LFClipNoise.kr(1/4))}.play;
)

// Start the second buffer with the same control input buses,
// but send it to the right channel using Out.ar(1, etc.)
(
{
	var speed, direction;
	speed = In.kr(~kbus1, 1);
	direction = In.kr(~kbus2);
	Out.ar(1, PlayBuf.ar(0, ~buf1, (speed * direction), loop: 1));
}.play;
)














// NODES
// Run the audio bus example again.
// Inspect what is happening in the server using the code below.

s.queryAllNodes; // same as 'ctrl + T"
s.plotTree;

/* The order of execution of nodes are important. From the Help files:
"Order of execution is a crucial issue when creating Synths which interact with each other.
If a sound is to be passed through a filter, the synth that does the filtering must be later in the order of execution than the synth which is its input. The computer must calculate a buffer's worth of sound, and then the computer moves on to calculate a buffer's worth of the filtered version of that sound."
See Help file "Order of Execution" for more info.
*/












