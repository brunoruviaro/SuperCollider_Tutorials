Window.closeAll; // use this to close all windows

// If you still have your crickets saved as ~c1, ~c2, etc..
// then they should play right out of the box with this patch.
// Evaluate the region of code below and look for the little
// red window that pops up (may be behind other windows).
// Once you find the window with the button, CRICK IT!

(
var availableBounds = Window.availableBounds;
var width = 150;
var height = 50;
var xbound = availableBounds.width - width;
var ybound = availableBounds.height - height;

Window.closeAll;

~fade = {arg win;
	var rout, steps = 100;
	rout = Routine {
		    steps.do({ arg i;
			i = steps - i / steps;
			//i.postln;
			{win.view.background = Color.red(0.5,i)}.defer(0);
			0.01.wait;
		    });
    "evaded...".postln;
}.play;
};

~makeWindow = { var w, b;
    // Create new window somewhere
	w = Window.new(
		name: "Cricket",
		bounds: Rect.new(
			left: xbound.rand,
			top: ybound.rand,
			width: width,
			height: height),
		resizable: false,
		border: true
	).front;
	// Create button;
	b = Button.new(w, Rect(0,0,width,height));
	b.states = [["Crick It!", Color.white, Color.red(0.7, 0.9)]];
	b.action = {
		~makeWindow.value;
		~fade.value(w);
		b.visible_(false);
		[~c1, ~c2, ~c3, ~c4].choose.play;
		"chirp".postln};
	//b.action = b.visible_(false), ~makeWindow;
};

~makeWindow.value;

)