%initialize the struct for the two reductions
stage1 = struct('reduction',0,'module',0,'p1Teeth',0,'g1Teeth',0,'p1D',0,'g1D',0,'p1OD',0,'g1OD',0);
stage2 = struct('reduction2',0,'module2',0,'p2Teeth',0,'g2Teeth',0,'p2D',0,'g2D',0,'p2OD',0,'g2OD',0);

Ouput = zeros(100:100);         %spreadsheet with witch the gears will populate

for sheet = 1:5     %all pages
    
    display(sheet);     %show current sheet and read it in
    Stage1In = xlsread('C:\Users\stuart\Documents\School\MECH 360\Gearbox Design Project\UpdatedGearDesign.xlsx',sheet,'A23:S44');
    
    %first stage gear teeth 
    col = 1;
    for p1Teeth = 10:18
        g1Teeth = Stage1In( 1, col + 2);
        
        for row = 2:20
            %conditional statements to determine gears
            %   1.small Shaft Size          2. large gear min size    3.MS
            if( Stage1In(row,col+1) > 10 && Stage1In(row,col+2) > 90 && Stage1In(row,col+2) < 145)
                
        end
        col = col + 3;      %moves over to the next gear
    end
    
    Stage2In = xlsread('C:\Users\stuart\Documents\School\MECH 360\Gearbox Design Project\UpdatedGearDesign.xlsx',sheet,'A47:S68');
    %secondstage 
    for p2Teeth = 15:23  
        gear = gears;
        row = 1;            %rows use number
        col = 2;
    end
end


%A = xlsread('C:\Users\stuart\Documents\School\MECH 360\Gearbox Design Project\UpdatedGearDesign.xlsx',sheet,'A23:S68')