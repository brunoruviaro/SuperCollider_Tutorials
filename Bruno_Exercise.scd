"SynthDefs_2013.scd".loadRelative;

// Exercise: create a short "plucked string etude" using one or more Pbinds. If you like, post your finished track to SoundCloud (include code)
(
Pbind(
	\instrument, "plucking",
	\scale, Scale.minor,
	\note, Pwhite(0, 7), // 0=C, 1=C#, 2=D, etc
	// \degree, 0 is middle C
	// \freq, ...in Herz
	// \midinote, 60 is middle C
	\dur, Pwhite(0.1, 1), //
	\amp, Pseq([0.4, 0.3], inf),
	\decay, 5,
	\coef, 0.7 // close to zero, bright; 1, muted
).play;
)

// How to write a rest! ;-)
(
Pbind(
	\note, Pseq([0, 1, 2, 3, 4, 5], inf),
	\dur, Pseq([0.1, 1, 0.4, Rest(0.1), 1), //
).play;
)

// How to record all the sound out from SuperCollider
s.record; // evaluate this to start recording
s.stopRecording; // evaluate this to stop recording


