function imout = funcTiling(PathPatches, C)
%%  PathPatches = patches_dir;
% This function tiles the patches into an image. To this end, we make
% decision based o centeralized patches and then apply the labels on the
% non-centeralized/raw patches

addpath(PathPatches)
load(['indexindicator.mat'])
rmpath(PathPatches)

% initially labelling the centralized patches
P = size(Patches,1);
LabelledPatches = zeros(P, P, size(Patches,3));
ProbaLabel = zeros(1,size(Patches,3));

for i = 1:size(Index,2)
    if find(C(:,2) == i)
    Labelled = Labeling_n(i, C, Patches(:,:,Index(i)));
    LabelledPatches(:,:,Index(i)) = Labelled.patch;
    ProbaLabel(1,Index(i)) = Labelled.prob;
    else
        disp(PathPatches)
        break;
    end
end
L = Tiling(Patches, P, P/2, R.BlX, R.BlY, R.PadX, R.PadY, R.r, R.c); % tling patches
L = L>0;  %imshow(L)

% Reconstruct the image via majority voting
imout = TilingOverlapped(LabelledPatches, ProbaLabel, L, P, R);% tling RGB patches
end