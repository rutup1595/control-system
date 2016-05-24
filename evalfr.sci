// Author :Rutuja Moharil
//evalfr calculates frequency response at complex number f
//the function works for both SISO and MIMO model .
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
    if (ndims(sys)==3) then    // check the size of matrix : (array of SISO of 3D matrix)
       t= cell(size(sys,'r'),size(sys,'c'),size(sys,3)) // creating cell array of empty matrices
        for i=1:size(sys,'r') 
        for j=1:size(sys,'c')
            for k=1:size(sys,3)
                t(i,j,k).entries=horner(sys(i,j,k),f)   //evaluate the polynomial at f
                fr(i,j,k)=t(i,j,k).entries          //extracting the sub cell values and display as matrix
        end
    end
end
                else            //condition for SISO and MIMO systems
        t=horner(sys,f)       //evaluate the polynomial at f
     fr=t;
 end
 end
endfunction
