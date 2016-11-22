function [ selectedIndex1, selectedIndex2 ] = Selection( weightList, nRural, ruralInteraction )
%     Selecting two induviduals with a probability depending on the
%     weights from the weightList.
%     
%   Inputs: 
%    individuals: All individuals
%    nRural: number of rural individualss
%
%   Outputs:
%    selectedIndex1: index of the first selected induvidual
%    selectedIndex2: index of the second selected induvidual

%     weightList = individuals(5:end, :);

    n = size(weightList, 2);
    
    if rand < ruralInteraction * nRural/n
    
        selectedIndex1 = randi(nRural);
        
    else
        
        selectedIndex1 = randi(n - nRural) + nRural;
        
    end
    
    rN = rand;
    selectedIndex2 = 1;
    threshold = weightList(selectedIndex2, selectedIndex1);
    
    while rN > threshold
        selectedIndex2 = selectedIndex2 + 1;
        threshold = threshold + weightList(selectedIndex2, selectedIndex1);
    end
    
end