// "Hanon" -- exercises of technique for SuperCollider
// how about writing a class for supercollider challenges?

/// You would use it like this:

FormantTable

Hanon.exercise(2); // show me prompt of exercise #2

Hanon.solution(2); // show me the solution of exercise #2

Hanon.random; // random choice of exercise;

Hanon.exercise(2).hint; // request a hint for the solution


// Exercises would look like this. Short prompts (challenges) defining a musical idea or concept.
// The musician then tries to solve it using in SuperCollider code.

/*

Play an ascending scale that:

- starts one octave below middle C
- goes up mostly by stepwise motion
- has a total of 24 notes.

Specify a different probability (weight) for each of the possible interval steps.

*/

// Solution
(
Pbind(
	\midinote, Pseries(48, Pwrand([1, 2, 3], [0.4, 0.5, 0.1], 24)),
	\dur, 0.2
).play;
)




/*
The choice of "Hanon" as the name for this class comes James Harkins, who used this analogy while discussing pedagogy of computer music. See thread from 2013-12-12.

From Wikipedia -- criticism of Hanon, The Virtuoso Pianist
"The most common criticism of the Hanon exercises is that having students drill on purely physical exercises results in an unmusical, mechanistic attitude toward the piano. Critics argue that practicing in an unmusical way dulls one's musical instincts, especially when forced upon children and beginners, who need to cultivate their musicality rather than inure themselves to rote physicality. It is also argued that it is more efficacious to practice one's musicality as one practices one's technique; training in most art forms involves practicing technique, however repetitively, within artistic context. It is further argued that musicality drives technique; the flow of musical expression is a potent motivator to finger agility. In the notes accompaning his work Hanon considered his exercises less "dry" than other exercises."
*/