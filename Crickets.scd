// 2013-04-13, Caltrain
// Updated on 2013-05-01

// Before starting the crickets, evaluate the big
// block of code that defines crickets ~c1, ~c2, etc.
// Then you can start the SystemClocks just below,
// which will play each cricket at the specified time intervals.

SystemClock.sched(0.0, { ~c1.play; rrand(1.5, 7.8)});
SystemClock.sched(0.0, { ~c2.play; rrand(1.9, 4.3)});
SystemClock.sched(0.0, { ~c3.play; rrand(1.5, 2.8)});
SystemClock.sched(0.0, { ~c4.play; rrand(1.7, 4.8)});

s.meter; // check the meter

// Evaluate the block below before anything (cricket definitions).
// Make sure the SC server is running (Ctrl + B).

(
// Cricket 1
~c1 =
{var dur = [0.3, 0.4, 0.5].choose;
	Mix.ar(LFPar.ar(
		freq: (1900, 1930 .. 2000),
		iphase: 0,
		mul: 0.05 * EnvGen.ar(Env.triangle(dur: dur), doneAction: 2)))
};

// Cricket 2
~c2 =
{var dur = [1.1, 0.8, 0.5, 0.7].choose;
	Mix.ar(LFPar.ar(
		freq: (1800, 1820 .. 2000),
		iphase: 0,
		mul: 0.05 * EnvGen.ar(Env.triangle(dur: dur), doneAction: 2)))
};

// Cricket 3
~c3 =
{var dur = [0.3, 0.4, 0.5].choose;
		FreeVerb.ar(
			in: Mix.ar(LFPar.ar(
				freq: (2700, 2720 .. 3000)+LFSaw.ar(1).range(40,1000),
				iphase: 0,
				mul: 0.05 * EnvGen.ar(Env.triangle(dur: dur), doneAction: 2))))
};

// Cricket 4 (bird-like)
~c4 =
{var dur = 0.3;
		FreeVerb.ar(
			in: Mix.ar(LFPar.ar(
				freq: (2800, 2820 .. 3000)+LFSaw.ar(10).range(40,1000),
				iphase: 0,
				mul: 0.05 * EnvGen.ar(Env.triangle(dur: dur), doneAction: 2))))
};

)













// END OF FILE

/*

Leftovers code (don't worry about the code below)

(
{LFSaw.ar(
  freq: [900, 990] + SinOsc.ar(1).range(50,100),
	iphase: 0,
	mul: LFPulse.ar(
		freq: SinOsc.kr([0.3, 1.4]).range(1/3, 1/5),
		iphase: 0,
		width: 0.1,
		mul: 0.01))
}.play;
)


(
// Cricket 1
~c1 =
{var dur = [0.3, 0.4, 0.5].choose;
	Splay.ar(
		inArray: LFPar.ar(
			freq: (1900, 1930 .. 2000),
			iphase: 0,
			mul: 0.1 * EnvGen.ar(Env.triangle(dur: dur), doneAction: 2)),
		spread: 1,
		level: 0.5)
};

// Cricket 2
~c2 =
{Splay.ar(
	inArray: LFPar.ar(
		freq: (1800, 1820 .. 2000),
		iphase: 0,
		mul: 0.1 * EnvGen.ar(Env.triangle, doneAction: 2)),
	spread: 1,
	level: 0.5)
};

// Cricket 3
~c3 =
{FreeVerb.ar(
	in: Splay.ar(
		inArray: LFPar.ar(
			freq: (2700, 2720 .. 3000)+LFSaw.ar(1).range(40,1000),
			iphase: 0,
			mul: 0.1 * EnvGen.ar(Env.triangle(dur: 0.3), doneAction: 2)),
		spread: 1,
		level: 0.5))
};

// Cricket 4 (bird-like)
~c4 =
{FreeVerb.ar(
	in: Splay.ar(
		inArray: LFPar.ar(
			freq: (2800, 2820 .. 3000)+LFSaw.ar(10).range(40,1000),
			iphase: 0,
			mul: 0.1 * EnvGen.ar(Env.triangle(dur: 0.3), doneAction: 2)),
		spread: 1,
		level: 0.5))
};
)


*/