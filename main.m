%-------------------FFR120, Voting system, Main--------------------------%
n = 1e3; 
nCities =10; 
citySize = 1; 
proportionAffected = 0.01;
time = 0; 
nTimeSteps = 1e3;  

[individuals] = GenerateIndividuals(n, nCities, citySize);

PlotIndividualsSimple(individuals);


while( time < nTimeSteps)
    
    time = time + 1;
    
    [ selectedIndex1, selectedIndex2 ] = Selection(individuals);
    individual1 = individuals(selectedIndex1,:);
    individual2 =  individuals(selectedIndex2,:);
    
    [ newOpinion1, newOpinion2 ] = OpinionTransfer( individual1, individual2 );
    individuals(selectedIndex1,4)= newOpinion1;
    individuals(selectedIndex2,4)= newOpinion2;
    
    individuals = Media(individuals, proportionAffected);
    
end