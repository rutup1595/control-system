global margin_x margin_y;
global frame_w frame_h plot_w plot_h;
// Window Parameters initialization
frame_w = 200+500; frame_h = 580;// Frame width and height
plot_w = 150; plot_h = frame_h;// Plot width and heigh
margin_x = 5; margin_y = 5;// Horizontal and vertical margin
//for elements
defaultfont = "arial"; // Default Font
//axes_w = 2*margin_x + frame_w + plot_w;// axes width
//axes_h = 2*margin_y + frame_h; // axes height (100 =>
//toolbar height)
demo_lhy = scf(100001);// Create window with id=100001 and make
//it the current one
// Background and text
demo_lhy.background = -2;
demo_lhy.figure_position = [100 0];
demo_lhy.figure_name = gettext("Control System");
// Change dimensions of the figure
demo_lhy.axes_size = [1100 610]; 

//demo_lhy.axes_size = [1320 600];
//demo_lhy.figure_size = [-1 -1];
// Remove Scilab graphics menus & toolbar
delmenu(demo_lhy.figure_id,gettext("&File"));
delmenu(demo_lhy.figure_id,gettext("&Tools"));
delmenu(demo_lhy.figure_id,gettext("&Edit"));
delmenu(demo_lhy.figure_id,gettext("&?"));
toolbar(demo_lhy.figure_id,"off");
// New menu
h1 = uimenu("parent",demo_lhy, "label",gettext("File"));
h5 = uimenu("parent",demo_lhy, "label",gettext("Stability Analysis"));
h3 = uimenu("parent",demo_lhy, "label",gettext("Time domain"));
h4 = uimenu("parent",demo_lhy, "label",gettext("Frequency Domain"));
h2 = uimenu("parent",demo_lhy, "label",gettext("About"));

// Populate menu: file
uimenu(h1, "label",gettext("Close"), 'callback',"demo_lhy=get_figure_handle(100001);delete(demo_lhy);");
uimenu(h2, "label",gettext("About"),"callback","About();");
popul1=uimenu(h3, "label",gettext("Plots"),"callback","plt();");
popul2=uimenu(h3, "label",gettext("Parameters"),"callback","param();");
popul3=uimenu(h4,"label",gettext("Response"),"callback","resp();");
popul4=uimenu(h4,"label",gettext("Parameters"),"callback","param_freq();");
//sleep(500);

//--------------------------------------outer- dhacha uptill here--------------------------------------------------------------//


my_frame = uicontrol("parent",demo_lhy, "relief","groove","style","frame", "units","pixels","position",[5 5 500 600],"horizontalalignment","center", "background",[1 1 1],"tag","frame_control");
//_______________outer box frame LHS-----------//////////

//my_frame_title = uicontrol("parent",demo_lhy, "style","text","string","System", "units","pixels","position",[70+margin_x margin_y+frame_h-10 frame_w-60 20],"fontname",defaultfont, "fontunits","points","fontsize",16, "horizontalalignment","center","background",[1 1 1], "tag","title_frame_control"); 

///////----------numerator & den ka edit box---------////////////
textsys1 = uicontrol("parent",demo_lhy,"relief","groove","style","edit","units","pixels","position",[margin_x+100 500 400-70 30],"tag","nter1");
textsys2 = uicontrol("parent",demo_lhy,"relief","groove","style","edit","units","pixels","position",[margin_x+100 450 400-70 30],"tag","nter2");

//////////-----numerator & denominator ka text------------//
dispnum = uicontrol("parent",demo_lhy,"relief","groove","style","text","units","pixels","string","Numerator","position",[margin_x+3 500 95 30]);
dispden = uicontrol("parent",demo_lhy,"relief","groove","style","text","units","pixels","string","Denominator","position",[margin_x+3 450 95 30]);


//________________________________system attributes left ----------------------//

//____________text boxes left attributes____________________//
dispsys = uicontrol("parent",demo_lhy,"relief","groove","style","text","units","pixels","string","System","position",[margin_x+3 400-50-50 95 60]);
disppol = uicontrol("parent",demo_lhy,"relief","groove","style","text","units","pixels","string","Poles","position",[margin_x+3 350-50-50 95 30]);
dispzer = uicontrol("parent",demo_lhy,"relief","groove","style","text","units","pixels","string","Zeros","position",[margin_x+3 300-50-50 95 30]);
dispgain = uicontrol("parent",demo_lhy,"relief","groove","style","text","units","pixels","string","Gain","position",[margin_x+3 250-50-50 95 30]);
dispstab = uicontrol("parent",demo_lhy,"relief","groove","style","text","units","pixels","string","Stability","position",[margin_x+3 200-50-50 95 30]);
dispsysa = uicontrol("parent",demo_lhy,"relief","groove","style","text","units","pixels","position",[margin_x+100 400-50-50 400-70 60],"tag","sysa");
disppola = uicontrol("parent",demo_lhy,"relief","groove","style","text","units","pixels","position",[margin_x+100 350-50-50 400-70 30],"tag","pola");
dispzera = uicontrol("parent",demo_lhy,"relief","groove","style","text","units","pixels","position",[margin_x+100 300-50-50 400-70 30],"tag","zera");
dispgaina = uicontrol("parent",demo_lhy,"relief","groove","style","text","units","pixels","position",[margin_x+100 250-50-50 400-70 30],"tag","gaina");
dispstaba = uicontrol("parent",demo_lhy,"relief","groove","style","text","units","pixels","position",[margin_x+100 200-50-50 400-70 30],"tag","staba");

//__________________________________________________________________________________________________________________________________________________//



//_____________Button to enter to kae action_______________//
enter = uicontrol("parent",demo_lhy,"relief","groove","style","pushbutton","units","pixels","position",[margin_x+100+330+5 450 60 80],"string","ENTER","callback","enter();"); 

//______________________________________________________________________//

//left layout ends here-_____________________//




//Right layout starts here-///////-------------------------------------------

function enter()

    sysnum = findobj("tag","nter1");
    sysden = findobj("tag","nter2");
    syst =(sysnum.string+"/"+sysden.string);
    s=%s;
    sys=evstr(sysnum.string)/evstr(sysden.string);

    sys=syslin('c',sys);
    aa=sys;
    textsys = findobj("tag","sysa");textsys.string=string(syst);
    hh=(pole(sys))
    textsys = findobj("tag","pola");textsys.string=string(hh);
    hh=zero(sys)
    textsys = findobj("tag","zera");textsys.string=string(hh);
    //  disp(typeof(sys1))

endfunction

//--------------------time domain-----------------------------------------------------------------------------------------------//
function plt()
//hh=gca()
//hh.visible="off";
    tag2 = findobj("tag","step1");
    tag2.visible="off"
    tag2 = findobj("tag","steady1");
    tag2.visible="off"
    tag1 = findobj("tag","margin1");
    tag1.visible="off"
    tag1 = findobj("tag","bode1");
    tag1.visible="off"
    tag1 = findobj("tag","p6");
    tag1.visible="off"
    tag1 = findobj("tag","p7");
    tag1.visible="off"
    tag1 = findobj("tag","l1");
    tag1.visible="off"
    tag1 = findobj("tag","l2");
    tag1.visible="off"
    tag1 = findobj("tag","l3");
    tag1.visible="off"
    tag1 = findobj("tag","l4");
    tag1.visible="off"
    tag1 = findobj("tag","l5");
    tag1.visible="off"
    tag1 = findobj("tag","l6");
    tag1.visible="off"
    tag1 = findobj("tag","l7");
    tag1.visible="off"
    tag1 = findobj("tag","l8");
    tag1.visible="off"
    tag1 = findobj("tag","peakt");
    tag1.visible="off"
    tag1 = findobj("tag","peak");
    tag1.visible="off"
    tag1 = findobj("tag","under");
    tag1.visible="off"
    tag1 = findobj("tag","over");
    tag1.visible="off"
    tag1 = findobj("tag","setmax");
    tag1.visible="off"
    tag1 = findobj("tag","setmin");
    tag1.visible="off"
    tag1 = findobj("tag","set");
    tag1.visible="off"
    tag1 = findobj("tag","rise");
    tag1.visible="off"
   hh=gca()
   delete()

    x=0:5;
    plot2d(sin(x));
    xgrid(5,1,7)
    plot1 = gca();
    plot1.margins = [0.5,0.125,0.125,0.5]; 
    delete();


    impls=uicontrol("parent",demo_lhy,"relief","groove","style","pushbutton","units","pixels","position",[margin_x+550 300-50-50 330 40],"tag","impuls","string","impulse","callback","impuls();");


    implsi=uicontrol("parent",demo_lhy,"relief","groove","style","pushbutton","units","pixels","position",[margin_x+550 300-50-50 20 40],"tag","impulsi","string","?","callback","knowimpulse();");

    stepp=uicontrol("parent",demo_lhy,"relief","groove","style","pushbutton","units","pixels","position",[margin_x+550 140 330 40],"tag","step","string","step-plot","callback","stepp();");

    steppi=uicontrol("parent",demo_lhy,"relief","groove","style","pushbutton","units","pixels","position",[margin_x+550 140 20 40],"tag","steppi","string","?","callback","knowstep();");

    //initali=uicontrol("parent",demo_lhy,"relief","groove","style","pushbutton","units","pixels","position",[margin_x+550 80 20 40],"tag","impuls1i","string","?","callback","knowsigma();");
    ////    iopi= uicontrol("parent",demo_lhy,"relief","groove","style","pushbutton","units","pixels","position",[margin_x+550 140 20 40],"tag","impuls2i","string","?","callback","knowiopz();");
endfunction


function param()        
    hh=gca()
   delete()                                                      //margin means parameters = step info
    tag1 = findobj("tag","impuls");
    tag1.visible="off"
    tag1 = findobj("tag","impulsi");
    tag1.visible="off"
    tag1 = findobj("tag","steppi");
    tag1.visible="off"
    tag2 = findobj("tag","step1");
    tag2.visible="off"
    tag1 = findobj("tag","margin1");
    tag1.visible="off"
    tag1 = findobj("tag","bode1");
    tag1.visible="off"
    tag1 = findobj("tag","p7");
    tag1.visible="off"
    tag1 = findobj("tag","p6");
    tag1.visible="off"
//    tag1 = findobj("tag","1l");
//    tag1.visible="off"
//    tag1 = findobj("tag","l2");
//    tag1.visible="off"
//    tag1 = findobj("tag","l3");
//    tag1.visible="off"
//    tag1 = findobj("tag","l4");
//    tag1.visible="off"
//    tag1 = findobj("tag","l5");
//    tag1.visible="off"
//    tag1 = findobj("tag","l6");
//    tag1.visible="off"
//    tag1 = findobj("tag","l7");
//    tag1.visible="off"
//    tag1 = findobj("tag","l8");
//    tag1.visible="off"
//    tag1 = findobj("tag","peak");
//    tag1.visible="off"
//    tag1 = findobj("tag","peakt");
//    tag1.visible="off"
//    tag1 = findobj("tag","under");
//    tag1.visible="off"
//    tag1 = findobj("tag","over");
//    tag1.visible="off"
//    tag1 = findobj("tag","setmax");
//    tag1.visible="off"
//    tag1 = findobj("tag","setmin");
//    tag1.visible="off"
//    tag1 = findobj("tag","set");
//    tag1.visible="off"
//    tag1 = findobj("tag","rise");
//    tag1.visible="off"



    //define the stepinfo and the steasy state error//-------------------------------------------------------------------------------------
    uicontrol("parent",demo_lhy,"relief","groove","style","pushbutton","units","pixels","position",[margin_x+550 200 330 40],"tag","step1","string","Stepinfo","callback","stepinfo1();");   
    uicontrol("parent",demo_lhy,"relief","groove","style","pushbutton","units","pixels","position",[margin_x+550 200 20 40],"tag","stepi","string","?","callback","knowstepinfo();");
    uicontrol("parent",demo_lhy,"relief","groove","style","pushbutton","units","pixels","position",[margin_x+550 140 330 40],"tag","steady1","string","Steady state error","callback","steady();");   
    uicontrol("parent",demo_lhy,"relief","groove","style","pushbutton","units","pixels","position",[margin_x+550 140 20 40],"tag","steadyi","string","?","callback","knowsteady();");



endfunction
//// time domain ends /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////



//--------------------freq domain-----------------------------------------------------------------------------------------------------------//
function resp()
    hh=gca()
    hh.visible="off" 
    tag2 = findobj("tag","step1");
    tag2.visible="off"
    tag2 = findobj("tag","steady1");
    tag2.visible="off"
    tag1 = findobj("tag","impuls");
    tag1.visible="off"
    tag1 = findobj("tag","impulsi");
    tag1.visible="off"
    tag1 = findobj("tag","steppi");
    tag1.visible="off"
    tag2 = findobj("tag","step1");
    tag2.visible="off"
    tag1 = findobj("tag","p7");
    tag1.visible="off"
    tag1 = findobj("tag","p6");
    tag1.visible="off"
    tag1 = findobj("tag","1l");
    tag1.visible="off"
    tag1 = findobj("tag","l2");
    tag1.visible="off"
    tag1 = findobj("tag","l3");
    tag1.visible="off"
    tag1 = findobj("tag","l4");
    tag1.visible="off"
    tag1 = findobj("tag","l5");
    tag1.visible="off"
    tag1 = findobj("tag","l6");
    tag1.visible="off"
    tag1 = findobj("tag","l7");
    tag1.visible="off"
    tag1 = findobj("tag","l8");
    tag1.visible="off"
    tag1 = findobj("tag","peakt");
    tag1.visible="off"
    tag1 = findobj("tag","peak");
    tag1.visible="off"
    
    tag1 = findobj("tag","under");
    tag1.visible="off"
    tag1 = findobj("tag","over");
    tag1.visible="off"
    tag1 = findobj("tag","setmax");
    tag1.visible="off"
    tag1 = findobj("tag","setmin");
    tag1.visible="off"
    tag1 = findobj("tag","set");
    tag1.visible="off"
    tag1 = findobj("tag","rise");
    tag1.visible="off"
    
    uicontrol("parent",demo_lhy,"relief","groove","style","pushbutton","units","pixels","position",[margin_x+550 200 330 40],"tag","margin1","string","Margin","callback","mgin();");
    uicontrol("parent",demo_lhy,"relief","groove","style","pushbutton","units","pixels","position",[margin_x+550 200 20 40],"tag","margini","string","?","callback","knowmargin();");

    uicontrol("parent",demo_lhy,"relief","groove","style","pushbutton","units","pixels","position",[margin_x+550 140 330 40],"tag","bode1","string","Bode","callback","bde();");
    uicontrol("parent",demo_lhy,"relief","groove","style","pushbutton","units","pixels","position",[margin_x+550 140 20 40],"tag","bodei","string","?","callback","knowbode();");
endfunction

function param_freq()
    hh=gca()
    hh.visible="off" 
    tag2 = findobj("tag","step1");
    tag2.visible="off"
    tag2 = findobj("tag","steady1");
    tag2.visible="off"
    tag1 = findobj("tag","impuls");
    tag1.visible="off"
    tag1 = findobj("tag","impulsi");
    tag1.visible="off"
    tag1 = findobj("tag","steppi");
    tag1.visible="off"
    tag2 = findobj("tag","step1");
    tag2.visible="off"
    tag1 = findobj("tag","margin1");
    tag1.visible="off"
    tag1 = findobj("tag","bode1");
    tag1.visible="off"
    tag1 = findobj("tag","1l");
    tag1.visible="off"
    tag1 = findobj("tag","l2");
    tag1.visible="off"
    tag1 = findobj("tag","l3");
    tag1.visible="off"
    tag1 = findobj("tag","l4");
    tag1.visible="off"
    tag1 = findobj("tag","l5");
    tag1.visible="off"
    tag1 = findobj("tag","l6");
    tag1.visible="off"
    tag1 = findobj("tag","l7");
    tag1.visible="off"
    tag1 = findobj("tag","l8");
    tag1.visible="off"
    tag1 = findobj("tag","peakt");
    tag1.visible="off"
    tag1 = findobj("tag","peak");
    tag1.visible="off"
    
    tag1 = findobj("tag","under");
    tag1.visible="off"
    tag1 = findobj("tag","over");
    tag1.visible="off"
    tag1 = findobj("tag","setmax");
    tag1.visible="off"
    tag1 = findobj("tag","setmin");
    tag1.visible="off"
    tag1 = findobj("tag","set");
    tag1.visible="off"
    tag1 = findobj("tag","rise");
    tag1.visible="off"
     
 
    
        uicontrol("parent",demo_lhy,"relief","groove","style","pushbutton","units","pixels","position",[margin_x+550 200 330 40],"tag","p6","string","Bandwidth","callback","bandwidth1();");
    uicontrol("parent",demo_lhy,"relief","groove","style","pushbutton","units","pixels","position",[margin_x+550 200 20 40],"tag","p6i","string","?","callback","knowbwidth();");

    uicontrol("parent",demo_lhy,"relief","groove","style","pushbutton","units","pixels","position",[margin_x+550 140 330 40],"tag","p7","string","Dc Gain","callback","dcgain1();");
    uicontrol("parent",demo_lhy,"relief","groove","style","pushbutton","units","pixels","position",[margin_x+550 140 20 40],"tag","p7i","string","?","callback","knowdc();");
endfunction

//Right layout ends here-///////////////-------------------------------------



//Functions---------------------------------------// 


//-----stability analysis------------------------------------------------------------------------------------------//

function iopz()


    sysnum = findobj("tag","nter1");
    sysden = findobj("tag","nter2");
    syst =(sysnum.string+"/"+sysden.string);
    s=%s;
    sys=evstr(sysnum.string)/evstr(sysden.string);
    sys=syslin('c',sys);

    plot1.margins = [0.5,0.125,0.125,0.5]; 
    plzr(sys);
    plot1 = gca();
    plot1.title.font_size = 3; 
    plot1.title.text=("POLE ZERO PLOT")
    plot1.auto_clear="on"

endfunction


//time domain response plots----------------------------------------------------------------------------------------//
function impuls()  


    sysnum = findobj("tag","nter1");
    sysden = findobj("tag","nter2");
    syst =(sysnum.string+"/"+sysden.string);
    s=%s;
    sys=evstr(sysnum.string)/evstr(sysden.string);
    sys=syslin('c',sys);
    plot1 = gca();
    plot1.margins = [0.5,0.125,0.125,0.5]; 
    impulse(sys);
    plot1.title.font_size = 3; 
    plot1.title.text=("IMPULSE PLOT")
    plot1.auto_clear="on"

endfunction


function stepp()
    sysnum = findobj("tag","nter1");
    sysden = findobj("tag","nter2");
    syst =(sysnum.string+"/"+sysden.string);
    s=%s;
    sys=evstr(sysnum.string)/evstr(sysden.string);
    sys=syslin('c',sys);
    plot1 = gca();
    plot1.margins = [0.5,0.125,0.125,0.5]; 
    stepplot(sys);
    plot1.title.font_size = 3; 
    plot1.title.text=("STEP PLOT")
    plot1.auto_clear="on"

endfunction
//-----------------------------------------------------------------------------------------------------------------------------------------//

//-----------time domain parameters--------------------------------------------------------------------------------------------------------//
function stepinfo1()
   uicontrol("parent",demo_lhy,"relief","groove","style","text","units","pixels","string","Peak time","position",[margin_x+600 300 330 40],"tag","l1")
   uicontrol("parent",demo_lhy,"relief","groove","style","text","units","pixels","position",[margin_x+700 300 330 40],"tag","peakt");
    
   uicontrol("parent",demo_lhy,"relief","groove","style","text","units","pixels","string","Peak","position",[margin_x+600 330 330 40],"tag","l2")
   uicontrol("parent",demo_lhy,"relief","groove","style","text","units","pixels","position",[margin_x+700 330 330 40],"tag","peak");
    
   uicontrol("parent",demo_lhy,"relief","groove","style","text","units","pixels","string","Undershoot","position",[margin_x+600 360 330 40],"tag","l3")
    uicontrol("parent",demo_lhy,"relief","groove","style","text","units","pixels","position",[margin_x+700 360 330 40],"tag","under");
     
    uicontrol("parent",demo_lhy,"relief","groove","style","text","units","pixels","string","Overshoot","position",[margin_x+600 390 330 40],"tag","l4")
    uicontrol("parent",demo_lhy,"relief","groove","style","text","units","pixels","position",[margin_x+700 390 330 40],"tag","over");
    
    
    uicontrol("parent",demo_lhy,"relief","groove","style","text","units","pixels","string","Settling MaX","position",[margin_x+600 420 370 40],"tag","l5")
    uicontrol("parent",demo_lhy,"relief","groove","style","text","units","pixels","position",[margin_x+700 420 330 40],"tag","setmax");
    
    
    uicontrol("parent",demo_lhy,"relief","groove","style","text","units","pixels","string","Settling Min","position",[margin_x+600 450 330 40],"tag","l6")
    uicontrol("parent",demo_lhy,"relief","groove","style","text","units","pixels","position",[margin_x+700 450 330 40],"tag","setmin");
    
    
    uicontrol("parent",demo_lhy,"relief","groove","style","text","units","pixels","string","Settling time","position",[margin_x+600 480 330 40],"tag","l7")
    uicontrol("parent",demo_lhy,"relief","groove","style","text","units","pixels","position",[margin_x+700 480 330 40],"tag","set");
    
    
    uicontrol("parent",demo_lhy,"relief","groove","style","text","units","pixels","string","Rise Time","position",[margin_x+600 510 330 40],"tag","l8")
    uicontrol("parent",demo_lhy,"relief","groove","style","text","units","pixels","position",[margin_x+700 510 330 40],"tag","rise");

    sysnum = findobj("tag","nter1");
    sysden = findobj("tag","nter2");
    syst =(sysnum.string+"/"+sysden.string);
    s=%s;
    sys=evstr(sysnum.string)/evstr(sysden.string);
    sys=syslin('c',sys);
    aa=sys;

    [x1 x2 x3 x4 x5 x6 x7 x8]=stepinfo(aa);
    textsys = findobj("tag","peakt");textsys.string=string(x8);
    textsys = findobj("tag","peak");textsys.string=string(x7);
    textsys = findobj("tag","under");textsys.string=string(x6);
    textsys = findobj("tag","over");textsys.string=string(x5);
    textsys = findobj("tag","setmax");textsys.string=string(x4);
    textsys = findobj("tag","setmin");textsys.string=string(x3);
    textsys = findobj("tag","set");textsys.string=string(x2);
    textsys = findobj("tag","rise");textsys.string=string(x1);



endfunction

//----------------freq domain response-----------------------------------------------------------------------------------------------//
function mgin()


    sysnum = findobj("tag","nter1");
    sysden = findobj("tag","nter2");
    syst =(sysnum.string+"/"+sysden.string);
    s=%s;
    sys=evstr(sysnum.string)/evstr(sysden.string);
    sys=syslin('c',sys);
    plot1 = scf(100002);
    plot1.background = -2;
    plot1.figure_position = [650 70];
    plot1.axes_size = [500 220];
    demo_lhy1.figure_name = gettext("SHOW MARGIN");
    show_margins(sys);
    hh=gca();
    hh.auto_clear="on"




endfunction
function bde()

    sysnum = findobj("tag","nter1");
    sysden = findobj("tag","nter2");
    syst =(sysnum.string+"/"+sysden.string);
    s=%s;
    sys=evstr(sysnum.string)/evstr(sysden.string);
    sys=syslin('c',sys);
    tag1= findobj("tag","margin1");
    plot1 = scf(100002);
    plot1.background = -2;
    plot1.figure_position = [650 70];
    plot1.axes_size = [500 220];
    demo_lhy1.figure_name = gettext("BODE");
    bode(sys);
    hh=gca();
    hh.auto_clear="on"

endfunction
//---------------------------------------------------------------------------------------------------------------------------------------------//


//---freq domain parameters---------------------------//
function bandwidth1()

    uicontrol("parent",demo_lhy,"relief","groove","style","text","units","pixels","string","Bandwidth","position",[margin_x+500 300 330 40])
    uicontrol("parent",demo_lhy,"relief","groove","style","text","units","pixels","position",[margin_x+600 300 330 40],"tag","bd");

    sysnum = findobj("tag","nter1");
    sysden = findobj("tag","nter2");
    syst =(sysnum.string+"/"+sysden.string);
    s=%s;
    sys=evstr(sysnum.string)/evstr(sysden.string);
    sys=syslin('c',sys);
    aa=bandwidth(sys);
    textsys = findobj("tag","bd");textsys.string=string(aa);

endfunction   


function dcgain1()
    uicontrol("parent",demo_lhy,"relief","groove","style","text","units","pixels","string","DC gain","position",[margin_x+500 300 330 40])
    uicontrol("parent",demo_lhy,"relief","groove","style","text","units","pixels","position",[margin_x+600 300 330 40],"tag","dc");
    
    sysnum = findobj("tag","nter1");
    sysden = findobj("tag","nter2");
    syst =(sysnum.string+"/"+sysden.string);
    s=%s;
    sys=evstr(sysnum.string)/evstr(sysden.string);
    sys=syslin('c',sys);
    aa=dcgain(sys);
  textsys = findobj("tag","dc");textsys.string=string(aa);


 endfunction   
//Please put left hand attributes function below this-------------------//


















