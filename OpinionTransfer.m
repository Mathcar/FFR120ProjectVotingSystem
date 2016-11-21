function [ newOpinion1, newOpinion2 ] = OpinionTransfer( induvidual1, induvidual2 )
    
    opinion1 = induvidual1(4);
    opinion2 = induvidual2(4);
    
    carisma1 = induvidual1(3);
    carisma2 = induvidual2(3);
    
    newOpinion1 = opinion1 + carisma2*(opinion2-opinion1);
    newOpinion2 = opinion2 + carisma1*(opinion1-opinion2);
    
end

