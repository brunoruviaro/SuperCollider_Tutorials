// LOAD SOUND FILES
~buf1 = Buffer.read(s, "/home/ruviaro/Music/SuperCollider/wheels-mono.wav");
~buf2 = Buffer.read(s, "/home/ruviaro/Music/Sounds/mussorgsky-mono.wav");


// CREATE CONTROL BUSES
(
~kbus1 = Bus.control; // a control bus
~kbus2 = Bus.control; // a control bus
)


// START THE CONTROLS
(
a = {Out.kr(~kbus1, LFNoise1.kr(1).range(0.5, 1))}.play;
b = {Out.kr(~kbus2, LFClipNoise.kr(1/5))}.play;
)

e = Synth("control", [\par1, 1, \par2, 3]);

e.set(\par1, 15)

a.free; b.free;

// GRANDMASTER FLASH (LEFT), MUSSORGSKY (RIGHT)
(
{
	var speed, direction;
	speed = In.kr(~kbus1);
	direction = In.kr(~kbus2);
	Out.ar(0, PlayBuf.ar(1, [~buf1, ~buf2], (speed * direction), loop: 1) * 0.3);
}.play;
)
















