function [ selectedIndex1, selectedIndex2 ] = Selection( weightList )
%     Selecting two induviduals with a probability depending on the
%     weights from the weightList.
%     
%   Inputs: 
%    weightList: A normalized transition matrix describing the probability
%    of induviduals interacting.
%
%   Outputs:
%    selectedIndex1: index of the first selected induvidual
%    selectedIndex2: index of the second selected induvidual

    selectedIndex1 = irand(size(weightList,2));
    
    rN = rand;
    selectedIndex2 = 1;
    tresshold = weightList(selectedIndex1, selectedIndex2);
    
    while rN > tresshold
        selectedIndex2 = selectedIndex2 + 1;
        tresshold = tresshold + weightList(selectedIndex1, selectedIndex2);
    end
    
end