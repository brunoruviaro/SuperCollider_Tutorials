SynthDef("PMCrotale", {
arg freq = 261, tone = 3, art = 1, amp = 0.8, pan = 0;
var env, out, mod;

env = Env.perc(0, art);
mod = 5 + (1/IRand(2, 6));

out = PMOsc.ar(freq, mod*freq,
	pmindex: EnvGen.kr(env, timeScale: art, levelScale: tone),
	mul: EnvGen.kr(env, timeScale: art, levelScale: 0.3));

out = Pan2.ar(out, pan);

out = out * EnvGen.kr(env, timeScale: 1.3*art,
	levelScale: Rand(0.1, 0.5), doneAction:2);
Out.ar(0, out*amp); //Out.ar(bus, out);

}).add;

SynthDef("blips", {
	arg freq = 25, numharm = 10, rel = 1, amp = 0.1;
	var snd, env;
	env = EnvGen.ar(Env.perc(releaseTime: rel), doneAction: 2);
	snd = Blip.ar([freq, freq*1.01], numharm, 0.3);
	snd = snd*env*amp;
	Out.ar(0, snd);
	}).add;

SynthDef("noisy", {
	arg freq = 110, amp = 0.2;
	var snd, env;
	env = EnvGen.ar(Env.perc(0.02, 0.1), doneAction: 2);
	snd = Mix(LFPulse.ar(
		freq: freq*[1, 5/2],
		iphase: 0.0,
		width: 0.5,
		mul: amp));
	snd = snd * env * amp;
	Out.ar(0, Pan2.ar(snd, 0.0));
}).add;

SynthDef("hihat", {arg amp = 0.5, att = 0.01, rel = 0.2, ffreq = 6000;
	var snd = WhiteNoise.ar(amp);
	var env = EnvGen.kr(Env.perc(att, rel), doneAction: 2);
	snd = HPF.ar(snd * env, ffreq);
	Out.ar(0, snd!2);
}).add;

SynthDef("snare", {arg amp = 0.1, sinfreq = 180, att = 0.01, rel = 0.2, ffreq = 2000;
	var snd1 = WhiteNoise.ar(amp);
	var snd2 = SinOsc.ar(sinfreq,0,amp);
	var env = EnvGen.kr(Env.perc(att, rel), doneAction: 2);
	var sum = HPF.ar(snd1 * env, ffreq)+(snd2*env);
	Out.ar(0, sum!2);
}).add;

SynthDef("kick", {arg amp = 0.3, sinfreq = 60, glissf = 0.9, att = 0.01, rel = 0.45;
	var gliss = XLine.kr(sinfreq, sinfreq*glissf, rel);
	var snd = SinOsc.ar(gliss);
	var env = EnvGen.kr(Env.perc(att, rel), doneAction: 2);
	snd = snd * env * amp;
	Out.ar(0, snd!2);
}).add;

SynthDef("kick3", {arg punch = 1, amp = 1;
    var freq = EnvGen.kr(Env([400, 66], [0.08], -3)),
	sig = Normalizer.ar(SinOsc.ar(freq, 0.5pi, punch).distort, 1) * amp
            * EnvGen.kr(Env([0, 1, 0.8, 0], [0.01, 0.1, 0.2]), doneAction: 2);
    Out.ar(0, sig ! 2);
}).add;

SynthDef(\harpsi, { |outbus = 0, freq = 440, amp = 0.1, gate = 1|
    var out;
    out = EnvGen.ar(Env.adsr, gate, doneAction: 2) * amp *
        Pulse.ar(freq, 0.25, 0.75);
    Out.ar(outbus, out ! 2);
}).add;

SynthDef("beating", {arg freq = 440, amp = 0.1, art = 1;
	var env, snd1, snd2;
	env = EnvGen.ar(Env.perc(0.01, art), doneAction: 2);
	snd1 = SinOsc.ar(freq);
	snd2 = SinOsc.ar(Line.kr(freq+15, freq, art));
	Out.ar(0, Pan2.ar(Mix([snd1, snd2]), 0, amp*env))
}).add;

SynthDef("defaultB", { arg out=0, freq=440, amp=0.1, pan=0, gate=1;
    var z;
    z = LPF.ar(
            Mix.new(VarSaw.ar(freq + [0, Rand(-0.4,0.0), Rand(0.0,0.4)], 0, 0.3)),
            XLine.kr(Rand(4000,5000), Rand(2500,3200), 1)
        ) * Linen.kr(gate, 0.01, 0.7, 0.3, 2);
    OffsetOut.ar(out, Pan2.ar(z, pan, amp));
}, [\ir]).add;

SynthDef("trig_demo", { |freq = 440, gate = 1, t_trig = 1|
    var env, sig;
	env = Decay2.kr(t_trig, 0.01, 0.1);
    sig = SinOsc.ar(freq, 0, env);
	sig = sig * Linen.kr(gate, 0.01, 0.1, 0.1, doneAction: 2);
    Out.ar(0, sig ! 2)
}).add;

SynthDef(\bass, { |freq = 440, gate = 1, amp = 0.5, slideTime = 0.17, ffreq = 1100, width = 0.15, detune = 1.005, preamp = 4|
    var sig, env;
	env = Env.adsr(0.01, 0.3, 0.4, 0.1);
    freq = Lag.kr(freq, slideTime);
    sig = Mix(VarSaw.ar([freq, freq * detune], 0, width, preamp)).distort;
	sig = sig * amp * EnvGen.kr(env, gate, doneAction: 2);
    sig = LPF.ar(sig, ffreq);
    Out.ar(0, sig ! 2)
}).add;

SynthDef(\kik, { |basefreq = 50, ratio = 7, sweeptime = 0.05, preamp = 1, amp = 1, decay1 = 0.3, decay1L = 0.8, decay2 = 0.15, out|
    var fcurve = EnvGen.kr(Env([basefreq * ratio, basefreq], [sweeptime], \exp)),
        env = EnvGen.kr(Env([1, decay1L, 0], [decay1, decay2], -4), doneAction: 2),
        sig = SinOsc.ar(fcurve, 0.5pi, preamp).distort * env * amp;
    Out.ar(out, sig ! 2)
}).add;

SynthDef(\kraftySnr, { |amp = 1, freq = 2000, rq = 3, decay = 0.3, pan, out|
	var sig = PinkNoise.ar(amp),
	env = EnvGen.kr(Env.perc(0.01, decay), doneAction: 2);
	sig = BPF.ar(sig, freq, rq, env);
	Out.ar(out, Pan2.ar(sig, pan))
}).add;

"SynthDefs_2013.scd loaded".postln;
"".postln;


/*
x = Synth.new("hihat");
x = Synth.new("snare");
x = Synth.new("kick");
x = Synth.new("kick2");
*/