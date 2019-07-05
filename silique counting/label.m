function out = label(str, char)
%%
out = nan;
x = strncmp(char, str, 3);
aa = find(x==1);
out1 = str2double(regexp(str{(aa)+1},'\d*','match'));
out = out1(1);

end