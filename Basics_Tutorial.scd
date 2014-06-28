////////////////////////
// SUPERCOLLIDER BASICS
////////////////////////

// HOW TO EVALUATE
// START AND STOP SOUND
// WRITING COMMENTS
// MESSAGES AND ARGUMENTS
// NESTING
// RECEIVER NOTATION, FUNCTIONAL NOTATION
// ENCLOSURES
// VARIABLES

// How to evaluate a line:
// [ctrl+Enter]

// Use a semicolon to end your lines.
// Evaluate lines below and see the results.

"Hello World".postln;

// Get yourself some GUI:

s.meter; // same as [ctrl+M]

// Make some sound:

{SinOsc.ar(440, 0, 0.1)}.play; // simple oscillator; how to stop it?

// How to stop all sounds:
// [ctrl+period]

// WRITING COMMENTS
// This is a comment.
// Anything written after two slashes is a comment.
// Write a lot of comments in your code. You will not regret.

"This is not a comment".postln; // THIS is a comment!

rrand(1, 10); // generate a random number between 1 and 10

// The word "rrand" above is what we call a "method."
// The numbers in parenthesis are the arguments.

x = rrand(1, 10); // store into a variable
x.postln; // there it is

y = ["hello", 90, 44, 11, x, 945]; // this is an array (a collection of items)

y.postln;

y.at(1); // retrive an item by index (starting at 0)
y[1]; // shortcut, same as line above


// Help files! Use them. Also available online: http://doc.sccode.org/
// Also, select any valid word in SC code and type ctrl + D. The corresponding help file will appear.

// Below, more "grammar" stuff to understand the language... read on!
// NOTE:
// If the section below seems to dry for you at this point, try
// the more friendly tutorial "Patterns_Intro" and come back here later on.

//////////////////////////
// MESSAGES AND ARGUMENTS
//////////////////////////

// Message: a lowercase word followed by a pair of parentheses containing a list of arguments.
// Arguments: lists of items separated by commas, inside parentheses, next to a message.

rand(100); // evaluate this several times, and watch the post window

rand(100.0); // if you use a float, a float is returned

exprand(1.0, 100.0); // a message with 2 arguments

// More examples of messages with arguments:

dup("fun", 20); // Rebecca Black
round([3.365, 5.923, 1009.19]);
round([3.365, 5.923, 1009.199], 0.1);
sort([56, 12, 62, 71, 1, 53, 4]);
rrand(440, 880); // different from rand; this allows you to specify a range

///////////
// NESTING
///////////

round(dup({exprand(1,10)}, 25), 0.1);

// To "read" nested code, start from innermost nested message and work your way outwards:

exprand(1,10);
dup({exprand(1,10)}, 25);
round(dup({exprand(1,10)}, 25));

// Notice the difference between these two nested statements, by the way:

dup( exprand(1,10), 25);
dup( {exprand(1,10)}, 25); // more on this later


//////////////////////////////////////////
// RECEIVER NOTATION, FUNCTIONAL NOTATION
//////////////////////////////////////////

// Functional notation:

rand(100)

// Object.receiver notation:

100.rand

// The two statements above mean the same thing. You can use either way of writing.
// Another example, now with more than one argument:

dup("hello", 20); // functional notation
"hello".dup(20);  // same thing in receiver notation

// The first argument of a message can be placed in front of the message, separated by a dot.

// EXERCISE: How would you rewrite these statements?

{SinOsc.ar(440, 0, 0.2)}.play; // rewrite this using functional notation only

dup(round(rand(1000.0), 0.1), 5); // rewrite this using receiver notation only

// It's a matter of style and convention. Sometimes one method can be clearer than the other.
// "Things that begin with uppercase letters (like SinOsc) are nearly always written as receiver.messages" [p. 11]

//////////////
// ENCLOSURES
//////////////

// Four types: (parentheses), [brackets], {braces}, and "quotation marks"

// (PARENTHESES)
// Parentheses are used to enclose argument lists, as seen before.
// They can also be used to force precedence:
5 + 10 * 4   // SuperCollider goes left to right, regardless of operators.
5 + (10 * 4) // Want the multiplication first? You have to be explicit.

// Messages normally take precedence:
5 + 10.squared // 10 is squared first, then result is added to 5
(5 + 10).squared // 5 and 10 are added first, then the result is squared

// [BRACKETS]
// Brackets define a collection of items. One common type of collection is called an Array.
[10, 11, 12, 13, 14, 15, 16, 17, "wow"]
[10, 11, 12, 13, 14, 15, 16, 17, "wow"].reverse
[10, 11, 12, 13, 14, 15, 16, 17, "wow"].choose
[10, 11, 12, 13, 14, 15, 16, 17, "wow"].mirror
[10, 11, 12, 13, 14, 15, 16, 17, "wow"].size
[10, 11, 12, 13, 14, 15, 16, 17, "wow"].at(0)
[10, 11, 12, 13, 14, 15, 16, 17, "wow"] ++ 999
[60, 72, 70, 65].midicps.round(0.1)
["cat", "mouse", "dog"].choose.dup(10)

(1..10)       // ...dirty trick to quickly generate an array.
(1, 3 .. 20)  // Yes, maybe confusing in the beginning. Better face it early on though! :-)

// For a handy summary of common Array operations, see
"https://ccrma.stanford.edu/wiki/SuperCollider_Quick_Reference#Arrays".openDocument;

// {BRACES}
// Curly braces define functions. Functions perform specific tasks that are usually repeated several times, normally with different results.

rand(1000.0) // This just picks a random number and returns it
{rand(1000.0)} // This creates and a function and returns the function

// This line says: "pick a random number, duplicate it 5 times"
dup(rand(1000.0), 5)

// Whereas this line says: "pick this function, duplicate it 5 times"
dup({rand(1000.0)}, 5)

// The line above has a similar result as this:
[rand(1000.0), rand(1000.0), rand(1000.0), rand(1000.0), rand(1000.0)]

{100.rand}.dup(10); // Here's a function receiving the message dup
{100.rand}.dup(10).plot; // Here's a function receiving the message dup; the result of it receives the message plot
{100.rand}.dup(50).sort.plot;
{rrand(1, 10)}.dup(12).sort.reverse;
{SinOsc.ar(440, 0, 0.2)}.plot; // Here's a function receiving the message plot
{SinOsc.ar(440, 0, 0.2)}.play; // Here's a function receiving the message play
{SinOsc.ar(440, 0, 0.2)}.scope; // Here's a function receiving the message scope

// "QUOTATION MARKS"

"Hello Again, World".postln;

"Quotation marks are used to enclose a string of characters (including spaces) as a single unit".postln

{"All work and no play makes Jack a dull boy".postln}.dup(1000); "".postln;

// These are called "strings." If you use single quotes, you will create a symbol.

'symbol'

\symbol // same as above

[1, 2, 3, \symbol, 4, "a string", 5];

// Symbols may be interchangeable with strings (though not always).

"This is a great string".size
"This is a great string".at(5)
'This is a great symbol'.size

/////////////
// VARIABLES
/////////////

// Default set of SC variables: lowercase letters a through z.

(
a = 440;
b = 3;
c = "math operations";
[c, a, b, a*b, a+b, a.pow(b), a.mod(b)];
)

// Once you assign a default variable, it remains valid until you close SC or re-assign it.
// Evaluate the lines below in order:

a; // evaluate this; it is still 440
a = "not anymore";
a; // evaluate this; 440 is gone, string "not anymore" replaced it

// Compare these two assignments (variables e and f):
e = {100.rand}.dup(10).plot;
e; // What is stored here?

f = {{100.rand}.dup(10).plot};
f; // What is stored here?

e.value; // To whom is the message "value" being sent to? What is being returned?
f.value; // To whom is the message "value" being sent to? What is being returned?

// You can define variables in other ways as well.

// You can use the key word "var" to define a variable with limited scope:
(
var ccrma = [660, "Lomita", "Drive", "The Knoll"];
ccrma.postln;
ccrma = ccrma.reverse;
ccrma.postln;
)

// You can also declare variables of less limited scope using a tilde:

~knoll = [660, 1910, 1946, 1986, 1975, 1989, 2005, 2012, "you won't get rid of me so easily"];
~knoll.reverse;
~knoll;

/*
This will remain valid until you restart SuperCollider. They are called "environment variables."
From the SC Book: "(...) similar to the a to z ones, but user defined. They will work anywhere in your patch, in other patches, even in other windows. By contrast, the [local] variables [as ccrma above] will work only inside the function where they are declared." (p. 25)
*/

