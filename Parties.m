function partiesList = Parties(nParties, minDistance)
%PARTIES Gives a list of parties
%
%   Inputs:
%       nParties: number of parties
%       minDistance: minimum distance between parties
%
%   Output:
%       partiesList: list of parties on the interval [0, 1]


    if (minDistance*nParties > .95)
        minDistance = .95/nParties;
    end
    
    done = 0;
    
    while not(done)
        
        partiesList = sort(rand(nParties, 1));
        done = 1;
        
        for i = 2:nParties
            if partiesList(i) - partiesList(i-1) < minDistance
                done = 0;
            end
        end
    
    end
    
end

