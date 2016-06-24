// dare function calculates the solution of discrete algebraic riccati equation (DARE)
//The input arguments can b 3,4 or 6
//output arguments give the solution X,eigen values L,gain matrix Z
//however the general dare equation(involving descriptor matrix E)is not predefined in scilab thus in this function generalised DARE is not evaluated.
// DARE :
//  a'*x*a-(a'*x*b1/(b2+b1'*x*b1))*(b1'*x*a)+c-x with b=b1/b2*b1'=0
//a,b,c real matrices nxn, b and c symmetric.
//
//Z=((b1'*X*b1+b2)^-1)*b1'*X*a
//L=eigen values of a-b*Z
function [varargout]=dare(A,B,Q,varargin)
    [lhs rhs]=argn(0)
    if (issquare(A)<>%T)|(issquare(Q)<>%T) then                                    //check if the matrices are square 
        error('wrong size of matrix')
    end
        if B'==B | Q'==Q then                                                     //check if the matrices are symmetric
    
        [n1 m1]=size(A);
        [n2 m2]=size(B);
        else
        error('enter the symmetric matrix only')
       end
   
    if(n2<>n1) then                                                                //number of rows of A and B matricx must be same
        error('wrong size')
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
