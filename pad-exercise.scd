(
play{
      var freq = { [60,64,65,67].choose.midicps * LFNoise2.kr(1,0.01,1) }!24;
      var gen = LFSaw.ar(freq) * 0.1;
      var fmod = LFCub.kr(1/12).range(1, MouseX.kr(2,16));
      var rqmod = LFNoise2.kr(1/8).range(0.1,1.0);
      var snd = RLPF.ar(gen, freq * fmod, rqmod);
      Splay.ar(snd)}
)



{LFNoise2.kr(1,0.01,1).poll(1)}.play\\[