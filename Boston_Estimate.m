clc
clear all
gridsize=20;
neighbourmultiplier=1;
set(0,'DefaultAxesFontName', 'Century Schoolbook')
load bostoncorrectednoheaders.dat;

YMAT = log(bostoncorrectednoheaders(:,7)); % log of the selling price: use corrected
LON= bostoncorrectednoheaders(:,4); 
LAT = bostoncorrectednoheaders(:,5);
%use the 10 variables of lesage and pace, transform as kostov - numbers almost match exactly
XMAT= [ones(length(YMAT),1),... % constant
    bostoncorrectednoheaders(:,8),... %crime
    bostoncorrectednoheaders(:,11),... %charles river
    bostoncorrectednoheaders(:,12).^2,...% nox squared
    bostoncorrectednoheaders(:,13).^2,... %room squared
    log(bostoncorrectednoheaders(:,15)),... %difst log 
    log(bostoncorrectednoheaders(:,16)),... %rad log
    bostoncorrectednoheaders(:,17),... %tax
    bostoncorrectednoheaders(:,18),... %ptratio
    bostoncorrectednoheaders(:,19),... %b
    log(bostoncorrectednoheaders(:,20))]; %lstat log
h = waitbar(0,'Please wait...');
counter=0;
for nn = 1:gridsize
    neighbours(nn)=nn*neighbourmultiplier; 
    for alpha=1:gridsize
        counter=counter+1;
        alphas(alpha)=(4*alpha)/gridsize;
        W=nnSWM(LAT,LON,nn*neighbourmultiplier,0,1);
        W=W.^((4*alpha)/gridsize);
        results_sar=sar(YMAT,XMAT,W);
        lambdavalues(nn,alpha)=results_sar.rho;
        logliks(nn,alpha)=log(results_sar.lik);
        DEcrime(nn,alpha)=median((sum((squeeze(results_sar.direct(:,1,:)))'))');
        sarc(counter)=sar_c(YMAT,XMAT,W);
    end
    waitbar(nn/gridsize)
end

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

BostonReplication_Script_Plot