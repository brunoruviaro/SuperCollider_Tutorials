// ------------------ //
// CONTROL STRUCTURES //
// ------------------ //


10.do({ arg count; [count, "Hello"].postln  });



["file1", "file2", "file3"].do({ arg item, count; [count, item.reverse].postln });

[1, 2, 3, 4, 5].collect({arg bananaItem; bananaItem*2 })

~num = 100;

if(~num > 10, { "true".postln }, { "false".postln });

(
case
{~num == 0} { "WOW".postln }
{~num == 1} { "ONE!".postln }
{~num < 0 } { "negative".postln }
{ true } { "last case scenario".postln }
)