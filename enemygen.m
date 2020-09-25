%% Enemy Generator
%% Parameters
%app.Chlng = 1;%diffuclty = chlng (0 hard coded for now)
%app.PrtyLvl = 5;%party level = PrtyLvl (5 hard coded for now)
%app.PrtySize = 4;%party size = PrtySize (4 hard coded for now)

%%
switch PrtyLvl %variable established in main file as party level setting
    case 1
        CRlimit = PrtySize* 1/4;
    case 2
        CRlimit = PrtySize* 1/2;
    case {3 4}
        CRlimit = PrtySize;
    case 5
        CRlimit = PrtySize* 2;
    case {6 7 8}
        CRlimit = PrtySize* 3;
    case {9 10}
        CRlimit = PrtySize* 4;
    case {11 12}
        CRlimit = PrtySize* 5;
    case {13 14}
        CRlimit = PrtySize* 6;
    case {15 16}
        CRlimit = PrtySize* 7;
    case {17 18}
        CRlimit = PrtySize* 8;
    case 19
        CRlimit = PrtySize* 9;
    case 20
        CRlimit = PrtySize* 10;
    otherwise
        disp('Invalid party level (1-20).')
end

switch Chlng 
    case 0 %easy
        CRlimit = CRlimit - floor(PrtyLvl * 1/4); 
    case 1 %normal
        CRlimit = CRlimit;
    case 2 %hard
        CRlimit = CRlimit + ceil(PrtyLvl * 1/4);
    case 3 %insane
        CRlimit = CRlimit + ceil(PrtyLvl * 1/2);
    case 4 %brutal
        CRlimit = CRlimit + PrtyLvl;
    otherwise
        disp('Invalid difficulty')
end
EnemyList = readmatrix('Monsters.xlsx');
EnemyCR = EnemyList(:,19);
EnemyTable = readtable('Monsters.xlsx');

Nenemy = numel(EnemyIndx); %number of enemies to generate
Enemy = cell(1,Nenemy); %initializes and preallocates enemy array
N = 0;

while N ~= Nenemy
    N = N+1;% add to N until N equal the number of enemies needed
    if CRlimit ~=0 %if the limit is below zero fill zero cr creatures
        if CRlimit > 1
            CR = randi(CRlimit); %CR of the enemy to generate caps at the current cr limit
        else
            CR = randi (1);
        end
        CRlimit = CRlimit - CR; %take CR from total
        [row,~] = find(EnemyList==CR);%finds the location of the code
        row = randsample(row,1); %grabs a random enemy from the refined cr list
        NewEnemy = table2array(EnemyTable(row,1)); %Finds the name and converts it to an array
        Enemy{N} = NewEnemy; %adds the new ink item to the end of the list
    else
        CR = 0;
        [row,~] = find(EnemyList==CR);%finds the location of the code
        row = randsample(row,1); %grabs a random enemy from the refined cr list
        NewEnemy = table2array(EnemyTable(row,1)); %Finds the name and converts it to an array
        Enemy{N} = NewEnemy;
    end
end



