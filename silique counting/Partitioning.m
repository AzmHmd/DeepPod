%%
function  [Patches, BlX, BlY, PadX, PadY]  = Partitioning(Im, P, q)
% Inputs
%  Im: a 2D image
%  P : the size of patch
%  q : the size of overlap
% Outputs
%  Patches    an array of patches
%  BlX        the number of blocks in the direction of X
%  BlY        the number of blocks in the direction of Y
%  PadX       the number of pads required in the direction of X
%  PadY       the number of pads required in the direction of Y
% 
% Description
%   This function partitions the input 2D image into P*P blocks with 'q'
%   overlap between any adjacent blocks
%
% Aug. 2, 2016. Morteza Ghahremani 
% Image Processing and Data Analysis Laboratory
% Tarbiat Modares University
%
% References
% Morteza Ghahremani and Hassan Ghassemian. Nonlinear IHS: A Promising 
% Method for Pan-Sharpening. IEEE Geoscience and Remote Sensing Letter
%
% Morteza Ghahremani and Hassan Ghassemian. Remote Sensing Image Fusion Using Ripplet
% Transform and Compressed Sensing. IEEE Geoscience and Remote Sensing Letter
%
% Morteza Ghahremani and Hassan Ghassemian. A Compressed-Sensing-Based 
% Pan-Sharpening Method for Spectral Distortion Reduction. IEEE TRANSACTIONS 
% ON GEOSCIENCE AND REMOTE SENSING, 2016
% 
% For any questions, please do not hesitate to email me by 
% morteza.ghahremani.b@gmail.com

% see Tiling.m


if q > 0.5*P
    disp('Warning! the maximum size of overlapping is 50%.');
    return   
end

[r,c] = size(Im);
%% determining Bl and Pad     
% Bl = the number of patches   
% Pad = the amount of padding

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
% [BlY, BlX]

PadX = P - (c - (BlX-1)*(P-q)); % horizontal pads
PadY = P - (r - (BlY-1)*(P-q)); % vertical pads
% [PadY, PadX]

ll = BlX*BlY;
Patches = zeros(P, P, ll);

% Padding  ==============================================================
ImPad = padarray(Im,[PadY PadX],'symmetric','post');
% Partioning ==============================================================
counter = 1;
for i = 1:BlY
    for j = 1:BlX
        ii = posiY(i);
        jj = posiX(j);
        %         fprintf('[%d:%d, %d:%d]\n',ii,ii+P-1,jj,jj+P-1)   % the positions of arrays
        Patches(:, :, counter) =  ImPad(ii:(ii+P-1), jj:(jj+P-1), : );
        counter = counter + 1;
    end
end
end