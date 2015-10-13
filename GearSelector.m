%initialize the struct for the two reductions
stage1 = struct('reduction',0,'module',0,'p1Teeth',0,'g1Teeth',0,'p1D',0,'g1D',0,'p1OD',0,'g1OD',0);
stage2 = struct('reduction2',0,'module2',0,'p2Teeth',0,'g2Teeth',0,'p2D',0,'g2D',0,'p2OD',0,'g2OD',0);

Ouput = zeros(100:100);         %spreadsheet with which the gears will populate

for sheet = 1:5     %all pages
    
    display(sheet);     %show current sheet and read it in
    Stage1In = xlsread('C:\Users\stuart\Documents\School\MECH 360\Gearbox Design Project\UpdatedGearDesign.xlsx',sheet,'A23:S44');
    
    
    
    %first stage gear teeth 
    col = 2;
    for p1Teeth = 10:18
        g1Teeth = Stage1In( 1, col + 1);
     
        for row = 2:22
            
            %conditions to determine gears
            %   1.pinion Shaft Size    2. large gear min size    3.MS
            if(Stage1In(row,col) > 10 && Stage1In(row,col+1) > 90 && Stage1In(row,col+1) < 150)
                
                %gear = stage1;     potentially uneeded variable
                
                stage1.reduction = g1Teeth / p1Teeth;
                stage1.module = Stage1In(row,1);
                stage1.p1Teeth = p1Teeth;
                stage1.g1Teeth = g1Teeth;
                stage1.p1D = Stage1In(row,col);
                stage1.g1D = Stage1In(row,col+1);
                stage1.p1OD = (p1Teeth + 2) * stage1.module;
                stage1.g1OD = (g1Teeth + 2) * stage1.module;
                
                %disp(module);
                %disp(p1Teeth);
                %disp(g1Teeth);
                %disp(p1D);
                %disp(g1D);
                %disp(p1OD);
                %disp(g1OD);
                %disp(reduction);
                
                disp(stage1);
                
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
                
                %disp(module);
                %disp(p1Teeth);
                %disp(g1Teeth);
                %disp(p1D);
                %disp(g1D);
                %disp(p1OD);
                %disp(g1OD);
                %disp(reduction);
                
                disp(stage2);
                
            end
            %display(col);
        end
        col = col + 2;      %moves over to the next gear
    end
end


%A = xlsread('C:\Users\stuart\Documents\School\MECH 360\Gearbox Design Project\UpdatedGearDesign.xlsx',sheet,'A23:S68')