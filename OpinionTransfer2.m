function [ newOpinion1, newOpinion2, newCertainty1, newCertainty2 ] = ... 
    OpinionTransfer2( individual1, individual2, transferEffect, threshold)
% OPINIONTRANSFER Transfer opinion between two individuals
%
%   Inputs:
%       individuals1, 2: Individuals subject to transfer
%       transferEffect:     (between 0 and 1)
%       threshold: Constant added every time step
%
%   Outputs:
%       newOpinion1, 2: The new opinions of individual 1 and 2
%       newCertainty1, 2: The new certainties of intidivuals 1 and 2

    opinion1 = individual1(3);
    opinion2 = individual2(3);
    
    certainty1 = individual1(4);
    certainty2 = individual2(4);
    

    newCertainty1 = certainty1 + threshold - abs(opinion1-opinion2);
    newCertainty2 = certainty2 + threshold - abs(opinion1-opinion2);
    
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
    
    newOpinion1 = opinion1 + transferEffect*...
        (certainty2/(certainty2 + certainty1+eps))*(opinion2-opinion1);
    newOpinion2 = opinion2 + transferEffect*...
        (certainty1/(certainty2 + certainty1 + eps))*(opinion1-opinion2);
    
end

