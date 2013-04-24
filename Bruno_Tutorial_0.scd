////////////////////////////////////////////
// BRUNO'S TUTORIAL ZERO - the EASY ONE!
////////////////////////////////////////////


// Before anything, make sure you have started JACK
// by launching Qjackctl and hitting the "Start" button.

// Now evaluate the following line to start
// the SuperCollider "sound engine".
// To evaluate a line, place the cursor anywhere
// in the line and hit Ctrl + Enter.

s.boot; // this is the same as using the shortcut Ctrl + B

/*
You should be seeing now some green numbers on the lower right corner of the window, where it says "Server".
*/

// Everything in color RED is a comment, meaning it doesn't do anything.
// Nothing happens if you evaluate a line that is a comment.

// Use two slashes to write a shorter comment, like this one.

/*
Comments are good for taking notes or writing documentation about your code. There are two ways of writing a comment: start the line with a two slashes (for quick, short comments), or, for longer comments, like this one, enclose all the text with the slash+asterisk combination. For example, see the first line of this paragraph: it starts with slash + asterisk. Now I am going to end this big comment with the "closing" combination: asterisk + slash.
*/

// Now you are ready to make some sound:

{SinOsc.ar(440, 0, 0.1)}.play;

// You should be hearing a simple sine wave.
// Stop the sound with the shortcut Ctrl + . (period)

// We can make this sine wave more flexible using
// the mouse (trackpad) to control its frequency:

{SinOsc.ar(MouseY.kr(300,600), 0, 0.1)}.play;

// Notice that where we had "440" before, now we have
// a longer expression that says "MouseY.kr(300,600)"

// MouseY is tracking your cursor vertically and
// changing the frequency between 300 Hz and 600 Hz.
// Stop the sound, change the upper and lower frequencies,
// evaluate the line again, etc... play around.

// You can start (evaluate) several lines in a row.
// They will all sound together:

{SinOsc.ar(200, 0, 0.1)}.play;
{SinOsc.ar(600, 0, 0.1)}.play;
{SinOsc.ar(1000, 0, 0.1)}.play;
{SinOsc.ar(1200, 0, 0.1)}.play;

// You should hear a major triad after evaluating
// the lines above one by one. We can evaluate
// chunks of code (several lines) at once
// by enclosing them in between parenthesis.
// Put your cursor anywhere in between the parenthesis and hit Ctrl + Enter.
// The whole "region" (all lines) will be evaluated at once.

(
{SinOsc.ar(200, 0, 0.1)}.play;
{SinOsc.ar(600, 0, 0.1)}.play;
{SinOsc.ar(1000, 0, 0.1)}.play;
{SinOsc.ar(1200, 0, 0.1)}.play;
)

// How about some glissando fun with this chord now?
// I just use MouseY again and choose some
// upper & lower boundaries for frequencies of notes.

(
{SinOsc.ar(MouseY.kr(200,300), 0, 0.1)}.play;
{SinOsc.ar(MouseY.kr(600,700), 0, 0.1)}.play;
{SinOsc.ar(MouseY.kr(1000,1300), 0, 0.1)}.play;
{SinOsc.ar(MouseY.kr(1200,1300), 0, 0.1)}.play;
)

// Now let's jump to a few more complex lines of code.
// Don't worry about understanding it all now. Just listen to the result.
// The first example below is actually just one big line, but I put it in
// parenthesis just because I like parenthesis.
// You can put the cursor anywhere inside and evaluate.
// Careful, it may be loud.

(
play{LFCub.ar(LFSaw.kr(LFPulse.kr(1/4,1/4,1/4)*2+2,1,-20,50))+(WhiteNoise.ar(LFPulse.kr(4,0,LFPulse.kr(1,3/4)/4+0.05))/8)}
)

// This is just to give you a taste of how much one is be able to do
// with very few lines of code.

// Stop the sound with Ctrl + .

// Now how about some bubbling?
// Same thing - cursor anywhere between parenthesis, then evaluate.
// This one is a softer sound.

(
{({RHPF.ar(OnePole.ar(BrownNoise.ar, 0.99), LPF.ar(BrownNoise.ar, 14)
* 400 + 500, 0.03, 0.003)}!2)
+ ({RHPF.ar(OnePole.ar(BrownNoise.ar, 0.99), LPF.ar(BrownNoise.ar, 20)
* 800 + 1000, 0.03, 0.005)}!2)
* 4}.play
)


// Let's see... maybe now it's time for an "epic pad"?
// This may also be a bit loud -- bring down the volume
// of the audio interface, evaluate the code,
// the bring volume back up slowly.

(
play{
      var freq = { [60,64,65,67].choose.midicps * LFNoise2.kr(1,0.01,1) }!24;
      var gen = LFSaw.ar(freq) * 0.1;
      var fmod = LFCub.kr(1/12).range(1, MouseX.kr(2,16));
      var rqmod = LFNoise2.kr(1/8).range(0.1,1.0);
      var snd = RLPF.ar(gen, freq * fmod, rqmod);
      Splay.ar(snd)}
)

// Move your cursor horizontally (left to right).
// Hear how the sound changes as you move it.
// See a "MouseX" somewhere in the middle of the code above?
// That's the sister of MouseY tracking your cursor horizontally,
// and doing something with those numbers.

// Again, don't worry about understanding all the code above.
// These are just short examples to make some interesting sounds.
// Now I'll copy the same code of the above "epic pad" down here
// so that you to mess with it:

(
play{
      var freq = { [60,64,65,67].choose.midicps * LFNoise2.kr(1,0.01,1) }!24;
      var gen = LFSaw.ar(freq) * 0.1;
      var fmod = LFCub.kr(1/12).range(1, MouseX.kr(2,16));
      var rqmod = LFNoise2.kr(1/8).range(0.1,1.0);
      var snd = RLPF.ar(gen, freq * fmod, rqmod);
      Splay.ar(snd)}
)

// Go ahead and change some of the numbers
// in the first line that starts with "var".
// Specifically, take a look at the list of numbers [60,64,65,67].
// Those are specifying the notes of the chord.
// These numbers are "MIDI Note Numbers", a numbering
// convention for all notes that exist in a piano.
// Middle C, for example is 60. C sharp above middle C is 61. B natural
// below middle C is 59, etc.
// Change the notes of the chord as you like, evaluate, and
// hear your new chords. Try notes within a reasonable range first,
// like between 40 and 70. Feel free to go wild later to see what happens.
// NOTE: MIDI Note Numbers only go from 1 to 127.
// The very low notes may be inaudible (even the piano does not have them).
// The very high notes may be piercing.

// After you have tried a few good-sounding chords, get adventurous.
// How about replacing one of the notes with a MouseY.kr instead of
// a fixed number? For example, choose any note, delete one of the numbers,
// and in its place type in something like MouseY.kr(57,60)
// Don't forget the comma to separate items of the list
// (meaning you'll need a comma right after your MouseY...stuff.
// How does it sound? Do you understand what's happening?


// A couple more examples.
// This is called "subtractive synthesis".
// Start with white noise and "filter out" parts of it.
// Move your mouse X and Y axes to change the filter.
// Very good way to mimic some wind sounds...

( // "wind"
{BPF.ar(
	in: WhiteNoise.ar(0.3),
	freq: MouseY.kr(200, 10000, 1),
	rq: MouseX.kr(0.01, 1, 1)
)}.freqscope;
)

// Of course this "wind" could be improved,
// but this is just a crude demo anyway.
// Notice that this example gives you
// something to look at (the freqscope window).
// If you don't see it, it may be behind SC's window.
// Use alt + tab to cycle through open windows.

// How about using subtractive synthesis
// to mimic something like a...??
// (whatever you think this sounds like)

(
{BPF.ar(
	in: Saw.ar(100, 0.5),
	freq: MouseY.kr(100, 10000),
	rq: MouseX.kr(0.1, 1)
)}.freqscope;
)

// OK, let's end with a chord progression.
// This little chunk of code will generate some
// more or less random chords based on a set of
// available notes, always varying chord durations.
// It will go on forever or until you stop the sound.

// Evaluate anywhere between the parenthesis.
(
~harmony = Pbind(
		\instrument, "default",
		\midinote, Ptuple([
			Pseq([60, 59, 58, 57], inf),
			Pseq([64, 63, 62, 61], inf),
			Prand([67, 67, 68, 70], inf)
			], inf),
		\dur, Pwhite(0.5, 2);
).play;
)

// You can use Ctrl + . to stop the sound.
// But in this case you can also request
// that this "chunk" alone stops. Notice that
// the whole code is in an expression that says
// "~harmony" equals to...
// "~harmony" is just a name I gave to this
// chunk of code. It allows for more flexibility
// to deal with that chunk directly.
// For example, now that "~harmony" is saved in
// memory, you can re-start it directly by
// evaluating this line:

~harmony.play;

// And you can tell it to stop by evaluating this line:

~harmony.stop;

// Finally, to give you a taste of graphical interface options
// avaiable in SuperCollider, let's create a simple silly set
// of buttons to to play and stop the chord progression (~harmony)/
// Evaluate the chunk below.

(
var window, button1, button2;
window = Window.new("Chord Progression", Rect(100, 100, 230, 120));

button1 = Button.new(window, Rect(10, 10, 100, 100));
button1.states = [["play", Color.blue]];
button1.action = { ~harmony.play; "playing...".postln };

button2 = Button.new(window, Rect(120, 10, 100, 100));
button2.states = [["stop", Color.red]];
button2.action = { ~harmony.stop; "stopped".postln };

window.front;
)

// A little window with a play and stop buttons should have appeared.
// If not, it's just behind SuperCollider's main window. Use
// alt + tab to cycle through open windows.
// In Ubuntu, by the way, another cool shortcut to see all your
// open windows is Super + W ("Super" is the key with the "windows" logo).
// You'll see all avaiable windows at once. Choose the little 'stop/play'
// window that you have just created (click on it), and it will become
// the frontmost window.

// THAT'S IT FOR TUTORIAL ZERO.
// Now we need to really start learning the basics of
// the SuperCollider language. In order to start,
// take a deep breath and go on to Bruno's Tutorial One...


