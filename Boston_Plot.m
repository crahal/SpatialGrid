figure('position', [0, 0, 600 500]);
lambdagraph=surf(alphas,neighbours,lambdavalues)
zlabel('$$\hat{\lambda}$$','Interpreter','latex','Fontsize',12)
colormap(brewermap([],'Reds')) 
xlabel('Alpha','Interpreter','latex','Fontsize',12)
ylabel('Nearest Neighbours','Fontsize',12)
set(gca,'Fontsize',12)
set(gcf,'color','w');
grid on
export_fig('Figure_lambda.png','-png','-r500','-nocrop')

figure('position', [0, 0, 600 500]);
DEcrimegraph=surf(alphas,neighbours,DEcrime)
zlabel('Direct Effects: Crime','Interpreter','latex','Fontsize',12)
colormap(brewermap([],'Greens')) 
xlabel('Alpha','Interpreter','latex','Fontsize',12)
ylabel('Nearest Neighbours','Fontsize',12)
set(gca,'Fontsize',12)
set(gcf,'color','w');
grid on
export_fig('Figure_DEcrime.png','-png','-r500','-nocrop')

lmarginal = [];
for i=1:length(sarc)
results = sarc(i);
fields = fieldnames(results);
nf = length(fields);
 for i=1:nf
    if strcmp(fields{i},'mlike')
        lmarginal = [lmarginal results.mlike];
    end;
 end;
end;
detval = results.lndet;
nrho = length(detval);
adj = max(max(lmarginal));
madj = lmarginal - adj;
xx = exp(madj);
yy = matmul(detval(:,1),ones(nrho,length(sarc)));
isum = zeros(1,length(sarc));
isum = sum((yy(2:nrho,:) + yy(1:nrho-1,:)).*(xx(2:nrho,:) - xx(1:nrho-1,:))/2);
psum = sum(isum);
probs = isum/psum;
holder = 0
for a = 1:20
    for b = 1:20
        holder=holder+1;
        modelprobsmatrix(a,b)=probs(holder);
    end
end
figure('position', [0, 0, 600 500]);
bars=bar3(modelprobsmatrix)
idxrep = repmat(1:length(modelprobsmatrix),6,1);  %magic 6
for K = 1 : length(modelprobsmatrix)
  Z = repmat(SchemeA_Estimates.sparsity(idxrep(:),K),1,4);   %magic 4
  set(bars(K), 'CData',Z);
end
colormap(brewermap([],'RdYlBu'))  
zlabel('Posterior Probability','Fontsize',12)
ylabel('Nearest Neighbours','Fontsize',12)
xlabel('Alpha Iteration','Fontsize',12)
set(gca,'Fontsize',12)
set(gcf,'color','w');
grid on
xlim([0 21]);
ylim([0 21]);
export_fig('Figure_bar3modelprobs.png','-png','-r600','-nocrop')

figure('position', [0, 0, 600 500]);
loglikhist=histfit(vertcat(reshape(logliks,400,1)),40,'kernel')
loglikhist(1).FaceColor = [.2148 0.492 .71875];
loglikhist(2).Color = [.8906 .10156 .109];
ylabel('Frequency','Fontsize',12)
xlabel('Log Likelihood','Fontsize',12);
loglikhist=set(gcf,'color','w','PaperPositionMode','auto');
grid on
legend('Histogram','Kernel-smoothing','Location','northeast')
set(gca,'Fontsize',12)
set(gcf,'color','w');
grid on
export_fig('Figure_histloglik.png','-png','-r600','-nocrop')