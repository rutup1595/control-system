//author :Rutuja moharil
// zero pole gain plot
//returns the zeros z, poles p, and gain(s) k and sample time Ts of the zero-pole-gain SISO and MIMO model sys.
function[x,t,o,dt]= zpkdata(sys,varargin)
    n=length(varargin); //length of the input vairiable matrix
    
   select typeof(sys)   //check the system type
    case "state-space"
        sys=ss2tf(sys);  //convert state space to tf model
    end;
    
    if (n==1)  then      //for SISO systems
        if((strcmpi(varargin(1),'v'))==0) then   //check whether the string 'v' is entered 
            
     x=roots(sys.num);  //extracting the zeroes
    t=roots(sys.den);  // extracting the poles
       
[y,o]=factors(sys.num); //extracting gain
o=o;
dt=sys.dt              // extracting sampling time
else
    error('specify proper variable input')
     
   end

       
       else if(n==0)       //for MIMO and array of SISO systems
    

    m = size(sys);
nd = length(m);

   if(nd>2) then
       x=cell(size(sys,'r'),size(sys,'c'),size(sys,3))
       y=cell(size(sys,'r'),size(sys,'c'),size(sys,3))
       o=cell(size(sys,'r'),size(sys,'c'),size(sys,3))
    for i=1:size(sys,'r')
        for j=1:size(sys,'c')
            for k=1:size(sys,3)
                x(i,j,k).entries=(roots(sys(i,j,k).num));
           
                
      //extracting the zeroes
  t(i,j,k).entries=roots(sys(i,j,k).den); 
                               // extracting the poles
                              // [y,m]=factors(n);
                              
 [y,nn]=factors(sys(i,j,k).num);
o(i,j,k).entries=nn;
    //        b= t(:,:,l);
      //      c=k(:,:,l);
       dt=sys.dt;
              
    end 
end
end

else 
    x=cell(size(sys,'r'),size(sys,'c'))
    t=cell(size(sys,'r'),size(sys,'c'))
   o=cell(size(sys,'r'),size(sys,'c'))
        for i=1:size(sys,'r')
        for j=1:size(sys,'c')
            x(i,j).entries=roots(sys(i,j).num);
            
        
            t(i,j).entries=roots(sys(i,j).den);
                
[y,nn]=factors(sys(i,j).num);
    o(i,j).entries=nn;
    dt=sys.dt
    //        b= t(:,:,l);
      //      c=k(:,:,l);
       
          
      end
  end
     
    end
 end

  end              
   endfunction
