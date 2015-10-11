MyDirInfo = dir('C:\Users\stuart\Documents\MATLAB\activities');  % creates a string with all the names of the files in that folder
%set table columns here
ride = 1:50;                 % length(MyDirInfo);
dist = ride;
cumdist = ride;
ridetime = ride;
avspeed = ride;

% list of vectors that will show %time spent in each zone
steepDecline = ride;        % -15% and beyond
moderateDecline = ride;     % -10% to -15%
decline = ride;             % -6% to -10%
slightDecline = ride;       % -2% to -6%
flat = ride;                % -2% to 2%
slightIncline = ride;       % 2% to 6%
incline = ride;             % 6% to 10%
moderateIncline = ride;     % 10% to 15%
steepIncline = ride;        % -15% and beyond

% List of vectors that will determine avgspeed in each zone
steepDSpeed = ride;        % -15% and beyond
moderateDSpeed = ride;     % -10% to -15%
declineSpeed = ride;       % -6% to -10%
slightDSpeed = ride;       % -2% to -6%
flatSpeed = ride;          % -2% to 2%
slightISpeed = ride;       % 2% to 6%
inclineSpeed = ride;       % 6% to 10%
moderateISpeed = ride;     % 10% to 15%
steepISpeed = ride;        % -15% and beyond

n = 1;       %set counter for number of files to read 
while n < 51 %length(MyDirInfo)
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
    eti = trk.ElapsedTime;
    
    %Slope Counters
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
    
    %avg Velocity counters
    sDS = 0;
    mDS = 0;
    dS = 0;
    slDS = 0;
    flS = 0;
    slIS = 0;
    iS = 0;
    mIS = 0;
    sIS = 0;
    
    z = 2;      %set to 2 to stay in range
    while z < length(cumdist)
        
        ph = cumdist(z-1);
        initEle = trk.Elevation(z);     % Initial Segment Elevation 
        initRideTime = trk.ElapsedTime(z);     % Initial Segment Time
        
        while ((cumdist(z) - ph) < 0.05 && z < length(cumdist))        % loop till gps recorded 50m
            z = z + 1;
            run = cumdist(z) - ph;
            segtime = trk.ElapsedTime(z) - initRideTime;
        end
        
        segvel = run/segtime*1000/86400;        %velocity of segment with units corrected
        
        %display(segvel);
        
        counter = counter + 1;          %increment total number of 50m segments counted
        
        %display(trk.Elevation(z) - initEle);
        
        slope = (trk.Elevation(z) - initEle)/run/1000*100;   % units corrected
        
        %display(slope);
        
        if (slope < 0)
            if slope > -2
                fl = fl + 1;
                flS = flS + segvel;
            elseif slope > -6
                slD = slD + 1;
                slDS = slDS + segvel;
            elseif slope > -10;
                d = d + 1;
                dS = dS + segvel;
            elseif slope > -15;
                mD = mD + 1;
                mDS = mDS + segvel;
            else
                sD = sD + 1;
                sDS = sDS + segvel;
            end
        else
            if slope < 2;
                fl = fl + 1;
                flS = flS + segvel;
            elseif slope < 6
                slI = slI + 1;
                slIS = slIS + segvel;
            elseif slope < 10
                i = i + 1;
                iS = iS + segvel;
            elseif slope < 15
                mI = mI + 1;
                mIS = mIS + segvel;
            else
                sI = sI + 1;
                sIS = sIS + segvel;
            end
        end  
        z = z + 1;
    end
    
    steepDecline(n) = sD/counter;
    moderateDecline(n) = mD/counter;
    decline(n) = d/counter;                 % -6% to -10%
    slightDecline(n) = slD/counter;         % -2% to -6%
    flat(n) = fl/counter;                   % -2% to 2%
    slightIncline(n) = slI/counter;         % 2% to 6%
    incline(n) = i/counter;                 % 6% to 10%
    moderateIncline(n) = mI/counter;        % 10% to 15%
    steepIncline(n) = sI/counter;           % -15% and beyond
    
    steepDSpeed(n) = sDS/(sD+1);                % -15% and beyond
    moderateDSpeed(n) = mDS/(mD+1);             % -10% to -15%
    declineSpeed(n) = dS/(d+1);                 % -6% to -10%
    slightDSpeed(n) = slDS/(slD+1);             % -2% to -6%
    flatSpeed(n) = flS/(fl+1);                  % -2% to 2%
    slightISpeed(n) = slIS/(slI+1);             % 2% to 6%
    inclineSpeed(n) = iS/(i+1);                 % 6% to 10%
    moderateISpeed(n) = mIS/(mI+1);             % 10% to 15%
    steepISpeed(n) = sIS/(sI+1);                % -15% and beyond
    
    
    
    n = n + 1;
end

T = [ride;dist;ridetime;avspeed;steepDecline;moderateDecline;decline;slightDecline;
    flat;slightIncline;incline;moderateIncline;steepIncline;steepDSpeed;
    moderateDSpeed;declineSpeed;slightDSpeed;flatSpeed;slightISpeed;inclineSpeed;
    moderateISpeed;steepISpeed];
      %1   %2     %3      %4        %5               %6         %7       %8
      
solution = T';