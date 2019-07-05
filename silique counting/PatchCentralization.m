function [patchout, RGBout, Index] = PatchCentralization(Patchin, PatchRGB, Lin, Irgb, P, q, Th)
%%       Patchin =Patches;    PatchRGB =PatchesRGB;  Lin = L;  Irgb = Iin; Par = R;

patchout = zeros(size(Patchin));
RGBout   = zeros(size(PatchRGB));

Patchindex = PatchCoordination(Lin, P, q);

n = 0;
for ii = 1:size(Patchin,3)
    Pacth_temp = Patchin(:,:,ii);
%        figure; imagesc(Pacth_temp);title(['i= ',num2str(ii)])
    
    % Removeing boreders
    Pacth_temp_RGB = squeeze(PatchRGB(:,:,ii,:));
    D1 =  abs(Pacth_temp_RGB(:,:,1) - Pacth_temp_RGB(:,:,2));
    D2 =  abs(Pacth_temp_RGB(:,:,1) - Pacth_temp_RGB(:,:,3));
    D3 =  abs(Pacth_temp_RGB(:,:,2) - Pacth_temp_RGB(:,:,3));
    
    p = regionprops(Pacth_temp,'Centroid');
    if (size(p,1) ~= 0) && ((mean(D1(:))+mean(D2(:))+ mean(D3(:)))> Th.Border)
        n = n+1;
        Index(n) = ii;
        dc = round((P/2) - p.Centroid(1));
        dr = round((P/2) - p.Centroid(2));
        
        yx = Patchindex(ii, :);
        X = yx(2) - dc;
        Y = yx(1) - dr;
         
        x = X: X+P-1;
        y = Y: Y+P-1;
    %    figure; imagesc(L(y, x));

        if (x(end) - size(Lin, 2))> 0  % x-range is out of border of the input image
            PadX =(x(end) - size(Lin, 2));
            x = X : size(Lin, 2);
        elseif x(1) < 1
            x = 1:P;
        end
        
        if (y(end) - size(Lin, 1))> 0 % y-range is out of border of the input image
            PadY =(y(end) - size(Lin, 1));
            y = Y : size(Lin, 1);
        elseif y(1) < 1
            y = 1:P;
        end
        
        
        temp = Lin(y, x);
        if (size(temp,1) < P) && (size(temp,2) == P)
            patchout(:,:,ii) = padarray(Lin(y, x),[PadY 0],'symmetric','post');
            %     figure; imagesc(PadL);title(['i= ',num2str(ii)])
            
            for kk =1:3
                Padrgb(:,:,kk) = padarray(Irgb(y, x, kk),[PadY 0],'symmetric','post');
            end
            RGBout(:,:,ii,:) = Padrgb;
            
        elseif (size(temp,1) == P) && (size(temp,2) < P)
            patchout(:,:,ii) = padarray(Lin(y, x),[0 PadX],'symmetric','post');
            %     figure; imagesc(patchout(:,:,ii));title(['i= ',num2str(ii)])
            for kk =1:3
                Padrgb(:,:,kk) = padarray(Irgb(y, x,kk),[0 PadX],'symmetric','post');
            end
            RGBout(:,:,ii,:) = Padrgb;
            
        elseif (size(temp,1) < P) && (size(temp,2) < P)
            patchout(:,:,ii) = padarray(Lin(y, x),[PadY PadX],'symmetric','post');
            %     figure; imagesc(patchout(:,:,ii));title(['i= ',num2str(ii)])
            for kk =1:3
                Padrgb(:,:,kk) = padarray(Irgb(y, x, kk),[PadY PadX],'symmetric','post');
            end
            RGBout(:,:,ii,:) = Padrgb;
        else
            patchout(:,:,ii) = Lin(y,x);
            %     figure; imagesc(patchout(:,:,ii));title(['i= ',num2str(ii)])
            RGBout(:,:,ii,:) = Irgb(y,x,:);
        end
    end
     %    figure; imagesc(patchout(:,:,ii));title(['i= ',num2str(i)])
     %    pnew = regionprops(patchout(:,:,ii),'Centroid');

end
end
%%%%%%%%%%%%%%   Auxilary Function
