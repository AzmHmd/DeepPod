% This code is written to extract the patches from various parts of a
% plant. Augment them and save them in appropriate folders.
%
% inputs: display: 1= show annotations on the image, 0= do not show ...
% patchSize: the size you are extracting patches for deep learning task
% annot: type of annotation you want to axtract information from (i.e.
% 'Top', 'Base',...)
% base_path: location where the annotations can be read from
% save_path0: location where you desire your extracted patches to be saved
%
% output: will be image patches around the point you annotated, saved in
% different folders for each image.
%
% Written by Azam Hamidinekoo, Aberystwyth, October, 2017
% -------------------------------------------------------------------------

clc; clear all; close all; warning off;
%% inputs
display = 0;
patchSize = 32; shift = 16;
annot = 'Stem';
ROOT = 'SPECIFY THE ROOT TO YOUR REPOSITORY';
p = 'ROOT\Patches\Siliques\';
base_path = dir(p);
save_path0 = ['ROOT\Patches\',annot,'\'];
%% start
for i = 1:length(base_path)
    if ~strcmp(base_path(i).name,'.')&&~strcmp(base_path(i).name,'..')
        
        imgs = dir([p,base_path(i).name,'\*.png']);
        
        %% read images and the annotations
        for j = 1:length(imgs)
            if imgs(j).bytes > 5000 && isempty(strfind(imgs(j).name,'s.png'))
                % read the image
                I = imread([p,base_path(i).name,'\',imgs(j).name]);
                
                % make the respective folder for individual images
                folder = strrep(imgs(j).name,'.png','');
                mkdir([save_path0,folder,'\',annot]);
                
                % read the annotations
                annotations = readAnnotation([p,base_path(i).name,'\',folder],annot);
            end
            
            %% show the annotations on the respective image
            if display == 1
                figure();
                imshow(I);hold on
                for a = 1:length(annotations)
                    plot(annotations(a,1), annotations(a,2),'*')
                end
            end
            %% extract patches using the annotations
            for x = 1:length(annotations)
                cntre = [annotations(x,1), annotations(x,2)];
                xmin = cntre(1) - patchSize/2 - shift;
                ymin = cntre(2) - patchSize/2 - shift;
                length_of_rect = patchSize+2*shift;
                rect = [xmin, ymin, length_of_rect-1, length_of_rect-1];
                I_crop = imcrop(I,rect);
                % perform rotation and cropping as data augmentation
                name = imgs(j).name; name = name(1:end-4);
                dataAugmentation(I_crop,[save_path0,folder,'\',annot,'\'],name,annot);
            end
        end
    end
end
%% end
