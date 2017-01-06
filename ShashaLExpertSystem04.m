%this is a GUI function that helps diagnose clinical disorders. It is a
%first step of an expert system that uses
%Bayesian inference to improve the diagnostic accuracy of clinical
%disorders including bipolar disorder, ADHD, borderline personality
%disorder, and antisocial personality disorder.
%% This version distinguishes five disorders from each other: bipolar I, bipolar II, borderline personality disorder, ADHD, and antisocial personality disorder.
% Due to the paucity of prevalence rates of individual DSM criteria of ADHD
% and ASPD, only diagnoses of BD and BPD integrated Bayesian statistics.
% The diagnoses of ADHD and ASPD still follows the criteria threshold
% delineated in DSM. Only BD and BPD diagnostic results are probability
% based, whereas ADHD and ASPD diagnostic results are yes/no.
%Author: Shasha Lin
%Version: 0.4
%Date: 4/7/2016
function ShashaLExpertSystem04()
format short
clear all
close all
clc
format short
%declaring all variables global, so that they can be accessed in all
%functions.
global bda
bda=0;
global bda1
bda1=0;
global bda2
bda2=0;
global bdi
bdi=0.006;
global bdii
bdii=0.018;
global bpd
bpd=0.016;%set original values for the three diagnoses
global DATA %Update data with new fields as you move on. Then save that. 

global bdb2
bdb2=0;
global bdb1
bdb1=0;
global bdb3
bdb3=0;

%p
global adhd1
global adhd2
global adhd3
global adhd4
global adhd5
global adhd6
global adhd7
global adhd8
global adhd9
global adhdi
global adhdiii
global adhdii
adhdii=0;
adhdiii=0;
adhdi=0;
adhd1=0;
adhd2=0;
adhd3=0;
adhd4=0;
adhd5=0;
adhd6=0;
adhd7=0;
adhd8=0;
adhd9=0;

global adhdii1
global adhdii2
global adhdii3
global adhdii4
global adhdii5
global adhdii6
global adhdii7
global adhdii8
global adhdii9

global aspdi
aspdi=0;


adhdii1=0;
adhdii2=0;
adhdii3=0;
adhdii4=0;
adhdii5=0;
adhdii6=0;
adhdii7=0;
adhdii8=0;
adhdii9=0;

global bpd1
global bpd2
global bpd3
global bpd4
global bpd5
global bpd6
global bpd7
global bpd8
global bpd9
global bpdi


bpd1=0.33;
bpd2=0.39;
bpd3=0.39;
bpd4=0.45;
bpd5=0.13;
bpd6=0.49;
bpd7=0.39;
bpd8=0.36;
bpd9=0.16;
bpdi=0;%borderline diagnosis

global bdc1
bdc1=0.12;%variables that begin with bdc check for mania
global bdc2
bdc2=0.166;
global bdc3
bdc3=0;
global bdc4
bdc4=0;
global bdc5
bdc5=0;
global bdc6
bdc6=0;
global bdc7
bdc7=0.03;

%variables that begin with bdd are two screening criteria for depression
global bdd1
bdd1=0;
global bdd2
bdd2=0;

%variables that begin with bde are detailed depression criteria
global bde1
bde1=0;
global bde2
bde2=0;
global bde3
bde3=0;
global bde4
bde4=0;
global bde5
bde5=0;
global bde6
bde6=0;
global bde7
bde7=0;

global ADHD1
global ADHD2
global ADHD3
global ADHD4
global ADHD5
global ADHD6
global ADHD7
global ADHD8
global ADHD9
global nADHD

global ADHDii1
global ADHDii2
global ADHDii3
global ADHDii4
global ADHDii5
global ADHDii6
global ADHDii7
global ADHDii8
global ADHDii9
global nADHDii

global ASPD1
global ASPD2
global ASPD3
global ASPD4
global ASPD5
global ASPD6
global ASPD7
global ASPD8
global nASPD

global aspd1
global aspd2
global aspd3
global aspd4
global aspd5
global aspd6
global aspd7
global aspd8
global aspd
aspd1=0;
aspd2=0;
aspd3=0;
aspd4=0;
aspd5=0;
aspd6=0;
aspd7=0;
aspd8=0;
aspd=0;



global BPD1
global BPD2
global BPD3
global BPD4
global BPD5
global BPD6
global BPD7
global BPD8
global BPD9

global BDC1
global BDC2
global BDC3
global BDC4
global BDC5
global BDC6
global BDC7

global BDD1
global BDD2

global BDE1
global BDE2
global BDE3
global BDE4
global BDE5
global BDE6
global BDE7

global nBDC
global nBPD
global nBDE

global HX1
global HX2
global HX3
global HX4
global nHX
%variables that begin with hx collect patient's family history, if they
%have any immediate family members that have received a diagnosis.
global hx1
global hx2
global hx3
global hx4
global nhx
hx1=0.02;
hx2=0.016;
hx3=0;
hx4=0;
nhx=0;

global BDA1
global BDA2
global nBDA

global nBDD

global bddp%this is the prevalence of depression in either BD or general population.
bddp=.065;%preassign the general population prevalence
global bd
bd=0;
global TS
TS=0.3;%TS is mania symptoms 3 and 4 combined. the preallocated value, 30%, is the prevalence of racing thoughts/
%pressure of speech in the general population.
global A
A=0.015;%A is mania symptoms 5 and 6 combined. The preallocated value, 1.5%, is the prevalence of distractibility/
%psychomotor agitation in the general population.

global instr1
global instr2
global instr3
%Step 0: record family history
f1=figure('Visible','on','units','normalized','outerposition',[0 0 1 1],'MenuBar','none');
p1=uipanel('Title','Step 1: screen for family history. Check if any of patient''s immediate family members ','Fontsize',20,'Position',[.1 .1 .8 .8]);
instr1=uicontrol('Parent',p1,'Style','text','units','normalized','Position',[0 .9 .7 .1],...
    'String','have been diagnosed with the following disorders','Fontsize',20);
HX1=uicontrol('Parent',p1,'Style','checkbox','units','normalized','Position',[.1 .7 .7 .1],...
    'String','Bipolar disorder','Fontsize',18,'Callback',@HX1_Callback);

HX2=uicontrol('Parent',p1,'Style','checkbox','units','normalized','Position',[.1 .5 .7 .1],...
    'String','Borderline personality disorder','Fontsize',18,'Callback',@HX2_Callback);

HX3=uicontrol('Parent',p1,'Style','checkbox','units','normalized','Position',[.1 .3 .7 .1],...
    'String','Attention-deficit/hyperactivity disorder','Fontsize',18,'Callback',@HX3_Callback);

HX4=uicontrol('Parent',p1,'Style','checkbox','units','normalized','Position',[.1 .1 .7 .1],...
    'String','Antisocial personality disorder ','Fontsize',18,'Callback',@HX4_Callback);

nHX=uicontrol('Parent',p1,'Style','pushbutton','units','normalized','Position',[.6 .2 .2 .1],...
    'String','Next','Fontsize',18,'Callback',@nHX_Callback);

    function HX1_Callback(hObject, eventdata, handles)%BD
        if (get(hObject,'Value') == get(hObject,'Max'))
            hx1=.075;
        elseif (get(hObject,'Value') == get(hObject,'Min'))
            hx1=.02;
        end
    end

    function HX2_Callback(hObject, eventdata, handles)%BPD
        if (get(hObject,'Value') == get(hObject,'Max'))
            hx2=0.091;
        elseif (get(hObject,'Value') == get(hObject,'Min'))
            
            hx2=0.016;
            
        end
    end
    function HX3_Callback(hObject, eventdata, handles)%ADHD
        if (get(hObject,'Value') == get(hObject,'Max'))
            hx3=1;
        elseif (get(hObject,'Value') == get(hObject,'Min'))
            
            hx3=0;
            
        end
    end
    function HX4_Callback(hObject, eventdata, handles)%ASPD
        if (get(hObject,'Value') == get(hObject,'Max'))
            hx4=1;
        elseif (get(hObject,'Value') == get(hObject,'Min'))
            
            hx4=0;
            
        end
    end
    function nHX_Callback(hObject, eventdata, handles)
        
        delete(HX1)
        delete(HX2)
        delete(HX3)
        delete(HX4)
        delete(nHX)
        delete(instr1)
        p1=uipanel('Title','Step 2: screen for bipolar disorder:check if each symptom has ever been present for at least 2 weeks','Fontsize',20,'Position',[.1 .1 .8 .8]);
        BDD1=uicontrol('Parent',p1,'Style','checkbox','units','normalized','Position',[.1 .7 .7 .1],...
            'String','depressed mood','Fontsize',18,...
            'Callback',@BDD1_Callback);
        BDD2=uicontrol('Parent',p1,'Style','checkbox','units','normalized','Position',[.1 .5 .7 .1],...
            'String','anhedonia','Fontsize',18,...
            'Callback',@BDD2_Callback);
        nBDD=uicontrol('Parent',p1,'Style','pushbutton','units','normalized','Position',[.6 .2 .2 .1],...
            'String','Next','Fontsize',18,'Callback',@nBDD_Callback);
    end
    function BDD1_Callback(hObject, eventdata, handles)
        if (get(hObject,'Value') == get(hObject,'Max'))
            bdd1=1;
        elseif (get(hObject,'Value') == get(hObject,'Min'))
            
            bdd1=0;
        end
    end
    function BDD2_Callback(hObject, eventdata, handles)
        if (get(hObject,'Value') == get(hObject,'Max'))
            bdd2=1;
        elseif (get(hObject,'Value') == get(hObject,'Min'))
            
            bdd2=0;
        end
    end
    function nBDD_Callback(hObject, eventdata, handles)
        delete(nBDD)
        delete(BDD1)
        delete(BDD2)
        if bdd1+bdd2~=0 %patient may have depression
            set(p1,'Title','Step 2: screen for bipolar disorder. Check if each symptom was present:','Fontsize',20);
            BDE1=uicontrol('Parent',p1,'Style','checkbox','units','normalized','Position',[.1 .8 .7 .1],...
                'String','weight loss or gain (>5% body weight in a month)','Fontsize',18,...
                'Callback',@BDE1_Callback);
            BDE2=uicontrol('Parent',p1,'Style','checkbox','units','normalized','Position',[.1 .7 .7 .1],...
                'String','insomnia/hypersomnia','Fontsize',18,...
                'Callback',@BDE2_Callback);
            BDE3=uicontrol('Parent',p1,'Style','checkbox','units','normalized','Position',[.1 .6 .7 .1],...
                'String','psychomotor agitation/retardation','Fontsize',18,...
                'Callback',@BDE3_Callback);
            BDE4=uicontrol('Parent',p1,'Style','checkbox','units','normalized','Position',[.1 .5 .7 .1],...
                'String','fatigue','Fontsize',18,...
                'Callback',@BDE4_Callback);
            BDE5=uicontrol('Parent',p1,'Style','checkbox','units','normalized','Position',[.1 .4 .7 .1],...
                'String','feeling worthless/guilty','Fontsize',18,...
                'Callback',@BDE5_Callback);
            BDE6=uicontrol('Parent',p1,'Style','checkbox','units','normalized','Position',[.1 .3 .7 .1],...
                'String','distractible/indecisive','Fontsize',18,...
                'Callback',@BDE6_Callback);
            BDE7=uicontrol('Parent',p1,'Style','checkbox','units','normalized','Position',[.1 .2 .7 .1],...
                'String','suicidal thoughts','Fontsize',18,...
                'Callback',@BDE7_Callback);
            nBDE=uicontrol('Parent',p1,'Style','pushbutton','units','normalized','Position',[.6 .2 .2 .1],...
                'String','Next','Fontsize',18,'Callback',@nBDE_Callback);
        else %patient does not have depression. Check mania directly.
            set(p1,'Title','Step 2: screen for bipolar disorder. Check if the following symptoms have been present')
            BDA1=uicontrol('Parent',p1,'Style','checkbox','units','normalized','Position',[.1 .7 .7 .1],...
                'String','Elevated/expansive mood','Fontsize',18,'Callback',@BDA1_Callback);
            
            BDA2=uicontrol('Parent',p1,'Style','checkbox','units','normalized','Position',[.1 .5 .7 .1],...
                'String','Irritable mood','Fontsize',18,'Callback',@BDA2_Callback);
            
            nBDA=uicontrol('Parent',p1,'Style','pushbutton','units','normalized','Position',[.6 .2 .2 .1],...
                'String','Next','Fontsize',18,'Callback',@nBDA_Callback);
        end
    end
    function BDE1_Callback (hObject, eventdata, handles)
        if (get(hObject,'Value') == get(hObject,'Max'))
            bde1=1;
        elseif (get(hObject,'Value') == get(hObject,'Min'))
            
            bde1=0;
        end
    end
    function BDE2_Callback (hObject, eventdata, handles)
        if (get(hObject,'Value') == get(hObject,'Max'))
            bde2=1;
        elseif (get(hObject,'Value') == get(hObject,'Min'))
            
            bde2=0;
        end
    end
    function BDE3_Callback (hObject, eventdata, handles)
        if (get(hObject,'Value') == get(hObject,'Max'))
            bde3=1;
        elseif (get(hObject,'Value') == get(hObject,'Min'))
            
            bde3=0;
        end
    end
    function BDE4_Callback (hObject, eventdata, handles)
        if (get(hObject,'Value') == get(hObject,'Max'))
            bde4=1;
        elseif (get(hObject,'Value') == get(hObject,'Min'))
            
            bde4=0;
        end
    end
    function BDE5_Callback (hObject, eventdata, handles)
        if (get(hObject,'Value') == get(hObject,'Max'))
            bde5=1;
        elseif (get(hObject,'Value') == get(hObject,'Min'))
            
            bde5=0;
        end
    end
    function BDE6_Callback (hObject, eventdata, handles)
        if (get(hObject,'Value') == get(hObject,'Max'))
            bde6=1;
        elseif (get(hObject,'Value') == get(hObject,'Min'))
            
            bde6=0;
        end
    end
    function BDE7_Callback (hObject, eventdata, handles)
        if (get(hObject,'Value') == get(hObject,'Max'))
            bde7=1;
        elseif (get(hObject,'Value') == get(hObject,'Min'))
            
            bde7=0;
        end
        
    end
    function nBDE_Callback(hObject, eventdata, handles)
        if bde1+bde2+bde3+bde4+bde5+bde6+bde7+bdd1+bdd2>=5;
            bddp=.503;%prevalence of depression in BD population
            
        else
            bddp=.065;%prevalence of depression in general population. Note:Although depression is common in BD, it's not
            %a strict diagnostic criteria, i.e. someone doesn't need to
            %have depression to have BD.
            
        end
        delete(BDE1)
        delete(BDE2)
        delete(BDE3)
        delete(BDE4)
        delete(BDE5)
        delete(BDE6)
        delete(BDE7)
        %%% Insert mania criteria here:
        set(p1,'Title','Step 2: screen for bipolar disorder. Please check if the following symptoms have been present')
        BDA1=uicontrol('Parent',p1,'Style','checkbox','units','normalized','Position',[.1 .7 .7 .1],...
            'String','Elevated/expansive mood','Fontsize',18,'Callback',@BDA1_Callback);
        
        BDA2=uicontrol('Parent',p1,'Style','checkbox','units','normalized','Position',[.1 .5 .7 .1],...
            'String','Irritable mood','Fontsize',18,'Callback',@BDA2_Callback);
        
        nBDA=uicontrol('Parent',p1,'Style','pushbutton','units','normalized','Position',[.6 .2 .2 .1],...
            'String','Next','Fontsize',18,'Callback',@nBDA_Callback);
    end
    function BDA1_Callback(hObject, eventdata, handles)
        if (get(hObject,'Value') == get(hObject,'Max'))
            bda1=1;
        elseif (get(hObject,'Value') == get(hObject,'Min'))
            
            bda1=0;
        end
        bda=bda1+bda2;
    end

    function BDA2_Callback(hObject, eventdata, handles)
        if (get(hObject,'Value') == get(hObject,'Max'))
            bda2=1;
        elseif (get(hObject,'Value') == get(hObject,'Min'))
            
            bda2=0;
            
        end
        bda=bda1+bda2;
    end
    function nBDA_Callback(hObject, eventdata, handles)
        bda=bda1+bda2;
        delete(BDA1)
        delete(BDA2)
        delete(nBDA)
        
        if bda~=0%patient may have mania
            
            set(p1,'Title','Step 2: screen for bipolar disorder:choose the most accurate option that','Fontsize',20,'Position',[.1 .1 .8 .8]);
            instr2=uicontrol('Parent',p1,'Style','text','units','normalized','Position',[0 .9 .7 .1],...
    'String','describes the duration of the mood in the previous page','Fontsize',20);
            BDB1=uicontrol('Parent',p1,'Style','checkbox','units','normalized','Position',[.1 .7 .7 .1],...
                'String','The mood lasted less than 4 days','Fontsize',18,...
                'Callback',@BDB1_Callback);
            BDB2=uicontrol('Parent',p1,'Style','checkbox','units','normalized','Position',[.1 .5 .7 .1],...
                'String','The mood lasted less  than one week, but more than 4 consecutive days','Fontsize',18,...
                'Callback',@BDB2_Callback);
            BDB3=uicontrol('Parent',p1,'Style','checkbox','units','normalized','Position',[.1 .3 .7 .1],...
                'String','The mood lasted more than one week, or its severity required hospitalization','Fontsize',18,...
                'Callback',@BDB3_Callback);
            nBDB=uicontrol('Parent',p1,'Style','pushbutton','units','normalized','Position',[.6 .2 .2 .1],...
                'String','Next','Fontsize',18,'Callback',@nBDB_Callback);
        else %patient doesn't have mania. Thus they cannot have bd.
            bdii=0;%not having bipolar ii diagnosis
            bdi=0;%not having bipolar i diagnosis
            %We now check for BPD
            set(p1,'Title','Step 3: screen for borderline personality disorder','Fontsize',20);
            BPD1=uicontrol('Parent',p1,'Style','checkbox','units','normalized','Position',[.1 .9 .7 .1],...
                'String','frantic efforts to avoid real/imagined abandonment','Fontsize',18,...
                'Callback',@BPD1_Callback);
            BPD2=uicontrol('Parent',p1,'Style','checkbox','units','normalized','Position',[.1 .8 .7 .1],...
                'String','unstable interpersonal relationships','Fontsize',18,...
                'Callback',@BPD2_Callback);
            BPD3=uicontrol('Parent',p1,'Style','checkbox','units','normalized','Position',[.1 .7 .7 .1],...
                'String','unstable self-image','Fontsize',18,...
                'Callback',@BPD3_Callback);
            BPD4=uicontrol('Parent',p1,'Style','checkbox','units','normalized','Position',[.1 .6 .7 .1],...
                'String','impulsive,self-damaging behavior (sexual, binge eating etc.)','Fontsize',18,...
                'Callback',@BPD4_Callback);
            BPD5=uicontrol('Parent',p1,'Style','checkbox','units','normalized','Position',[.1 .5 .7 .1],...
                'String','suicidal attempt/gesture','Fontsize',18,...
                'Callback',@BPD5_Callback);
            BPD6=uicontrol('Parent',p1,'Style','checkbox','units','normalized','Position',[.1 .4 .7 .1],...
                'String','affective instability, hyper reactive mood','Fontsize',18,...
                'Callback',@BPD6_Callback);
            BPD7=uicontrol('Parent',p1,'Style','checkbox','units','normalized','Position',[.1 .3 .7 .1],...
                'String','feeling of emptiness','Fontsize',18,...
                'Callback',@BPD7_Callback);
            BPD8=uicontrol('Parent',p1,'Style','checkbox','units','normalized','Position',[.1 .2 .7 .1],...
                'String','intense anger','Fontsize',18,...
                'Callback',@BPD8_Callback);
            BPD9=uicontrol('Parent',p1,'Style','checkbox','units','normalized','Position',[.1 .1 .7 .1],...
                'String','paranoid ideation, dissociative symptoms','Fontsize',18,...
                'Callback',@BPD9_Callback);
            nBPD=uicontrol('Parent',p1,'Style','pushbutton','units','normalized','Position',[.6 .2 .2 .1],...
                'String','Next','Fontsize',18,'Callback',@nBPD_Callback);
        end
        function BDB1_Callback(hObject, eventdata, handles)
            if (get(hObject,'Value') == get(hObject,'Max'))
                bdb1=1;
            elseif (get(hObject,'Value') == get(hObject,'Min'))
                
                bdb1=0;
            end
        end
        function BDB2_Callback(hObject, eventdata, handles)
            if (get(hObject,'Value') == get(hObject,'Max'))
                bdb2=1;
            elseif (get(hObject,'Value') == get(hObject,'Min'))
                
                bdb2=0;
            end
        end
        function BDB3_Callback(hObject, eventdata, handles)
            if (get(hObject,'Value') == get(hObject,'Max'))
                bdb3=1;
            elseif (get(hObject,'Value') == get(hObject,'Min'))
                
                bdb3=0;
            end
        end
        function BPD1_Callback(hObject, eventdata, handles)
            if (get(hObject,'Value') == get(hObject,'Max'))
                bpd1=.70;
            elseif (get(hObject,'Value') == get(hObject,'Min'))
                
                bpd1=0.39;
            end
        end
        function BPD2_Callback(hObject, eventdata, handles)
            if (get(hObject,'Value') == get(hObject,'Max'))
                bpd2=.77;
                DATA.bpd2 = bpd2;
            elseif (get(hObject,'Value') == get(hObject,'Min'))
                
                bda2=0.39;
            end
        end
        function BPD3_Callback(hObject, eventdata, handles)
            if (get(hObject,'Value') == get(hObject,'Max'))
                bpd3=.49;
            elseif (get(hObject,'Value') == get(hObject,'Min'))
                
                bpd3=0.13;
            end
        end
        function BPD4_Callback(hObject, eventdata, handles)
            if (get(hObject,'Value') == get(hObject,'Max'))
                bpd4=.89;
            elseif (get(hObject,'Value') == get(hObject,'Min'))
                
                bpd4=0.39;
            end
        end
        function BPD5_Callback(hObject, eventdata, handles)
            if (get(hObject,'Value') == get(hObject,'Max'))
                bpd5=0.91;
            elseif (get(hObject,'Value') == get(hObject,'Min'))
                
                bpd5=0.36;
            end
        end
        function BPD6_Callback(hObject, eventdata, handles)
            if (get(hObject,'Value') == get(hObject,'Max'))
                bpd6=.79;
            elseif (get(hObject,'Value') == get(hObject,'Min'))
                
                bpd6=0.49;
            end
        end
        function BPD7_Callback(hObject, eventdata, handles)
            if (get(hObject,'Value') == get(hObject,'Max'))
                bpd7=.58;
            elseif (get(hObject,'Value') == get(hObject,'Min'))
                
                bpd7=0.16;
            end
        end
        function BPD8_Callback(hObject, eventdata, handles)
            if (get(hObject,'Value') == get(hObject,'Max'))
                bpd8=.87;
            elseif (get(hObject,'Value') == get(hObject,'Min'))
                
                bpd8=0.45;
            end
        end
        function BPD9_Callback(hObject, eventdata, handles)
            if (get(hObject,'Value') == get(hObject,'Max'))
                bpd9=.68;
            elseif (get(hObject,'Value') == get(hObject,'Min'))
                
                bpd9=0.33;
            end
        end
        function nBDB_Callback (hObject, eventdata, handles)
            delete(nBDB)
            delete(BDB1)
            delete(BDB2)
            delete(BDB3)
            delete(instr2)
            %variables that start with bdb indicate the length of mania.
            %bdb1 is the shortest, bdb3 is the longest.
            set(p1,'Title','Step 2: screen for bipolar disorder: check if patient has the following symptoms','Fontsize',20,'Position',[.1 .1 .8 .8]);
            if bdb2==1
                bdi=0;%BD type I ruled out
                %Patient does not have BD I, but now let's check for BD II.
                BDC1=uicontrol('Parent',p1,'Style','checkbox','units','normalized','Position',[.1 .8 .7 .1],...
                    'String','feeling of grandiosity','Fontsize',18,...
                    'Callback',@BDC1_Callback);
                BDC2=uicontrol('Parent',p1,'Style','checkbox','units','normalized','Position',[.1 .7 .7 .1],...
                    'String','less need for sleep','Fontsize',18,...
                    'Callback',@BDC2_Callback);
                BDC3=uicontrol('Parent',p1,'Style','checkbox','units','normalized','Position',[.1 .6 .7 .1],...
                    'String','overly talkative','Fontsize',18,...
                    'Callback',@BDC3_Callback);
                BDC4=uicontrol('Parent',p1,'Style','checkbox','units','normalized','Position',[.1 .5 .7 .1],...
                    'String','flight of ideas','Fontsize',18,...
                    'Callback',@BDC4_Callback);
                BDC5=uicontrol('Parent',p1,'Style','checkbox','units','normalized','Position',[.1 .4 .7 .1],...
                    'String','overly distractable','Fontsize',18,...
                    'Callback',@BDC5_Callback);
                BDC6=uicontrol('Parent',p1,'Style','checkbox','units','normalized','Position',[.1 .3 .7 .1],...
                    'String','increase in goal-directed activity or psychomotor agitation','Fontsize',18,...
                    'Callback',@BDC6_Callback);
                BDC7=uicontrol('Parent',p1,'Style','checkbox','units','normalized','Position',[.1 .2 .7 .1],...
                    'String','risky behavior (sexual/financial etc.)','Fontsize',18,...
                    'Callback',@BDC7_Callback);
                nBDC=uicontrol('Parent',p1,'Style','pushbutton','units','normalized','Position',[.6 .2 .2 .1],...
                    'String','Next','Fontsize',18,'Callback',@nBDC_Callback);
            elseif bdb1==1
                bdii=0;%not having bipolar ii diagnosis
                bdi=0; %not having bipolar i diagnosis. Patient's mania hasn't lasted long enough to qualify for a BD diagnosis.
                %Time to diagnose borderline personality disorder.
                set(p1,'Title','Step 3: screen for borderline personality disorder','Fontsize',20);
                instr3=uicontrol('Parent', p1, 'Style','text','units','normalized','Position',[.0 .9 .7 .1],...
                    'String','check if any of the following symptoms are present','Fontsize',20);
                BPD1=uicontrol('Parent',p1,'Style','checkbox','units','normalized','Position',[.1 .9 .7 .1],...
                    'String','frantic efforts to avoid real/imagined abandonment','Fontsize',18,...
                    'Callback',@BPD1_Callback);
                BPD2=uicontrol('Parent',p1,'Style','checkbox','units','normalized','Position',[.1 .8 .7 .1],...
                    'String','unstable interpersonal relationships','Fontsize',18,...
                    'Callback',@BPD2_Callback);
                BPD3=uicontrol('Parent',p1,'Style','checkbox','units','normalized','Position',[.1 .7 .7 .1],...
                    'String','unstable self-image','Fontsize',18,...
                    'Callback',@BPD3_Callback);
                BPD4=uicontrol('Parent',p1,'Style','checkbox','units','normalized','Position',[.1 .6 .7 .1],...
                    'String','impulsive,self-damaging behavior (sexual, binge eating etc.)','Fontsize',18,...
                    'Callback',@BPD4_Callback);
                BPD5=uicontrol('Parent',p1,'Style','checkbox','units','normalized','Position',[.1 .5 .7 .1],...
                    'String','suicidal attempt/gesture','Fontsize',18,...
                    'Callback',@BPD5_Callback);
                BPD6=uicontrol('Parent',p1,'Style','checkbox','units','normalized','Position',[.1 .4 .7 .1],...
                    'String','affective instability, hyper reactive mood','Fontsize',18,...
                    'Callback',@BPD6_Callback);
                BPD7=uicontrol('Parent',p1,'Style','checkbox','units','normalized','Position',[.1 .3 .7 .1],...
                    'String','feeling of emptiness','Fontsize',18,...
                    'Callback',@BPD7_Callback);
                BPD8=uicontrol('Parent',p1,'Style','checkbox','units','normalized','Position',[.1 .2 .7 .1],...
                    'String','intense anger','Fontsize',18,...
                    'Callback',@BPD8_Callback);
                BPD9=uicontrol('Parent',p1,'Style','checkbox','units','normalized','Position',[.1 .1 .7 .1],...
                    'String','paranoid ideation, dissociative symptoms','Fontsize',18,...
                    'Callback',@BPD9_Callback);
                nBPD=uicontrol('Parent',p1,'Style','pushbutton','units','normalized','Position',[.6 .2 .2 .1],...
                    'String','Next','Fontsize',18,'Callback',@nBPD_Callback);
            else
                bdii=0;%not having bipolar II. Now let's check the mania symptoms and see if patient satisfies bipolar I criteria.
                
                BDC1=uicontrol('Parent',p1,'Style','checkbox','units','normalized','Position',[.1 .8 .7 .1],...
                    'String','feeling of grandiosity','Fontsize',18,...
                    'Callback',@BDC1_Callback);
                BDC2=uicontrol('Parent',p1,'Style','checkbox','units','normalized','Position',[.1 .7 .7 .1],...
                    'String','less need for sleep','Fontsize',18,...
                    'Callback',@BDC2_Callback);
                BDC3=uicontrol('Parent',p1,'Style','checkbox','units','normalized','Position',[.1 .6 .7 .1],...
                    'String','overly talkative','Fontsize',18,...
                    'Callback',@BDC3_Callback);
                BDC4=uicontrol('Parent',p1,'Style','checkbox','units','normalized','Position',[.1 .5 .7 .1],...
                    'String','flight of ideas','Fontsize',18,...
                    'Callback',@BDC4_Callback);
                BDC5=uicontrol('Parent',p1,'Style','checkbox','units','normalized','Position',[.1 .4 .7 .1],...
                    'String','overly distractable','Fontsize',18,...
                    'Callback',@BDC5_Callback);
                BDC6=uicontrol('Parent',p1,'Style','checkbox','units','normalized','Position',[.1 .3 .7 .1],...
                    'String','increase in goal-directed activity or psychomotor agitation','Fontsize',18,...
                    'Callback',@BDC6_Callback);
                BDC7=uicontrol('Parent',p1,'Style','checkbox','units','normalized','Position',[.1 .2 .7 .1],...
                    'String','risky behavior (sexual/financial etc.)','Fontsize',18,...
                    'Callback',@BDC7_Callback);
                nBDC=uicontrol('Parent',p1,'Style','pushbutton','units','normalized','Position',[.6 .2 .2 .1],...
                    'String','Next','Fontsize',18,'Callback',@nBDC_Callback);
                
            end
            
        end
        %Plugging in the mania symptom prevalences in BD vs. general
        %population. Symptom 3 and 4, symptom 5 and 6 are grouped
        %together in the prevalence studies, and the calculation reflects that.
        function BDC1_Callback(hObject, eventdata, handles)
            if (get(hObject,'Value') == get(hObject,'Max'))
                bdc1=.59;
            elseif (get(hObject,'Value') == get(hObject,'Min'))
                
                bdc1=0.12;
            end
        end
        function BDC2_Callback(hObject, eventdata, handles)
            if (get(hObject,'Value') == get(hObject,'Max'))
                bdc2=.84;
            elseif (get(hObject,'Value') == get(hObject,'Min'))
                
                bdc2=0.166;
            end
        end
        function BDC3_Callback(hObject, eventdata, handles)
            if (get(hObject,'Value') == get(hObject,'Max'))
                bdc3=1;
            elseif (get(hObject,'Value') == get(hObject,'Min'))
                
                bdc3=0;
            end
        end
        function BDC4_Callback(hObject, ~, handles)
            if (get(hObject,'Value') == get(hObject,'Max'))
                bdc4=1;
            elseif (get(hObject,'Value') == get(hObject,'Min'))
                
                bdc4=0;
            end
        end
        function BDC5_Callback(hObject, eventdata, handles)
            if (get(hObject,'Value') == get(hObject,'Max'))
                bdc5=1;
            elseif (get(hObject,'Value') == get(hObject,'Min'))
                
                bdc5=0;
            end
        end
        function BDC6_Callback(hObject, eventdata, handles)
            if (get(hObject,'Value') == get(hObject,'Max'))
                bdc6=1;
            elseif (get(hObject,'Value') == get(hObject,'Min'))
                
                bdc6=0;
            end
        end
        function BDC7_Callback(hObject, eventdata, handles)
            if (get(hObject,'Value') == get(hObject,'Max'))
                bdc7=.13;
            elseif (get(hObject,'Value') == get(hObject,'Min'))
                
                bdc7=.03;
            end
        end
        function nBDC_Callback(hObject, eventdata, handles)
            delete(BDC1)
            delete(BDC2)
            delete(BDC3)
            delete(BDC4)
            delete(BDC5)
            delete(BDC6)
            delete(BDC7)
            if bdc3+bdc4>0
                TS=.72;%prevlaence of racing thoughts/pressure of speech in BD population
            end
            if bdc5+bdc6>0
                A=.90;%prevalence of Distractibility/psychomotor agitation in BD population
            end
            if bdb1==1
                bdi=0;
                bdii=0;
            elseif bdb2==1&bddp==.503%patient's mania is hypo, and they have depression
                bdi=0;
                bdii=.018*bdc1*bdc2*TS*A*bdc7*hx1/(.12*.166*.3*.015*.03*.02)%Bayesian calculation of BD type II probability
                %1.8% is the 12 months prevalence rate of BD type II in US,
                
                %adult population per DSM 5.
            elseif bdb3==1
                bdii=0;
                bdi=.006*bdc1*bdc2*TS*A*bdc7*bddp*hx1/(.12*.166*.3*.015*.03*.065*.02)%Bayesian calculation of BD type I probability
                %.6% is the 12 months prevalence rate of BD type I in US
                %adult population per DSM 5.
            else bdi=0;
                bdii=0;
            end
            set(p1,'Title','Step 3: screen for borderline personality disorder','Fontsize',20);
            
            BPD1=uicontrol('Parent',p1,'Style','checkbox','units','normalized','Position',[.1 .9 .7 .1],...
                'String','frantic efforts to avoid real/imagined abandonment','Fontsize',18,...
                'Callback',@BPD1_Callback);
            BPD2=uicontrol('Parent',p1,'Style','checkbox','units','normalized','Position',[.1 .8 .7 .1],...
                'String','unstable interpersonal relationships','Fontsize',18,...
                'Callback',@BPD2_Callback);
            BPD3=uicontrol('Parent',p1,'Style','checkbox','units','normalized','Position',[.1 .7 .7 .1],...
                'String','unstable self-image','Fontsize',18,...
                'Callback',@BPD3_Callback);
            BPD4=uicontrol('Parent',p1,'Style','checkbox','units','normalized','Position',[.1 .6 .7 .1],...
                'String','impulsive,self-damaging behavior (sexual, binge eating etc.)','Fontsize',18,...
                'Callback',@BPD4_Callback);
            BPD5=uicontrol('Parent',p1,'Style','checkbox','units','normalized','Position',[.1 .5 .7 .1],...
                'String','suicidal attempt/gesture','Fontsize',18,...
                'Callback',@BPD5_Callback);
            BPD6=uicontrol('Parent',p1,'Style','checkbox','units','normalized','Position',[.1 .4 .7 .1],...
                'String','affective instability, hyper reactive mood','Fontsize',18,...
                'Callback',@BPD6_Callback);
            BPD7=uicontrol('Parent',p1,'Style','checkbox','units','normalized','Position',[.1 .3 .7 .1],...
                'String','feeling of emptiness','Fontsize',18,...
                'Callback',@BPD7_Callback);
            BPD8=uicontrol('Parent',p1,'Style','checkbox','units','normalized','Position',[.1 .2 .7 .1],...
                'String','intense anger','Fontsize',18,...
                'Callback',@BPD8_Callback);
            BPD9=uicontrol('Parent',p1,'Style','checkbox','units','normalized','Position',[.1 .1 .7 .1],...
                'String','paranoid ideation, dissociative symptoms','Fontsize',18,...
                'Callback',@BPD9_Callback);
            nBPD=uicontrol('Parent',p1,'Style','pushbutton','units','normalized','Position',[.6 .2 .2 .1],...
                'String','Next','Fontsize',18,'Callback',@nBPD_Callback);
            
        end
    end
    function BPD1_Callback(hObject, eventdata, handles)
        if (get(hObject,'Value') == get(hObject,'Max'))
            bpd1=.70;
        elseif (get(hObject,'Value') == get(hObject,'Min'))
            
            bpd1=0.39;
        end
    end
    function BPD2_Callback(hObject, eventdata, handles)
        if (get(hObject,'Value') == get(hObject,'Max'))
            bpd2=.77;
        elseif (get(hObject,'Value') == get(hObject,'Min'))
            
            bda2=0.39;
        end
    end
    function BPD3_Callback(hObject, eventdata, handles)
        if (get(hObject,'Value') == get(hObject,'Max'))
            bpd3=.49;
        elseif (get(hObject,'Value') == get(hObject,'Min'))
            
            bpd3=0.13;
        end
    end
    function BPD4_Callback(hObject, eventdata, handles)
        if (get(hObject,'Value') == get(hObject,'Max'))
            bpd4=.89;
        elseif (get(hObject,'Value') == get(hObject,'Min'))
            
            bpd4=0.39;
        end
    end
    function BPD5_Callback(hObject, eventdata, handles)
        if (get(hObject,'Value') == get(hObject,'Max'))
            bpd5=0.91;
        elseif (get(hObject,'Value') == get(hObject,'Min'))
            
            bpd5=0.36;
        end
    end
    function BPD6_Callback(hObject, eventdata, handles)
        if (get(hObject,'Value') == get(hObject,'Max'))
            bpd6=.79;
        elseif (get(hObject,'Value') == get(hObject,'Min'))
            
            bpd6=0.49;
        end
    end
    function BPD7_Callback(hObject, eventdata, handles)
        if (get(hObject,'Value') == get(hObject,'Max'))
            bpd7=.58;
        elseif (get(hObject,'Value') == get(hObject,'Min'))
            
            bpd7=0.16;
        end
    end
    function BPD8_Callback(hObject, eventdata, handles)
        if (get(hObject,'Value') == get(hObject,'Max'))
            bpd8=.87;
        elseif (get(hObject,'Value') == get(hObject,'Min'))
            
            bpd8=0.45;
        end
    end
    function BPD9_Callback(hObject, eventdata, handles)
        if (get(hObject,'Value') == get(hObject,'Max'))
            bpd9=.68;
        elseif (get(hObject,'Value') == get(hObject,'Min'))
            
            bpd9=0.33;
        end
    end
    function nBPD_Callback(hObject, eventdata, handles)
        bpd=.016*bpd1*bpd2*bpd3*bpd4*bpd5*bpd6*bpd7*bpd8*bpd9*hx2/(.33*.39*.39*.45*.13*.49*.39*.36*.16*.016)
        %likelihood of the patient having bpd
        delete (BPD1)
        delete (BPD2)
        delete (BPD3)
        delete (BPD4)
        delete (BPD5)
        delete (BPD6)
        delete (BPD7)
        delete (BPD8)
        delete (BPD9)
        delete (instr3)
        set(p1,'Title','Step 4: screen for attention-deficit/hyperactivity disorder:check if the following symptoms exist','Fontsize',20,'Position',[.1 .1 .8 .8]);
        %first, check all the inattention symptoms
        ADHD1=uicontrol('Parent',p1,'Style','checkbox','units','normalized','Position',[.1 .9 .7 .1],...
            'String','fail to attend to details in school/work','Fontsize',18,...
            'Callback',@ADHD1_Callback);
        ADHD2=uicontrol('Parent',p1,'Style','checkbox','units','normalized','Position',[.1 .8 .7 .1],...
            'String','difficulty sustaining attention in tasks','Fontsize',18,...
            'Callback',@ADHD2_Callback);
        ADHD3=uicontrol('Parent',p1,'Style','checkbox','units','normalized','Position',[.1 .7 .7 .1],...
            'String','absent-mindedness when spoken to','Fontsize',18,...
            'Callback',@ADHD3_Callback);
        ADHD4=uicontrol('Parent',p1,'Style','checkbox','units','normalized','Position',[.1 .6 .7 .1],...
            'String','fail to follow through/finish work/chores','Fontsize',18,...
            'Callback',@ADHD4_Callback);
        ADHD5=uicontrol('Parent',p1,'Style','checkbox','units','normalized','Position',[.1 .5 .7 .1],...
            'String','difficulty organizing tasks/activities','Fontsize',18,...
            'Callback',@ADHD5_Callback);
        ADHD6=uicontrol('Parent',p1,'Style','checkbox','units','normalized','Position',[.1 .4 .7 .1],...
            'String','reluctant to engage in tasks requiring sustained mental effort','Fontsize',18,...
            'Callback',@ADHD6_Callback);
        ADHD7=uicontrol('Parent',p1,'Style','checkbox','units','normalized','Position',[.1 .3 .7 .1],...
            'String','tend to lose belongings','Fontsize',18,...
            'Callback',@ADHD7_Callback);
        ADHD8=uicontrol('Parent',p1,'Style','checkbox','units','normalized','Position',[.1 .2 .7 .1],...
            'String','easily distracted','Fontsize',18,...
            'Callback',@ADHD8_Callback);
        ADHD9=uicontrol('Parent',p1,'Style','checkbox','units','normalized','Position',[.1 .1 .7 .1],...
            'String','forgetful in daily activities','Fontsize',18,...
            'Callback',@ADHD9_Callback);
        nADHD=uicontrol('Parent',p1,'Style','pushbutton','units','normalized','Position',[.6 .2 .2 .1],...
            'String','Next','Fontsize',18,'Callback',@nADHD_Callback);
    end
    function ADHD1_Callback(hObject, eventdata, handles)
        if (get(hObject,'Value') == get(hObject,'Max'))
            adhd1=1;
        elseif (get(hObject,'Value') == get(hObject,'Min'))
            
            adhd1=0;
        end
    end
    function ADHD2_Callback(hObject, eventdata, handles)
        if (get(hObject,'Value') == get(hObject,'Max'))
            adhd2=1;
        elseif (get(hObject,'Value') == get(hObject,'Min'))
            
            adhd2=0;
        end
    end
    function ADHD3_Callback(hObject, eventdata, handles)
        if (get(hObject,'Value') == get(hObject,'Max'))
            adhd3=1;
        elseif (get(hObject,'Value') == get(hObject,'Min'))
            
            adhd3=0;
        end
    end
    function ADHD4_Callback(hObject, eventdata, handles)
        if (get(hObject,'Value') == get(hObject,'Max'))
            adhd4=1;
        elseif (get(hObject,'Value') == get(hObject,'Min'))
            
            adhd4=0;
        end
    end
    function ADHD5_Callback(hObject, eventdata, handles)
        if (get(hObject,'Value') == get(hObject,'Max'))
            adhd5=1;
        elseif (get(hObject,'Value') == get(hObject,'Min'))
            
            adhd5=0;
        end
    end
    function ADHD6_Callback(hObject, eventdata, handles)
        if (get(hObject,'Value') == get(hObject,'Max'))
            adhd6=1;
        elseif (get(hObject,'Value') == get(hObject,'Min'))
            
            adhd6=0;
        end
    end
    function ADHD7_Callback(hObject, eventdata, handles)
        if (get(hObject,'Value') == get(hObject,'Max'))
            adhd7=1;
        elseif (get(hObject,'Value') == get(hObject,'Min'))
            
            adhd7=0;
        end
    end
    function ADHD8_Callback(hObject, eventdata, handles)
        if (get(hObject,'Value') == get(hObject,'Max'))
            adhd8=1;
        elseif (get(hObject,'Value') == get(hObject,'Min'))
            
            adhd8=0;
        end
    end
    function ADHD9_Callback(hObject, eventdata, handles)
        if (get(hObject,'Value') == get(hObject,'Max'))
            adhd9=1;
        elseif (get(hObject,'Value') == get(hObject,'Min'))
            
            adhd9=0;
        end
    end
    function nADHD_Callback(hObject, eventdata, handles)
        adhdi=adhd1+adhd2+adhd3+adhd4+adhd5+adhd6+adhd7+adhd8+adhd9;
        delete(ADHD1)
        delete(ADHD2)
        delete(ADHD3)
        delete(ADHD4)
        delete(ADHD5)
        delete(ADHD6)
        delete(ADHD7)
        delete(ADHD8)
        delete(ADHD9)
        delete(nADHD)
        if adhdi>=5,
            adhdiii=1;
            %screen for antisocial personality disorder
            set(p1,'Title','Step 5: screen for antisocial personality disorder:check if patient has pervasive pattern of following behaviors','Fontsize',20,'Position',[.1 .1 .8 .8]);
            ASPD1=uicontrol('Parent',p1,'Style','checkbox','units','normalized','Position',[.1 .9 .7 .1],...
                'String','repeated acts that are grounds for arrest','Fontsize',18,...
                'Callback',@ASPD1_Callback);
            ASPD2=uicontrol('Parent',p1,'Style','checkbox','units','normalized','Position',[.1 .8 .7 .1],...
                'String','deceitfulness','Fontsize',18,...
                'Callback',@ASPD2_Callback);
            ASPD3=uicontrol('Parent',p1,'Style','checkbox','units','normalized','Position',[.1 .7 .7 .1],...
                'String','impulsivity/failure to plan ahead','Fontsize',18,...
                'Callback',@ASPD3_Callback);
            ASPD4=uicontrol('Parent',p1,'Style','checkbox','units','normalized','Position',[.1 .6 .7 .1],...
                'String','aggressive, repeated physical fights/assaults','Fontsize',18,...
                'Callback',@ASPD4_Callback);
            ASPD5=uicontrol('Parent',p1,'Style','checkbox','units','normalized','Position',[.1 .5 .7 .1],...
                'String','disregard for safety of self/others','Fontsize',18,...
                'Callback',@ASPD5_Callback);
            ASPD6=uicontrol('Parent',p1,'Style','checkbox','units','normalized','Position',[.1 .4 .7 .1],...
                'String','irresponsible, failure to sustain work or honor financial obligations','Fontsize',18,...
                'Callback',@ASPD6_Callback);
            ASPD7=uicontrol('Parent',p1,'Style','checkbox','units','normalized','Position',[.1 .3 .7 .1],...
                'String','lack of remorse','Fontsize',18,...
                'Callback',@ASPD7_Callback);
            ASPD8=uicontrol('Parent',p1,'Style','checkbox','units','normalized','Position',[.1 .2 .7 .1],...
                'String','evidence of conduct disorder before age 15','Fontsize',18,...
                'Callback',@ASPD8_Callback);
            
            nASPD=uicontrol('Parent',p1,'Style','pushbutton','units','normalized','Position',[.7 .2 .2 .1],...
                'String','Next','Fontsize',18,'Callback',@nASPD_Callback);
            
            
        else %screen for hyperactivity criteria
            set(p1,'Title','Step 3: screen for attention-deficit/hyperactivity disorder:check if the following symptoms exist','Fontsize',20,'Position',[.1 .1 .8 .8]);
            ADHDii1=uicontrol('Parent',p1,'Style','checkbox','units','normalized','Position',[.1 .9 .7 .1],...
                'String','fidgety','Fontsize',18,...
                'Callback',@ADHDii1_Callback);
            ADHDii2=uicontrol('Parent',p1,'Style','checkbox','units','normalized','Position',[.1 .8 .7 .1],...
                'String','trouble remain sitting when required','Fontsize',18,...
                'Callback',@ADHDii2_Callback);
            ADHDii3=uicontrol('Parent',p1,'Style','checkbox','units','normalized','Position',[.1 .7 .7 .1],...
                'String','feeling restless','Fontsize',18,...
                'Callback',@ADHDii3_Callback);
            ADHDii4=uicontrol('Parent',p1,'Style','checkbox','units','normalized','Position',[.1 .6 .7 .1],...
                'String','unable to engage in quiet leisure activities','Fontsize',18,...
                'Callback',@ADHDii4_Callback);
            ADHDii5=uicontrol('Parent',p1,'Style','checkbox','units','normalized','Position',[.1 .5 .7 .1],...
                'String','often ''on the go''','Fontsize',18,...
                'Callback',@ADHDii5_Callback);
            ADHDii6=uicontrol('Parent',p1,'Style','checkbox','units','normalized','Position',[.1 .4 .7 .1],...
                'String','talks excessively','Fontsize',18,...
                'Callback',@ADHDii6_Callback);
            ADHDii7=uicontrol('Parent',p1,'Style','checkbox','units','normalized','Position',[.1 .3 .7 .1],...
                'String','cannnot wait for turn in conversation','Fontsize',18,...
                'Callback',@ADHDii7_Callback);
            ADHDii8=uicontrol('Parent',p1,'Style','checkbox','units','normalized','Position',[.1 .2 .7 .1],...
                'String','impatient for his or her turn in activities, e.g. waiting in line','Fontsize',18,...
                'Callback',@ADHDii8_Callback);
            ADHDii9=uicontrol('Parent',p1,'Style','checkbox','units','normalized','Position',[.1 .1 .7 .1],...
                'String','often interrupts/intrudes on others','Fontsize',18,...
                'Callback',@ADHDii9_Callback);
            nADHDii=uicontrol('Parent',p1,'Style','pushbutton','units','normalized','Position',[.7 .2 .2 .1],...
                'String','Next','Fontsize',18,'Callback',@nADHDii_Callback);
        end
    end


    function ADHDii1_Callback(hObject, eventdata, handles)
        
        if (get(hObject,'Value') == get(hObject,'Max'))
            adhdii1=1;
        elseif (get(hObject,'Value') == get(hObject,'Min'))
            
            adhdii1=0;
        end
    end
    function ADHDii2_Callback(hObject, eventdata, handles)
        if (get(hObject,'Value') == get(hObject,'Max'))
            adhdii2=1;
        elseif (get(hObject,'Value') == get(hObject,'Min'))
            
            adhdii2=0;
        end
    end
    function ADHDii3_Callback(hObject, eventdata, handles)
        if (get(hObject,'Value') == get(hObject,'Max'))
            adhdii3=1;
        elseif (get(hObject,'Value') == get(hObject,'Min'))
            
            adhdii3=0;
        end
    end
    function ADHDii4_Callback(hObject, eventdata, handles)
        if (get(hObject,'Value') == get(hObject,'Max'))
            adhdii4=1;
        elseif (get(hObject,'Value') == get(hObject,'Min'))
            
            adhdii4=0;
        end
    end
    function ADHDii5_Callback(hObject, eventdata, handles)
        if (get(hObject,'Value') == get(hObject,'Max'))
            adhdii5=1;
        elseif (get(hObject,'Value') == get(hObject,'Min'))
            
            adhdii5=0;
        end
    end
    function ADHDii6_Callback(hObject, eventdata, handles)
        if (get(hObject,'Value') == get(hObject,'Max'))
            adhdii6=1;
        elseif (get(hObject,'Value') == get(hObject,'Min'))
            
            adhdii6=0;
        end
    end
    function ADHDii7_Callback(hObject, eventdata, handles)
        if (get(hObject,'Value') == get(hObject,'Max'))
            adhdii7=1;
        elseif (get(hObject,'Value') == get(hObject,'Min'))
            
            adhdii7=0;
        end
    end
    function ADHDii8_Callback(hObject, eventdata, handles)
        if (get(hObject,'Value') == get(hObject,'Max'))
            adhdii8=1;
        elseif (get(hObject,'Value') == get(hObject,'Min'))
            
            adhdii8=0;
        end
    end
    function ADHDii9_Callback(hObject, eventdata, handles)
        if (get(hObject,'Value') == get(hObject,'Max'))
            adhdii9=1;
        elseif (get(hObject,'Value') == get(hObject,'Min'))
            
            adhdii9=0;
        end
    end


    function nADHDii_Callback(hObject, eventdata, handles)
        delete(ADHDii1)
        delete(ADHDii2)
        delete(ADHDii3)
        delete(ADHDii4)
        delete(ADHDii5)
        delete(ADHDii6)
        delete(ADHDii7)
        delete(ADHDii8)
        delete(ADHDii9)
        delete(nADHDii)
        adhdii=adhdii1+adhdii2+adhdii3+adhdii4+adhdii5+adhdii6+adhdii7+adhdii8+adhdii9;
        if adhdii>=5
            adhdiii=1;
        else adhdiii=0;
        end
        %screen for antisocial personality disorder
        set(p1,'Title','Step 4: screen for antisocial personality disorder:check if patient has pervasive pattern of following behaviors','Fontsize',20,'Position',[.1 .1 .8 .8]);
        ASPD1=uicontrol('Parent',p1,'Style','checkbox','units','normalized','Position',[.1 .9 .7 .1],...
            'String','repeated acts that are grounds for arrest','Fontsize',18,...
            'Callback',@ASPD1_Callback);
        ASPD2=uicontrol('Parent',p1,'Style','checkbox','units','normalized','Position',[.1 .8 .7 .1],...
            'String','deceitfulness','Fontsize',18,...
            'Callback',@ASPD2_Callback);
        ASPD3=uicontrol('Parent',p1,'Style','checkbox','units','normalized','Position',[.1 .7 .7 .1],...
            'String','impulsivity/failure to plan ahead','Fontsize',18,...
            'Callback',@ASPD3_Callback);
        ASPD4=uicontrol('Parent',p1,'Style','checkbox','units','normalized','Position',[.1 .6 .7 .1],...
            'String','aggressive, repeated physical fights/assaults','Fontsize',18,...
            'Callback',@ASPD4_Callback);
        ASPD5=uicontrol('Parent',p1,'Style','checkbox','units','normalized','Position',[.1 .5 .7 .1],...
            'String','disregard for safety of self/others','Fontsize',18,...
            'Callback',@ASPD5_Callback);
        ASPD6=uicontrol('Parent',p1,'Style','checkbox','units','normalized','Position',[.1 .4 .7 .1],...
            'String','irresponsible, failure to sustain work or honor financial obligations','Fontsize',18,...
            'Callback',@ASPD6_Callback);
        ASPD7=uicontrol('Parent',p1,'Style','checkbox','units','normalized','Position',[.1 .3 .7 .1],...
            'String','lack of remorse','Fontsize',18,...
            'Callback',@ASPD7_Callback);
        ASPD8=uicontrol('Parent',p1,'Style','checkbox','units','normalized','Position',[.1 .2 .7 .1],...
            'String','evidence of conduct disorder before age 15','Fontsize',18,...
            'Callback',@ASPD8_Callback);
        
        nASPD=uicontrol('Parent',p1,'Style','pushbutton','units','normalized','Position',[.7 .2 .2 .1],...
            'String','Next','Fontsize',18,'Callback',@nASPD_Callback);
    end

    function ASPD1_Callback(hObject, eventdata, handles)
        
        if (get(hObject,'Value') == get(hObject,'Max'))
            aspd1=1;
        elseif (get(hObject,'Value') == get(hObject,'Min'))
            
            aspd1=0;
        end
    end
    function ASPD2_Callback(hObject, eventdata, handles)
        if (get(hObject,'Value') == get(hObject,'Max'))
            aspd2=1;
        elseif (get(hObject,'Value') == get(hObject,'Min'))
            
            aspd2=0;
        end
    end
    function ASPD3_Callback(hObject, eventdata, handles)
        if (get(hObject,'Value') == get(hObject,'Max'))
            aspd3=1;
        elseif (get(hObject,'Value') == get(hObject,'Min'))
            
            aspd3=0;
        end
    end
    function ASPD4_Callback(hObject, eventdata, handles)
        if (get(hObject,'Value') == get(hObject,'Max'))
            aspd4=1;
        elseif (get(hObject,'Value') == get(hObject,'Min'))
            
            aspd4=0;
        end
    end
    function ASPD5_Callback(hObject, eventdata, handles)
        if (get(hObject,'Value') == get(hObject,'Max'))
            aspd5=1;
        elseif (get(hObject,'Value') == get(hObject,'Min'))
            
            aspd5=0;
        end
    end
    function ASPD6_Callback(hObject, eventdata, handles)
        if (get(hObject,'Value') == get(hObject,'Max'))
            aspd6=1;
        elseif (get(hObject,'Value') == get(hObject,'Min'))
            
            aspd6=0;
        end
    end
    function ASPD7_Callback(hObject, eventdata, handles)
        if (get(hObject,'Value') == get(hObject,'Max'))
            aspd7=1;
        elseif (get(hObject,'Value') == get(hObject,'Min'))
            
            aspd7=0;
        end
    end
    function ASPD8_Callback(hObject, eventdata, handles)
        if (get(hObject,'Value') == get(hObject,'Max'))
            aspd8=1;
        elseif (get(hObject,'Value') == get(hObject,'Min'))
            
            aspd8=0;
        end
    end
    function nASPD_Callback(hObject, eventdata, handles)
        delete(ASPD1)
        delete(ASPD2)
        delete(ASPD3)
        delete(ASPD4)
        delete(ASPD5)
        delete(ASPD6)
        delete(ASPD7)
        delete(ASPD8)
        
        delete(nASPD)
        aspd=aspd1+aspd2+aspd3+aspd4+aspd5+aspd6+aspd7+aspd8;
        if aspd>=3
            aspdi=1;
        else aspdi=0;
        end
        
        
        
        
        %Show results
        
        close(f1)
        f2=figure('Visible','on','units','normalized','outerposition',[0 0 1 1],'MenuBar','none');
        p2=uipanel('Title','Congratulations! You have reached a diagnosis.','Fontsize',20,'Position',[.1 .1 .8 .8]);
        
        if bdi==0;
           
            uicontrol('Parent',p2,'Style','text','units','normalized','Position',[.1 .8 .7 .1],...
                'String','no evidence of bipolar disorder, type I.','Fontsize',18);
        end
        
        if bdi>=1
           uicontrol('Parent',p2,'Style','text','units','normalized','Position',[.1 .8 .7 .1],...
                'String','almost surely a presence of bipolar disorder, type I.','Fontsize',18);
        end
        if bdi~=0 & bdi<1
            strbdi = 'likelihood of bipolar disorder, type I, is:';
            s1trbdi=num2str(bdi*100);
            
            
            s2trbdi=strcat(strbdi,' ', s1trbdi,'%.');
            
            uicontrol('Parent',p2,'Style','text','units','normalized','Position',[.1 .8 .7 .1],...
                'String',s2trbdi,'Fontsize',18);
        end
        if bdii==0;
            uicontrol('Parent',p2,'Style','text','units','normalized','Position',[.1 .6 .7 .1],...
                'String','no evidence of bipolar disorder, type II','Fontsize',18);
        end
        if bdii>=1
           uicontrol('Parent',p2,'Style','text','units','normalized','Position',[.1 .6 .7 .1],...
                'String','almost surely a presence of bipolar disorder, type II.','Fontsize',18);
        end
        if bdii~=0 & bdii<1
            strbdii = 'likelihood of has bipolar disorder, type II, is:';
            s1trbdii=num2str(bdii*100);
            
            
            s2trbdii=strcat(strbdii, s1trbdii,'%.');
           
            uicontrol('Parent',p2,'Style','text','units','normalized','Position',[.1 .6 .7 .1],...
                'String',s2trbdii,'Fontsize',18);
        end
        if bpd==0;
            uicontrol('Parent',p2,'Style','text','units','normalized','Position',[.1 .4 .7 .1],...
                'String','no evidence of borderline personality disorder','Fontsize',18);
        end
if bpd>=1
           uicontrol('Parent',p2,'Style','text','units','normalized','Position',[.1 .4 .7 .1],...
                'String','almost surely a presence of borderline personality disorder.','Fontsize',18);
        end
        if bpd~=0 & bpd<1
            strbpd = 'likelihood of borderline personality disorder is:';
            s1trbpd=num2str(bpd*100);
            
            
            s2trbpd=strcat(strbpd, s1trbpd,'%.');
           
            uicontrol('Parent',p2,'Style','text','units','normalized','Position',[.1 .4 .7 .1],...
                'String',s2trbpd,'Fontsize',18);
        end
        if adhdiii==0;
            uicontrol('Parent',p2,'Style','text','units','normalized','Position',[.1 .2 .7 .1],'String','no evidence of attention-deficit/hyperactivity disorder.','Fontsize',18);
        end
        if adhdiii==1;
            uicontrol('Parent',p2,'Style','text','units','normalized','Position',[.1 .2 .7 .1],'String','positive diagnosis of attention-deficit/hyperactivity disorder.','Fontsize',18);
        end
        if aspdi==0;
            uicontrol('Parent',p2,'Style','text','units','normalized','Position',[.1 .0 .7 .1],...
                'String','no evidence of antisocial personality disorder.','Fontsize',18,...
                'Callback',@adhdResult_Callback);
        end
        if aspdi==1;
            uicontrol('Parent',p2,'Style','text','units','normalized','Position',[.1 .0 .7 .1],...
                'String','positive diagnosis of antisocial personality disorder.','Fontsize',18,...
                'Callback',@adhdResult_Callback);
        end
    end
end
