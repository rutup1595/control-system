
function[fr]=evalfr(sys,f)
    //
    //Calling Sequence
    //function[fr]=evalfr(sys,f)
    //Parameters
    //sys- SISO or MIMO or array of SISO models 
    //f - complex frequency at which  the response is to be evaluated
    //Description
    //evalfr calculates frequency response at complex frequency f
    //calculates the frequency response for continuous or discrete time linear model of 'sys' at complex frequency 'f'
    // this is simplified version of  the repfreq function however evalfr is defined for calculating the response at a single point only
    //Examples:
    // 1.z=poly(0,'z');
    //sys=syslin('d',(z-1)/(z^2+z+1));           
    //p1=evalfr(sys,1+%i)
    // 2.aa=pid(rand(2,2,1),3,4,5);
    //p2=evalfr(aa,1+%i)
    //3. bb=syslin('c',[1,3;4,5],[5,6;8,9],[2,3;4,5],[1,2;8,9]);
    //p3=evalfr(bb,1+%i);
    // 4.s=poly(0,'s');
    //ab=syslin('c',(s+2)/(s^2-2*s+8));
    //p4=evalfr(ab,2)
    //See also
    // ndims,repfreq,horner
    //Authors
    //Rutuja Moharil
    //Bibliography
    //http://www-rohan.sdsu.edu/doc/matlab/toolbox/control/ref/evalfr.html
   [lhs,rhs]=argn(0);
   if lhs >1 then
       error("Too many output arguments")
   end
    if rhs==2 then 

    z=poly(0,'z');                                                    //define z and s as polynomials
    s=poly(0,'s');
    if (imag(f)==[]|imag(f)==0) then                                  //check whether desired point is a complex number 
        error('enter complex frequency only');
    else
        select typeof(sys)
        case "state-space" then                                           // check if the system is state space model
            sys=ss2tf(sys)                                                 // convert state space to continuous time model
        end;
        if (ndims(sys)==3) then                                           // check the size of matrix : (array of SISO of 3D matrix)
            t= cell(size(sys,'r'),size(sys,'c'),size(sys,3))               // creating cell array of empty matrices
            for i=1:size(sys,'r') 
                for j=1:size(sys,'c')
                    for k=1:size(sys,3)
                        t(i,j,k).entries=horner(sys(i,j,k),f)                 //evaluate the polynomial at f
                        fr(i,j,k)=t(i,j,k).entries                            //extracting the sub cell values and display as matrix
                    end
                end
            end
        else                                                  //condition for SISO and MIMO systems
            t=horner(sys,f)                                               //evaluate the polynomial at f
            fr=t;
        end
    end
else 
    error("Not enough input arguments.")
 end
endfunction
