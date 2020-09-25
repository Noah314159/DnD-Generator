%% Ink Generator
function [Ink] = inkgen(InkIndx)
InkList = readmatrix('Ink.xlsx');
InkCode = InkList(:,2);
InkTable = readtable('Ink.xlsx');

Nink= numel(InkIndx); %number of ink items to be generated
Ink = cell(1,Nink); %initializes the ink item array


InkNum = numel(InkCode);
N = 0;
while N ~= Nink
    N = N+1;
    Code = InkCode(randperm(InkNum,1)); %selects random ink code from list
    [row,~] = find(InkList==Code);%finds the location of the code
    NewInk = table2array(InkTable(row,1)); %Finds the name and converts it to an array
    Ink{N} = NewInk; %adds the new ink item to the end of the list
end
end  