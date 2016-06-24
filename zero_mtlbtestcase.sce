s=poly(0,'s');
sys=syslin('c',(4.2*s^2 +0.25*s-0.004)/(s^2+9.6*s+17));  //example taken from http://in.mathworks.com/help/control/ref/zero.html
[z1 b1]= zero(sys)

aa=pid(rand(2,2,3),3,4,5);
[z2 b2]=zero(aa,1);

//execute for array(sys,1)

a=ssrand(2,2,3)
[z3 b3]=zero(a)
