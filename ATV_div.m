function FdivHH=ATV_div(H)

% FOTV derivative
Beta=1.1; 
    K =5;
  for g = 1:K-1
    w(K-g) = (-1)^g*gamma(Beta+1)/(gamma(Beta-g+1)*factorial(g));
  end
[m,n] = size(H);
            % backward finite difference operator
    Dux = imfilter(H,w,'circular','full');  % column differences
    Dux = Dux(:,1:n);
    Duy = imfilter(H,w','circular','full'); % row differences
    Duy = Duy(1:m,:);      
    absdivH=sqrt((Dux.^2)+(Duy.^2));
    p=1+1./(1+absdivH.^2);
    B=Dux./(absdivH.^(2-p));
    O=Duy./(absdivH.^(2-p));
    d = length(w);
     
      w = fliplr(w);
      DtB= imfilter(B,w,'circular','full');
      DtB = DtB(:,d:end);
      DtO = imfilter(O,w','circular','full');
      DtO = DtO(d:end,:);
      FdivHH =conj((-1)^Beta)*(-1)^Beta*(DtB+DtO);    %%add conj((-1)^a)*(-1)^a
      FdivHH=(-1)*FdivHH;
end
%   [m,n]=size(dxh);
%   meshgrid(1:n,1:m)  


