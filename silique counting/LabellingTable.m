function [Lout] = LabellingTable(L1, L2)
%%
if L1 == L2
    if L1 == 1          % That is tip
        Lout = 1;
    elseif L1 == 2      % That is body
        Lout = 2;
    elseif L1 == 3      % That is base
        Lout = 3;
    elseif L1 == 4      % That is stem
        Lout = 4;
    end
elseif ((L1 == 1)&(L2 == 2)) | ((L1 == 2)&(L2 == 1)) % That is body&tip
    Lout = 5;
elseif ((L1 == 1)&(L2 == 3)) | ((L1 == 3)&(L2 == 1))  % That is base&tip
    Lout = 6;
elseif ((L1 == 2)&(L2 == 3)) | ((L1 == 3)&(L2 == 2))  % That is base&body
    Lout = 7;
elseif ((L1 == 2)&(L2 == 4)) | ((L1 == 4)&(L2 == 2))  % That is stem&body
    Lout = 8;
elseif ((L1 == 3)&(L2 == 4)) | ((L1 == 4)&(L2 == 3))  % That is stem&base
    Lout = 9;
else
    Lout = 0;   % That is nothing  >> be aware that we have no stem&tip
end