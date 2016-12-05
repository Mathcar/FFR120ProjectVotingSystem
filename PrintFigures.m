function PrintFigures(sweepParameterFilePrefix, parameterList)
    figHandles = get(0,'child');
    
    for i = 1:length(figHandles)
        set(0,'CurrentFigure',figHandles(i).Number)
        fig = gcf;
        fig.PaperPositionMode = 'auto';
        fig_pos = fig.PaperPosition;
        fig.PaperSize = [fig_pos(3) fig_pos(4)];
        set(gca, 'LooseInset', get(gca, 'TightInset'));
        baseName = [sweepParameterFilePrefix num2str(parameterList(i))];
        print([baseName '.pdf'], '-dpdf')
        savefig([baseName '.fig'])
    end
    
end