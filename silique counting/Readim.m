function ImPath = Readim(path, type)
%%
paths = recursedir(path, type);

n = 0;
for i = 1:size(paths, 1)
    CurrentFolderPath = paths{i,1};    
    Im = dirrec(CurrentFolderPath, '.png' );
    for j = 1:size(Im,2)
        n = n+1;
        ImPath(n).CurrentImagePath = Im{1,j};
%         ImPath.im = imread(I.CurrentImagePath);
    end
end
end