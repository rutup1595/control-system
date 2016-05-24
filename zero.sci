function[x,k]= zero(sys,varargin)
    n=length(varargin); //length of the input vairiable matrix
    if (n==1)  then      //for SISO systems
        select typeof(sys)   //check the system type
    case "state-space"
        sys=ss2tf(sys);
    end;
        if((strcmpi(varargin(1),'v'))==0) then 
            if (size(sys)==[1 1])
            x=roots(sys.num);  // extracting the zeros
       
[y,o]=factors(sys.num); //extracting gain
k=o;
else
    error('valid for SISO only')
end
else
    error('wrong variable')
end
else  
        if (size(sys)<>[1 ]) then
            k=[];
        select typeof(sys)
        case "rational"
            sys=tf2ss(sys);
       end;
        
[a b c d]=abcd(sys);
s=poly(0,'s');
sys=systmat(sys);
u=roots(det(sys));
pp=length(u);
for i=1:pp
s=u(i);
aa=horner(sys,s) 
if (rank(aa)<mtlb_size(aa)) then
    x=u;
else
    x=[];
end   
end 
end
end
endfunction

