// ----------- //
// Envelopes
// ----------- //


/* Use Env.new to define an envelope from scratch using breakpoints. The first three arguments to Env.new are: levels, times, and curve (there are two more args, see help file).

levels - an array of levels. The first level is the initial value of the envelope.
times - an array of durations of segments in seconds. There should be one fewer duration than there are levels.
curve - choose from 'step', 'linear', 'exponential', 'sine', 'welch' (see help file for details). */

Env.new([0, 1, 0.3, 0.8, 0], [2, 3, 1, 4],'linear').test.plot; // this will play a test tone with envelope

// Here's how to "read" the two arrays above:
// "Go from 0 to 1 in two seconds;
// then go from 1 to 0.3 in 3 seconds;
// then go from 0.3 to 0.8 in 1 second;
// finally go from 0.8 to 0 in 4 seconds."

// If you choose 'exponential', you can't use zero in the first array, but something like 0.001 will do:

Env.new([0.001, 1, 0.3, 0.8, 0.001], [2, 3, 1, 4],'exponential').test.plot;

// You can also create some standard frequently-used envelope shapes by supplying durations to the following methods:


// LINE ENVELOPE
// *linen(attackTime, sustainTime, releaseTime, level, curve)

Env.linen(attackTime: 1, sustainTime: 2, releaseTime: 3, level: 0.6).test.plot;
Env.linen(0.1, 0.2, 0.1, 0.6).test.plot;
Env.linen(1, 2, 3, 0.6, 'sine').test.plot;
Env.linen(1, 2, 3, 0.6, 'welch').test.plot;


// TRIANGLE ENVELOPE
// *triangle(duration, level)

Env.triangle(1, 1).test.plot;


// HANNING ENVELOPE (BELL SHAPE)
// *sine(duration, level)

Env.sine(1,1).test.plot;

// PERCUSSIVE ENVELOPE
// *perc(attackTime, releaseTime, peakLevel, curve)

Env.perc(0.05, 1, 1, 0).test.plot;   // linear
Env.perc(0.05, 1, 1, -4).test.plot;  // exponential
Env.perc(0.001, 1, 1, -4).test.plot; // sharper attack
Env.perc(0.001, 1, 1, -8).test.plot; // change curvature
Env.perc(1, 0.01, 1, 4).test.plot;  // reverse envelope


// --------------------------------------- //
// USING ENVELOPES IN SYNTH DEFINITIONS
// --------------------------------------- //

// In order to "perform" an Env inside a Synth, you need EnvGen, the Envelope Generator:

{SinOsc.ar(800, 0, 0.5) * EnvGen.kr(Env.perc (0.001, 1))}.play;

// Another way of writing the same thing:
(
{
	var freq, env;
	freq = 800;
	env = EnvGen.kr(Env.perc(attackTime: 0.001, releaseTime: 1));
	SinOsc.ar(freq: freq, mul: env);
}.play;
)

// Example using a trigger.
// The "gate" argument of EnvGen triggers the envelope and holds it open while value is > 0.
// See EnvGen Help file for more info.

(
 {
  var freq, trigger, env;
  freq = 800;
  trigger = Impulse.kr(1/2); // trigger a note every 2 seconds
  env = EnvGen.kr(Env.perc(0.001, 1), gate: trigger);
  SinOsc.ar(freq, mul: env);
 }.play;
)


// Similar, now using an envelope to control frequency as well.
(
{
	var trigger, freqEnv, ampEnv;
	trigger = Impulse.kr(1/2); // trigger a note every 2 seconds
	freqEnv = EnvGen.kr(Env.linen(0.1, 0.5, 0.4), gate: trigger).range(440, 880);
	ampEnv = EnvGen.kr(Env.perc(0.001, 1), gate: trigger);
  SinOsc.ar(freq: freqEnv, mul: ampEnv);
 }.play;
)


