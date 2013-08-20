////////////////////////////////////////////////////////////////
// 10 Things You Need To Know  (SuperCollider Total Beginner) //
////////////////////////////////////////////////////////////////


// *****************************
// 1. EVALUATE: CONTROL + ENTER
// *****************************

// Use Ctrl + Enter to evaluate a line or a code block in SuperCollider.
// On a Mac, use the "command" key instead of control.
// Try it: put your cursor anywhere on the line below and hit Ctrl + Enter.
// Watch the post window for the result.

2 + 2 + 10;

// ********************************
// 2. BOOT THE SERVER: CONTROL + B
// ********************************

// SuperCollider will only make sound if its "sound engine" (the Server)
// is turned on. Hit Ctrl + B to boot the Server. Alternatively, you can
// right-click on the numbers on the bottom right of the SC window (where
// it says "Server"), and choose "Boot Server" from the menu. When the
// Server is on, those numbers will be in green color. After booting
// the Server, run the line below to test that you can make sound:

{SinOsc.ar(freq: MouseY.kr(300, 2000), mul: Line.kr(0.2, 0, 10))}.play;

// (Move your mouse up and down just for fun. Sound will fade out in 10 seconds.)


// **************************************
// 3. STOP ALL SOUNDS: CONTROL + PERIOD.
// **************************************

// Before blasting more sounds through the speakers, it's a good idea to
// know how to stop all sounds. The shortcut you will be using all
// the time is Ctrl + period. Run the two lines below to make some
// white noise that starts soft and slowly gets louder. Stop the
// sounds with Ctrl + period when you feel like.

{WhiteNoise.ar(Line.kr(start: 0, end: 1, dur: 60))}.play;



// ***********************************
// 4. END YOUR LINES WITH A SEMICOLON
// ***********************************

// Indicate the end of a line of code by putting a semicolon at the end:

"This is a line of code".postln;

[1, 2, 3, 4, 5].reverse; // line ends at semicolon

// Yes, you will occasionally see lines that do not use it;
// Yes, you will see that in some situations it works just the
// same without the semicolon, and then you may be tempted to
// leave some semicolons out, or you may just forget it sometimes.
// Still, if you get into the habit of always ending your lines
// with semicolons, you may save yourself from some trouble in the future.


// **************
// 5. CODE BLOCK
// **************

// Often you will want to run several lines of code with a single
// keystroke. You can always select all lines and then evaluate them,
// but a handy alternative is to enclose all your code within parentheses.
// The "code block" between those parentheses will be evaluated at once
// (line by line, in order). You can have your cursor *anywhere* inside
// the block and Ctrl + Enter will work just the same!

(
"This is the first line".postln;
"This is the second line".postln;
8 + 8; // this is the third line
"This is my last line".postln;
)

// **************
// 6. PRECEDENCE
// **************

// Multiplication and division will NOT go first.
// SuperCollider goes in order.

5 + 2 * 2; // equals 14, not 9.

// If you want to force a specific order of operations, use parentheses:

5 + (2 * 2); // equals 9.

// ************
// 7. COMMENTS
// ************

// All text that you see in RED is a "comment".
// If you are new to programming languages, comments are a very
// useful way to document your code, both for yourself and for
// others who may have to read your code. Any line that starts
// with a double slash is a comment. You can write comments
// right after valid lines of code; the comment part will be
// ignored when you evaluate.

2 + 5 + 10 - 5; // just doing some math
rrand(10, 20); // generate a random number between 10 and 20

// You can evaluate a line even if your cursor is in the middle
// of the comment after that line. The comment part is ignored.

// If you write a really long comment, your text may break into what looks like a new line that does *not* start with a double slash. That still counts as a single line of comment: as you can see, this whole bunch of text is all in RED because it belongs to the same line that begins with a double slash above. I am being verbose here just to make the point... ;-)

/* Now, if you would like to "comment out" a big section of code comprising several lines, you can use the combination "slash + asterisk" to open and "asterisk + slash" to close a big chunk of code that you want to comment out. A nice trick to comment and "un-comment" a big section is to select the whole thing and hit Ctrl + slash. Try it with this paragraph. */

// ***********************************
// 8. HOW TO CLEAN UP THE POST WINDOW
// ***********************************

// Sometimes it is a good idea to clean up the Post Window
// of all the stuff that got printed there. There is a great
// shortcut for that: Ctrl + Shift + P. Try it now.

// Now evaluate this line and clean the Post Window afterwards:

1000.do({"Print this line over and over...".postln});


// *************************
// 9. POSTLN IS YOUR FRIEND
// *************************

// You can explicitly request to SuperCollider to "post"
// some data on the Post Window. This is useful to debug
// your code or just to learn more about what is going on.
// Evaluate the code block below and watch the Post Window.

(

"You will not see on the Post Window the result of 76 + 10".postln;

76 + 10; // the calculation is made, but there's no request to post it.

"...but you WILL see the result of 7 + 7 in the following line".postln;

(7 + 7).postln; // this line says, "post the result of seven plus seven"

"This is a line of this block that it won't get posted";

"Bye".postln;

)

// All lines above are evaluated in order. We get to see the results
// of those that end with "postln", but not those without a postln.
// "So why does the following line gets posted anyway?", you may ask.

76 + 10; // no postln; why do we see the results posted?

// Answer: by default, SuperCollider always "dumps" on the Post Window
// whatever was the last result of the last evaluated function. So the
// result of the sum above is the last thing that results, thus it
// gets posted. Try evaluating the small code block below:

(
100 + 11;
7 + 7;
)

// Both lines are evaluated, but the last thing that "returns"
// is the number 14. This is what gets posted. This is way the
// word "Bye" in the earlier example was printed twice on the
// Post Window (did you notice it?): the first time as the
// result of a explicit call to postln, the second time because
// it was the very last thing that resulted from that evaluated block.
// Understanding this, and understanding how to use postln effectively
// is VERY helpful to debug and better understand your code.


// ************************
// 10. USE THE HELP FILES
// ************************

// Find help by selecting an Object or method in the code
// and hitting Ctrl + D (for "Documentation"). This also works
// if you simply place your cursor within the word to be looked up.
// Sometimes you end up directly on a Help file, sometimes on a menu with
// links to relevant Help files. Evaluate the line below just to see what it
// does, then try placing your cursor anywhere inside the word "scramble",
// then hit Ctrl + D:

[1, 2, 3, 4, 5, 6].scramble;

// You will see that "scramble" is a method that can be used with Objects
// such as Array, List, or String. In the example above we have an Array.
// Click on the word "Array" on the Help browser and you will be taken
// directly to the explanation.

// Not sure what an Array is? Either use the "Search" function in the Help
// Browser or, often, you can just type the Object name and Ctrl + D:

Array // try Ctrl + D on this word, see help browser
SinOsc // try Ctrl + D on this word, see help browser


// **************************************************************
// end of this tutorial
// **************************************************************