%initialize the struct for the two reductions
stage1Gear = struct('reduction',0,'module',0,'p1Teeth',0,'g1Teeth',0,'p1D',0,'g1D',0,'p1OD',0,'g1OD',0,'reduction2',0,'module2',0,'p2Teeth',0,'g2Teeth',0,'p2D',0,'g2D',0,'p2OD',0,'g2OD',0);
stage2Gear = struct('reduction',0,'module',0,'p1Teeth',0,'g1Teeth',0,'p1D',0,'g1D',0,'p1OD',0,'g1OD',0,'reduction2',0,'module2',0,'p2Teeth',0,'g2Teeth',0,'p2D',0,'g2D',0,'p2OD',0,'g2OD',0);

Ouput = zeros(100:100);

for sheet = 1:5     %all pages
    
    display(sheet);     %show current sheet and read it in
    Stage1In = xlsread('C:\Users\stuart\Documents\School\MECH 360\Gearbox Design Project\UpdatedGearDesign.xlsx',sheet,'A23:S44');
    
    %first stage gear teeth 
    for p1Teeth = 10:18         % first reduction gear
        
        for row = 2:20
            gear = gears;
    end
    
    Stage2In = xlsread('C:\Users\stuart\Documents\School\MECH 360\Gearbox Design Project\UpdatedGearDesign.xlsx',sheet,'A47:S68');
    %secondstage 
    for p2Teeth = 15:23         % first reduction gear
        gear = gears;
        row = 1;            %rows use number
        col = 2;
    end
end


%A = xlsread('C:\Users\stuart\Documents\School\MECH 360\Gearbox Design Project\UpdatedGearDesign.xlsx',sheet,'A23:S68')