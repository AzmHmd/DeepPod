function sil = funcSiliqdef(imout)
%%
% This function applys silique definition on the image and finds the regions contained siliques; to
% this end, we first merge borderies between tips and bodies' regions; then merge borderies between
%  the resulted regions with base regions

% 1- First we merge borderies between tips and bodies and then remove body
% or tip regions that have no common borderies
im1 = (imout == 1) + 2*(imout == 2);
[labeledImage, numRegions] = bwlabel(im1);

n = 0;
for k = 1:numRegions
    L_temp = labeledImage ==k;
    L1k = L_temp.*im1;
    U = unique(L1k);
    if size(nonzeros(U),1) ==2
        n = n+1;
        NoTipBody(n) = k;
    end
end
if n <1; sil = 0; return; end

labeledImTipBody = 0*L_temp;
for i = 1:numel(NoTipBody)
    L_temp = labeledImage==NoTipBody(i);
    labeledImTipBody = labeledImTipBody + L_temp;
end

% 2- alike previous section, we merge the borderies between the resulted
% regions (above section) and base regions

im1 = 0*im1;
im1 = 2*(imout == 3) + (labeledImTipBody == 1);
[labeledImage, numRegions] = bwlabel(im1);  % imagesc(labeledImage)
n = 0;

NoTipBodyBase = [];

for k = 1:numRegions
    L_temp = labeledImage == k;
    L1k = L_temp.*im1;
    U = unique(L1k);
    if size(nonzeros(U),1) ==2
        n = n+1;
        NoTipBodyBase(n) = k;
    end
end

sil = 0*L_temp;
if numel(NoTipBodyBase)>0
    for i = 1:numel(NoTipBodyBase)
        sil = sil + i*(labeledImage==NoTipBodyBase(i));
    end
end
end