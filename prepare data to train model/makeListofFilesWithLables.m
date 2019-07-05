% This code is written to dedicate random samples to training, validation
% and testing sets.
%
% inputs: 
% fidtrain: the path to write list of training samples 
% fidval: the path to write list of validation samples 
% fidtest: the path to write list of testing samples 
% all_plant_names: list all plant IDs to be shuffled for data allocation
% p: path to the extracted and prepared patch data
%
% Written by Azam Hamidinekoo, Computer Science, Aberystwyth, 2018
%--------------------------------------------------------------------------

clear;clc;

% make text files to write in
fidtrain = fopen('ROOT/training.txt','w');
fidval = fopen('ROOT/validation.txt','w');
fidtest = fopen('ROOT/test.txt','w');


% list all plant IDs and shuffle for data allocation
all_plant_names = dir('ROOT/Siliques/');
all_plant_names(1) = [];
all_plant_names(1) = [];
shuff = all_plant_names(randperm(length(all_plant_names)));

% allocate suffled data to each set
p = 'SPECIFY PATH TO THE EXTRACTED PATCHES/Patches/';
root = dir(p);
for i = 3:length(root)
    
    % find the label
    type = root(i).name;
    switch type
        case 'Base'
            label = 0;
        case 'Body'
            label = 1;
        case 'Stem'
            label = 2;
        case 'Tip'
            label = 3;
    end
    
    for nn = 1:length(shuff)
        disp(['==== writing data ',num2str(nn),'/',num2str(length(shuff)),' ===='])
        folder = strsplit(shuff(nn).name,' ');
        root2 = dir([p,type,'/',folder{2},'*']);
        for j = 1:length(root2)
            imgs = dir([root2(j).folder,'/',root2(j).name,'/',type,'/*.png']);
            
            % write the training list
            if nn <= 0.7*length(shuff)
                disp('* writing training data *')
                for k = 1:length(imgs)
                    fprintf(fidtrain,[imgs(k).folder,'/',imgs(k).name, ' ', num2str(label),'\n']);
                end
                
            % write the validation list (without augmentation)
            elseif nn>0.7*length(shuff) && nn<=0.7*length(shuff)+0.2*length(shuff)
                disp('** writing validation data **')
                for k = 1:length(imgs)
                    if strfind(imgs(k).name,'_0_5.png')
                    fprintf(fidval,[imgs(k).folder,'/',imgs(k).name, ' ', num2str(label),'\n']);
                    end
                end
                
            % write the testing list (without augmentation)
            else
                disp('*** writing test data ***')
                for k = 1:length(imgs)
                    if strfind(imgs(k).name,'_0_5.png')
                    fprintf(fidtest,[imgs(k).folder,'/',imgs(k).name, ' ', num2str(label),'\n']);
                    end
                end
            end
        end
    end
end

