function Patchindex = PatchCoordination(L, P, q)
%%
[r,c] = size(L);

posiX = 1:P-q:c; % column position
posiY = 1:P-q:r; % raw position

% remove extra positions
while  c - posiX(end) <= (q-1)
    posiX = posiX(1:end-1);
end
while r - posiY(end) <= (q-1)
    posiY = posiY(1:end-1);
end

BlX = numel(posiX); % horizontal patches
BlY = numel(posiY); % vertical patches

counter = 1;
Patchindex = [];

for i = 1:BlY
    for j = 1:BlX
        ii = posiY(i);
        jj = posiX(j);
        Patchindex = [Patchindex; [ii, jj]];
    end
end
end
