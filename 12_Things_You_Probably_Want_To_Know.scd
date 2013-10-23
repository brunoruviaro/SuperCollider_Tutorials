////////////////////////////////////////////////////////////////
// 12 Tips for SuperCollider Beginners
////////////////////////////////////////////////////////////////


// *****************************************
// 1. MULTICHANNEL EXPANSION
// *****************************************

// Open the Server meter to see what's going on in these examples.

s.meter; // same as Ctrl + M shortcut

// This sends sound to the left channel (which is bus 0 in SC):
{SinOsc.ar(440, 0, 0.1)}.play;

// This sends sound to the left and right channels (bus 0 and 1):
{SinOsc.ar([440, 550], 0, 0.1)}.play;

// This sends sound to outputs 0, 1, and 2:
{SinOsc.ar([440, 550, 660], 0, 0.1)}.play;

// This sends sound to outputs 0, 1, 2, 3, 4, 5:
{SinOsc.ar([440, 550, 660, 100, 412, 1067], 0, 0.1)}.play;

/*
In the example above, you probably only hear the first two channels, unless you have a multichannel soundcard and more than 2 loudspeakers in your studio.

In a nutshell: everytime you provide an Array of arguments to a Synth, it will
"multichannel expand" to the number of elements in the array.
*/

// Read more about it here:
"Multichannel Expansion".help

// Or read online: http://doc.sccode.org/Guides/Multichannel-Expansion.html





// ***********************************
// 2. THAT FUNNY EXCLAMATION MARK
// ***********************************

// What is this?

30!4

// It simply creates an array containing
// the same item a number of times.
// Evaluate and see the results.
// Essentially, this is the same as writing:

Array.fill(4, 30);





// ******************************************
// 3. TWO DOTS WITHIN PARENTHESES
// ******************************************

// What is this?

(10..15);

// It's just another array trick. The following
// two lines produce the same result:

Array.series(6, 10);

(10..15); // shortcut form

/*

Note that each method implies a different way of thinking.

The shortcut allows you to think: "just start from 10 then go all the way up to (and including) 15". You don't necessarily think about how many items the array will end up having.

The Array.series allows you to think: "just give me an array with 6 items total, starting from 10". You don't necessarily think about who is going to be the last number in the series.

Also note that the shortcut uses parentheses, not square brackets. The resulting array, of course, will be within square brackets.

*/

// For a step different than 1, you can do this:
(10, 13 .. 20); // step of 3

// ...which gives the same result as:
Array.series(4, 10, 3);





// ***********************************
// 4. VOLUME CONTROL GUI
// ***********************************

s.volume.gui; // why not, right?





// ******************
// 5. QUICK RECORD
// ******************

// GUI with record button, volume control, mute button:

s.makeWindow

// When you press "record", the Post Window will show
// the path of the folder where the file will be saved.
// For more info,

Server.help; // scroll down to "Recording Support"
// Same doc file online:
// http://doc.sccode.org/Classes/Server.html





// **************
// 6.
// **************


// ************
// 7.
// ************


// ***********************************
// 8.
// ***********************************


// *************************
// 9.
// *************************


// ************************
// 10.
// ************************



// **************************************************************
// end of this tutorial
// **************************************************************