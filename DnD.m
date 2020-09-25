%% room generation
rmwide = randi([1,20]);%room width
rmtall = randi([1,20]);%room height
room = randi(100,rmtall,rmwide);%makes room matrix

%% Global Settings

%room type
roomType = app.roomType;
roomType = str2double(roomType);
SpecRoom = randi(100); %randomly determines type of special room

%sanity setting
Sanity = 0;%Input('Enter sanity: '); %(0-min, 5-max)

%celestial ink


switch roomType
    %% Normal Room
    case 0 %
        %diffuclty setting
        
        Chlng = app.Chlng; %input('Enter difficulty: '); %(0-easy, 1-medium, 2-hard, 3-brutal, 4-insane)
        Chlng = str2double(Chlng);
        
        PrtyLvl = app.PrtyLvl;%input('Enter party level: ');
        PrtySize = app.PrtySize;%input('Enter number of party memebrs: ');
        
        %tile type variables
        %(0=null(25%), 1=objects(50%), 2=enemies(15%), 3=Ink(5%), 4=Pickups(5%))
        
        ObjIndx = find(room<=50);
        NullIndx = find(room<=75 & room>=51);
        EnemyIndx = find(room<=90 & room>=76);
        InkIndx = find(room<=95 & room>=91);
        PickIndx = find(room<=100 & room>=96);
        
        room(NullIndx)=0; %no code required
        room(ObjIndx)=1; %object generator (Done)
        room(EnemyIndx)=2; %enemy generator
        room(InkIndx)=3; %Ink generator
        room(PickIndx)=4; %pickup generator
        
        %runs the generator functions
        run enemygen.m
        Objects = objgen(ObjIndx);
        Ink = inkgen(InkIndx);
        Pickups = pickgen(PickIndx);
        
        Null = {'null'}; %creates null cell for reference
        % Indexes item cells into proper room sqaure
        room = num2cell(room);
        room(NullIndx) = Null;
        room(ObjIndx) = Objects;
        room(PickIndx) = Pickups;
        room(InkIndx) = Ink;
        room(EnemyIndx) = Enemy;
        room = cell2table(room);
        room = table2cell(room);
        
    case 1 % Special Rooms
        %% Probability settings
        lrN = 40; %percent chance for lava room
        lrBound = 100-lrN;
        
        wrN = 10; %percent chance for water room
        wrBound = lrBound-wrN;
        
        hsN = 10; %percent chance for healing room
        hsBound = wrBound - hsN;
        
        irN = 10; %percent chance for item room
        irBound = hsBound - irN;
        
        vrN = 10; %percent chance for void room
        vrBound = irBound - vrN;
        
        cirN = 10; %percent chance for celestial ink room
        cirBound = vrBound - cirN;
        %extra perecents if they exist will result in an empty room if landed on
        
        %% Special Rooom Type
        if (SpecRoom <= 100) && (SpecRoom > lrBound) %lava only room (0-50)
            lavaN = 50;%if less than 100 will generate some null tiles
            %(difference between N and 100 equals percent chance for null)
            Lava = {'lava'};
            Null = {'null'};
            LavaIndx = find(room <= lavaN);
            NullIndx = find(room > lavaN);
            room = num2cell(room);
            room(LavaIndx) = Lava;
            room(NullIndx) = Null;
            
        elseif (SpecRoom <= lrBound) && (SpecRoom > wrBound) %water room (filled or just floor)
            WaterN = 50;%if less than 100 will generate some null tiles
            %(difference between N and 100 equals percent chance for null)
            Water = {'water'};
            Null = {'null'};
            WaterIndx = find(room <= WaterN);
            NullIndx = find(room > WaterN);
            room = num2cell(room);
            room(WaterIndx) = Water;
            room(NullIndx) = Null;
        elseif (SpecRoom <= wrBound) && (SpecRoom > hsBound) %healing shrine
            Test = ('healing');
        elseif (SpecRoom <= hsBound) && (SpecRoom > irBound) %item room (mega rare one with only treasure)
            Test = ('item');
        elseif (SpecRoom <= irBound) && (SpecRoom > vrBound) %void room
            Test = ('void');
        elseif (SpecRoom <= vrBound) && (SpecRoom > cirBound) %celestial ink room (VERY rare)
            Test = ('ink');
        else %empty room
            Test = ('empty');
            
        end
        
        
        
        
    otherwise
end

