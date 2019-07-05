In order to detect and count the number of siliques on unseen Arabidopsis images, firstly, run `Demo_Patching.m`. Then feed the extracted patches to the trained model. Finally run `Demo_counter.m` to get the number of silliqus count. 


% Phase I: Before feeding to the trained model
-  Demo_Patching.m:  this function detaches the input image into P*P blocks/patches and then stores them.

% Phase II: After Classification via the trained model
- Demo_counter.m : This file counts the No. of siliques from the classified results

Warning!!!! 
% Please check the directories before losing your old data :)




