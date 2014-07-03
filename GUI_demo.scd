
// Summary of Nick Collins' tutorial 4.2 - Graphical User Interfaces

// ********
// WINDOW
// ********

// How to make a window
// The Rect(angle) takes the initial screen position and the window size
// as screenx, screeny, windowwidth, windowheight, where screeny is 0 at the bottom

(
var w;
w = Window("My Window", Rect(100, 500, 200, 200));
// How the read the line above: "at screen co-ordinates (100, 500), create a 200x200 window"
w.front; // this line is needed to make the window actually appear
)

// A big window
(
var w;
w = Window("BIG Window", Rect(left: 100, top: 500, width: 600, height: 500));
w.front;
)

// *******
// SLIDER
// *******

(
var w, slid;

w = Window("My Window", Rect(100, 500, 200, 100));
slid = Slider(w, Rect(10, 10, 180, 40)); // a basic slider object of size 180 by 40 appears 10 pixels in from the left, and 10 pixels down from the top

slid.action_({slid.value.postln;}); // this is the callback: the function is called whenever you move the slider.
// action_ means to set up the slider object to use the function passed in as its argument.

w.front;
)

// Note how the default slider range is from 0.0 to 1.0
// In order to rescale slider range, remember linlin, linexp:

1.0.rand.linlin(0.0, 1.0, 14.7, 68.12)
1.0.rand.linexp(0.0, 1.0, 14.7, 68.12)


// ************
// ControlSpec
// ************

 // Rather than doing these remappings yourself, an alternative is to take advantage of a ControlSpec, a helpful class which can be used to turn input into any desired range through various available precanned mappings

(
var w, slid, cs;

w = Window("My Window", Rect(100, 500, 200, 100));
slid = Slider(w, Rect(10, 10, 180, 40));

cs = ControlSpec(
	minval: 20,
	maxval: 20000,
	warp: \exponential,
	step: 10,
	default: 1000);

slid.action_({cs.map(slid.value).postln;}); // map to the desired range

w.front;
)

// ***************************************
// Demo of using 2D-Slider for synthesis
// ***************************************

(
SynthDef(\filterme, {arg freq = 500, rq = 0.01;
	Out.ar(0, Pan2.ar(
		BPF.ar(Impulse.ar(LFNoise0.kr(15, 500, 1000), 0.1, WhiteNoise.ar(2)), freq, rq)))}).add;
)

(
var w, slid2d, syn, csfreq, csrq;

w = Window("My Window", Rect(100, 300, 200, 200));
slid2d = Slider2D(w, Rect(5, 5, 190, 190));

syn = Synth(\filterme);	// create synth

csfreq = ControlSpec(
	minval: 500,
	maxval: 10000,
	warp: \exponential,
	step: 1);

csrq = ControlSpec(
	minval: 0.01,
	maxval: 0.10,
	warp: \exponential,
	step: 0.01);

slid2d.action_({
	syn.set(\freq, csfreq.map(slid2d.y), \rq, csrq.map(slid2d.x));
	[csfreq.map(slid2d.y), csrq.map(slid2d.x)].postln;
});

w.front;

w.onClose = {syn.free};	// stops running synth when the window close button is pressed
)

// *********************
// KNOBs and FlowLayout
// *********************

(
w = Window("decoration", Rect(200, 200, 400, 500));
// set up decorator. FlowLayout needs to know the size of the parent window, the outer borders (10 pixels in on horizontal and vertical here) and the standard gap to space GUI views (20 in x, 20 in y)
w.view.decorator = FlowLayout(w.view.bounds, 10@10, 20@20);

// now, when GUI views are added to the main view, they are automatically arranged, and you only need to say how big each view is
k = Array.fill(10, {Knob(w.view,100@100).background_(Color.rand)});

w.front; // make GUI appear
)

// they were stored in an array, held in global variable k, so we can access them all easily via one variable
k[0].background_(Color.rand)


/////////////////
// Fun with GUI:

(
w = Window();
w.front;
{
	inf.do({
		{Slider(w, Rect(
			left: rrand(10, 290),
			top: rrand(10, 250),
			width: rrand(50, 150),
			height: rrand(50, 200)))}.defer;
		rrand(0.1, 0.3).wait;
		{w.view.children[0].remove}.defer;
		rrand(0.3, 0.5).wait;
	});
}.fork;
)
