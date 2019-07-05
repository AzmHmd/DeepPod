%%
% this file convert the input images into patches and then stores them
% see README.txt
close all; clear; clc; format compact
%% Directory and file's format declaration

% windows
prompt = 'What is the drive of EXTERNAL HARD (e, f, g)? ';
Drive = input(prompt, 's');
im_path = [Drive , 'SPECIFY']; % the directory of input images
code_path =  [Drive , 'SPECIFY']; % the current directory of code

% the directory of stored patches (we have two types of patches: centalized and non-centralized: 
% we use centralized patches to decision making and the reslts then applied to non-cenntralized patches)
pathSav_non_cen  = [Drive , 'SPECIFY\test' ];
pathSav_cen     = [Drive , 'SPECIFY\test_centralized']; 

type  = 'png' ;
types = '.png';
P = 32;   % the lenght of patch
q = P/2;  % the lenght of overlapping
Th.Border = 10;  % this threshold does not consider the boundries that are free from siliques and 
% removes blank patches -> increase speed
%% Read the input images and then the possible pathes
cd(code_path)
Impath = Readim(im_path, type);
for i = 1:size(Impath,2)     %  simple test image: 1 , the complicated one: 26)
    Cpath = Impath(i).CurrentImagePath;
    im = imread(Cpath);
    [R.r, R.c, R.d] = size(im);
    
    % 0- Preprocessing: this part segments the input image into vegetated regions (index = 1) 
    % and background (index = 0)
    Igray = rgb2gray(im);   % convert RGB to Gray value
    Igray   = im2bw(Igray, graythresh(Igray));
    [L, ~] = bwlabel(imcomplement(Igray)); 
    L = L > 0; % 
    
    Igray =[];
    % 1- Partitioning the input image into P*P patches
    [Patches, R.BlX, R.BlY, R.PadX, R.PadY]  = Partitioning(L, P, q); % imagesc(L)
    for ii = 1:size(im,3)
        [PatchesRGB(:,:,:,ii), ~, ~, ~, ~]  = Partitioning(im(:,:,ii), P, q);
    end
    
    % 2- Centralize the pacthes
    [TestPatches, TestRGBpatches, Index] = PatchCentralization(Patches, ...
        PatchesRGB, L, im, P, q, Th);
    %  ReconstructionError(L, Patches, Index, R, P, q);
    
    % 3-storing the patches as well as inforamtion of patching at the predetermined directories
    cd(pathSav_non_cen)
    mkdir(num2str(i))
    cd(num2str(i))
    save('indexindicator.mat', 'Index', 'R', 'P', 'q', 'Patches', 'PatchesRGB')
    
    for indexk = 1: numel(Index)
        filename = [num2str(indexk),types];
        imwrite(uint8(squeeze(PatchesRGB(:,:,Index(indexk),:))),filename);
    end
    
    cd(pathSav_cen)
    mkdir(num2str(i))
    cd(num2str(i))
    for indexk = 1: numel(Index)
        filename = [num2str(indexk),types];
        imwrite(uint8(squeeze(TestRGBpatches(:,:,Index(indexk),:))),filename);
    end
    cd(code_path)
end