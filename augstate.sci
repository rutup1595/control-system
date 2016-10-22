function[]=augstate(sys)
    //
    //Calling Sequence
    //function[]=augstate(sys)
    //Parameters
    //sys- SISO or MIMO state space models 
    //Description
    //augstate function appends states to the outputs of a state-space model
    //this command is useful to close the loop on a full-state feedback gain  u = Kx. After preparing the plant with augstate,you can use the FEEDBACK command to derive the closed-loop model. 
    // augstate function is not defined for array of SISO.
    //Examples:
    // 1.aa=syslin('c',[1,3;4,5],[6;8],[2,3],[1]);
    //   a1=augstate(aa)
    // 2.ab=syslin('c',[1,2;3,4],[4,5;6,7],[8,9;0,1],[1,0;0,5])
    //   a2=augstate(ab)
    //See also
    // siso ,mimo
    //Authors
    //Rutuja Moharil
    //Bibliography
    //http://www-rohan.sdsu.edu/doc/matlab/toolbox/control/ref/augstate.html
    //http://octave.sourceforge.net/control/function/augstate.html


    select typeof(sys)
    case "state-space" then                                           // check if the entered system is state space model
        [A B C D]=abcd(sys);                                           // extracting A,B,C,D matrices
        t=mtlb_size(A);               
        [row,col]=size(B);
        if (isempty(C)==%t) then
            C=zeros(size(A,1),size(A,2));

        end
        if(isempty(D)==%t) then
            D=zeros(size(C,1),size(B,2));
        end

        C=cat(1,C,eye(t,t))                                        // cocatenation of matrix  C and identity matrix of size of A 
        D=cat(1,D,zeros(t,col))                                    // cocatenation of matrix  A and null matrix of row of A and column of D
        if sys.dt=='c' then
            sysa=syslin('c',A,B,C,D);
             disp(sysa)
        else
            if sys.dt=='d' then
                dt=1
            else
                dt=sys.dt
             end   
            sysa=syslin('d',A,B,C,D);
             disp(sysa)
            disp (dt,"Sample time :")
        end
       
    else                                                               // for any other system display the error
        error(msprintf(_("\n %s: Wrong type of input argument #%d: State space model expected.\n"),"augstate",1))
    end;
endfunction





