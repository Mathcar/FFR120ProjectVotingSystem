function [ newOpinion1, newOpinion2, newCertainty1, newCertainty2 ] = OpinionTransfer( individual1, individual2, transferEffect)
    
    opinion1 = individual1(4);
    opinion2 = individual2(4);
    
    certainty1 = individual1(3);
    certainty2 = individual2(3);
    
    % I chose the number 0.1 as a guesstimation.
    % We might need to tweek this number.
    newCertainty1 = certainty1 + 0.1 - abs(opinion1-opinion2);
    newCertainty2 = certainty2 + 0.1 - abs(opinion1-opinion2);
    
    if newCertainty1 > 1
        newCertainty1 = 1;
    elseif newCertainty1 < 0
        newCertainty1 = 0;
    end
    
     if newCertainty2 > 1
        newCertainty2 = 1;
    elseif newCertainty2 < 0
        newCertainty2 = 0;
    end
    
    newOpinion1 = opinion1 + transferEffect*(certainty2/(certainty2 + certainty1+eps))*(opinion2-opinion1);
    newOpinion2 = opinion2 + transferEffect*(certainty1/(certainty2 + certainty1 + eps))*(opinion1-opinion2);
    
end % Tänker att kanske opinion ändras för mycket här? att vi borde ha en 
    % faktor ~.2 framför andra termen i newOpinion. Just nu möts de på
    % mitten

