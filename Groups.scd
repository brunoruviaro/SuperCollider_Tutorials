// ------- //
// GROUPS
// ------- //


// Using groups to organize order of execution



// Watch everything in the NodeTree
s.plotTree;


// Define groups in proper order
~sources = Group.new
~effects = Group.new(~sources, \addAfter);
~master = Group.new(~effects, \addAfter);

// Create some buses
~reverbBus = Bus.audio(s, 2);
~masterBus = Bus.audio(s, 2);


// This is the source sound
{Out.ar(~reverbBus, SinOsc.ar([800, 880])*LFPulse.ar(2)*0.1)}.play(~sources);

// This is some reverb
{Out.ar(~masterBus, FreeVerb.ar(In.ar(~reverbBus, 2), mix: 0.5, room: 0.9))}.play(~effects);

// Some silly master volume control with mouse
{Out.ar(0, In.ar(~masterBus) * MouseY.kr(0, 1))}.play(~master)

