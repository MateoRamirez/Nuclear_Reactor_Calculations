%*************************************************************************%
%                               PRESENTATION

%Xi'An Jiaotong - Liverpool University
%EEE405-NUCLEAR ENERGY TECHNOLOGY
%Module leader: Dr. Dr. Jinling ZHANG
%Department of Electrical and Electronic Engineering 
%Author: Mateo RAMÍREZ
%Master Program - Sustainable Energy Technologies
%*************************************************************************%
%*************************************************************************%
%Clean and Clear
%*************************************************************************%
clc
clear vars
%*************************************************************************%
%User Dialog Box - Constant or Calculator
%*************************************************************************%
choice = questdlg('Stored Data or New Inputs?', ...
	'Nuclear Reactor Heat Calculator', ...
	'Stored Data','New Inputs {PWR/BWR}','Cancel','Cancel');
switch choice
%*************************************************************************%
%Case Stored Data
%*************************************************************************%
    case 'Stored Data'
        disp([choice '...processing'])
%*************************************************************************%
%Constant Definition PWR
%*************************************************************************%
CPL_PWR = 953;
PPD_PWR = 97.4;
FAC_PWR = 121;
ALS_PWR = 200;
FRA_PWR = 204;
FRL_PWR = 2900;
FRD_PWR = 10;
%*************************************************************************%
%Constant Definition BWR
%*************************************************************************%
CPL_BWR = 3579;
PPD_BWR = 96;
FAC_BWR = 732;
ALS_BWR = 152;
FRA_BWR = 62;
FRL_BWR = 3760;
FRD_BWR = 12.5;
%*************************************************************************%
%Constant Definition PHWR
%*************************************************************************%
CPL_PHWR = 2140;
PPD_PHWR = 95;
FAC_PHWR = 4560;
ALS_PHWR = 280;
FRA_PHWR = 37;
FRL_PHWR = 480;
FRD_PHWR = 13.1;
%*************************************************************************%
%Fuel Assembly Area
%*************************************************************************%
FAA_PWR = ((ALS_PWR/1000)^2);
FAA_BWR = ((ALS_BWR/1000)^2);
FAA_PHWR = ((ALS_PHWR/1000)^2);
%*************************************************************************%
%Core Area
%*************************************************************************%
CA_PWR = (FAA_PWR)*(FAC_PWR);
CA_BWR = (FAA_BWR)*(FAC_BWR);
CA_PHWR = (FAA_PHWR)*(FAC_PHWR/12);
%*************************************************************************%
%Equivalent Circular Diameter
%*************************************************************************%
ECD_PWR = sqrt(CA_PWR*4/pi);
ECD_BWR = sqrt(CA_BWR*4/pi);
ECD_PHWR = sqrt(CA_PHWR*4/pi);
%*************************************************************************%
%Core Length
%*************************************************************************%
CLE_PWR = FRL_PWR/1000;
CLE_BWR = FRL_BWR/1000;
CLE_PHWR = FRL_PHWR*12/1000;
%*************************************************************************%
%Total Core Volume
%*************************************************************************%
TCV_PWR = ((FRL_PWR/1000)*(pi*(ECD_PWR^2)))/4;
TCV_BWR = ((FRL_BWR/1000)*(pi*(ECD_BWR^2)))/4;
TCV_PHWR = ((FRL_PHWR/1000)*(pi*(ECD_PHWR^2)))/4;
%*************************************************************************%
%Average Core Power Density
%*************************************************************************%
ACPD_PWR = CPL_PWR/TCV_PWR;
ACPD_BWR = CPL_BWR/TCV_BWR;
ACPD_PHWR = CPL_PHWR/(pi*((ECD_PHWR/2)^2)*(CLE_PHWR));
%*************************************************************************%
%Core-Wide Average Linear Heat-Generation Rate of a Fuel Rode
%*************************************************************************%
CWAL_PWR = ((PPD_PWR/100)*CPL_PWR*1000)/(FRA_PWR*FAC_PWR*(FRL_PWR/1000));
CWAL_BWR = ((PPD_BWR/100)*CPL_BWR*1000)/(FRA_BWR*FAC_BWR*(FRL_BWR/1000));
CWAL_PHWR = ((PPD_PHWR/100)*CPL_PHWR*1000)/(FRA_PHWR*FAC_PHWR*(FRL_PHWR/1000));
%*************************************************************************%
%Core-Wide Average Heat-Flux at the Interface Between the Rod and the 
%Coolant
%*************************************************************************%
CWAH_PWR = (CWAL_PWR/1000)/(pi*FRD_PWR/1000);
CWAH_BWR = (CWAL_BWR/1000)/(pi*FRD_BWR/1000);
CWAH_PHWR = (CWAL_PHWR/1000)/(pi*FRD_PHWR/1000);
%*************************************************************************%
%User Output
%*************************************************************************%
uiwait(msgbox({['------'];...
    ['PWR RESULTS'];...
    ['Equivalent Core Diameter m = ' num2str(ECD_PWR)];...
    ['Core Length m = ' num2str(CLE_PWR)];...
    ['Average Core Power Density MW/m^3 = ' num2str(ACPD_PWR)];...
    ['Core-Wide Average Linear Heat-Generation Rate of a Fuel Rod kW/m = ' num2str(CWAL_PWR)];...
    ['Core-Wide Average Heat Flux at the Interface Between the Rod and the Coolant MW/m^2 = ' num2str(CWAH_PWR)];...
    ['------'];...
    ['BWR RESULTS'];...
    ['Equivalent Core Diameter m = ' num2str(ECD_BWR)];...
    ['Core Length m = ' num2str(CLE_BWR)];...
    ['Average Core Power Density MW/m^3 = ' num2str(ACPD_BWR)];...
    ['Core-Wide Average Linear Heat-Generation Rate of a Fuel Rod kW/m = ' num2str(CWAL_BWR)];...
    ['Core-Wide Average Heat Flux at the Interface Between the Rod and the Coolant MW/m^2 = ' num2str(CWAH_BWR)];...
    ['------'];...
    ['PHWR RESULTS'];...
    ['Equivalent Core Diameter m = ' num2str(ECD_PHWR)];...
    ['Core Length m = ' num2str(CLE_PHWR)];...
    ['Average Core Power Density MW/m^3 = ' num2str(ACPD_PHWR)];...
    ['Core-Wide Average Linear Heat-Generation Rate of a Fuel Rod kW/m = ' num2str(CWAL_PHWR)];...
    ['Core-Wide Average Heat Flux at the Interface Between the Rod and the Coolant MW/m^2 = ' num2str(CWAH_PHWR)];...
    } ,...
    'Results Interface','modal'));
%*************************************************************************%
%Case New Inputs
%*************************************************************************%
    case 'New Inputs {PWR/BWR}'
        disp([choice ' ...processing'])
%*************************************************************************%
%Constant User Input
%*************************************************************************%        
prompt={'Core Power Level [MWt]:','% Power Deposited in Fuel Rods [%]:',...
        'Fuel Assemblies/Core :','Assembly Lateral Spacing [mm]:',...
        'Fuel Rods/Assembly:','Fuel rod lenght (mm):',...
        'Fuel rod Diamater (mm):'};
dlg_title='Power Flow Analysis'; 
num_lines = [1,50];
defaultans={'953','97.4','121','200','204','2900','10'};
answer=inputdlg(prompt,dlg_title,num_lines,defaultans);
CPL_PWR = str2num(answer{1});                                                   
PPD_PWR = str2num(answer{2});                                                  
FAC_PWR = str2num(answer{3});                                                  
ALS_PWR = str2num(answer{4});                                                   
FRA_PWR = str2num(answer{5});                                                   
FRL_PWR = str2num(answer{6});                                                   
FRD_PWR = str2num(answer{7});                                                    
%*************************************************************************%
%Fuel Assembly Area
%*************************************************************************%
FAA_PWR = ((ALS_PWR/1000)^2);
%*************************************************************************%
%Core Area
%*************************************************************************%
CA_PWR = (FAA_PWR)*(FAC_PWR);
%*************************************************************************%
%Equivalent Circular Diamater
%*************************************************************************%
ECD_PWR = sqrt(CA_PWR*4/pi);
%*************************************************************************%
%Core Length
%*************************************************************************%
CLE_PWR = FRL_PWR/1000;
%*************************************************************************%
%Total Core Volume
%*************************************************************************%
TCV_PWR = ((FRL_PWR/1000)*(pi*(ECD_PWR^2)))/4;
%*************************************************************************%
%Average Core Power Density
%*************************************************************************%
ACPD_PWR = CPL_PWR/TCV_PWR;
%*************************************************************************%
%Core-Wide Average Linear Heat-Generation Rate of a Fuel Rode
%*************************************************************************%
CWAL_PWR = ((PPD_PWR/100)*CPL_PWR*1000)/(FRA_PWR*FAC_PWR*(FRL_PWR/1000));
%*************************************************************************%
%Core-Wide Average Heat-Flux at the Interface Between the Rod and the 
%Coolant
%*************************************************************************%
CWAH_PWR = (CWAL_PWR/1000)/(pi*FRD_PWR/1000);
%*************************************************************************%
%User Output
%*************************************************************************%
uiwait(msgbox({['------'];...
    ['PWR RESULTS'];...
    ['Equivalent Core Diameter m = ' num2str(ECD_PWR)];...
    ['Core Length m = ' num2str(CLE_PWR)];...
    ['Average Core Power Density MW/m^3 = ' num2str(ACPD_PWR)];...
    ['Core-Wide Average Linear Heat-Generation Rate of a Fuel Rod kW/m = ' num2str(CWAL_PWR)];...
    ['Core-Wide Average Heat Flux at the Interface Between the Rod and the Coolant MW/m^2 = ' num2str(CWAH_PWR)];...
    } ,...
    'Results Interface','modal'));
%*************************************************************************%
%Case Cancel
%*************************************************************************%
    case 'Cancel'
        disp('See You Later Alligator')
end