%-------------------FFR120, Voting system, Main--------------------------%
% Individuals
percentRural = 20;
n = 1e3; 
nCities = 5; 
citySize = .5;
% Timesteps
nTimeSteps = 2e5;  
plotInterval = 1000;
% OpinionTransfer
transferEffect = .05;
ruralInteraction = .05;
confidenceThreshold = .1;
interactionThreshold = 0.3;
% Parties
nParties = 4;
minDistance = .0005;
% Media
proportionAffected = .001;
mediaEffectScalar = 0.001;


nRural = floor(percentRural/100 * n);
partiesList = Parties(nParties, minDistance);
[individuals, interactionMatrix] = GenerateIndividuals(n, nCities, citySize, percentRural);

[figHandle, plotHandle] = InitPlot(individuals, partiesList, nTimeSteps);

time = 0;

while( time < nTimeSteps)
    
    time = time + 1;
    
    [ selectedIndex1, selectedIndex2 ] = Selection(interactionMatrix, ...
        nRural, ruralInteraction);
    % discards the selection if the difference in opinion is to large
    while(abs(individuals(3,selectedIndex1)-individuals(3,selectedIndex2)) > interactionThreshold)
        [ selectedIndex1, selectedIndex2 ] = Selection(interactionMatrix, nRural, ruralInteraction);
    end
    individual1 = individuals(:,selectedIndex1);
    individual2 =  individuals(:,selectedIndex2);
    
    [ newOpinion1, newOpinion2, newCertainty1, newCertainty2 ] =  ...
        OpinionTransfer2( individual1, individual2, transferEffect, confidenceThreshold );
    individuals(3,selectedIndex1)= newOpinion1;
    individuals(3,selectedIndex2)= newOpinion2;
    individuals(4,selectedIndex1)= newCertainty1;
    individuals(4,selectedIndex2)= newCertainty2;
    
    individuals = Media(individuals, proportionAffected, mediaEffectScalar);
    
    if( mod(time, plotInterval) == 0)
        UpdatePlot(individuals, partiesList, figHandle, plotHandle, time)
    end
end

