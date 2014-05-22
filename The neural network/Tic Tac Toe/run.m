
%% LOAD DATASET
clear;
warning('off','all');
fileID = fopen('tic-tac-toe.data');
board = textscan(fileID,'%s\n');

%% TRANSFORM DATASET TO A VALID ONE

[P, T] = board2mat(board);
clearvars -except P T;

%% FINDING THE BEST ALGORITHM
% trainings = {'traingd' 'traingdm' 'traincgf' 'traincgp' 'traingda' 'trainrp' 'traingdm' 'traingdx' 'trainbfg' 'trainoss' 'trainlm'};
% colors = {'red', 'green', 'blue', 'yellow', [0.8 0.4 0.6], [0.5 0.5 0.5], 'magenta', 'cyan', 'black', [0.1 0.6 1], [0.3 0.6 0.3]};
%                                            %a dark pink      %grey                              %kind of dark blue  %dark green
% [R,V] = size(P); 
% [Q,~] = size(T);
% 
% %clf;
% for i = 1:length(trainings)
%     net = newff(minmax(P),[R Q],{'tansig' 'logsig'}, trainings{i});
%     net.performFcn = 'sse';
%     
%     %% Method I - efficiency of every algorithm in a number of given epochs
% %     net.trainParam.epochs = 100;
% %     [net, tr] = train(net, P, T);
% %     hold on;
% %     plot(tr.epoch, tr.perf, 'Color', colors{i});
% %     hold off;
%     
%     %% Method II - execution time of every algorithm until reaches the goal
%     net.trainParam.epochs = 10000;
%     net.trainParam.goal = 0.1;
%     [net, tr] = train(net, P, T);
%     %fprintf('Time %s: %s; SSE: %g\n', trainings{i}, datestr(tr.time(end) / 86400, 'MM:SS.FFF'), tr.perf(end));
%       % OR
%     fprintf('Epoci %s: %g; SSE: %g\n', trainings{i}, tr.epoch(end), tr.perf(end));
% end



%% TRAIN NETWORK (with Levenberg-Marquardt)
p = randperm(size(P,2));
P = P(:,p);
T = T(:,p);
[R, Q] = size(P);
E = [];

idx_testing = 1:2:Q;
idx_training = 2:2:Q;

training.P = P(:, idx_training);
training.T = T(:, idx_training);
testing.P = P(:, idx_testing);
testing.T = T(:, idx_testing);

net = newff(minmax(P), [10 5 size(T,1)], {'tansig' 'logsig' 'logsig'}, 'trainlm');
net.performFcn = 'sse';
net.trainParam.epochs = 100;
net.trainParam.mu = 10;

%train first part
net = train(net, training.P, training.T);
%test second part
Y = sim(net, testing.P);
Y = round(Y);
E = numel(find((testing.T ~= Y) > 0)) / length(Y)

%train hole datates
net = train(net, P, T);
% Y = sim(net, P);
% Y = round(Y);
% E = [E numel(find((T ~= Y) > 0)) / length(Y)];

% mean(E)
board = zeros(3);
board( round( (9-1) * rand() + 1) ) = 1; % begin X
exit = 0;
mat2board(board)

%% PLAY X AND O

while 1
    %% READ O POSITION
    
     while 1 % read until a valid position
         result = input('Write O position:\n', 's'); 
         if strcmp(result,'stop') == 1
             exit = 1;
             break;
         end
         if isstrprop(result, 'digit')       
             poz = str2double(result); % extract position
             if poz < 1 || poz > 9
                 continue;
             end
             if board(poz) == 1 || board(poz) == -1
                 continue;
             end
             break;
         end
     end
     if exit == 1
         break;
     end
     
     board(poz) = -1; % set O there
     
     %% find if O wins
     y = round( sim(net,board(:)) );
     
     if y == 0 % IF the network tells it lost
         for i = 1:3
             % verify it's correct
             if sum(board(:,i) == [-1; -1 ; -1]) > 2 ||...
                     sum(board(i,:) == [-1 -1 -1]) > 2 ||...
                     sum([board(1) board(5) board(9)] == [-1 -1 -1]) > 2 ||...
                     sum([board(7) board(5) board(3)] == [-1 -1 -1]) > 2
                 fprintf('\n*** O wins ***\n');
                 exit = 1;
                 break;
             end
         end
         if exit == 1
             mat2board(board)
             break;
         end 
     end
     
     %% Find best position for putting X
     max = 0; I = 0; y = 0; exit = 0;
     for i = 1:numel(board) % for every square
         if board(i) == 0 % if it is free
             board(i) = 1; % put X there

             y = sim(net,board(:)); % test the resulted table
             
             if y > max
                 max = y;
                 I = i;
             end

             if round(y) == 1 % IF the network tells it wins
                 for j = 1:3 
                     % verify it actually won
                     if sum(board(:,j) == [1; 1 ; 1]) > 2 ||...
                             sum(board(j,:) == [1 1 1]) > 2 ||...
                             sum([board(1) board(5) board(9)] == [1 1 1]) > 2 ||...
                             sum([board(7) board(5) board(3)] == [1 1 1]) > 2
                         fprintf('\n*** X wins ***\n');
                         exit = 1;
                         break;
                     end
                 end
                 if exit == 1
                     break;
                 end
             end
             if exit == 1
                 break;
             end

             board(i) = 0;
         end
     end
     if exit == 1
         board(i) = 1; % put X there
         mat2board(board)
         break;
     end
     
     if max == 0 % IF a suitable board(table) wasn't found
         I = round( (9-1) * rand() + 1); % find a free position randomly
         while board(I) ~= 0
             I = 9-(-1) * rand() + (-1);
         end
     end
     
     board(I) = 1; % put X there
     
     %% Show Result
     mat2board(board) 
end
