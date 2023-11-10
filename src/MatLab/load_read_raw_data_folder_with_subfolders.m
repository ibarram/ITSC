%--------------------------------------------------------------------------
%------------- Read raw data from folder with separation into subfolders
%--------------------------------------------------------------------------
% Configuration Initial
clc; close all; clear;

if ispc
    d = '\';
else
    d = '/';
end

n_classes     = 13;
n_repetitions = 5;
Data          = cell(n_classes, n_repetitions);
% info to read of data
ext_data = '.csv';
path_bd  = uigetdir(pwd, 'Database derectory');
folders  = dir(path_bd);
folders  = setdiff({folders.name}, {'.', '..'})';
nfolders = length(folders);
% ----------------- read of data ------------------------------------------
for j1 = 1:nfolders
    files  = dir([path_bd d  folders{j1} d '*' ext_data]);
    nfiles = length(files);
    for j2 = 1:nfiles
        Signals = readmatrix([path_bd d folders{j1} d files(j2).name]);
        Data{j1,j2} = Signals;
    end
end