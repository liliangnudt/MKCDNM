function [H] = MKC_DNM(KH,numclass)
%------------------------- The Proposed MKC_DNM ---------------------------
[num,~,numker]=size(KH);
d_max=min(num,numclass*25); % d_max should be big enough

Hp=zeros(num,d_max,numker);
opt.disp=0;
for p=1:numker
    [Hp(:,:,p),~]=eigs(KH(:,:,p),d_max,'la',opt);
end

[d]=compute_d_MKCDNM(Hp,numclass);

U=zeros(num,sum(d));
i=0;
for p=1:numker
    U(:,i+1:i+d(p))=Hp(:,1:d(p),p);
    i=i+d(p);
end
[H,~,~] = svds(U,numclass);
end
