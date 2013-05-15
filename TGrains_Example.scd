//////////////////////
// GRANULAR SYNTHESIS
//////////////////////


// **************************
// FIRST STEP
//
// Copy the sound file of a song into /Music/SuperCollider/.
// Important: it has to be a mono wave file.
// If you have a stereo file, use Audacity to convert it to mono.


// **************************
// SECOND STEP
//
// Load the sound file into a buffer in memory:

(
Buffer.freeAll;

~mybuffer = Buffer.read(
	server: s,
	path: "~/Music/SuperCollider/wheels-mono.wav".standardizePath,
	bufnum: 55); // just an arbitrary number I chose for this buffer
)

// You can retrieve some info from the buffer just to double check:

~mybuffer.numChannels; // how many channels are stored in the buffer
~mybuffer.numFrames/44100; // duration of buffer in seconds (= duration of sound file)
~mybuffer.bufnum; // buffer number

// You can also simply play back the sound that was loaded into the buffer:

{PlayBuf.ar(1, 55)}.play;

// **************************
// THIRD STEP
//
// Granulate it!

(
{
	var buffer = ~mybuffer.bufnum;
	var bufdur = BufDur.kr(buffer);
	TGrains.ar(
		numChannels: 2,
		trigger: Impulse.ar(1),
		bufnum: buffer,
		rate: 1,
		centerPos: 3,
		dur: 0.5,
		amp: 1)
}.play;
)

// Play around with the various grain parameters.

/*

Explanation of the important parameters:

TRIGGER is how many grains to play per second;
BUFNUM is what buffer to granulate;
RATE is transposition factor ("playback rate"): 1 is normal, 2 is octave above, 0.5 is octave below, etc.
CENTERPOS stands for "center position". It is the time location in the sound to pick a grain from.
DUR is duration of a grain.
AMP is amplitude of a grain.

Instead of having fixed numbers for these parameters, you can try using other functions, like random number generators or mouse control. For example:

MouseX.kr(0, bufdur) // control centerPos with the horizontal movement of mouse

LFNoise0.kr(1).range(0, bufdur) // control centerPos randomly

Impulse.ar(MouseY.kr(0.1, 0.5)) // control number of grains per second with mouse

etc...

*/



/////////////////////////////////////


Ndef(\a).play; // start;
Ndef(\a).fadeTime = 1; // fadeTime (crossfade between changes)

// Evaluate the grains,
// Change them as you like,
// Evaluate again,
// etc

(
Ndef(\a,
{
	var buffer = ~mybuffer.bufnum;
	var bufdur = BufDur.kr(buffer);
	Mix(TGrains.ar(
			numChannels: 2,
			trigger: Impulse.ar(MouseX.kr(1/4,10)), // change these numbers
			bufnum: buffer,
			rate: MouseX.kr(1,2), // change these numbers
			centerPos: 3, // LFNoise0.kr(1).range(0,5),
			dur: MouseY.kr(0.5,5),
			amp: 0.5))
})
)

// Try any of these:
// LFNoise0.kr(a).range(b, c),
// MouseX.kr(a, b),
// MouseY.kr(a, b),

