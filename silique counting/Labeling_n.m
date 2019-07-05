function  PI = Labeling_n(n, C, impatch)
%%
 % label the class of each patch
aa = find(C(:,2) == n);
c = C(aa,end-3:end);
[val, ind] = sort(c, 'descend');

PI.indx = ind(1);
PI.prob = val(1);

PI.patch = PI.indx*impatch;
end