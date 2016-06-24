a = [-0.5572, -0.7814; 0.7814, 0];
c = [1.9691  6.4493];                    //example taken from http://in.mathworks.com/help/control/ref/initial.html
sys=syslin('c',a,zeros(2,1),c,[0]);
y1=initial(sys,'b',[1;0])



aa=ssrand(2,3,2);
aa1=syslin(1,aa.a,aa.b,aa.c,aa.d);    
y2=initial(sys,'b',aa1,'r',[1;0]);

//initial(sys,'b',aa1,'r',[1;0])

sysa=syslin(1,a,zeros(2,1),c,[0]);
y3=initial(sysa,'r',[1;0])
y4=initial(sys,'b'sysa,'r',[1;0])

[y t x]=initial(sys,'b',[1;0]);
