function [XBest,BestF,Iters,allx,ally]=Grid_Search(N, XLo, XHi, NumDiv, MinDeltaX, Eps_Fx, MaxIter, myFx)
% GRID SEARCH FUNCTION
%
% Input
%
% N - number of variables
% XLo - array of lower values
% XHi - array of higher values
% NumDiv - array of number of divisions along each dimension
% MinDeltaX - array of minimum search values for each variable
% Eps_Fx - tolerance for difference in successive function values
% MaxIter - maximum number of iterations
% myFx - name of the optimized function
%
% Output
%
% XBest - array of optimized variables
% BestF - function value at optimum
% Iters - number of iterations
%

allx=[];
ally=[];

Xcenter = (XHi + XLo) / 2;
XBest = Xcenter;
DeltaX = (XHi - XLo) ./ NumDiv;
BestF = feval(myFx, XBest, N);

it=[1];
if BestF >= 0
  LastBestF = BestF + 100;
else
  LastBestF = 100 - BestF;
end
X = XLo; % initial search value

Iters = 0;
bGoOn = 1;

while (bGoOn > 0) && (abs(BestF - LastBestF) > Eps_Fx) || (Iters <= MaxIter)

  bGoOn2 = 1;

  while bGoOn2 > 0 && (Iters <= MaxIter)

    Iters = Iters + 1;
    F = feval(myFx, X, N);
      allx=[allx;XBest];
      ally=[ally;BestF];
      it=[it;Iters];
    if F < BestF
      LastBestF = BestF;
      BestF = F;
      XBest = X;

    end

    for i = 1:N
      if X(i) >= XHi(i)
        if i < N
          X(i) = XLo(i);
        else
          bGoOn2 = 0;
          break
        end
      else
        X(i) = X(i) + DeltaX(i);
        break
      end
    end

  end


  XCenter = XBest;
  DeltaX = DeltaX ./ NumDiv;
  XLo = XCenter - DeltaX .* NumDiv / 2;
  XHi = XCenter + DeltaX .* NumDiv / 2;
  X = XLo; 

  bGoOn = 0;
  for i=1:N
    if DeltaX(i) > MinDeltaX(i)
      bGoOn = 1;
    end
  end

end 
