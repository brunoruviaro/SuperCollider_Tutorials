// ======
// OSCdef
// ======

/*
Simplest demo:

GOAL: to send OSC messages from a smartphone to your computer (or computer to computer)

- Install any free OSC app on your phone (for example, gyrosc);
- Find the IP address of your computer;
- Set the IP address of your computer into the OSC app (as 'target');
- Set the SC receiving port into the OSC app; (usually 57120)
- Check the exact message path that the app uses to send OSC to.
- In the example below I take a 0 or 1 message from a button on the phone.

If doing computer to computer, simply have SuperCollider running on both sides to receive and send.
See end of this file for an example of how to send a message to another computer.
*/


// SET UP OSCdef ON THE RECEIVING COMPUTER
// Simple OSCdef:
(
OSCdef(
	key: \postargs,
	func: {arg ...args; args.postln},
	path: '/stuff')
)

// Adjust the path above to whatever you want.
// On the OSC app, indicate the IP address of your computer and the port.
// This is the port SC uses to receive. Normally 57120 (sometimes 57121):
NetAddr.langPort; // evaluate to see


// As long as your phone is sending messages to the proper path, you should see them arriving on the computer.
// If sending messages from another computer (not a phone), SuperCollider can send OSC messages like this:

// USE THIS ON THE MACHINE SENDING MESSAGES
~destination = NetAddr("127.0.0.1", 57120); // use correct IP address of destination computer

~destination.sendMsg("/stuff", "heelloooo");




// ********************************************
// If you don't have another machine to send OSC messages from, try this:

(
OSCdef(
	key: \soliloquy,
	func: {arg ...args; args.postln},
	path: '/stuff')
)

~self = NetAddr("127.0.0.1", 57120); // send messages internally (from this computer to this computer)

~self.sendMsg("/stuff", "heelloooo");

// Here's a message being sent every 2 seconds:
SystemClock.sched(0,{~self.sendMsg("/stuff", "hello-from-me", 8888.rand); 2.0});







// ================================================
// since SC 3.5 you can open up additional ports:
thisProcess.openUDPPort(1121); // attempt to open 1121
// return true when it succeeded, false if not

thisProcess.openPorts; // list all open custom ports







