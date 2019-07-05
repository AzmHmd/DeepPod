function imout = TilingOverlapped(LabelledPatches, ProbaLabell, L, P, RR)
%%       LabelledPatches =Label; ProbaLabell= ProbaLabel; RR = R;
BlX = RR.BlX; 
BlY = RR.BlY; 
PadX= RR.PadX; 
PadY= RR.PadY; 
r   = RR.r; 
c   = RR.c;
% Warning!!! This is only for q = P/2
Irecon  = zeros(r+PadY , c+PadX); % the reconstructed image
q = P/2;
%% CR = class results
for ii = 1:BlY
    for jj = 1:BlX
        posi = (ii-1)*BlX + jj;
        CR(posi).patchNo = posi;
        CR(posi).position = [(ii-1)*q+1, (jj-1)*q+1];
    end
end
                  % I  I  I  I I
                  % V  M  M  M X
                  % V  M  M  M X
                  % V  M  M  M X
                  % V  C  C  C Y
%% Region #I
ii = 1;   
jj = 1;
k  = (ii-1)*BlX + jj;

CR(1).Label=  max(max(LabelledPatches(1:q,1:q,k)));
CR(1).Prob =  ProbaLabell(k);

for jj = 2:BlX
    k  = (ii-1)*BlX + jj;
    
    CR(k).Label(1) = max(max(LabelledPatches(1:q,q+1:end,k-1)));
    CR(k).Prob(1)  = ProbaLabell(k-1)*(max(max(LabelledPatches(1:q,q+1:end,k-1)))>0);
    
    CR(k).Label(2) = max(max(LabelledPatches(1:q,1:q,k)));
    CR(k).Prob(2)  = ProbaLabell(k) *(max(max(LabelledPatches(1:q,1:q,k))) >0);
end
%% Region #V
jj = 1;
for ii = 2:BlY
    k  = (ii-1)*BlX + jj;
    
    CR(k).Label(1) = max(max(LabelledPatches(q+1:end, 1:q, k-BlX)));
    CR(k).Prob(1)  = ProbaLabell(k-BlX)*(max(max(LabelledPatches(q+1:end, 1:q, k-BlX))));
    
    CR(k).Label(2) = max(max(LabelledPatches(1:q,1:q,k)));
    CR(k).Prob(2)  = ProbaLabell(k)*(max(max(LabelledPatches(1:q,1:q,k))));
end
%% Region #M
for ii = 2:BlY
    for jj = 2:BlX
        k  = (ii-1)*BlX + jj;
        
        CR(k).Label(1) = max(max(LabelledPatches(1:q,1:q,k)));
        CR(k).Prob(1)  = ProbaLabell(k)*(max(max(LabelledPatches(1:q,1:q,k))));
        
        CR(k).Label(2) = max(max(LabelledPatches(1:q, q+1:end, k-1)));
        CR(k).Prob(2)  = ProbaLabell(k-1)*(max(max(LabelledPatches(1:q, q+1:end, k-1))));
        
        CR(k).Label(3) = max(max(LabelledPatches(q+1:end, 1:q, k-BlX)));
        CR(k).Prob(3)  = ProbaLabell(k-BlX)*(max(max(LabelledPatches(q+1:end, 1:q, k-BlX))));
        
        CR(k).Label(4) = max(max(LabelledPatches(q+1:end, q+1:end, k-BlX-1)));
        CR(k).Prob(4)  = ProbaLabell(k-BlX-1)*(max(max(LabelledPatches(q+1:end, q+1:end, k-BlX-1))));
    end
end

%% Dicision making
for k = 1:numel(CR)
    Ind = CR(k).Label;
    %     Pr  = CR(k).Prob;    
    CR(k).indF =  mode(Ind) * (max(Ind(:))>0);
end
%% Reconstruction
for k = 1:numel(CR)
    y = CR(k).position(1);
    x = CR(k).position(2);
    
    Irecon(y:y+q-1, x:x+q-1) = CR(k).indF * L(y:y+q-1, x:x+q-1);
end
imout = Irecon(1:r, 1:c);