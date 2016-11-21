%-------------------FFR120, Voting system, Main--------------------------%
n = 1e3; 
nCities =10; 
citySize = 5; 
proportionAffected = 0.01;
nTimeSteps = 1e3;  
time = 0; 

[individuals] = GenerateIndividuals(n, nCities, citySize);

PlotIndividualsSimple(individuals);

while( time < nTimeSteps)
    
    time = time + 1;
    
    [ selectedIndex1, selectedIndex2 ] = Selection(individuals);
    individual1 = individuals(:,selectedIndex1);
    individual2 =  individuals(:,selectedIndex2);
    
    [ newOpinion1, newOpinion2 ] = OpinionTransfer( individual1, individual2 );
    individuals(4,selectedIndex1)= newOpinion1;
    individuals(4,selectedIndex2)= newOpinion2;
    
    individuals = Media(individuals, proportionAffected);
    
end

