function GenLegend(n)
   arg = {};
   for i=1:n
      arg{i} = num2str(i);
   end
   legend(arg{:});
end