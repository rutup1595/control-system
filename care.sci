function [varargout]=care(A,B,Q,varargin)
    //
    //Calling Sequence
    //function[X L G]=care(A,B,Q,R)   --- for continuous time systems
    //Parameters
    //A - Real matrix (n-by-n).
    //B - Real symmetric matrix (n-by-m).
    //Q - Real symmetric matrix (n-by-n).
    //R - Real matrix (m-by-m).
    //X - Unique stabilizing solution of the continuous-time Riccati equation (n-by-n).
    //L - Closed-loop poles (n-by-1).
    //G - Corresponding gain matrix (m-by-n).
    //Description
    //Solves continuous-time algebraic Riccati equations.
    // A'X + XA - XB R^(-1)  B'X + Q = 0 (continuous time case)
    //Z=(R^-1)*B'*X
    //L=eigen values of (A-B*Z)
    //however the general Care equation(involving descriptor matrix E)is not predefined in scilab thus in this function generalised CARE is not evaluated.
    //Examples:
    // 1. c = [ 1  -1];
    //r = 3;
    //a=[-3 2;1 1];
    //b = [ 0;1];
    //[x y z]=care(a,b,c.'*c,r)
    
    // 2. a = [ 0.0  1.0
    //       0.0  0.0];
    // b = [ 0.0
    //       1.0];
    // c = [ 1.0  0.0
    //       0.0  1.0
    //       0.0  0.0];
    // d = [ 0.0
    //       0.0
    //       1.0];
    // [x, l, g] = care (a, b, c.'*c, d.'*d);

    //See also
    // riccati,schur,stabil,dare
    //Authors
    //Rutuja Moharil
    //Bibliography
    //https://sourceforge.net/p/octave/control/ci/f7d0ce2cad551ee1dc57af498ff9dcbb94db6ae1/tree/inst/care.m#l34
    [lhs rhs]=argn(0)
    if (issquare(A)<>%T)|(issquare(Q)<>%T) then                                  //check if the matrices are square 
        error(msprintf(_("\n %s: Wrong size of matrix #%d:  a and q must square matrix.\n"),"care",1))
    end
    if  Q'==Q then                                                   ///check if the matrices are symmetric

        [n1 m1]=size(A);
        [n2 m2]=size(B);
    else
        error(msprintf(_("\n %s: Wrong size of matrix #%d: Square matrix expected.\n"),"care",2))
    end

    if stabil(A,B)==[] then                                                      //check stabilizability
        error('wrong input arguments')
    end
    if(n2<>n1) then                                                             //number of rows of A and B matricx must be same
        error(msprintf(_("\n %s: Wrong size of matrix #%d:  a and b must have the same number of rows.\n"),"care",3))
    end
    if rhs==4 then

        if  length(varargin)==1 & (issquare(varargin(1))==%T) then

            r=varargin(1);                                                                        
            [n4 m4]=size(r)
            if (m4<>m2) then                                                    // number of columns of B and R must be same
                error(msprintf(_("\n %s: Wrong size of matrix #%d:  a and r must have the same number of columns.\n"),"care",4))
            end

            B1=B*inv(r)*B'

            x=riccati(A,B1,Q,'c','schur') ;                                         // using riccati command to solve care
            //x=X1/X2
            y=inv(r)*B'*x                                                           // gain matrix
            z=A-B*y                   
            z=spec(z)                                                               //eigen values

        end
    elseif rhs==3                                                            //when R matrix is not given as input

        r=eye(m2,m2);
        B1=B*inv(r)*B'
        x=riccati(A,B1,Q,'c','schur') ;                                        // using riccati command to solve care
        y=inv(r)*B'*x                                                          // gain matrix
        z=A-B*y
        z=spec(z)                                                             // eigen values
    else
        error('wrong number of input arguments')
    end
    varargout(1)=x;
    varargout(3)=y;
    varargout(2)=z;
endfunction
