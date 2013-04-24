
(
{Saw.ar(
	freq: MouseX.kr([40,41],80),
	mul: MouseY.kr(0,1)
)}.play
)



(
{Saw.ar(
	freq: MouseX.kr([30,31],120),
	mul: MouseY.kr(0,1)
)}.play
)



(
var env = Env.new([60, 40, 43], [0.2, 0.2]);
{Splay.ar(Saw.ar(
	freq: EnvGen.ar(env)*[2,3,4,5,7,9],
	mul: EnvGen.ar(Env.perc)*0.2;
))}.play
)

{Splay.ar(Saw.ar(EnvGen.ar(Env([60,40,43],[0.2,0.2]))*[2,3,4,5,7,9]))*EnvGen.ar(Env.perc)*0.2}.play

/*eclecticity*/ Ndef(\x, { SinOsc.ar(BrownNoise.ar(30!2, 200), Ndef(\x).ar * LFNoise1.kr(1!2,1,1)) }).play;