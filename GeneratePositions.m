function [positions] = GeneratePositions(n, nCities, citySize)

%GENERATEPOSITIONS Generate x and y positions for n individuals
%
%   Generates individuals in a number of cities on [0,1]x[0,1]
%   
%   Inputs: 
%       n: number of individuals
%       nCities: number of wanted cities
%       citySize: size of cities, recommended in [1, 10]
%
%   Outputs: positions: (2 x n) matrix

    R = @(u) -2*log(u(1));
    theta = @(u) 2*pi*u(2);
    z = @(u) [R(u)*cos(theta(u)); R(u)*sin(theta(u))];
    
    indiviudlasPerCity = ceil(n/nCities);
    positions = zeros(2, indiviudlasPerCity*nCities);
    citySize = citySize * 1e-4;
    
    for i = 1:nCities
        
        mu = [rand; rand];
        varianceMatrix = [citySize, 0; 0, citySize];
        A = chol(varianceMatrix);
        distribution = @(u) mu + A * z(u);
        
        for j = 1:indiviudlasPerCity
            
            positions(:, (i-1)*indiviudlasPerCity + j) = distribution([rand; rand]);
            
        end
        
    end
    
    positions = positions(:, 1:n);
    
    for i = 1:2
        
        positions(i, :) = positions(i, :) - min(positions(i, :));
        positions(i, :) = positions(i, :) / max(positions(i, :));
        
    end

end

