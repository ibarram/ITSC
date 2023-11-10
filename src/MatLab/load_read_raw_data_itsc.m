%--------------------------------------------------------------------------
%------------- Read data from Data_ITSC.mat
%--------------------------------------------------------------------------
clear all, close all, clc;

if ispc
    d = '\';
else
    d = '/';
end

ext_bd        = '.mat';
n_classes     = 13;
n_repetitions = 5;
Data          = cell(n_classes, n_repetitions);
%--------------------------------------------------------------------------
% If the .mat file is inside the directory where this script is located,use:
%--------------------------------------------------------------------------
% load('RAWData_ITSC.mat');
% f_names = fieldnames(itsc);
% nfnames = length(f_names);
% % read of all data in struct of data set
% for j1 = 1:nfnames
%     sf_names = fieldnames(itsc.(f_names{j1}));
%     nsfnames = length(sf_names);
%     for j2 = 1:nsfnames
%         Data{j1,j2} = itsc.(f_names{j1}).(sf_names{j2});
%     end
% end

%--------------------------------------------------------------------------
% ------------ conversely, to find the .mat file use:----------------------
%--------------------------------------------------------------------------
% path_bd = uigetdir(pwd, 'Database derectory');
% file_d  = dir([path_bd d '*' ext_bd]);
% ITSC    = importdata("RAWData_ITSC.mat");
% 
% f_names = fieldnames(ITSC);
% nfnames = length(f_names);
% % read of all data in struct of data set
% for i1 = 1:nfnames
%     sf_names = fieldnames(ITSC.(f_names{i1}));
%     nsfnames = length(sf_names);
%     for i2 = 1:nsfnames
%         Data{i1,i2} = ITSC.(f_names{i1}).(sf_names{i2});
%     end
% end