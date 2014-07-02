// ============================================
// Simple MIDI-controlled sampler
// 2011-11-07, BTR
// 2014-07-02 (update), BTR
// ============================================

// ************
// LOAD SAMPLES
// ************

~buffers = "/home/ruviaro/Music/Sounds/caminhos-cruzados-short-samples/stereo/*/*.wav".pathMatch.collect({ arg i;  Buffer.read(s, i)});

~buffers[3]
~buffers.size

// Buffer.freeAll

// Quick test
{PlayBuf.ar(2, ~buffers[rrand(0, (~buffers.size-1))])}.play; // number of channels and buffer


// *********
// SYNTHDEF
// *********

// Create a SynthDef

(
SynthDef("midi-sample-playback", {
	arg bufnum = 0, rate = 1, amp = 1, gate = 1;
	var snd, env;
	env = EnvGen.ar(
		envelope: Env.adsr(
			attackTime: 0.01,
			decayTime: 0.3,
			sustainLevel: 0.5,
			releaseTime: 0.3),
		gate: gate,
		doneAction: 2);
	snd = PlayBuf.ar(2, bufnum, BufRateScale.kr(bufnum) * rate, loop: 1);
	snd = snd * env * amp;
	Out.ar(0, snd)
}).add;
)

// test
f = Synth("midi-sample-playback", [\bufnum, rrand(0, 30).postln, \rate, 1.1]);

f.set(\rate, 2);
f.set(\gate, 0);
f.release; // shortcut to .set(\gate, 0)


// MIDI STUFF

MIDIIn.connectAll;

// note on becomes bufnum
// note off sends gate=0 --> release envelope

(
var midiSamplerArray = Array.newClear(128);    // array has one slot per possible MIDI note

MIDIdef.noteOn(key: \sampleOn,
	       func: { arg velocity, noteNumber;
   		 midiSamplerArray[noteNumber] = Synth("midi-sample-playback", [
			\bufnum, noteNumber.linlin(41, 72, 0, ~buffers.size-1),
			\rate, velocity.linlin(0, 127, 0.95, 1.5),
			\amp, velocity.linlin(0, 127, 0, 1)
			])});

MIDIdef.noteOff(key: \sampleOff,
	        func: { arg velocity, noteNumber;
			midiSamplerArray[noteNumber].set(\gate, 0)});

)

// Note that in my sampler I chose to use velocity not only for amplitude, but also to change sample playback rate.



/*
http://new-supercollider-mailing-lists-forums-use-these.2681727.n2.nabble.com/Using-SC-with-MIDI-sequencer-or-keyboard-td3684526.html#a3686405
*/
