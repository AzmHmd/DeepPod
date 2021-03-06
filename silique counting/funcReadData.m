function C =  funcReadData(fid)
%%
x = 1;
i = 0;
while x
    i = i+1;
    line = fgetl(fid);
    
    if line == -1
        x = 0;
        break;
    end
    %             str    = strsplit(line,' ');
    %             %str{1} = '';
    %             str2 = strjoin(str);
    %             str3 = strsplit(str2);
    %             clear str;
    %             str = str3;
    %
    %             strAddre = str{1};
    %             splitStr = regexp(strAddre,'/','split');
    str1  = strsplit(line,'.png');
    str2 = strsplit(str1{2},' ');
    str1 = str1{1};
    
    v1  = regexp(str1,'/','split');
    C(i,1) = 0;
    C(i,2) = str2double(v1{end});   % image no.
    
    %splitStr2 = regexp(splitStr{6},'.png','split');
    %C(i,2)    = str2double(splitStr2{1});
    
    b = regexp(str2{end},':','split');   % tip
    C(i,3) = str2double(b{end});
    
    b = regexp(str2{end-2},':','split');  % body
    C(i,4) = str2double(b{end});
    
    b = regexp(str2{end-3},':','split');  % Base
    C(i,5) = str2double(b{end});
    
    b = regexp(str2{end-1},':','split');  % Stem
    C(i,6) = str2double(b{end});

end
