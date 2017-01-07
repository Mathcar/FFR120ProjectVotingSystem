fileNames = {
'all_data_17-01-06_19.14.12.mat';
'all_data_17-01-06_17.55.30.mat';
'all_data_17-01-07_20.25.53.mat';
};
nFiles = length(fileNames);
tWinCell = cell(nFiles,1);
mediaEffectCell = cell(nFiles,1);

for i = 1:nFiles
   data = load(fileNames{i});
   tWinCell{i} = data.tWin;
   mediaEffectCell{i} = data.mediaEffectScalarList;
end
nCities = data.nCities;
nParties = data.nParties;
proportionAffected = data.proportionAffected;

tWin = [tWinCell{3} [tWinCell{1};tWinCell{2}]];
mediaEffectScalarList = [mediaEffectCell{3} mediaEffectCell{1}];
tWinNaN = tWin;
tWinNaN(tWin==0) = NaN;
tWinMean = nanmean(tWinNaN,1);
tWinSigma = nanstd(tWinNaN,1);
figure
errorbar(mediaEffectScalarList,tWinMean,tWinSigma)

textOpts = {'Interpreter','LaTex','FontSize',14};

xlabel('$M_{\mathrm{limit}}$',textOpts{:});
ylabel('Convergence Time',textOpts{:});
TITLE_FORMAT = '\\texttt{nCities} = %d, \\texttt{nParties} = %d, proportion affected by media: %1.0e';
title(sprintf(TITLE_FORMAT,nCities,nParties,proportionAffected),textOpts{:})

fig = gcf;
fig.PaperPositionMode = 'auto';
fig_pos = fig.PaperPosition;
fig.PaperSize = [fig_pos(3) fig_pos(4)];
set(gca, 'LooseInset', get(gca, 'TightInset'));
set(gca,'TickLabelInterpreter','LaTeX','FontSize',12)


DATE_FORMAT = 'yy-mm-dd_HH.MM.SS';
print(['conv_' datestr(datetime(),DATE_FORMAT) '.pdf'], '-dpdf')
savefig(['conv_' datestr(datetime(),DATE_FORMAT) '.fig'])
