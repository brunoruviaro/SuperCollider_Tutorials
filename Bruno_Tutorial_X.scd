(
SynthDef("percussive_tones", {
	arg freq = 440, amp = 0.2, pan = 0;
	var snd;
snd = SinOsc.ar(freq) * EnvGen.kr(Env.perc, doneAction: 2) * amp;
	snd = Pan2.ar(snd, pan);
	Out.ar(0, snd)
}).add;
)

// Simple sine wave
{SinOsc.ar(440, 0, 1)}.play;

// Another way of writing the same thing:
(
{SinOsc.ar(
	freq: 440,
	phase: 0,
	mul: 1)}.play;
)

// Instead of fixed freq and amplitude, use mouse controls:
(
{SinOsc.ar(
	freq: MouseY.kr(440, 500),
	phase: 0,
	mul: MouseX.kr(0.1, 1))}.play;
)

// Instead of a never-ending note, add a percussive envelope:
(
{SinOsc.ar(
	freq: 440,
	phase: 0,
	mul: EnvGen.kr(
		envelope: Env.perc,
		doneAction: 2)
)}.play;
)

// Another way of writing the same thing:
(
{var env = EnvGen.kr(envelope: Env.perc, doneAction: 2);
	SinOsc.ar(
		freq: 440,
		phase: 0,
		mul: env)
}.play;
)

// This could all fit in one line, using "abbreviations":
{SinOsc.ar(440, 0, EnvGen.kr(Env.perc, doneAction: 2))}.play;

// Back to the more verbose mode to make it easier to understand.
// Let's make the percussive envelope to last longer.
(
{SinOsc.ar(
	freq: 440,
	phase: 0,
	mul: EnvGen.kr(
		envelope: Env.perc(
			attackTime: 0.01,
			releaseTime: 2), // 2 seconds duration
		levelScale: 0.1, // this is for amplitude of the envelope
		doneAction: 2)
)}.play;
)

// Now -- remember how to generate random numbers within a given range?

rrand(100, 500);

// Use this structure to choose a random note every time you
// evaluate the SinOsc code above.
// Feel free to experiment the same thing with other parameters.



)


(
{SinOsc.ar(
	freq: 440,
	phase: 0,
	mul: EnvGen.kr(
		envelope: Env.perc(
			attackTime: rrand(0.01, 0.1),
			releaseTime: rrand(1, 2),
			level: 0.4),
		doneAction: 2)
)}.play;
)



(
{SinOsc.ar(
	freq: 440,
	phase: 0,
	mul: EnvGen.kr(
		envelope: Env.linen(
			attackTime: 0.02,
			sustainTime: 5,
			releaseTime: 1,
			level: 1,
			curve: 'lin'),
		doneAction: 2)
)}.play;
)