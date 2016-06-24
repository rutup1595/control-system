// care function calculates the solution of continuous algebraic riccati equation (CARE)
//The input arguments can b 3,4 or 6
//output arguments give the solution X,eigen values L,gain matrix Z
//however the general Care equation(involving descriptor matrix E)is not predefined in scilab thus in this function generalised CARE is not evaluated.
// CARE :
//   A'X + XA - XB R^(-1)  B'X + Q = 0 (continuous time case)
//A,B,Q real matrices nxn, B and Q symmetric.
//
//Z=(R^-1)*B'*X
//L=eigen values of A-B*Z

function [varargout]=care(A,B,Q,varargin)
    [lhs rhs]=argn(0)
    if (issquare(A)<>%T)|(issquare(Q)<>%T) then                                  //check if the matrices are square 
        error('wrong size of matrix')
    end
        if B'==B | Q'==Q then                                                   ///check if the matrices are symmetric
    
        [n1 m1]=size(A);
        [n2 m2]=size(B);
        else
        error('enter the symmetric matrix only')
       end
    
    
    if(n2<>n1) then                                                             //number of rows of A and B matricx must be same
        error('wrong size')
    end
    if rhs==4 then
    
        if  length(varargin)==1 & (issquare(varargin(1))==%T) then
         
         r=varargin(1);                                                                        
        [n4 m4]=size(r)
            if (m4<>m2) then                                                    // number of columns of B and R must be same
            error('wrong size')
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
