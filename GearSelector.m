%initialize the struct for the two reductions
stage1 = struct('reduction',0,'module',0,'p1Teeth',0,'g1Teeth',0,'p1D',0,'g1D',0,'p1OD',0,'g1OD',0);
stage2 = struct('reduction2',0,'module2',0,'p2Teeth',0,'g2Teeth',0,'p2D',0,'g2D',0,'p2OD',0,'g2OD',0);

Output = zeros(100:17);         %matrix with which the gears will populate

n = 1;

for sheet = 1:5     %all pages
    
    display(sheet);     %show current sheet and read it in
    Stage1In = xlsread('C:\Users\stuart\Documents\School\MECH 360\Gearbox Design Project\UpdatedGearDesign.xlsx',sheet,'A23:S44');
    
     n = n + 1;
    Output(n,1) = sheet;
    
    %first stage gear teeth 
    col = 2;

    i = n + 1;
    
    for p1Teeth = 10:18
        g1Teeth = Stage1In( 1, col + 1);
     
        for row = 2:22
            
            %conditions to determine gears
            %   1.pinion Shaft Size    2. large gear min size    3.MS
            if(Stage1In(row,col) > 10 && Stage1In(row,col+1) > 90 && Stage1In(row,col+1) < 150)
                
                n = n + 1; 
                
                stage1.reduction = g1Teeth / p1Teeth;
                stage1.module = Stage1In(row,1);
                stage1.p1Teeth = p1Teeth;
                stage1.g1Teeth = g1Teeth;
                stage1.p1D = Stage1In(row,col);
                stage1.g1D = Stage1In(row,col+1);
                stage1.p1OD = (p1Teeth + 2) * stage1.module;
                stage1.g1OD = (g1Teeth + 2) * stage1.module;
                
                Output(n,1) = stage1.reduction;
                Output(n,2) = stage1.module;
                Output(n,3) = stage1.p1Teeth;
                Output(n,4) = stage1.g1Teeth;
                Output(n,5) = stage1.p1D;
                Output(n,6) = stage1.g1D;
                Output(n,7) = stage1.p1OD; 
                Output(n,8) = stage1.g1OD;
                
                %disp(stage1);
                
            end
            %display(col);
        end
        col = col + 2;      %moves over to the next gear
    end
    
    Stage2In = xlsread('C:\Users\stuart\Documents\School\MECH 360\Gearbox Design Project\UpdatedGearDesign.xlsx',sheet,'A47:S68');
    %secondstage
    
    %Second stage gear teeth 
    col = 2;
    
    for p2Teeth = 15:23 
        g2Teeth = Stage2In( 1, col + 1);
        for row = 2:22
            %conditions to determine gears
            %   1.pinion Shaft Size    2. large gear min size    3.Max size
            if(Stage2In(row,col) > 10 && Stage2In(row,col+1) > 90 && Stage2In(row,col+1) < 150)
                
                %gear = stage2;     Potentially uneeded variable
                
                stage2.reduction2 = g2Teeth / p2Teeth;
                stage2.module2 = Stage2In(row,1);
                stage2.p2Teeth = p2Teeth;
                stage2.g2Teeth = g2Teeth;
                stage2.p2D = Stage2In(row,col);
                stage2.g2D = Stage2In(row,col+1);
                stage2.p2OD = (p2Teeth + 2) * stage2.module2;
                stage2.g2OD = (g2Teeth + 2) * stage2.module2;
                
                Output(i,10) = stage2.reduction2;
                Output(i,11) = stage2.module2;
                Output(i,12) = stage2.p2Teeth;
                Output(i,13) = stage2.g2Teeth;
                Output(i,14) = stage2.p2D;
                Output(i,15) = stage2.g2D;
                Output(i,16) = stage2.p2OD; 
                Output(i,17) = stage2.g2OD;
                
                %disp(stage2);
                i = i + 1;
            end
            %display(col);
        end
        if(i > n)
            n = i;
        end
        col = col + 2;      %moves over to the next gear
    end
    n = n + 1;
end

xlswrite('C:\Users\stuart\Documents\School\MECH 360\Gearbox Design Project\GearSelector.xlsx',Output);

%xlswrite('C:\Users\stuart\Documents\School\MECH 360\Gearbox Design Project\GearSelector.xlsx','Primary Reduction','A1:A1');
