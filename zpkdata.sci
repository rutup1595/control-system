
function[x,k]= zero(sys,varargin)
    //
    //Calling Sequence
    //function[x]=zpkdata(sys)   --- for  zeros of continuous siso systems
    //function[x,k]=zpkdata(sys) ----for  zeros and gain of continuous siso systems
    //function[x]=zpkdata(sys,1)  ---for  zeros of arrays of siso systems (Continuous)
    //function[x,k]=zpkdata(sys,1) --- for  zeros and gain of arrays of siso systems (Continuous)
    //Parameters
    //sys- SISO or  array of SISO models 
    //x - zero of the system
    //k - gain of the system
    //Description
    //zero function calculates the zeroes of the system .The system can be either SISO or array of SISO .
    //this function is not defined for MIMO . thus this function considers any MIMO function as an array of SISO 
    //Examples:
    // 1.s=poly(0,'s');
    //sys=syslin('c',(4.2*s^2 +0.25*s-0.004)/(s^2+9.6*s+17)); 
    //[z1 b1]= zero(sys)
    // 2. aa=pid(rand(2,2,3),3,4,5);
    //[z2 b2]=zero(aa,1);
    //3.a=ssrand(2,2,3)
    //[z3 b3]=zero(a,1)

    //See also
    // ndims,cell,factors,roots
    //Authors
    //Rutuja Moharil
    //Bibliography
    //https://in.mathworks.com/help/control/ref/zero.html

    n=length(varargin);
    if n>1 then
        error("Too many input arguments")
    end
    //---------------check siso------------------//    
    if (n==0)& ndims(sys)==2 then                                                    //for SISO simply enter the system 
        select typeof(sys) 
        case "state-space" then                                     //check if state-space
            sys=ss2tf(sys);                                           //convert state-space to rational
        end;
        if(size(sys)==[1 1]) then                                         //check if the system is SISO
            x=roots(sys.num);                                            // extracting the zeros

            [y,o]=factors(sys.num);                                               //extracting gain
            k=o;
        else
             error(msprintf(_("\n %s: Wrong type of input argument #%d: SISO model expected.\n"),"zero",1))
        end
        //----------check siso array-------------------//
    elseif varargin(1)==1 then                                   
                select typeof(sys) 
                case "state-space" then 
                error(msprintf(_("\n %s: Wrong type of input argument #%d: SISO array model expected.\n"),"zero",1))    
                end;
                m = size(sys);                                               //find the size of array of SISO
                nd = length(m);
                //--------------siso array---------------------//
                if(nd>2) then                                                      //3-D matrix or hypermatrix case
                    x=cell(size(sys,'r'),size(sys,'c'),size(sys,3))                // creating cell array of empty matrices of zeroes
                    for i=1:size(sys,'r')
                        for j=1:size(sys,'c')
                            for l=1:size(sys,3)
                                x(i,j,l).entries=(roots(sys(i,j,l).num));             //extracting the sub cell values of zeroes and display as matrix
                                [y,nn]=factors(sys(i,j,l).num);
                                k(i,j,l).entries=nn;

                            end
                        end
                    end
                else
                    x=cell(size(sys,'r'),size(sys,'c'))                               //2-D siso array 
                    for i=1:size(sys,'r')
                        for j=1:size(sys,'c')
                            x(i,j).entries=roots(sys(i,j).num);                       // creating cell array of empty matrices of zeroes
                            [y,nn]=factors(sys(i,j).num);
                            k(i,j).entries=nn;
                        end
                    end
                end
            end
       
    
endfunction
