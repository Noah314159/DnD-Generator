%% object generator
function [Objects] = objgen(ObjIndx)
%% pulls data from tables
SolidObjList = readmatrix('SolidObj.xlsx');%imports item code list
SolidObjCode = SolidObjList(:,2);%pulls code list
SolidObjTable = readtable('SolidObj.xlsx'); %imports spreadsheet as table

HzrdObjList = readmatrix('HazardObj.xlsx');
HzrdObjCode = HzrdObjList(:,2);
HzrdObjTable = readtable('HazardObj.xlsx');

ObstObjList = readmatrix('ObstacleObj.xlsx');
ObstObjCode = ObstObjList(:,2);
ObstObjTable = readtable('ObstacleObj.xlsx');
%%
Nobj=numel(ObjIndx); %number of objects to be generated
Objects = cell(1,Nobj); %initializes the Object array
N = 0;

SolidObjNum = numel(SolidObjCode); %number of solid objects
HzrdObjNum = numel(HzrdObjCode); %number of hazard objects
ObstObjNum = numel(ObstObjCode); %number of obstacle objects
while N ~= Nobj
    N = N+1;%ticks down the object count
    RndmObjType = randi(10);%random number 1-10
    switch RndmObjType
        case {1 2 3}%1-3 %solid Objects 3/10 chances
    Code = SolidObjCode(randperm(SolidObjNum,1)); %selects random object code from list
    [row,~] = find(SolidObjList==Code);%finds the location of the code
    NewObject = table2array(SolidObjTable(row,1)); %Finds the name and converts it to an array
    Objects{N} = NewObject; %adds the new object to the end of the list
        case {4 5} %Hazards 2/10 chances
    Code = HzrdObjCode(randperm(HzrdObjNum,1));
    [row,~] = find(HzrdObjList==Code);
    NewObject = table2array(HzrdObjTable(row,1)); 
    Objects{N} = NewObject;
        otherwise %Obstacles 5/10 chances
    Code = ObstObjCode(randperm(ObstObjNum,1));
    [row,~] = find(ObstObjList==Code);
    NewObject = table2array(ObstObjTable(row,1)); 
    Objects{N} = NewObject;
    end
end
end


