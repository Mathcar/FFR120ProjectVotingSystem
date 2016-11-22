%-------------------FFR120, Voting system, Main--------------------------%
n = 1e3; 
nCities = 10; 
citySize = 5; 
proportionAffected = 0.01;
nTimeSteps = 1e6;  
time = 0;
plotInterval = 1000;
transferEffect = .1;
nParties = 5;
minDistance = .1;
mediaEffectScalar = .2;

partiesList = Parties(nParties, minDistance);
[individuals, interactionMatrix] = GenerateIndividuals(n, nCities, citySize);

[figHandle, plotHandle] = InitPlot(individuals, partiesList);

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

