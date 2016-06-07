//author : Rutuja Moharil
//zero function calculates the zeroes of the system .The system can be either SISO or array of SISO .
//this function is not defined for MIMO . thus this function considers any MIMO function as an array of SISO .
//to execute this function for SISO simply enter [x,k]=zero(sys)
//to execute this function for SISO array enter [x,k]=zero(sys,1)
function[x,k]= zero(sys,varargin)

    n=length(varargin);
    
    if (n==0) then
        select typeof(sys)
        case "state-space" then
            sys=ss2tf(sys);         
    end;
    if(size(sys)==[1 1]) then //check if the system is SISO
         x=roots(sys.num);  // extracting the zeros
       
[y,o]=factors(sys.num); //extracting gain
k=o;
else
    error('Wrong size for input argument Single input, single output system expected.')
end
else if(n==1 & varargin(1)==1) //check if user enters a SISO array
        aa=1;
    else
        aa=0;
    end
    select typeof(sys)
    case "state-space"
        sys=ss2tf(sys);
            end;
         
    if(size(sys)<>[1 1]&aa==0) then  //check for MIMO
         error('Wrong size for input argument Single input, single output system expected.')
     else 
         m = size(sys);  //find the size of array of SISO
nd = length(m);

   if(nd>2) then         //3-D matrix or hypermatrix case
       x=cell(size(sys,'r'),size(sys,'c'),size(sys,3))// creating cell array of empty matrices of zeroes
       for i=1:size(sys,'r')
        for j=1:size(sys,'c')
            for l=1:size(sys,3)
                x(i,j,l).entries=(roots(sys(i,j,l).num));  //extracting the sub cell values of zeroes and display as matrix
                [y,nn]=factors(sys(i,j,l).num);
k(i,j,l).entries=nn;

end
end
end
else
    x=cell(size(sys,'r'),size(sys,'c'))
    for i=1:size(sys,'r')
        for j=1:size(sys,'c')
            x(i,j).entries=roots(sys(i,j).num);
            [y,nn]=factors(sys(i,j).num);
    k(i,j).entries=nn;
end
end
end
end
end
endfunction
