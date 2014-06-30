"SynthDefs_2013.scd".loadRelative;


// -------------- //
// QUICK RECORDING
// -------------- //

// Start recording all SC output
// (Post window will indicate where file is saved)
s.record;

// Stop recording
s.stopRecording;

// IMPORTANT:
// Do not press ctrl+period BEFORE evaluating the line above -- control period kills everything, including the recording!!