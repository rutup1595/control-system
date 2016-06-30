function[varargout]=iopzplot(varargin)
    [lhs,rhs]=argn(0)
     for j=1:rhs
         if(typeof(varargin(j))=='string') then
             continue;
         end

         xx1(j)=size(varargin(j),'r');                           
         yy1(j)=size(varargin(j),'c');
         if (typeof(varargin(j))=='state-space') then
             varargin(j)=ss2tf(varargin(j));
         end
     
    end

CIndex=1;
    for i=1:rhs
        
        
        if typeof(varargin(i))=='string' then
            continue;
        end 
        CIndex=CIndex+1;
        //___________________siso__________________//
        if typeof(varargin(i))=='rational' & size(varargin(i))==[1 1]  then
            subplot(max(xx1),max(yy1),1)
            plzr(varargin(i))
//              hh=gda();
//              hh.children.mark_foreground=CIndex;
              //____________Siso RRay________________//
          elseif i<> rhs&(typeof(varargin(i))=='rational'& typeof(varargin(i+1))=='string') then
              if(varargin(i+1)<>'v')
                    error("iozplot:Siso array must be followed by string v");
              end
            //  disp('cheenu')
                t=varargin(i)
                [n1 c1]=size(t)
                index=1; 
                for ii=1:n1
                    for iii=1:c1
                        for jj=1:size(t,3) 
                            subplot(max(xx1),max(yy1),1)
                             plzr(t(ii,iii,jj))
//                              hh=gda();
//                        hh.children.mark_foreground=CIndex; 
                        end
                    end
                end 
             
                              
                              
              elseif (typeof(varargin(i))==['rational']) & size(varargin(i))<>[1 1]  then
                [n1 c1]=size(varargin(i))
                index=1; 
                for ii=1:n1
                    for iii=1:c1
                        for jj=1:size(varargin(i),3)  
                        subplot(max(xx1),max(yy1),index)
                        plzr(varargin(i)(ii,iii,jj))
                        index=index+1;
//                        hh=gda();
//                        hh.children.mark_foreground=CIndex;

       
                        end
                    end
                end 
              
end
end
////// //       
//////    if rhs ==1 then
//////        p=pole(varargin(1))
//////        p=cell2mat(p)
//////        z=zero(varargin(1))
//////        md=degree(varargin(1).den)
//////        disp(md)
//////        nr=1;
//////     //   plot2d(0,0,1,rect=[0,0,12,10], frameflag=3)
//////       x1 =[z;matrix(p,md*nr,1)];
//////       disp(x1)
//////    xmin=min(real(x1));xmax=max(real(x1))
//////    ymin=min(imag(x1));ymax=max(imag(x1))
//////    dx=abs(xmax-xmin)*0.05
//////    dy=abs(ymax-ymin)*0.05
//////    if dx<1d-10, dx=0.01,end
//////    if dy<1d-10, dy=0.01,end
//////    legs=[],lstyle=[];lhandle=[]
//////    rect=[xmin-dx;ymin-dy;xmax+dx;ymax+dy];
//////    plot2d(0,0,1,rect=[xmin-dx;ymin-dy;xmax+dx;ymax+dy], frameflag=3)
//    f=gcf();
//    immediate_drawing= f.immediate_drawing;
//    f.immediate_drawing = "off";
//    a=gca();
//    if a.children==[]
//        a.data_bounds=[rect(1) rect(2);rect(3) rect(4)];
//        a.axes_visible="on";
//        a.title.text=_("Evans root locus");
//        a.x_label.text=_("Real axis");
//        a.y_label.text=_("Imaginary axis");
//        axes.clip_state = "clipgrf";
//    else //enlarge the boundaries
//        a.data_bounds=[min(a.data_bounds(1,:),[rect(1) rect(2)]);
//        max(a.data_bounds(2,:),[rect(3) rect(4)])];
//
//    end 
//       if p<>[] then
//        xpoly(real(p(:,1)),imag(p(:,1)))
//      //  xpolys(real(z),imag(z),0)
//        e=gce();e.line_mode="off";e.mark_mode="on";
//        e.mark_size_unit="point";e.mark_size=7;e.mark_style=2;
//        
//        end
////////
//        if z<>[] then
//          xpoly(real(z),imag(z))
//        e=gce();e.line_mode="off";e.mark_mode="on";
//        e.mark_size_unit="point";e.mark_size=7;e.mark_style=5;
//        end
 //       xpoly(real(z),imag(z),"marks")
////         e=gce();
////         set(e,"mark_style",0)
//        ;e.line_mode="off";e.mark_mode="on";
//        e.mark_size_unit="point";e.mark_size=7;e.mark_style=2;
//            
    
  endfunction  
