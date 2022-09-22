function d=update_d_MKCDNM(d,d2,Hp,M,numclass)
% Update d
numker=length(d);

for p =1:numker
    right=d(p);
    left=fix(M/(M+0.5)*d2(p));
    flag=1; % left is feasible
    for q=1:numker
        s = sum(( Hp(:,1:left,p)'*Hp(:,1:d2(q),q) ).^2,'all');
        if s < numclass; flag=0; break; end % left is not feasible
    end
    if flag
        d(p)=left; if (M/(M+0.5)*d2(p))-left>0.5; d(p)=d(p)+1; end; continue;
    end
    % now left is not feasible, employ discrete binary search
    while right-left>1
        temp=fix((right+left)/2);
        flag=1; % temp is feasible
        for q=1:numker
            s = sum(( Hp(:,1:temp,p)'*Hp(:,1:d2(q),q) ).^2,'all');
            if s < numclass; left=temp; flag=0; break; end
        end
        if flag
            right=temp;% temp is feasible
        end
    end
    d(p)=right; % right is better than left
end

end