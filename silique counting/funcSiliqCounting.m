function [no_Sil, no_clear_Sil, Measurments] = funcSiliqCounting(Labelled_im, imout)
% This function first devides the images into single siliques and cross siliques
% single/unique Siliques: a pure silique is called single silique
% cross Siliques: a combination of overlaid siliques is called a cross silique
%
% output:
%       no_clear_Sil: it counts clear Siliques
%       no_Sil    : it counts all Siliques (clear plus cross)
%       Measurments

% 1- partining the image into single Siliques and cross Siliques
if Labelled_im==0
    no_clear_Sil = 0;
    no_Sil = 0;
    Measurments = [];
    return; 
end

index = []; % this returns the index of cross siliques
clear Measurments_struct
n = 0;

for k = 1: numel(unique(Labelled_im)) -1
    im_temp = Labelled_im==k;
    [ym, xm] = find(im_temp == 1);
    y = [min(ym): max(ym)];
    x = [min(xm): max(xm)];
    im_zoom = im_temp(y, x);
    TBBS = imout(y, x);  % Tip Body Base Stem
    
    p1 = regionprops(im_zoom,'Eccentricity'); % this paremeter estimates that whether the
    % im_zoom is an ellipsis or not -> a cross silique unlike a single silique is not ellipsis_shaped
    
    p2 = regionprops(TBBS==1,'centroid'); % this command calculates the number of Tips region
    p3 = regionprops(TBBS==3,'centroid'); % this command calculates the number of base region
    
    if p1.Eccentricity < 0.97  && (numel(p2) + numel(p3) > 2) % This is not a single silique
        index = [index; k];
    else    % this is a clear silique, so we calcualate its dimension
        n = n+1;
        Measurments_struct(n) = regionprops(im_zoom, 'MinorAxisLength', 'MajorAxisLength', 'Perimeter', 'Area');
    end
end
no_clear_Sil = k - numel(index);  % No. of single siliques(those Siliques are clear without ambiguous)

Measurments = struct2cell(Measurments_struct);

if size(Measurments, 3) <= 1
    Measurments = [];
end
% Area:
% MajorAxisLength:
% MinorAxisLength:
% Perimeter:
%%
% 2- now, we count the siliques in the cross-Siliques regions
Numerator = [];
for k =  1: numel(index)
    crsil = Labelled_im == index(k);
    [ym, xm] = find(crsil == 1);
    y = [min(ym): max(ym)];
    x = [min(xm): max(xm)];
    
    D    = -bwdist(~crsil(y, x));
    mask = imextendedmin(D,2);
    TBBS = imout(y,x);
    
    pmask = regionprops(mask==1,'Centroid'); % this command calculate the number of Tips region
    ptip = regionprops(TBBS==1,'Centroid', 'Area'); % this command calculate the number of Tips region
    pbase = regionprops(TBBS==3,'Centroid', 'Area'); % this command calculate the number of base region
    
    thBaes = 20; % minium area for detected base regions
    thTip = 20;  % minium area for detected tip regions
    
    Nbase = sum([pbase(:).Area] > thBaes);
    n = 0;
    centroidBase = [];
    for g = 1: size([pbase(:).Area], 2)
        if pbase(g).Area > thBaes
            n = n+1;
            centroidBase(n,:) =pbase(g).Centroid;
        end
    end
    
    Ntip = sum([ptip(:).Area] > thTip);
    n = 0;
    centroidTip = [];
    for g = 1: size([ptip(:).Area],2)
        if ptip(g).Area > thTip
            n = n+1;
            centroidTip(n,:) =ptip(g).Centroid;
        end
    end
    
    c1 = Ntip == Nbase;
    c2 = Ntip == numel(pmask);
    c3 = (Ntip ==2  &&  Nbase== 1)   || (Ntip ==1  &&  Nbase== 2);
    
    if c1
        Numerator(k) = Ntip ;
    elseif c3 && ~c1    % this conditional checks two adjacent silisues
        if Ntip > Nbase
            centroid(1,:) = [ centroidBase, 1];
            centroid(2,:) = [centroidTip(1,:), 1];
            centroid(3,:) = [centroidTip(2, :), 1];
        else
            centroid(1,:) = [ centroidTip, 1];
            centroid(2,:) = [centroidBase(1,:), 1];
            centroid(3,:) = [centroidBase(2, :), 1];
        end
        l1 = cross(centroid(1,:), centroid(2,:) );
        l2 = cross(centroid(1,:), centroid(3,:) );
        tetha = acosd(dot(l1, l2)/(norm(l1,2)*norm(l2,2)));
        if tetha > 0.05; Numerator(k) = max(Ntip, Nbase); end
        
    elseif   c2 && ~c3 && ~c1
        Numerator(k) = numel(pmask) ;
    else
        Numerator(k) = round((Ntip +Nbase)/2);
    end
end
no_Sil = no_clear_Sil + sum(Numerator);
end