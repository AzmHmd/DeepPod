% This function is written to extract the annotation information 
% inputs: 
% p: path to the text file of the annotation
% type: kind of annotation (can be 'Base', 'Top',...)
%
% output:
% out: is a mx2 matix of representing x and y coordinates of an annotated
% part. m is the number of annotations provided in an image for a type
%
% Written by Azam Hamidinekoo, Computer Science, Aberystwyth, 2017
%--------------------------------------------------------------------------


function out = readAnnotation(p,type)

annotations = fopen([p,'_',type,'.txt'],'r');
tline = fgetl(annotations);
i = 1;
while ischar(tline)
%     disp(tline);
    out(i,1) = round(str2num(tline(1:strfind(tline,',')-1)));
    out(i,2) = round(str2num(tline(strfind(tline,',')+1:end)));
    i = i+1;
    tline = fgetl(annotations);
end

