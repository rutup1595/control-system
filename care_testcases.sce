//care test cases
//examples taken from https://sourceforge.net/p/octave/control/ci/f7d0ce2cad551ee1dc57af498ff9dcbb94db6ae1/tree/inst/care.m#l241
c = [ 1  -1];
r = 3;
a=[-3 2;1 1];
b = [ 0;1];
[x y z]=care(a,b,c.'*c,r)



 a = [ 0.0  1.0
       0.0  0.0];

 b = [ 0.0
       1.0];

 c = [ 1.0  0.0
       0.0  1.0
       0.0  0.0];

 d = [ 0.0
       0.0
       1.0];
 [x, l, g] = care (a, b, c.'*c, d.'*d);
