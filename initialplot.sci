function[pp]=initialplot(varargin)
    n=length(varargin);
    //m=length(varargout);
    [lhs,rhs]=argn(0)
    if(typeof(varargin(1))<>'state-space') then
     error('wrong input argument .Enter state space model only' )
    end
 k=0;
 //////////determining no. of constants///////////////
 for j=1:rhs
     if(typeof(varargin(j))=='constant') then
         k=k+1;
     end
 end
 
 /////////////getting subplot credentiALA////////////

 /////////////////////////////////////////////////////////
 ///////////////////////////////////////////////////
 //disp(k);
 ///////if two constants///////////////////////////////////////time & x0 specification part//////////
 if (k==2) then
     x0=varargin(n-1);///////second last as initial condition///////////
      //disp(x0);
      if typeof(varargin($)) == 'constant' then /////time//////////
            if size(varargin($)) == [1 1] then
                if varargin($) <= 0 then
                    error(msprintf(gettext("%s: The final time value must be a positive real number.\n"),"stepplot"))
                end
                tFinal = varargin($)
                totalTime =0:0.01:tFinal; 
            elseif isequal(size(varargin($)),[1 1]) == %f then
                // finding that the time vector has positive time value
                tempTimeIndex = find(varargin($) >= 0)
                if isequal(size(varargin($)),size(tempTimeIndex)) == %t then
                    totalTime = varargin($)
                    for l=1:(n-2)
                    if(typeof(varargin(l))==['state-space'] & varargin(l).dt<>'c') then
                        if(varargin(l).dt=='d') then
                              t=1; /////////if 'd' then the sampling time is 1
                         else
                            t=varargin(l).dt
                        end
                        if(t<>(totalTime(2)-totalTime(1))) then
                            error('time interval must be equal to sampling time')
                        else
                            totalTime=0:t:totalTime($)
                        end
                    end
                 end           
                            
                else
                    ////////////here also we should check dt but lets do it later---""CHEENU""/////////////////
                    
                    tempTime = varargin($)
                    tempTime = tempTime(tempTimeIndex(1):tempTimeIndex($))
                    totalTime = tempTime
                end
            end
        end
    
elseif(k==1) then        //////////////////if time is not specified/////////////////////////
        x0=varargin($);
end
///////////////////////////////////////////////////////////////////////////////
ll=0;
 for j=1:rhs-k
     xx1(j)=size(varargin(j),'r');
   
////    if(typeof(varargin(j))=='state-space') then
////     bb=varargin(j).a
////    if(size(x0,'r')==size(bb,'r')) then
////        ll=ll+1;
////    else
////        error('wrong size of initial condition');
//// end
////end
////end
////tl=find(typeof(varargin(j))=='state-space');
////if (size(tl,'c')==ll) then
////    disp('paro')
////else
////    disp('cheenu')
end

index=1;
 for i=1:(n-k)
     index=index+1;
     if(typeof(varargin(i))=='string') then
         continue;
     end
     
   [row col]=size(x0);
     if(typeof(varargin(i))==['state-space'] & col==1) then
         [a b c d] =  abcd(varargin(i));
         ///////////checking matrix sizes////////////////
         if(size(b)<>[mtlb_size(a,1),mtlb_size(d,2)]| size(c)<>[mtlb_size(d,1),mtlb_size(a,2)]| size(d)<>[mtlb_size(c,1),mtlb_size(b,2)]|size(varargin(i).a,'r')<>row) then
               error('wrong size of matrices')
         else
            //b1 = zeros(mtlb_size(a,1),mtlb_size(d,2));
             d1 = zeros(mtlb_size(c,1),mtlb_size(x0,2));
             c1 = zeros(mtlb_size(d,1),mtlb_size(a,2));
         end
         
         
             if(((varargin(i).dt)=='c')) then
                sys=syslin('c',a,x0,c1,d1);
        
                 if (k==1) then
                     pq=pole(varargin(i))
                    pq=cell2mat(pq);
                           mm=real(pq);
                         //qq= find(pq>0)
                            t1=0:0.1:100;
                         if or(mm>0) then
                             totalTime=t1;
//                             [aa,x]=csim('impuls',t1,sys)
//                             aa=c*x;
                         else
                            [aa,x]=csim('impuls',t1,sys)
                             aa=c*x;
                             tt=find(aa>0.002);
                            totalTime=0:0.1:t1(tt($))
                         end
                         [aa,x]=csim('impuls',totalTime,sys)
                         aa=c*x;
                    

                  else
        //sys=syslin('c',a,x0,c1,d1);
                      [aa,x]=csim('impuls',totalTime,sys);
                      aa=c*x;
       
               
       
       
                end

         
         else  /////////////////this else is of string and continuous therefore for discrete//////////////////////
  
                if (k==1) then
       
                               pq=pole(varargin(i));
                               pq=cell2mat(pq);
                                t1=0:0.1:100;
                               mm=real(pq);
                               if(varargin(i).dt=='d') then
                                   dtime=1;
                               else
                                   dtime=varargin(i).dt;
                               end
                        if or(mm>0) then
                           // disp('paro')
                           totalTime=0:dtime:100;
                           //disp('paro')
//                           [aa,x]=ltitr(a,b,zeros(1,length(totalTime)),x0);
//                           aa=c*x;
                        elseif and(mm<0) then 
                           [aa,x]=ltitr(a,b,zeros((size(b,'c')),length(t1)),x0);
                           aa=c*x;
                           tt=find(or(aa>=0.002))       
                          totalTime=0:dtime:t1(tt($));
       
                       end
                      [aa,x]=ltitr(a,b,zeros(size(b,'c'),length(totalTime)),x0);
                      aa=c*x;
 
                 
             else
                [aa,x]=ltitr(a,b,zeros(size(b,'c'),length(totalTime)),x0);
                aa=c*x;
            end
        
      end

   elseif(typeof(varargin(i))<>['string']) then
       error('wrong type of initial condition entered');
   end
      ////////////////////////////plotting//////////////
   if (lhs==1) then
       if (size(varargin(i))==[1 1]) then
  if(typeof(varargin(i+1))=='string') then
      plot(totalTime,aa,varargin(i+1));
      hh=gce();
    if(varargin(i).dt<>'c') then
       hh.children.polyline_style=2;
    end
  else
    plot(totalTime,aa)
    hh=gce();
    hh.children.foreground=index;
  if(varargin(i).dt<>'c') then
   hh.children.polyline_style=2;
  end
 end
else
    //xx=size(aa,'r');
    xx=size(varargin(i),'r');
    Q=1;
    if(typeof(varargin(i+1))=='string') then
        
            for oo=1:xx
      //          for pp=1:yy
        subplot(max(xx1),1,Q)
          Q=Q+1;
          plot(totalTime,aa(oo,:),varargin(i+1))
           if(varargin(i).dt<>'c') then
               hh=gce();
               hh.children.polyline_style=2;
            end
        end
        
  // end

      else
         for oo=1:xx
      //for pp=1:yy
       subplot(max(xx1),1,Q)
      Q=Q+1;
     plot(totalTime,aa(oo,:))
     hh=gce();
     hh.children.foreground=index;
if(varargin(i).dt<>'c') then
               
               hh.children.polyline_style=2;
            end 
//end
 
end
end
end
//end    
    

//varargout(1)="INITIAL_RESPONSE"
//end
/////////fot ends here////////////////

end
end
pp=gcf();
pp.figure_name="INITIAL_RESPONSE";
endfunction
