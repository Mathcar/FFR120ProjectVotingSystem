function statistics = CalcStatistics(individuals)
   statistics = zeros(2,1);
   
   statistics(1) = mean(individuals(4,:));
   
   statistics(2) = var(individuals(4,:));
end