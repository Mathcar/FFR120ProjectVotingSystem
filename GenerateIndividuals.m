function [individuals ,interactionMat] = GenerateIndividuals(n, nCities, citySize, percentRural)

%GENERATEINDIVIDUALS Generate n individuals using GeneratePositions.m
%
%   Inputs: 
%       n: number of individuals
%       nCities: number of wanted cities
%       citySize: size of cities, recommended in [.1, 5]
%
%   Outputs:
%       individuals: [x position; y position; carisma; ...
%           opinion; interactionWeights]
%
%       x position, y position, carisma, opinion are on [0, 1]
%
%       interactionWeights: (n x 1) with probabilities of interaction
%           with all n individuals based on distance.
%           To self the probability is set to 0.

    positions = GeneratePositions(n, nCities, citySize, percentRural);
    
    opinions = rand(1, n);
    
    certaintys = rand(1, n);
    
    interactionWeightsMat = zeros(n, n);
    
    for i = 1:n
        
        distances = zeros(n, 1);
        
        for j = 1:n
            
            distances(j) = (positions(1, j) - positions(1, i))^2 + ...
                (positions(2, j) - positions(2, i))^2;
            
        end
        distances = sqrt(distances);
        
        distances(i) = inf;
        
        interactionWeights = 1./distances.^2; % 1/r^2
        
        interactionWeights = interactionWeights ./ ...
            sum(interactionWeights);
        
        interactionWeightsMat(:, i) = interactionWeights;
        
    end
    
    individuals = [positions; opinions; certaintys];
    interactionMat = interactionWeightsMat;

end

