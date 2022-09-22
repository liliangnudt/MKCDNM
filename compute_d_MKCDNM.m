function [d]=compute_d_MKCDNM(Hp,numclass)
% Compute d
[~,~,numker]=size(Hp);
d=zeros(numker,1);
d2=d;

% Find a feasible solution
while 1
    d=d+numclass;
    d2=d;
    for p=1:numker
        for q=p+1:numker
            s = sum(( Hp(:,1:d(p),p)'*Hp(:,1:d2(q),q) ).^2,'all');
            if s < numclass; break; end
        end
        if s < numclass; break; end
    end
    if s >= numclass; break; end
end
Hp=Hp(:,1:d(1),:);

% Optimize alternately
M=1;
while 1
    % Optimize d
    d=update_d_MKCDNM(d,d2,Hp,M,numclass);
    if sum(d==d2)==numker; break; end
    
    % Optimize d2
    d2=update_d_MKCDNM(d2,d,Hp,M,numclass);
    if sum(d==d2)==numker; break; end
    
    % Update M
    M=M*2;
end

end