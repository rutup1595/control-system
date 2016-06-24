z=poly(0,'z');
sys1=syslin('d',z/(z-0.3));                                  //example taken from http://in.mathworks.com/help/control/ref/zpkdata.html
sys2=syslin('d',2*(z+0.5)/(z^2 -0.2*z+1.01));
a=[sys1,sys2];
[z1 p1 k1]=zpkdata(sys)



aa=pid(rand(2,2,3),3,4,5)
[z2 p2 k2]=zpkdata(aa)



ss=syslin('c',[1,3,4;4,5,6;1,0,9],[0,1,3;6,7,8;0,9,6],[1,2,3;6,4,5;0,1,1],[3,5,2;9,8,1;0,3,4]);

[z3 p3 k3]=zpkdata(ss);

