function [ result ] = mat2board( board )

    board(board == -1) = 2;
    result = num2str(board, '%d');
    
    result(result == '1') = 'x';
    result(result == '2') = 'o';
    result(result == '0') = '-';
end

