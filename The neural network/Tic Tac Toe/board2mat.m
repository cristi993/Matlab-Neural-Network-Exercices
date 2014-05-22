function [ P, T ] = board2mat( board )

    temp = char(board{1});

    %% PROCESS TARGETS
    T = temp(:, 19);
    T(T == 'p') = '1';
    T(T == 'n') = '0';
    T = str2num(T);
    
    %% PROCESS EXAMPLES
    temp = strrep(board{1}, ',positive', '');
    temp = strrep(temp, ',negative', '');
    
    temp = strrep(temp, 'b', '0');
    temp = strrep(temp, 'o', '-1');
    temp = strrep(temp, 'x', '1');

    P = str2num(char(temp));
    % finay, blank = 0, O = -1 and X = 1
    
    P = P';
    T = T';
end

