function [varargout]=dare(A,B,Q,varargin)
     //
    //Calling Sequence
    //function[X L G]=dare(A,B,Q,R)   --- for discrete time systems
    //Parameters
    //A - Real matrix (n-by-n).
    //B - Real symmetric matrix (n-by-m).
    //Q - Real symmetric matrix (n-by-n).
    //R - Real matrix (m-by-m).
    //X - Unique stabilizing solution of the discrete-time Riccati equation (n-by-n).
    //L - Closed-loop poles (n-by-1).
    //G - Corresponding gain matrix (m-by-n).
    //Description
    //Solves discrete-time algebraic Riccati equations.
    // A'X + XA - XB R^(-1)  B'X + Q = 0 (continuous time case)
    //Z=(R^-1)*B'*X
    //L=eigen values of (A-B*Z)
    //however the general dare equation(involving descriptor matrix E)is not predefined in scilab thus in this function generalised DARE is not evaluated.
    //Examples:
    // 1. a = [ 0.4   1.7;0.9 3.8];
    // b = [ 0.8 ;2.1];
    // c=[1 -1];
    // r=3;
    // [x y z]=dare(a,b,c.'*c,r)
    //See also
    // riccati,schur,stabil,care
    //Authors
    //Rutuja Moharil
    //Bibliography
    //https://sourceforge.net/p/octave/control/ci/f7d0ce2cad551ee1dc57af498ff9dcbb94db6ae1/tree/inst/dare.m#l34
    [lhs rhs]=argn(0)
    if (issquare(A)<>%T)|(issquare(Q)<>%T) then                                    //check if the matrices are square 
        error('wrong size of matrix')
    end
        if Q'==Q then                                                     //check if the matrices are symmetric
    
        [n1 m1]=size(A);
        [n2 m2]=size(B);
        else
        error('enter the symmetric matrix only')
       end
   
    if(n2<>n1) then                                                                //number of rows of A and B matricx must be same
        error('wrong size')
    end
    if stabil(A,B)==[] then                                                      //check stabilizability
    error('wrong input arguments')
    end
    if rhs==4 then
    
        if  length(varargin)==1 & (issquare(varargin(1))==%T) then
            
             
             r=varargin(1);                                                                        
            [n4 m4]=size(r)                                                       // number of columns of B and R must be same
                if (m4<>m2) then
                     error('wrong size')
                end
         
            B1=B*inv(r)*B'
      
            x=riccati(A,B1,Q,'d') ;                                               // using riccati command to solve dare
      //x=X1/X2
            y=inv(B'*x*B+r)*B'*x*A                                                // gain matrix
            z=A-B*y
            z=spec(z)                                                             // eigen values
            
        end
       elseif rhs==3                                                            // when R matrix is not present
        
          r=eye(m2,m2);
         // B1=B*inv(r)*B'
          x=riccati(A,B,Q,'d') ;                                                // using riccati command to solve dare
          y=inv(B'*x*B+r)*B'*x*A                                                // gainn matrix
          z=A-B*y
          z=spec(z)                                                             // eigen values
       else
           error('wrong input arguments')
       end
       varargout(1)=x;
       varargout(3)=y;
       varargout(2)=z;
      endfunction
