// ============
// ENCLOSURES
// ============
// This tutorial is adapted from the SuperCollider Book -- chapter 1 by David Cottle.

/*

There are four types of enclosures (parentheses), [brackets], {braces}, and "quotation marks".

It is important to keep these pairs matched or “balanced” as you write code: everything that you open needs to be closed at some point later in the code. Nesting can make balancing difficult and confusing. (...) The SuperCollider language editor has some tools to help you keep track. For example, the SuperCollider IDE automatically indicates matching parentheses when you close a pair (they show up in red); and you can double click a parenthesis to select everything within. If you click on a parenthesis that lacks an opening/closing match, you will see a dark red selection telling you your are missing something. Balancing is a quick way to select large sections of code for evaluation, deletion, or copy/paste operations.

*/





////////////////////
// Quotation marks
////////////////////

/* Quotation marks are used to enclose a string of characters (including spaces) as a single unit. These are aptly called strings. Single quotes create symbols, which are similar to strings. You can also make a symbol by preceding some text with a backslash. Thus 'aSymbol' and \aSymbol are equivalent. Symbols are often used as labels for parameters and are sometimes, but not always, interchangeable with strings. See the Symbol and String help files for more information. */

"Here's a nice string";

'aSymbol';





///////////////
// Parentheses
///////////////

// Parentheses can be used to enclose argument lists, as in this example:

rrand(0, 10);

// They can also force precedence, which is the order in which things get done.
// For example, compare

5 + 10 * 4;
5 + (10 * 4);

// Parentheses are also used to cread code blocks
// (multiple lines of code to be evaluated together)
(
"first line".postln;
(9 + 9).postln;
"last line".postln;
)




/////////////
// Brackets
/////////////

// Brackets define a collection of items.

[1, 2, 3, 4, "hello"];

/* An Array (one type of collection) can contain numbers but also text, functions, or entire patches. You can even mix data types within an array. Arrays can receive messages such as reverse, scramble, mirror, rotate , midicps, choose, and permute, to name a few. You can also perform mathematical operations on arrays. */

[1, 2, 3, 4, "hello"].scramble;

[1, 2, 3, 4, "hello"].mirror;

[1, 2, 3, 4] + 10;

// convert midi to frequency in Hz
[60, 62, 64, 65, 67, 69, 71].midicps.round(0.1);





/////////////////
// Curly Braces
/////////////////

/* Braces (or “curly braces”), the last enclosure, define functions. Functions perform specific tasks that are usually repeated, often millions of times and often with different results. Try these lines, one at a time. */

exprand(1, 1000.0);

{ exprand(1, 1000.0) };

/* The first line picks a random number, which is displayed in the post window. The second prints a very different result: a function. What does the function do? It picks a random number. How can that difference affect code? Consider the lines below. The first chooses a random number and duplicates it. The second executes the random-number-picking function 5 times and collects the results in an array. */

dup(rand(1000.0), 5);  // picks a number, duplicates it

dup({rand(1000.0)}, 5);  // duplicates the function of picking a number

// essentially, this (which has a similar result)
[rand(1000.0), rand(1000.0), rand(1000.0), rand(1000.0), rand(1000.0)]


{ LFNoise0.ar }.play;  // play a series of random numbers (careful: loud)
{ LFNoise0.ar(10000) }.plot; // plot those numbers

{ 100.rand }.dup(10) // pick 10 random numbers
{ 100.rand } ! 10 // same as above
{ 100.rand }.dup(10).postln.plot // pick 10 numbers, post, plot
{ 100.rand }.dup(100).sort.plot // pick 100 numbers, sort, plot





/* In Summary:
Receivers, messages, and argument lists: object.message(arglist)
Collections: [list, of, items]
Functions: { often multiple lines of code }
Strings: "words inside quotes"
Symbols: 'words inside single quotes' or preceded by a backslash (\)
