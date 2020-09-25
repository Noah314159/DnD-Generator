%% Pickup Generator
%% 
function [Pickups] = pickgen (PickIndx)
PickupList = readmatrix('Pickups.xlsx');
PickupCode = PickupList(:,2);
PickupTable = readtable('Pickups.xlsx');

Npick=numel(PickIndx); %number of pickups to be generated
Pickups = cell(1,Npick); %initializes the pickup array

PickupsNum = numel(PickupCode);
N = 0;
while N ~= Npick
    N = N+1;
    Code = PickupCode(randperm(PickupsNum,1)); %selects random pickup code from list
    [row,~] = find(PickupList==Code);%finds the location of the code
    NewPickup = table2array(PickupTable(row,1)); %Finds the name and converts it to an array
    Pickups{N} = NewPickup; %adds the new pickup to the end of the list
end
end