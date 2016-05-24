//Author: Rutuja Moharil
//augstate function
//augstate appends states to the outputs of a state-space model
// This command is useful to close the loop on a full-state feedback gain  u = Kx. After preparing the plant with augstate,you can use the FEEDBACK command to derive the closed-loop model. 
       
function[]=augstate(sys)
    
    select typeof(sys)
    case "state-space" then          // check if the entered system is state space model
       [A B C D]=abcd(sys);          // extracting A,B,C,D matrices
       t=mtlb_size(A);               
        [row,col]=size(B);       
    
           C=cat(1,C,eye(t,t))     // cocatenation of matrix  C and identity matrix of size of A 
           D=cat(1,D,zeros(t,col))  // cocatenation of matrix  A and null matrix of row of A and column of D
         disp(A,'A =')
    disp(B,'B =');
   disp(C,'C =');
    disp(D,'D =');
      
   else                              // for any other system display the error
       error('enter only state space')
   end;
endfunction

          
          
         
