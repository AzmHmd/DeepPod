%%
% Phase II: After labelling patches via deep learning
% This file counts the No. of siliques from the labelled results
% see README.txt
close all; clear; clc; format compact
%% Determine the directories
classified_dir = 'SPECIFY/test_centralized/'; % the directory of CLASSIFIED images
code_dir =  'SPECIFY'; % the current directory of code
sort_path_lenet = 'SPECIFY/classification_output/LeNet/';
sort_path_densenet = 'SPECIFY/classification_output/DenseNet/';

%% reconstruct the clssified images and count the no. of Siliquies
warning off
cd(code_dir)
% delete(poolobj);
% poolobj = parpool;
type_net = 'D';  % 'D' stands for 'densenet', and likewise, 'L' stands for 'Lenet'
d = dir(classified_dir);
R_path = cell(length(d)-2);  % the path of results

%%
for i = 3:length(d)
    IM = i-2;
    i
    
    mkdir([d(i).folder,'/',d(i).name,'/',type_net,'/']);
    classified_dir = [d(i).folder,'/',d(i).name,'/',type_net,'/'];
    counter = [];
    %%... Phase I:
    % 1-Read the classified.txt file
    addpath(classified_dir);
    fid = fopen([d(i).folder,'/',d(i).name,'/results.txt'],'r');
    rmpath(classified_dir)
    C =  funcReadData(fid);
    
    % 2-Read stored patches; label them and finally tile them
    d2 = (strrep([d(i).folder,'/',d(i).name],'test_centralized','test'));
    d2 = strrep(d2,'_AT023',' AT023');
    d2 = dir(d2);
    
    for j = 3:length(d2)
        patches_dir = [d2(j).folder,'/',d2(j).name];
    end
    
    im_out = funcTiling(patches_dir, C);
    % figure, imagesc(imout); mymap = [0,0,0; 1,0,0; 0,1,0; 0,0,1; 1,1,1]; colormap(mymap)
    %%..... Phase II: Apply Silique definition on the labelled image and then find Siliquies
    Sil_def_im = funcSiliqdef(im_out);
    % figure;imagesc(mydata)
    
    % counting the siliques and other related measurements
    [no_all, no_clear(IM), Measurments] = funcSiliqCounting(Sil_def_im, im_out);  
    
    %%.... Storing the results
    % [num_silique, Area, MajorAxisLength, MinorAxisLength, Perimeter]
    
    if size(Measurments,3) > 1
        Measurments_mat = cell2mat(Measurments);
        result_mean(IM, :) = mean(Measurments_mat,3);
        result_min(IM, :) = min(Measurments_mat, [], 3);
        result_max(IM, :) = max(Measurments_mat, [], 3);
        result_var(IM, :) = std(Measurments_mat, 0, 3);
    else
        result_mean(IM, :) = [nan, nan, nan, nan] ;
        result_min(IM, :) = [nan, nan, nan, nan] ;
        result_max(IM, :) = [nan, nan, nan, nan] ;
        result_var(IM, :) = [nan, nan, nan, nan] ;
    end
    
    R_no(IM) = no_all;
    R_path{IM} = [d(i).folder,'/',d(i).name];
end
%%
% figure;imagesc(mydata)

no_dataset = length(R_no);

if type_net == 'L'
    %**************************************   Classification's Results
    page = 1;
    cd(sort_path_lenet)
    filename = 'ClassificationResults_lenet.xlsx';
    xlswrite(filename, R_no, page, 'A1');
    save('results_dir', 'R_path');
    
    clear DataMat
    DataMat = {'DataSet', 'No of Clear Sil.',  'No of total detected Sil.'};
    for i = 1:no_dataset
        DataMat(i+1,:) = {i; no_clear(i); no_all(i)};
    end
%     page = 2;
%     xlswrite(filename, DataMat, page, 'A1');
    save('results_Sil_no', 'DataMat');
    %***********************************************   Major Axis Length
    clear DataMat
    DataMat = {'DataSet', 'mean_Major Axis Length(pix.)', ...
    'min_Major Axis Length', 'max_Major Axis Length', 'std_Major Axis Length'};
    for i = 1:no_dataset
         DataMat(i+1,:) = {i; result_mean(i,2); result_min(i,2); result_max(i,2); result_var(i,2)};
    end
    %page  = 3;
    %xlswrite(filename, DataMat, page, 'A1');
    save('results_Major_Axis_Length', 'DataMat');
    %**************************************************   Minor Axis Length    
    clear DataMat
    DataMat = {'DataSet', 'mean_Minor Axis Length(pix.)', ...
    'min_Minor Axis Length', 'max_Minor Axis Length', 'std_Minor Axis Length'};
    for i = 1:no_dataset
        DataMat(i+1,:) = {i; result_mean(i,3); result_min(i,3); result_max(i,3); result_var(i,3)};
    end
    %page  = 4;
    %xlswrite(filename, DataMat, page, 'A1');
    save('results_Minor_Axis_Length', 'DataMat');
    %********************************************************    Area     
    clear DataMat
    DataMat = {'DataSet', 'mean_Area(pix.)', 'min_Area', 'max_Area', 'std_Area'};
    for i = 1:no_dataset
      DataMat(i+1,:) = {i; result_mean(i,1); result_min(i,1); result_max(i,1); result_var(i,1)};
    end
    %page  = 5;
    %xlswrite(filename, DataMat, page, 'A1');
    save('results_Area', 'DataMat');
    %******************************************************   Perimeter     
    clear DataMat
    DataMat = {'DataSet', 'mean_Perimeter(pix.)', 'min_Perimeter', 'max_Perimeter', 'std_Perimeter'};
    for i = 1:no_dataset
     DataMat(i+1,:) = {i; result_mean(i,4); result_min(i,4); result_max(i,4); result_var(i,4)};
    end
    %page  = 6;
    %xlswrite(filename, DataMat, page, 'A1')
    save('results_Perimeter', 'DataMat');
    %**********************************************************************
    cd(code_dir)

    
    
else
    cd(sort_path_densenet)
    %**************************************   Classification's Results
    filename = 'ClassificationResults_densenet.xlsx';
    page = 1;
    xlswrite(filename, R_no, page, 'A1');
    save('results_dir', 'R_path');

    clear DataMat
    DataMat = {'DataSet', 'No of Clear Sil.',  'No of total detected Sil.'};
    for i = 1:no_dataset
        DataMat(i+1,:) = {i; no_clear(i); no_all(i)};
    end
%     page = 2;
%     xlswrite(filename, DataMat, page, 'A1');
    save('results_Sil_no', 'DataMat');
    %***********************************************   Major Axis Length
    clear DataMat
    DataMat = {'DataSet', 'mean_Major Axis Length(pix.)', ...
    'min_Major Axis Length', 'max_Major Axis Length', 'std_Major Axis Length'};
    for i = 1:no_dataset
         DataMat(i+1,:) = {i; result_mean(i,2); result_min(i,2); result_max(i,2); result_var(i,2)};
    end
    %page  = 3;
    %xlswrite(filename, DataMat, page, 'A1');
    save('results_Major_Axis_Length', 'DataMat');
    %**************************************************   Minor Axis Length    
    clear DataMat
    DataMat = {'DataSet', 'mean_Minor Axis Length(pix.)', ...
    'min_Minor Axis Length', 'max_Minor Axis Length', 'std_Minor Axis Length'};
    for i = 1:no_dataset
        DataMat(i+1,:) = {i; result_mean(i,3); result_min(i,3); result_max(i,3); result_var(i,3)};
    end
    %page  = 4;
    %xlswrite(filename, DataMat, page, 'A1');
    save('results_Minor_Axis_Length', 'DataMat');
    %********************************************************    Area     
    clear DataMat
    DataMat = {'DataSet', 'mean_Area(pix.)', 'min_Area', 'max_Area', 'std_Area'};
    for i = 1:no_dataset
      DataMat(i+1,:) = {i; result_mean(i,1); result_min(i,1); result_max(i,1); result_var(i,1)};
    end
    %page  = 5;
    %xlswrite(filename, DataMat, page, 'A1');
    save('results_Area', 'DataMat');
    %******************************************************   Perimeter     
    clear DataMat
    DataMat = {'DataSet', 'mean_Perimeter(pix.)', 'min_Perimeter', 'max_Perimeter', 'std_Perimeter'};
    for i = 1:no_dataset
     DataMat(i+1,:) = {i; result_mean(i,4); result_min(i,4); result_max(i,4); result_var(i,4)};
    end
    %page  = 6;
    %xlswrite(filename, DataMat, page, 'A1')
    save('results_Perimeter', 'DataMat');
    %**********************************************************************
    cd(code_dir)
end
warning on
