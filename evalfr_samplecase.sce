z=poly(0,'z');
sys=syslin('d',(z-1)/(z^2+z+1));            //example taken from http://in.mathworks.com/help/control/ref/evalfr.html
p1=evalfr(sys,1+%i)



aa=pid(rand(2,2,1),3,4,5);
p2=evalfr(aa,1+%i)


bb=syslin('c',[1,3;4,5],[5,6;8,9],[2,3;4,5],[1,2;8,9]);
p3=evalfr(bb,1+%i);

s=poly(0,'s');
ab=syslin('c',(s+2)/(s^2-2*s+8));
p4=evalfr(ab,2)
