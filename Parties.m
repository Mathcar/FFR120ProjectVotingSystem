function partiesList = Parties(nParties, minDistance)
%PARTIES Gives a list of parties
%
%   Inputs:
%       nParties: number of parties
%       minDistance: minimum distance between parties
%
%   Output:
%       partiesList: list of parties on the interval [0, 1]


    if (minDistance*nParties > 1)
        minDistance = 1/nParties;
    end
    
    distanceToBeDistributed = 1 - minDistance*(nParties - 1);
    
    distances = rand(nParties - 1, 1);
    distances = distanceToBeDistributed .* distances ./ sum(distances) ...
        + minDistance;
    partiesList = zeros(nParties, 1);
    
    for i = 2:nParties
        
        partiesList(i) = partiesList(i-1) + distances(i-1);
        
    end
    
end

