/////////////////////////////////////
// Basic Computer Music Concepts
// Sound Design class
// After reading Hosken's chapter 2
// Bruno Ruviaro, 2013-09-28
/////////////////////////////////////

// Control + B to boot the server.
// Control + M to open the meter window.
// Use Control + Period to stop all sounds at anytime.


// Just listen to a sine wave first.
{SinOsc.ar(freq: 440, mul: 0.1)}.play;

// A little more fun:
{SinOsc.ar(freq: MouseX.kr(440, 2000), mul: 0.1)}.play;

// Simplest example of a plot in SuperCollider:

[1, 2, 3, 6, -6, 9].plot;

// Customize it a bit:

[1, 2, 3, 6, -6, 9].plot(minval: -100, maxval: 100);

// Scroll down to begin...





























// ******************************************
// FREQUENCY (physical), PITCH (perceptual)
// ******************************************

{ SinOsc.ar(freq: 440, mul: 0.1) }.play;

// "freq" specifies the frequency of this Sine Wave Oscillator (SinOsc).
// From the reading:
// f (frequency) is measured in Hz, or cycles per second (cps).
// T is the period of the waveform (measured in seconds)

// f = 1/T

// Suppose a very long period T of 1 second.
// Then frequency is also 1 second (one cycle per second).
// Here's a plot just for visualization (this won't play):

{SinOsc.ar(freq: 1)}.plot(duration: 1); // default plot duration is 0.01; here we request 1 second instead.

// Note that the horizontal axis (X) of the plot is the number of samples.
// The vertical axis (-1 to +1) represents amplitude range (more on this later).
// We can't hear 1 Hz; it's too low.
// Human hearing range is 20 to 20000 Hz approximately.
//
// The lowest note on the piano is 27.5 Hz (low A).
// The highest note on the piano is 4,186.01 Hz (high C).
// Middle C is 261.63 Hz (AKA as "C4", or midi note 60).
// Tuning fork A is 440 Hz (AKA as "A4", or midi note 69).

// Exercise: play these notes (type the whole line to practice)

// { SinOsc... etc.



























// Let's plot one second of a 261.63 Hz sine wave (middle C).

{SinOsc.ar(freq: 261.63)}.plot(duration: 1);

// The plot above shows 261.63 cycles crammed into one second.
// How do we find out the period (T)?
// Remember, the period is the duration of a SINGLE cycle.
// Just use the formula f = 1/T.

// When you find the T value,
// plug it into the "duration" of the plot:

{SinOsc.ar(freq: 261.63)}.plot(duration: /*replace this by T*/  );




















// Frequency relationships in a nutshell:
// Doubling or halving frequencies corresponds to OCTAVES in musical terms.

// A4
{ SinOsc.ar(freq: 440, mul: 0.1) }.play;
// A3
{ SinOsc.ar(freq: 220, mul: 0.1) }.play;
// A2
// ... type expression and play
// A5
// ... type expression and play



// Compare two plots: 100 Hz and 200 Hz

{ [SinOsc.ar(freq: 100), SinOsc.ar(freq: 200)] }.plot(duration: 1/100);
































// ********************************************
// AMPLITUDE (physical), LOUDNESS (perceptual)
// ********************************************

// The text mentions "db SPL": starts from zero and goes up,
// 0 = threshold of hearing, 120 = threshold of pain, etc.
// For our purposes here and now, we will be just using a
// linear scale between 0 and 1 to mean min and max amplitude.
// In SC that's the "mul" input you will find in many places.
// Thus, a "mul" of 1 means full amplitude, and 0 means silence.

{SinOsc.ar(freq: 440, mul: 1)}.play // careful: LOUD!

// All plot examples so far had Y axis between -1 and +1 (minval, maxval).
// Sine waves shown above reached those two extremes (full amplitude).
// Here's a sine wave that is half of maximum amplitude:

{SinOsc.ar(freq: 440, mul: 0.5)}.plot(minval: -1, maxval: 1);

// Compare two plots. Both 100 Hz, but one full amplitude, the other half amplitude:

{ [SinOsc.ar(freq: 440, mul: 1), SinOsc.ar(freq: 440, mul: 0.5)] }.plot(minval: -1, maxval: 1);

















































// **********
// TIMBRE
// **********

// Here's a few artificial waveforms beyond the simple sine wave.
// ("a sort of rudimentary timbre vocabulary" -- Hosken p. 25)

// SINE WAVE
{ SinOsc.ar(100) }.plot; // see
{ SinOsc.ar(MouseY.kr(50, 1000), mul: 0.1) }.play; // listen

// TRIANGLE WAVE
{ LFTri.ar(100) }.plot; // see
{ LFTri.ar(MouseY.kr(50, 1000), mul: 0.1) }.play; // listen

// SAWTOOTH WAVE
{ LFSaw.ar(100) }.plot; // see
{ LFSaw.ar(MouseY.kr(50, 1000), mul: 0.05) }.play; // listen

// SQUARE WAVE
{ LFPulse.ar(100) }.plot; // see
{ LFPulse.ar(MouseY.kr(50, 1000), mul: 0.05) }.play; // listen

// PULSE WAVE
{ LFPulse.ar(100, width: 0.2) }.plot; // basically a square with different "width" value
{ LFPulse.ar(MouseY.kr(50, 1000), width: 0.2, mul: 0.05) }.play; // sounds a bit different



// WHITE NOISE
{ WhiteNoise.ar(mul: 1) }.plot; // see
{ WhiteNoise.ar(mul: 1) }.plot(duration: 0.001); // see (zoomed in)
{ WhiteNoise.ar(mul: MouseY.kr(0, 0.2)) }.play; // listen

// PINK NOISE
{ PinkNoise.ar(mul: 1) }.plot; // see
{ PinkNoise.ar(mul: MouseY.kr(0, 0.2)) }.play; // listen






















































// *************
// ARTICULATION
// *************

// Amplitude Envelope

// Plot 1 second of a sine wave at full amplitude (no change in amp):
{ SinOsc.ar(freq: 440, mul: 1) }.plot(duration: 1);

// Plot a sine wave starting at full amplitude (1)
// and decreasing to 0 amplitude over 2 seconds:
{ SinOsc.ar(freq: 440, mul: Line.kr(start: 1, end: 0, dur: 2)) }.plot(duration: 2);

// Listen:
{ SinOsc.ar(freq: 440, mul: Line.kr(start: 1, end: 0, dur: 2)) }.play;



























//////////////////
// Envelope Types
//////////////////




// Plot a sine wave starting at full amplitude (1)
// and decreasing to 0 amplitude over 2 seconds:
{ SinOsc.ar(freq: 440, mul: Line.kr(start: 1, end: 0, dur: 2)) }.plot(duration: 2);
// Listen:
{ SinOsc.ar(freq: 440, mul: Line.kr(start: 1, end: 0, dur: 2)) }.play;





// Typical AR envelope ("struck or plucked" model)
// Attack and Release

// Meet Env, a handy tool to create envelopes
Env.perc.plot; // see
Env.perc.test; // listen

// Lines of an envelope can be straight or curved:
Env.perc(curve: 0).test.plot; // straight lines
Env.perc(curve: -4).test.plot; // curved lines (generally 'sound more natural')

// Customize it a bit:
Env.perc(attackTime: 0.5, releaseTime: 2).test.plot;

// Typical ADSR envelope ("bowed or blown" model)
// Attack, Decay, Sustain, Release

Env.adsr.plot;
Env.adsr.test;

// Straight or curved lines:
Env.adsr(curve: 0).plot;
Env.adsr(curve: -4).plot;

// Customize it a bit:
Env.adsr(attackTime: 0.1, decayTime: 1, sustainLevel: 0.1, releaseTime: 1, curve: 0).test.plot;
Env.adsr(attackTime: 0.01, decayTime: 0.2, sustainLevel: 0.2, releaseTime: 1, curve: 0).test.plot;

// BTW...
// You don't have to be verbose all the time. With time
// and practice, you can get rid of the keywords in green.
// SC knows the order of arguments.

Env.perc(0.01, 4).test.plot;
Env.adsr(0.1, 0.5, 0.4, 2).test.plot;

// Other envelopes:
Env.triangle.test.plot;
Env.linen.test.plot;
Env.pairs(pairs: [[0, 0], [0.1, 1], [0.2, 0.2], [1.5, 1], [2, 0]], curve: 0).test.plot;

// BTW...
// Feel free to format lines in other ways
// to make them more readable:

(
Env.pairs(
	pairs: [
		[0.0, 0.0], // time, level
		[0.1, 1.0], // time, level
		[0.2, 0.2], // etc...
		[1.5, 1.0],
		[2.0, 0.0]
	],
	curve: 0).test.plot;
)


































// Finally.. how to use Env with a SinOsc, WhiteNoise, LFSaw, etc...
// Just put it inside an EnvGen.kr
// Note: do not try with adsr just yet. It will need a bit more to work.

// PERC
// See
{ SinOsc.ar(freq: 440, mul: EnvGen.kr(Env.perc)) }.plot(duration: 1);
// Listen
{ SinOsc.ar(freq: 440, mul: EnvGen.kr(Env.perc)) }.play;

// TRIANGLE
// See
{ SinOsc.ar(freq: 100, mul: EnvGen.kr(Env.triangle)) }.plot(duration: 1);
// Listen
{ SinOsc.ar(freq: 100, mul: EnvGen.kr(Env.triangle)) }.play;

// LINEN
// See
{ SinOsc.ar(freq: 440, mul: EnvGen.kr(Env.linen)) }.plot(duration: 2);
// Listen
{ SinOsc.ar(freq: 440, mul: EnvGen.kr(Env.linen)) }.play;





























// Last:
// Simultaneous oscillators!

// Ouch! Why does the following comes out distorted?
(
{ SinOsc.ar(freq: 140, mul: EnvGen.kr(Env.perc(attackTime: 0.01, releaseTime: 1))) }.play;
{ SinOsc.ar(freq: 440, mul: EnvGen.kr(Env.perc(attackTime: 0.01, releaseTime: 1))) }.play;
{ SinOsc.ar(freq: 1449, mul: EnvGen.kr(Env.perc(attackTime: 0.01, releaseTime: 1))) }.play;
{ SinOsc.ar(freq: 2245, mul: EnvGen.kr(Env.perc(attackTime: 0.01, releaseTime: 1))) }.play;
)

// Solution:
(
{ SinOsc.ar(freq: 140, mul: EnvGen.kr(Env.perc(attackTime: 0.01, releaseTime: 1, level: 0.1))) }.play;
{ SinOsc.ar(freq: 440, mul: EnvGen.kr(Env.perc(attackTime: 0.01, releaseTime: 1, level: 0.1))) }.play;
{ SinOsc.ar(freq: 1449, mul: EnvGen.kr(Env.perc(attackTime: 0.01, releaseTime: 1, level: 0.1))) }.play;
{ SinOsc.ar(freq: 2245, mul: EnvGen.kr(Env.perc(attackTime: 0.01, releaseTime: 1, level: 0.1))) }.play;
)







// **********
// EXERCISES
// **********

// 1)
// Choose an oscillator (SinOsc, LFTri, etc).
// Use the horizontal motion of your mouse to control frequency (choose min and max).
// Use the vertical motion of your mouse to control amplitude (0-1).
// Play it.



// 2)
// Now create a few more lines of code like the above.
// Choose a different oscillator for each line.
// Choose different min and max frequency values for each line.
// TIP: keep amplitudes low, between 0 and 0.2 for example
// (remember: all oscillators will add up in amplitude)
// Evaluate all lines at the same time.
// Play and hear the results.


// 3)
// Write a chord of 4 or more sine waves, but:
// Use a different frequency for each sine wave (no mouse control);
// Use a percussive Amplitude Envelope for each sine wave;
// Use a different attackTime and releaseTime for each note of the chord.
// Make sure that all levels do not add up to more than 1.
// Hear the results.

