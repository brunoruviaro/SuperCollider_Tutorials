// --------- //
// MIDI demo //
// --------- //


// Quick way to connect all available devices to SC
MIDIIn.connectAll;


// Quick way to see all incoming MIDI messages
MIDIFunc.trace(true);
MIDIFunc.trace(false); // stop it

// Quick way to listen for a specific controller number
MIDIdef.cc(\someCC, {arg a, b; [a, b].postln});

// A Synth for quick tests
(
SynthDef("quick", {arg freq, amp;
	Out.ar(0, SinOsc.ar(freq, 0, amp) * EnvGen.kr(Env.perc, doneAction: 0));
}).add;
)

// Play from a keyboard
(
MIDIdef.noteOn(\someKeyboard, { arg vel, note;
	Synth("quick", [\freq, note.midicps, \amp, vel.linlin(0, 127, 0, 1)]);
});
)

// Create a pattern and play that from the keyboard
(
a = Pbind(
	\instrument, "quick",
	\degree, Pwhite(0, 10, 5),
	\amp, Pwhite(0, 0.1),
	\dur, 0.1
);
)

// test
a.play

// Trigger pattern from keyboard
MIDIdef.noteOn(\quneo, { arg vel, note; a.play });


// Listen only for cc #7 from channel 0
MIDIdef.cc(\someSpecificControl, {arg a, b; [a, b].postln}, ccNum: 7, chan: 0);



MIDIdef.cc(\quneoCCtyui, {arg value, ccNumber; "WOW".postln}, 22);


