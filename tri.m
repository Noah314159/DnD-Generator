L = randi([4,10], 1, 1);
totCups = zeros(1,L);
for i=1:L
    j = 1; %loop variable initialized
    while j == 1
        totCups(i) = totCups(i) + factorial(i);
        %update the loop variable
        j = j+i;
    end
end
