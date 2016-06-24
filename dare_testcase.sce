//dare test cases
// example taken from https://sourceforge.net/p/octave/control/ci/f7d0ce2cad551ee1dc57af498ff9dcbb94db6ae1/tree/inst/dare.m#l220
 a = [ 0.4   1.7;0.9 3.8];
 b = [ 0.8 ;2.1];
 c=[1 -1];
 r=3;
 [x y z]=dare(a,b,c.'*c,r)
