function [ selectedIndex1, selectedIndex2 ] = Selection( individuals )
%     Selecting two induviduals with a probability depending on the
%     weights from the weightList.
%     
%   Inputs: 
%    individuals: All individuals
%
%   Outputs:
%    selectedIndex1: index of the first selected induvidual
%    selectedIndex2: index of the second selected induvidual

    weightList = individuals(5:end, :);

    selectedIndex1 = randi(size(weightList, 2));
    
    rN = rand;
    selectedIndex2 = 1;
    threshold = weightList(selectedIndex1, selectedIndex2);
    
    while rN > threshold
        selectedIndex2 = selectedIndex2 + 1;
        threshold = threshold + weightList(selectedIndex1, selectedIndex2);
    end
    
end