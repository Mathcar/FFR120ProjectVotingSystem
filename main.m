%-------------------FFR120, Voting system, Main--------------------------%
% Individuals
percentRural = 4;
n = 1e3; 
nCities = 4; 
citySize = .005;
% Timesteps
nTimeSteps = 1e6;  
plotInterval = 100;
% OpinionTransfer
transferEffect = .1;
% Parties
nParties = 5;
minDistance = .1;
% Media
proportionAffected = 0.01;
mediaEffectScalar = .2;


partiesList = Parties(nParties, minDistance);
[individuals, interactionMatrix] = GenerateIndividuals(n, nCities, citySize, percentRural);

[figHandle, plotHandle] = InitPlot(individuals, partiesList);

time = 0;

while( time < nTimeSteps)
    
    time = time + 1;
    
    [ selectedIndex1, selectedIndex2 ] = Selection(interactionMatrix);
    individual1 = individuals(:,selectedIndex1);
    individual2 =  individuals(:,selectedIndex2);
    
    [ newOpinion1, newOpinion2 ] = OpinionTransfer( individual1, individual2, transferEffect );
    individuals(4,selectedIndex1)= newOpinion1;
    individuals(4,selectedIndex2)= newOpinion2;
    
    individuals = Media(individuals, proportionAffected, mediaEffectScalar);
    
    if( mod(time, plotInterval) == 0)
        UpdatePlot(individuals, partiesList, figHandle, plotHandle)
    end
end

