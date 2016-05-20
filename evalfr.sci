// Author :Rutuja Moharil
//evalfr calculates frequency response at complex number f
//the function works for both SISO and MIMO model .It also works for an array of SISO model
function[fr]=evalfr(sys,f)
    z=poly(0,'z');               //define z and s as polynomials
    s=poly(0,'s');
    if (imag(f)==[]) then       //check whether desired point is a complex number 
        fr=[];
           else
    select typeof(sys)
    case "state-space" then     // check if the system is state space model
       sys=ss2tf(sys)          // convert state space to continuous time model
    end;
    if  (sys.dt=='c') then    // check if system is continuous
                s=f;
        t=horner(sys,s)       //evaluate the polynomial at f
        fr=t;
    else                      //if system is discrete
        z=f;
        t=horner(sys,z);      // evaluate the polynomial at f
        fr=t;
    end
end
endfunction
