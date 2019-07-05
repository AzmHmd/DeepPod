function paths = recursedir(pathsofar, type)
%%
paths = [];
dirfiles = dir(pathsofar);
isdirs = [dirfiles(1:end).isdir];

ndx = find(isdirs);%the struct indicies of files that are subdirectories
for i = ndx(3:end)%1 is ., and 2 is .., so definitely skip to keep from going in circles
    paths = [paths; recursedir([pathsofar '/' dirfiles(i).name], type)];
end

for i = find(~isdirs)%iterate over files that are not subdirectories
    if (strfind(dirfiles(i).name, type))%if contains whatever file extension
        paths = [paths; {pathsofar}];%cell array to keep strings separated
        break;%don't keep adding the directory to the list
    end
end
end