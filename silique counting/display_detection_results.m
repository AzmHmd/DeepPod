% display the detected results on the image
% if you want to visualise the detection results, just indicate the
% location of the image in the folder like bellow:

% nnn = {'/media/azh2/TOSHIBA/Deep-learning-AT/Second-part/test_900_samples/samples/test_centralized/13_2016-05-24_AT023_030341',
% '/media/azh2/TOSHIBA/Deep-learning-AT/Second-part/test_900_samples/samples/test_centralized/16_2016-05-24_AT023_030341',
% '/media/azh2/TOSHIBA/Deep-learning-AT/Second-part/test_900_samples/samples/test_centralized/19_2016-05-24_AT023_032341',
% '/media/azh2/TOSHIBA/Deep-learning-AT/Second-part/test_900_samples/samples/test_centralized/22_2016-05-24_AT023_035312',
% '/media/azh2/TOSHIBA/Deep-learning-AT/Second-part/test_900_samples/samples/test_centralized/25_2016-05-24_AT023_035341',
% '/media/azh2/TOSHIBA/Deep-learning-AT/Second-part/test_900_samples/samples/test_centralized/28_2016-05-24_AT023_038342',
% '/media/azh2/TOSHIBA/Deep-learning-AT/Second-part/test_900_samples/samples/test_centralized/31_2016-05-24_AT023_049342',
% '/media/azh2/TOSHIBA/Deep-learning-AT/Second-part/test_900_samples/samples/test_centralized/34_2016-05-24_AT023_049342'};
% 

nnn={'/media/azh2/TOSHIBA/Deep-learning-AT/Second-part/test_900_samples/samples/test_centralized/2_2016-05-24_AT023_011341';
'/media/azh2/TOSHIBA/Deep-learning-AT/Second-part/test_900_samples/samples/test_centralized/39_2016-05-24_AT023_057341';
'/media/azh2/TOSHIBA/Deep-learning-AT/Second-part/test_900_samples/samples/test_centralized/53_2016-05-24_AT023_072342';
'/media/azh2/TOSHIBA/Deep-learning-AT/Second-part/test_900_samples/samples/test_centralized/75_2016-05-24_AT023_080341';
'/media/azh2/TOSHIBA/Deep-learning-AT/Second-part/test_900_samples/samples/test_centralized/102_2016-05-24_AT023_111342';
'/media/azh2/TOSHIBA/Deep-learning-AT/Second-part/test_900_samples/samples/test_centralized/122_2016-05-24_AT023_156341';
'/media/azh2/TOSHIBA/Deep-learning-AT/Second-part/test_900_samples/samples/test_centralized/160_2016-05-25_AT023_029342';
'/media/azh2/TOSHIBA/Deep-learning-AT/Second-part/test_900_samples/samples/test_centralized/190_2016-05-25_AT023_035343';
'/media/azh2/TOSHIBA/Deep-learning-AT/Second-part/test_900_samples/samples/test_centralized/212_2016-05-25_AT023_061343';
'/media/azh2/TOSHIBA/Deep-learning-AT/Second-part/test_900_samples/samples/test_centralized/222_2016-05-25_AT023_067342';
'/media/azh2/TOSHIBA/Deep-learning-AT/Second-part/test_900_samples/samples/test_centralized/240_2016-05-25_AT023_070343';
'/media/azh2/TOSHIBA/Deep-learning-AT/Second-part/test_900_samples/samples/test_centralized/258_2016-05-25_AT023_078343';
'/media/azh2/TOSHIBA/Deep-learning-AT/Second-part/test_900_samples/samples/test_centralized/272_2016-05-25_AT023_082342';
'/media/azh2/TOSHIBA/Deep-learning-AT/Second-part/test_900_samples/samples/test_centralized/321_2016-05-25_AT023_147342';
'/media/azh2/TOSHIBA/Deep-learning-AT/Second-part/test_900_samples/samples/test_centralized/355_2016-05-25_AT023_162341';
'/media/azh2/TOSHIBA/Deep-learning-AT/Second-part/test_900_samples/samples/test_centralized/387_2016-05-26_AT023_016342';
'/media/azh2/TOSHIBA/Deep-learning-AT/Second-part/test_900_samples/samples/test_centralized/424_2016-05-26_AT023_042343';
'/media/azh2/TOSHIBA/Deep-learning-AT/Second-part/test_900_samples/samples/test_centralized/461_2016-05-26_AT023_067312'};
for num = 1:1
% location = '/media/azh2/TOSHIBA/Deep-learning-AT/Second-part/test_900_samples/samples/test_centralized/2_2016-05-24_AT023_011341';
location = nnn{num};
%%
% fid = fopen([location,'/results_LeNet.txt'],'r');
% C =  funcReadData2(fid);

fid = fopen([location,'/results_DenseNet.txt'],'r');
C =  funcReadData(fid);

% Read stored patches; do detection analysis
d2 = (strrep(location,'test_centralized','test'));
d2 = strrep(d2,'_AT023',' AT023');
d2 = dir(d2);
patches_dir = [d2(3).folder,'/',d2(3).name]
im_out = funcTiling(patches_dir, C);

% show the detection results
figure;imagesc(im_out); mymap = [0,0,0; 1,0,0; 0,1,0; 0,0,1; 1,1,1]; colormap(mymap)
title('Detection results')

% Apply Silique definition on the labelled image and then find Siliquies
Sil_def_im = funcSiliqdef(im_out);

%Display detected siliques
figure;imagesc(Sil_def_im);
mymap = [0,0,0;1,1,1]; colormap(mymap)
title('Individual detected siliques')

l = strsplit(location,'test_centralized/');
ll = strsplit(l{2},'_'); kk = strsplit(patches_dir,'/');
lll = ['/media/azh2/TOSHIBA/Deep-learning-AT/Second-part/test_900_samples/AT023_images/',ll{2},' ',ll{3},'_',ll{end},'/',kk{end},'.png'];
I = imread(lll);
figure;imwrite(I,['/media/azh2/TOSHIBA/images',kk{end},'.png'])

end

%%
% clear
% clc;
% 
% nn = {'16','53','77','102','143'};
% location0 = '/media/azh2/TOSHIBA/Deep-learning-AT/Second-part/Sample Classified Images/';
% for num = 1:5
%     
%     location = ['/media/azh2/TOSHIBA/Deep-learning-AT/Second-part/test/',nn{num},'/'];
% 
%     fid = fopen([location0,num2str(num),'/x_densenet.txt'],'r');
% C =  funcReadData(fid);
% 
% % Read stored patches; do detection analysis
% patches_dir = (location);
% 
% im_out = funcTiling(patches_dir, C);
% 
% % show the detection results
% figure;imagesc(im_out); mymap = [0,0,0; 1,0,0; 0,1,0; 0,0,1; 1,1,1]; colormap(mymap)
% title('Detection results')
% 
% % % Apply Silique definition on the labelled image and then find Siliquies
% % Sil_def_im = funcSiliqdef(im_out);
% % 
% % %Display detected siliques
% % figure;imagesc(Sil_def_im);mymap = [0,0,0;1,1,1]; colormap(mymap)
% % title('Individual detected siliques')
% end