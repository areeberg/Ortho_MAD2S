function[X,eval]=RandSearch(data,label,dim,numIter,lowerb,upperb,myFx)

rng(29,'simdTwister'); %to garantee repoducibility



r = lowerb + (upperb-lowerb) .* rand(1,1);
%ftarget=0.01;
%numIter=100;
%ObjFun=@(x) sum(x.^2);
%BestF = feval(myFx,data,label ,XBest, N);
currentx=[];
loss=[];
best=[];
bestx=[];
for i=1:numIter
    for j=1:dim
      r(j) = lowerb(j) + (upperb(j)-lowerb(j)) .* rand(1,1);  
    end
    currentx=[currentx;r];
    closs=min(feval(myFx,data,label,r));
    loss=[loss;closs];
    disp(closs)
    if closs<=min(loss)
        bestv=closs;
        bestxv=currentx;
    end
    best=[best;bestv];
    bestx=[bestx;bestxv];
    
    
    
%     if best <= ftarget
%         break;
%     end
end

X=bestx;
eval=best;

end