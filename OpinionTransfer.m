function [ newOpinion1, newOpinion2 ] = OpinionTransfer( individual1, individual2 )
    
    opinion1 = individual1(4);
    opinion2 = individual2(4);
    
    charisma1 = individual1(3);
    charisma2 = individual2(3);
    
    newOpinion1 = opinion1 + (charisma2/(charisma2 + charisma1))*(opinion2-opinion1);
    newOpinion2 = opinion2 + (charisma1/(charisma2 + charisma1))*(opinion1-opinion2);
    
end % Tänker att kanske opinion ändras för mycket här? att vi borde ha en 
    % faktor ~.2 framför andra termen i newOpinion. Just nu möts de på
    % mitten

