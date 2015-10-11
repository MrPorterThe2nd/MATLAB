MyDirInfo = dir('C:\Users\stuart\Documents\MATLAB\activities');  % creates a string with all the names of the files in that folder
%set table columns here
ride = 1:10;                 % length(MyDirInfo);
dist = ride;
cumdist = ride;
ridetime = ride;
avspeed = ride;
steepDecline = ride;        % -15% and beyond
moderateDecline = ride;     % -10% to -15%
decline = ride;             % -6% to -10%
slightDecline = ride;       % -2% to -6%
flat = ride;                % -2% to 2%
slightIncline = ride;       % 2% to 6%
incline = ride;             % 6% to 10%
moderateIncline = ride;     % 10% to 15%
steepIncline = ride;        % -15% and beyond

n = 1;       %set counter 
while n < 11 %length(MyDirInfo)
    trk = gpxread(MyDirInfo(n+2).name,'FeatureType','Track');
    
    %distance rode make function
    e = wgs84Ellipsoid;
    lat = trk.Latitude;
    lon = trk.Longitude;
    d = distance(lat(1:end-1), lon(1:end-1), lat(2:end), lon(2:end), e);
    d = d * unitsratio('km', 'meter');
    dist(n) = sum(d);
    
    %time ridden make function
    timeStr = strrep(trk.Time, 'T', ' ');
    timeStr = strrep(timeStr, '.000Z', '');
    trk.DateNumber = datenum(timeStr,'yyyy-mm-dd HH:MM:SS');
    day = fix(trk.DateNumber(1));
    trk.TimeOfDay = trk.DateNumber - day;
    trk.ElapsedTime = trk.TimeOfDay - trk.TimeOfDay(1);
    ridetime(n) = sum(trk.ElapsedTime);
    
    %avg speed
    avsp = sum(d)/sum(trk.ElapsedTime)*60;
    avspeed(n) = avsp;
    
    % find the percentage of time spent at a certain incline/decline
    
    % initialize counters
    
    cumdist = cumsum(d);    % vector showing total distance travel at that gps point
    ele = trk.Elevation;
    
    sD = 0;
    mD = 0;
    d = 0;
    slD = 0;
    fl = 0;
    slI = 0;
    i = 0;
    mI = 0;
    sI = 0;
    counter = 0;        
    
    z = 2;
    while z < length(cumdist)
        
        ph = cumdist(z-1);
        initEle = trk.Elevation(z);
        
        while ((cumdist(z) - ph) < 0.05 && z < length(cumdist))        % loop till gps recorded 50m
            z = z + 1;
            run = cumdist(z) - ph;
        end
        
        counter = counter + 1;          %increment total number of 50m segments counted
        
        %display(trk.Elevation(z) - initEle);
        
        slope = (trk.Elevation(z) - initEle)/run/1000*100;   % units corrected
        
        %display(slope);
        
        if (slope < 0)
            if slope > -2
                fl = fl + 1;
            elseif slope > -6
                slD = slD + 1;
            elseif slope > -10;
                d = d + 1;
            elseif slope > -15;
                mD = mD + 1;
            else
                sD = sD + 1;
            end
        else
            if slope < 2;
                fl = fl + 1;
            elseif slope < 6
                slI = slI + 1;
            elseif slope < 10
                i = i + 1;
            elseif slope < 15
                mI = mI + 1;
            else
                sI = sI + 1;
            end
        end 
        z = z + 1;
    end
    
    steepDecline(n) = sD/counter;
    moderateDecline(n) = mD/counter;
    decline(n) = d/counter;             % -6% to -10%
    slightDecline(n) = slD/counter;       % -2% to -6%
    flat(n) = fl/counter;                % -2% to 2%
    slightIncline(n) = slI/counter;       % 2% to 6%
    incline(n) = i/counter;             % 6% to 10%
    moderateIncline(n) = mI/counter;     % 10% to 15%
    steepIncline(n) = sI/counter;        % -15% and beyond
    
    
    
    n = n + 1;
end

T = [ride;dist;ridetime;avspeed;steepDecline;moderateDecline;decline;slightDecline;flat;slightIncline;incline;moderateIncline;steepIncline];
      %1   %2     %3      %4        %5               %6         %7       %8
      
solution = T';
